START TRANSACTION;

-- Return ₦1,000 to Bank A
UPDATE accounts
SET balance = balance + 1000.00
WHERE account_id = 1;

-- Deduct ₦1,000 from Bank B
UPDATE accounts
SET balance = balance - 1000
WHERE account_id = 2;


COMMIT;