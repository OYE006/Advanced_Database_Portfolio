
START TRANSACTION;

SELECT account_id, balance
FROM accounts
WHERE account_id IN (1, 2)
ORDER BY account_id
FOR UPDATE;

UPDATE accounts
SET balance = balance - 1000.00
WHERE account_id = 1
  AND status = 'ACTIVE'
  AND balance >= 1000.00;

-- Check that exactly one row was updated.
-- If not, issue ROLLBACK instead.

UPDATE accounts
SET balance = balance + 1000.00
WHERE account_id = 2
  AND status = 'ACTIVE';

-- Check that exactly one row was updated.
-- If not, issue ROLLBACK instead.

INSERT INTO transfers
    (source_account_id, destination_account_id,
     amount, status, reference, description)
VALUES
    (1, 2, 1000.00, 'COMPLETED',
     'SB-TEST-0001', 'Portfolio transfer test');

SET @transfer_id = LAST_INSERT_ID();

INSERT INTO ledger_entries
    (transfer_id, account_id, entry_type, amount)
VALUES
    (@transfer_id, 1, 'DEBIT', 1000.00),
    (@transfer_id, 2, 'CREDIT', 1000.00);

COMMIT;

SELECT account_id, account_number, balance
FROM accounts
WHERE account_id IN (1, 2);
