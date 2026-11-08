# SecureBank Normalization

## Summary

The SecureBank database separates customer details, bank accounts, transfers, ledger entries and audit events into five related tables. Each table has a primary key to identify each record, while foreign keys connect records that depend on one another. Unique constraints prevent duplicate email addresses, account numbers and transfer references. Check constraints reject negative account balances and invalid transaction amounts.

## First Normal Form (1NF)

The tables use defined columns and single values rather than storing multiple customer emails, account numbers or transfer records in a single field. Each row has a primary key. 

## Second Normal Form (2NF)

Each table uses a single-column primary key. So, no partial dependencies on only part of a composite primary key. The non-key attributes are designed to depend on the primary key.

## Third Normal Form (3NF)

Customer information is stored in customers, not copied into account and transfer rows. Account information is stored in accounts, while transfer information and debit/credit ledger records are stored separately. This reduces duplication when customer details or transfer records change.

## Design considerations

The balance stores the current account balance for efficient balance enquiries and must remain consistent with the ledger, while ledger_entries preserves the debit and credit records associated with transfers. 