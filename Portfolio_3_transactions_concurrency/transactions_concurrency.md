# Transactions and Concurrency

## Objective

This activity examines transaction processing and concurrency control in the SecureBank MySQL database using the InnoDB storage engine.

## Transaction processing

A stored procedure was implemented to transfer funds between two accounts. It validates the account IDs, checks account status and available funds, updates both account balances, creates a transfer record and inserts corresponding debit and credit ledger entries.

The procedure uses `START TRANSACTION`, `COMMIT` and an exception handler that executes `ROLLBACK` if an SQL exception occurs.

## Rollback demonstration

An account balance was temporarily reduced within a transaction. After executing `ROLLBACK`, the original balance was restored. This demonstrated how uncommitted changes can be cancelled.

## Isolation and concurrency

The session isolation level was examined and set to REPEATABLE READ. A two-session experiment demonstrated consistent snapshot reads and locking reads. A separate row-locking test showed how a second session waits when another transaction holds a lock on the same account row.

## ACID evaluation

- **Atomicity:** The transfer procedure groups balance updates and financial records into one transaction.
- **Consistency:** Constraints and validation checks protect the database from invalid account and transfer operations.
- **Isolation:** InnoDB transaction isolation and row-level locks coordinate concurrent access.
- **Durability:** A successful commit makes the completed transaction persistent.

## Limitations and improvements

The demonstration uses a small simulated dataset and a simplified transfer procedure. A production implementation would require stronger authorisation, idempotent processing, transaction limits, reconciliation, monitoring, backup and recovery procedures. Deadlocks and lock timeouts would also need application-level handling and controlled retries.

## Conclusion

The experiments demonstrate how MySQL transactions and concurrency controls help maintain consistent financial records when multiple database operations interact.