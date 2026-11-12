# Transactions and Concurrency

How transactions work in MySQL using the InnoDB storage engine for the SecureBank database.

## Transaction Processing

A stored procedure was created to move money between two accounts. The procedure will validate account IDs, check account status and balance, update both account’s balance and create a record of the transaction. Debit and credit entries were added to the ledger. The procedure includes transaction control using START TRANSACTION, COMMIT and exception handling to call ROLLBACK in the case of any SQL exceptions.

## Rollback

By reducing the account balance temporarily during a transaction and calling ROLLBACK we can see how it cancels any uncommitted changes.

## Isolation

Looked at the isolation level of the session. The isolation level was set to REPEATABLE READ. By running two sessions we can see how the database will return consistent READ snapshots. Also ran an extra test using row locking to show how a second session will be forced to wait when a transaction has locked the account row.

## ACID

Atomicity: The procedure contains the updating of balances and financial records in one transaction.

Consistency: Constraints and validation ensures that the database cannot be corrupted by invalid account and transaction actions.

Isolation: The InnoDB provides transaction isolation and row locking to manage concurrency.

Durability: If the transaction successfully commits then data is made persistent.

## Limitations and Improvements

This test uses a small sample data set and a simple transaction procedure. Additional security features would need to be included to authorise the user, ensure idempotency, limit the transaction and include reconciliation. Monitoring, back-up and recovery features would also be required. Deadlock and lock timeout would need to be handled at application level with limited retries.

## Conclusion

This shows how transactions and concurrency controls in MySQL can help ensure consistent financial records when multiple database actions are being processed.