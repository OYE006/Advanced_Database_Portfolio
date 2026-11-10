-- Check current isolation level
SELECT @@transaction_isolation;


-- Set the session isolation level

SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

SELECT @@transaction_isolation;