db.customers.createIndex(
  { customer_id: 1 },
  { unique: true }
)

db.customers.createIndex(
  { email: 1 },
  { unique: true }
)

db.accounts.createIndex(
  { account_id: 1 },
  { unique: true }
)

db.accounts.createIndex(
  { account_number: 1 },
  { unique: true }
)

db.transactions.createIndex(
  { transaction_id: 1 },
  { unique: true }
)

db.transactions.createIndex(
  { account_id: 1, transaction_date: -1 }
)

db.audit_logs.createIndex(
  { customer_id: 1, timestamp: -1 }
)

//verify indexes

db.customers.getIndexes()
db.accounts.getIndexes()
db.transactions.getIndexes()
db.audit_logs.getIndexes()