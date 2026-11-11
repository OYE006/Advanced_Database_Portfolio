//Transaction_event

db.transactions.insertMany([
  {
    transaction_id: "TXN001",
    account_id: "ACC001",
    transaction_type: "Deposit",
    amount: 100000,
    currency: "NGN",
    status: "Successful",
    description: "Initial deposit",
    transaction_date: new Date()
  },
  {
    transaction_id: "TXN002",
    account_id: "ACC001",
    transaction_type: "Transfer",
    amount: 25000,
    currency: "NGN",
    status: "Successful",
    description: "Transfer to ACC002",
    transaction_date: new Date()
  },
  {
    transaction_id: "TXN003",
    account_id: "ACC002",
    transaction_type: "Deposit",
    amount: 50000,
    currency: "NGN",
    status: "Successful",
    description: "Cash deposit",
    transaction_date: new Date()
  }
])