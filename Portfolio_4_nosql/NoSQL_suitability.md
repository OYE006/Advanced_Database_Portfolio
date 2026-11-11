# Suitability of NoSQL Data Models for SecureBank

The SecureBank Banking/Fintech System contains various data; customer information, account activity, user sessions, transaction history and customer relationships. Depending on the type of NoSQL database being used there are advantages to different Data Models that make them suitable for certain processes in the banking system. 

## Document database: MongoDB

This would be suitable for SecureBank as it uses document based data storage. The customer information can be different depending on the type of customer (individual or business). For example, individual customers might have personal identification information, whereas businesses might need company registration information. This can be easily stored in MongoDB as it can handle varying structures. It also has nested documents, schema validation and indexing to keep the customer information well structured.

Disadvantage: MongoDB isn’t able to automatically enforce foreign keys like MySQL. More validation needs to be done within the application to keep the relationships. 

## Key value database: Redis

This would be suitable for SecureBank as it can quickly retrieve data. Banking systems often require quick access to temporary information such as user sessions, OTP data and failed login attempts. Redis has automatic expiry so temporary authentication information can be deleted after a certain time.

Disadvantage: Redis shouldn’t be used to store definitive customer balance or financial data. There is also considerations for persistence, replication and recovery. 

## Column family database: Apache Cassandra

This would be suitable for SecureBank as it has been created to spread large amounts of data across multiple servers. As the bank grows there will be more customer activities and transaction history records. Cassandra can scale horizontally by adding nodes to the system.

The partition key can allow efficient querying of transaction history for individual accounts. 

## Graph database: Neo4j

This would be suitable for SecureBank as there can be links between different customers, accounts, devices and beneficiaries within banking fraud. If multiple customer accounts are using the same device or are transferring money through related beneficiaries Neo4j can help with the investigation.

As it has a graph structure it can make it easier to query linked data and find any potential suspicious patterns. 

Disadvantage: Graph databases aren’t intended to be used for financial transactions. Neo4j should only be used to help investigate fraud and relationships.

## Recommendations

It would be more suitable to use a mixture of different database technologies for SecureBank. The main database should still be MySQL as it provides relational integrity and ACID transactions for financial data, account balances and money transfers. MongoDB can be used for flexible customer data, Redis for temporary authentication data, Cassandra for large volumes of activity data and Neo4j for fraud investigation. This is called polyglot persistence. It allows SecureBank to choose which database technology to use for the different processes. However, there will be additional administration, security and synchronisation requirements. SecureBank will need to put in place the right integration methods.

## Conclusion

All four NoSQL models are suitable for different parts of SecureBank. They can help provide more flexibility, scalability and fraud investigation. However, MySQL will still provide the definitive financial information.