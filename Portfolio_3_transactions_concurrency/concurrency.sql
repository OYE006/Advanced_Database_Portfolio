-- Note: Connection ID must be different for the concurrency to work use the command below to check the ID;
		SELECT
			CONNECTION_ID() AS session_id,
			DATABASE() AS database_name;

-- Run this in Session A and execute:

USE securebank;

START TRANSACTION;

SELECT balance
FROM accounts
WHERE account_id = 1
FOR UPDATE;

-- MySQL displays the account balance.
		
-- Request the same lock in session B and execute

-- MySQL displays running.

-- Release the lock in Session A by adding "COMMIT;" The blocked query in session B should complete and display the account balance.