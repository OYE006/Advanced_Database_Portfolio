//Find a customer

db.customers.findOne({
  customer_id: "CUST001"
})

//Find all customer accounts

db.accounts.find({
  customer_id: "CUST001"
})

//Find transactions for an account

db.transactions.find({
  account_id: "ACC001"
}).sort({
  transaction_date: -1
})

//Find successful transfers

db.transactions.find({
  transaction_type: "Transfer",
  status: "Successful"
})

