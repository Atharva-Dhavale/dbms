    db.purchase_orders.insertMany([
  { product: "toothbrush", total: 4.75, customer: "Mike" },
  { product: "guitar", total: 199.99, customer: "Tom" },
  { product: "milk", total: 11.33, customer: "Mike" },
  { product: "pizza", total: 8.50, customer: "Karen" },
  { product: "toothbrush", total: 4.75, customer: "Karen" },
  { product: "pizza", total: 4.75, customer: "Dave" },
  { product: "toothbrush", total: 4.75, customer: "Mike" }
])




db.purchase_orders.createIndex({ product: 1 })



1. Find out how many toothbrushes were sold
db.purchase_orders.find({ product: "toothbrush" })
db.purchase_orders.find({ product: "toothbrush" })

db.purchase_orders.aggregate([
  { $match: { product: "toothbrush" } },
  { $count: "toothbrushesSold" }
])


2. Find how much money has been earned by selling the products toothbrushes and pizza.
db.purchase_orders.distinct("product")




db.purchase_orders.aggregate([
  { $match: { product: { $in: ["toothbrush", "pizza"] } } },
  { $group: { _id: null, totalRevenue: { $sum: "$total" } } }
])

db.purchase_orders.aggregate(
    [
        {$match :{product :{$in:["toothbrush" , "pizza"]}}},
        {$group : {_id:null, totalRevenue :{$sum:"$total"}}}
    ]
)


3. Find the list of all sold products

db.purchase_orders.distinct("product")

db.purchase_orders.aggregate([
  {
    $group: {
      _id: "$product" ,
        bro : { $first: "$product" } 
    }
  },
  {
    $project: {
      _id: 0,            // hide _id
      product: "$bro"    // rename bro to product
    }
  }
])






4. Find the total amount of money spent by each customer

db.purchase_orders.aggregate([
  {
    $group: {
      _id: "$customer",
      moneyspent: { $sum: "$total" }
    }
  },
  {
    $project: {
      _id: 0,
      customer: "$_id",
      moneyspent: 1
    }
  }
]);

5. Find how much has been spent on each product and sort it by amount spent

db.purchase_orders.aggregate([
  { $group: { _id: "$product", totalSpent: { $sum: "$total" } } },
  { $sort: { totalSpent: -1 } }
])

6. Find the product with least earnings.
db.purchase_orders.aggregate([
    {$group : {_id:"$product" , totalspent :{$sum : "$total"}}},
    {$sort:{totalspent:1}},
    {$limit : 1}
])

7. Find how much money each customer has spent on toothbrushes and pizza

db.purchase_orders.aggregate([
    {$match :{product:{$in :["toothbrush", "pizza"]}}},
    {$group : {_id:"$customer" , toothspent : {$sum:"$total"}}}
])

db.purchase_orders.aggregate([
  {
    $match: {
      product: { $in: ["toothbrush", "pizza"] }
    }
  },
  {
    $group: {
      _id: "$customer",
      toothbrushSpent: {
        $sum: {
          $cond: [{ $eq: ["$product", "toothbrush"] }, "$total", 0]
        }
      },
      pizzaSpent: {
        $sum: {
          $cond: [{ $eq: ["$product", "pizza"] }, "$total", 0]
        }
      },
      totalSpent: { $sum: "$total" } // optional
    }
  },
  {
    $project: {
      _id: 0,
      customer: "$_id",
      toothbrushSpent: 1,
      pizzaSpent: 1,
      totalSpent: 1
    }
  }
])



db.purchase_orders.aggregate([
  {
    $match: {
      product: { $in: ["toothbrush", "pizza"] }
    }
  },
  {
    $group: {
      _id: "$customer",
      toothbrushSpent: {
        $sum: {
          $cond: {
            if: { $eq: ["$product", "toothbrush"] },
            then: "$total",
            else: 0
          }
        }
      },
      pizzaSpent: {
        $sum: {
          $cond: {
            if: { $eq: ["$product", "pizza"] },
            then: "$total",
            else: 0
          }
        }
      },
      totalSpent: { $sum: "$total" }
    }
  },
  {
    $project: {
      _id: 0,
      customer: "$_id",
      toothbrushSpent: 1,
      pizzaSpent: 1,
      totalSpent: 1
    }
  }
])


8. Find the customer who has given highest business for the product toothbrush


db.purchase_orders.aggregate([
    {$match:{product:{$in:["toothbrush"]}}},
    {$group:{
        _id:"$product",
        totalspent:{$sum:"$total"}
    }},
    {$sort:{totalspent:1}},
    {$limit:1}
])

















db.teachers.aggregate([
  { $sort: { marks: -1 } },
  { $limit: 5 }
])

db.teachers.aggregate([
  { $match: { appointment_nature: "permanent"  } },
  { $count: "Total_IT_Students" }
])

db.purchase_orders.countDocuments({ product: "toothbrush" })


//count types
db.teachers.countDocuments({ appointment_nature: "permanent"})



db.students.aggregate([
  { $sort: { marks: -1 } },   // sort highest first
  { 
    $group: {
      _id: "$dept",
      topStudentMarks: { $first: "$marks" },
      topStudentName: { $first: "$name" }
    }
  }
])










When you define operators ($match, $project, $cond, $gte, etc.) or key–value pairs



{ $match: { marks: { $gte: 40 } } }


here there are both condtion $ and key value mapping
