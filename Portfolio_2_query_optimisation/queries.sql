SELECT
    c.customer_id,
    c.full_name,
    a.account_number,
    a.account_type,
    a.balance,
    a.currency,
    a.status
FROM customers AS c
JOIN accounts AS a
    ON a.customer_id = c.customer_id
ORDER BY c.full_name;


SELECT
    t.reference,
    src.account_number AS source_account,
    dst.account_number AS destination_account,
    t.amount,
    t.status,
    t.created_at
FROM transfers AS t
JOIN accounts AS src
    ON src.account_id = t.source_account_id
JOIN accounts AS dst
    ON dst.account_id = t.destination_account_id
WHERE t.status = 'COMPLETED'
  AND (
      t.source_account_id = 1
      OR t.destination_account_id = 1
  )
ORDER BY t.created_at DESC;


SELECT
    COUNT(*) AS transfer_count,
    COALESCE(SUM(amount), 0.00) AS total_amount
FROM transfers
WHERE status = 'COMPLETED';


SELECT account_number, balance
FROM accounts
WHERE status = 'ACTIVE'
  AND balance >= 50000.00
ORDER BY balance DESC;