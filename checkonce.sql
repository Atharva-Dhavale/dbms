db.collection.find({
  $or: [
    { product: "toothbrush" },
    { product: "pizza" }
  ]
})



db.collection.find({
    product : {$in : ["toothbrush" , "pizza" ]}
})

{ product: ["toothbrush", "soap", "paste"] }

$project?

The $project stage in MongoDB is used to control what fields appear in the output documents.
It’s like the SELECT clause in SQL, deciding which fields you want to include, exclude, or even create new calculated fields.

db.collection.aggregate([
  {
    $project: {
      field1: 1,         // include field1
      field2: 0,         // exclude field2
      newField: <expr>,  // create new field using an expression
    }
  }
])



db.teachers.aggregate([
  {
    $project: {
      name: 1,
      total_salary: { $add: ["$salary.basic", "$salary.HRA", "$salary.TA", "$salary.DA"] }
    }
  }
])



/// condition operator 
{
  $cond: {
    if: <condition>,
    then: <value_if_true>,
    else: <value_if_false>
  }
}


db.students.aggregate([
  {
    $project: {
      name: 1,
      result: {
        $cond: { if: { $gte: ["$marks", 40] }, then: "Pass", else: "Fail" }
      }
    }
  }
])
