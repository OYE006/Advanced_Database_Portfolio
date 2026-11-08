# Advanced_Database_Portfolio (SECUREBANK)

SecureBank is a simulated digital banking platform designed to manage customer information, bank accounts, transfers, and transaction records. The system use MySQL as its primary relational database to enforce data integrity and support transactional operations. MongoDB is used to demonstrate flexible document based storage for transaction events and audit data. The portfolio will examine database design, normalisation, query optimisation, transaction processing, concurrency control, NoSQL modelling, and distributed database concepts.

## Portfolio 1: Database Design and Modelling
Building the foundation of SecureBank.

### Step 1: Creating the database

Open MySQL Workbench, connect to the local server, and execute:

    CREATE DATABASE securebank;
    USE securebank;
    
    SHOW DATABASES;


Expected result: securebank appears in the database list.

### Step 2: Creating the five tables

Create a new SQL file in portfolio_1_database_design called schema.sql.

Create in this order:

- customers
- accounts
- transfers
- ledger_entries
- audit_events

Execute the SQL from top to bottom. The order matters because some tables reference others through foreign keys.


        USE securebank;
        
        CREATE TABLE customers (
            customer_id BIGINT PRIMARY KEY AUTO_INCREMENT,
            full_name VARCHAR(120) NOT NULL,
            email VARCHAR(150) NOT NULL UNIQUE,
            phone VARCHAR(25) UNIQUE,
            created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        );
        
        CREATE TABLE accounts (
            account_id BIGINT PRIMARY KEY AUTO_INCREMENT,
            customer_id BIGINT NOT NULL,
            account_number CHAR(10) NOT NULL UNIQUE,
            account_type ENUM('SAVINGS', 'CURRENT') NOT NULL,
            balance DECIMAL(15,2) NOT NULL DEFAULT 0.00,
            currency CHAR(3) NOT NULL DEFAULT 'NGN',
            status ENUM('ACTIVE', 'FROZEN', 'CLOSED')
                NOT NULL DEFAULT 'ACTIVE',
            created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
            CONSTRAINT fk_account_customer
                FOREIGN KEY (customer_id)
                REFERENCES customers(customer_id),
            CONSTRAINT chk_account_balance CHECK (balance >= 0)
        );
        
        CREATE TABLE transfers (
            transfer_id BIGINT PRIMARY KEY AUTO_INCREMENT,
            source_account_id BIGINT NOT NULL,
            destination_account_id BIGINT NOT NULL,
            amount DECIMAL(15,2) NOT NULL,
            status ENUM('PENDING', 'COMPLETED', 'FAILED')
                NOT NULL DEFAULT 'PENDING',
            reference VARCHAR(40) NOT NULL UNIQUE,
            description VARCHAR(255),
            created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
            CONSTRAINT fk_transfer_source
                FOREIGN KEY (source_account_id)
                REFERENCES accounts(account_id),
            CONSTRAINT fk_transfer_destination
                FOREIGN KEY (destination_account_id)
                REFERENCES accounts(account_id),
            CONSTRAINT chk_transfer_amount CHECK (amount > 0),
            CONSTRAINT chk_different_accounts
                CHECK (source_account_id <> destination_account_id)
        );
        
        CREATE TABLE ledger_entries (
            entry_id BIGINT PRIMARY KEY AUTO_INCREMENT,
            transfer_id BIGINT NOT NULL,
            account_id BIGINT NOT NULL,
            entry_type ENUM('DEBIT', 'CREDIT') NOT NULL,
            amount DECIMAL(15,2) NOT NULL,
            created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
            CONSTRAINT fk_ledger_transfer
                FOREIGN KEY (transfer_id)
                REFERENCES transfers(transfer_id),
            CONSTRAINT fk_ledger_account
                FOREIGN KEY (account_id)
                REFERENCES accounts(account_id),
            CONSTRAINT chk_ledger_amount CHECK (amount > 0)
        );
        
        CREATE TABLE audit_events (
            event_id BIGINT PRIMARY KEY AUTO_INCREMENT,
            customer_id BIGINT NULL,
            transfer_id BIGINT NULL,
            event_type VARCHAR(60) NOT NULL,
            details JSON,
            created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
            FOREIGN KEY (customer_id)
                REFERENCES customers(customer_id),
            FOREIGN KEY (transfer_id)
                REFERENCES transfers(transfer_id)
        );

Understand the design:

- PRIMARY KEY: uniquely identifies each record.
- FOREIGN KEY: prevents accounts or ledger entries from referencing nonexistent records.
- UNIQUE: prevents duplicate email addresses, account numbers, and transfer references.
- DECIMAL(15,2): Avoid floating point types for financial values.
- CHECK: constraints reject invalid amounts and negative account balances.
- ENUM: restricts fields to the listed values.

Confirm the tables exist by running:

    USE securebank;
    SHOW TABLES;

### Step 3: Inserting the sample data
Create sample_data.sql in the same folder.

Execute and verify the simulated data:

    INSERT INTO customers (full_name, email, phone)
    VALUES
    ('Amina Bello', 'amina@example.test', '08030000001'),
    ('David Okafor', 'david@example.test', '08030000002'),
    ('Grace Adeyemi', 'grace@example.test', '08030000003');
    
    INSERT INTO accounts
        (customer_id, account_number, account_type, balance)
    VALUES
        (1, '1000000001', 'SAVINGS', 100000.00),
        (2, '1000000002', 'CURRENT',  50000.00),
        (3, '1000000003', 'SAVINGS',  25000.00);
    
    SELECT * FROM customers;
    SELECT account_number, balance, currency, status
    FROM accounts;

Expected initial balances:
- Account 1000000001: ₦100,000.00
- Account 1000000002: ₦50,000.00
- Account 1000000003: ₦25,000.00

### Step 4: Testing the database constraints
Run the tests one at a time. Each invalid insert should fail.

Test A: Duplicate email

    INSERT INTO customers (full_name, email)
    VALUES ('Test Customer', 'amina@example.test');

Expected: a duplicate key error because the email is already in use.

Test B: Negative account balance

    INSERT INTO accounts
    (customer_id, account_number, account_type, balance)
    VALUES (1, '1000000099', 'SAVINGS', -100.00);

Expected: a check constraint error enforces the defined CHECK constraint.

Test C: Invalid transfer amount

    INSERT INTO transfers
    (source_account_id, destination_account_id,
     amount, reference)
    VALUES (1, 2, -100.00, 'SB-INVALID-001');

Expected: the amount constraint rejects the record.

### Step 4: ER diagram
In MySQL Workbench the diagram is exported as PNG or PDF. The generated diagram displays the primary keys, foreign keys, and relationships.
