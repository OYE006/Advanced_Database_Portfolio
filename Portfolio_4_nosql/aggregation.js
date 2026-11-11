//Calculate total transaction amount

db.transactions.aggregate([
  {
    $match: {
      status: "Successful"
    }
  },
  {
    $group: {
      _id: "$transaction_type",
      total_amount: {
        $sum: "$amount"
      },
      transaction_count: {
        $sum: 1
      }
    }
  }
])

//Retrieve customer information with account details

db.customers.aggregate([
  {
    $lookup: {
      from: "accounts",
      localField: "customer_id",
      foreignField: "customer_id",
      as: "customer_accounts"
    }
  }
])