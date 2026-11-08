
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


