\# SecureBank Normalization



\## Summary

The database contains five(5) tables with each related to each other. There is a primary key to identify each individual record, while also having foreign keys to relate records which are dependent on each other. Unique constraints are applied to ensure no duplicates are present for emails, account numbers and transfer references. Check constraints are applied to ensure negative account balances and incorrect transaction amounts are denied. 



\## First Normal Form (1NF):

As defined there are specific column names and each record only has one value, so there are no multiple emails, account numbers or transfers per customer. Each row has a primary key. 



\## Second Normal Form (2NF):

Each table has single column primary key, therefore there are no partial dependencies as there are no partial primary keys. Non-key attributes have been designed to be dependent on primary keys. 



\## Third Normal Form (3NF):

There is no duplication of customer information as it is stored in its own table. Account information is stored in its own table and transfer information is stored within its own table along with debit/credit ledger information. This avoids duplication if the customer information or transfer information changes. 



\## Design Considerations

The balance table allows quick look up of current account balance. It needs to be consistent with the ledger. The ledger\_entries table stores the debit/credit information associated with transfers.

