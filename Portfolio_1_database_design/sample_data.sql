
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
