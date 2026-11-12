\# Distributed and Cloud Database



\## Step 1: Design Proposed Architecture



\### 1.1 Proposed Architecture



The diagram can be found in the Portfolio\_5\_distributed\_cloud folder.



\### 1.2 Proposed Architecture Components



|Component|Purpose|
|-|-|
|MySQL Primary|Processes deposit, withdrawal, transfer and balance functions.|
|MySQL Replica|Used for reports and high read functions.|
|MongoDB|Store audit events, login activity and semi-structured logs.|
|Cloud Backup|Used to store individual backup of databases.|
|Application Layer|Used to direct requests to the database.|





Why this is a good design?



This design separates processes so that the primary database is not put under pressure and therefore a horizontal solution can be implemented. MySQL is good for transactions as it supports ACID transactions, relational constraints and managed concurrency. MongoDB is just an extra, added to MySQL as it is used for storing semi-structured data but the financial ledger does not depend on document database.



\### 1.3 Proposed Process Flow



* Customer wishes to send a ₦10,000 transfer.



* Application sends request to MySQL Primary.



* MySQL validates the accounts and performs the debit and credit in one transaction.



* Primary commits the transaction.



* Change is replicated to MySQL Replica.



* Audit event is written to MongoDB.



* Reporting services can be used to get historical data from the replica.



The financial transaction will have been successfully processed once the main transaction in MySQL has been committed. If MongoDB is temporarily down we should implement a reliable retry or transactional outbox to ensure we do not lose any audit events.



\## Step 2: Database Replication



Replication is a way to copy database changes from one server to another. This can help with scaling reads.



For the Securebank platform:



* Primary Database is used to process balance updates and transfer transactions.



* Read replica used for reports such as transaction summaries.



* Real time balances are read from primary.



* Lag can occur resulting in data being returned from the replica.



* Failover, backups, monitoring and recovery are important to set up.



\### Advantages



* Improved read scalability with extra replica.



* Data is replicated.



* There is a recovery plan.



* Reduces load on primary.



\### Disadvantages



* Replication can cause stale data due to lag.



* Replication requires monitoring and management.



* Not guaranteed to failover automatically.



* If the replica fails there needs to be a recovery process.



\## Step 3: Database Sharding



Sharding allows databases to scale, This is done by dividing the data into smaller chunks known as shards. Each shard contains part of the data and can be ran on its own server. This ensures the records are distributed across multiple database servers.



Unlike replication, it divides the data across the database servers. An example would be SecureBank dividing customer and account data based on the customer ID or account range. It is important to ensure the shard key is balanced to distribute the workload and to reduce any cross-shard actions.



\### Benefits



* Can scale.



* Storage is distributed.



* Queries are distributed.



* Reduces load on individual servers.



\### Challenges



* More complex management.



* Transactions across shards are difficult.



* Aggregation required for reporting.



* Planning is required to rebalance the shards.



When transferring between accounts on different shards there needs to be co-ordinated transaction processing. Sharding requires a distributed transaction protocol or designed transfer process.



\## Step 4: Consistency and Availability



\### 4.1 Consistency



Consistency ensures the integrity and accuracy of the data stored in the database during read/write operations.



For example:



When a customer wants to make a ₦10,000 transfer from Account A to B, the primary database handles the debit and credit as one ACID transaction. The primary database will validate the affected rows to ensure both accounts are valid. If either operation fails the transaction will be rolled back. This will happen even if the replica has received both changes. The report may display balance data for a short period of time whilst the data is copied. Read replicas are consistent so it is important to ensure any checks or transfers are not dependent on potentially out-of-date data from the replica.



For any operations requiring up-to-date data the application should connect to the database, Or a method can be implemented to ensure the required transaction has been applied on the replica.



\### 4.2 Availability



Availability ensures access to the database service when required. For SecureBank it is important to ensure the database is available as customers may want to access their accounts and make transfers at any time. The proposed design includes:



* Replication: copies of the database.



* Failover: Automatically switches work to a standby database so the service continues with minimal interruption.



* Monitoring: Detects failures in the database. Detects lag in replication.



* Backups: Helps when data is lost/corrupted.



* Disaster Recovery: Ensures business units can continue during a crisis.





What happens if the primary database is unavailable?



The following recovery process would be used:



* Database monitoring detects that the primary database is not available.



* Administrator or failover controller checks the status of the replica.



* Check if all required transactions have been sent to the replica.



* Suitable replica becomes new primary.



* Application connects to primary.



* Initial primary is reconfigured and added back into the replication topology.



A major issue is data loss, if the transactions have not been sent via asynchronous replication. This risk can be reduced by using synchronous replication or improved acknowledgements. This may introduce latency and reduce availability.

