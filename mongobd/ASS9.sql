db.teachers.insertMany([
  {
    name: "Dr. Meena Patil",
    qualifications: "PhD, M.Tech",
    deptno: 101,
    deptname: "Computer",
    designation: "Associate Professor",
    experience: { teaching: 8, industry: 2 },
    salary: { basic: 60000, TA: 5000, DA: 7000, HRA: 8000 },
    date_of_joining: new Date("2015-06-15"),
    appointment_nature: "permanent",
    area_of_expertise: "Machine Learning"
  },
  {
    name: "Mr. Rajesh Kulkarni",
    qualifications: "M.E., B.E.",
    deptno: 102,
    deptname: "IT",
    designation: "Assistant Professor",
    experience: { teaching: 5, industry: 1 },
    salary: { basic: 55000, TA: 4000, DA: 6000, HRA: 7000 },
    date_of_joining: new Date("2018-07-10"),
    appointment_nature: "adhoc",
    area_of_expertise: "Networking"
  },
  {
    name: "Mrs. Sneha Deshmukh",
    qualifications: "M.Tech",
    deptno: 103,
    deptname: "E&TC",
    designation: "Lecturer",
    experience: { teaching: 6, industry: 2 },
    salary: { basic: 65000, TA: 6000, DA: 8000, HRA: 9000 },
    date_of_joining: new Date("2017-03-22"),
    appointment_nature: "permanent",
    area_of_expertise: "Embedded Systems"
  },
  {
    name: "Mr. Ajay Sharma",
    qualifications: "B.E.",
    deptno: 104,
    deptname: "First Year",
    designation: "Lecturer",
    experience: { teaching: 3, industry: 0 },
    salary: { basic: 40000, TA: 3000, DA: 4000, HRA: 5000 },
    date_of_joining: new Date("2020-01-12"),
    appointment_nature: "adhoc",
    area_of_expertise: "Engineering Mechanics"
  }
])


2. Find the information about all teachers 
db.teachers.find().pretty()


3. Find the information about all teachers of computer department
db.teachers.find({ deptname: "Computer" }).pretty()



 4. Find the information about all teachers of computer, IT & first year departments 
db.teachers.find({ deptname: { $in: ["Computer", "IT", "First Year"] } }).pretty()
db.teachers.find({
    deptname :{
        $in:["Computer", "IT", "First Year"]
    }
}).pretty()

 5. Find the information about all teachers of computer, IT and E&TC department having salary in between 70,000 and 1,00,000 (inclusive) 

db.teachers.updateMany(
  {},
  [
    {
      $set: {
        total_salary: { $add: ["$salary.basic", "$salary.TA", "$salary.DA", "$salary.HRA"] }
      }
    }
  ]
)



 db.teachers.find(
    {   deptname :{$in:["Computer", "IT", "E&TC"]}  ,
        total_salary : {$gte: 70000, $lte: 100000}
    }
 )



 const teachers = db.teachers.find({
  deptname: { $in: ["Computer", "IT", "E&TC"] }
}).toArray();

teachers.filter(t => {
  const total = t.salary.basic + t.salary.TA + t.salary.DA + t.salary.HRA;
  return total >= 70000 && total <= 100000;
});



db.teachers.updateMany({},
[
    {
        $set:{
            total_sal : {
                $add : ["$salary.basic", "$salary.TA", "$salary.DA", "$salary.HRA"]
            }
        }
    }
]
)


db.teachers.find({
    deptname: { $in: ["Computer", "IT", "E&TC"] },
    total_sal : {$gte:70000 , $lte:100000}
})

 6. Update the experience of any teacher to 10 years and if the entry is not available in database consider the entry as new entry (use update function only) 

db.teachers.update(
  { name: "Mr. Ramesh Pawar" },   // condition — check if this teacher exists
  {
    $set: {
      name: "Mr. Ramesh Pawar",
      qualifications: "M.E.",
      deptname: "Computer",
      designation: "Assistant Professor",
      experience: { teaching: 10, industry: 0 },
      appointment_nature: "permanent",
      area_of_expertise: "Data Structures"
    }
  },
  { upsert: true }   // <-- insert new entry if not found
)


db.teachers.update(
  { name: "Mr. Ramesh Pawar" },   // condition — check if this teacher exists
  {
    $set: {
      name: "Mr. Ramesh Pawar",
      qualifications: "M.E.",
      deptname: "Computer",
      designation: "Assistant Professor",
      experience: { teaching: 10, industry: 0 },
      appointment_nature: "permanent",
      area_of_expertise: "Data"
    }
  },
  { upsert: true }   // <-- insert new entry if not found
)


db.teachers.update(
    { name: "Mr. Ramesh Pawar" },
    {
 $set: {
      name: "Mr. Ramesh Pawar",
      qualifications: "M..",
      deptname: "Computer",
      designation: "Assistant Professor",
      experience: { teaching: 10, industry: 0 },
      appointment_nature: "permanent",
      area_of_expertise: "Data"
    }
    },{
        upsert:true
    }
)


 7. Find the teachers‟ name and experience & arrange in decreasing order of experience 
 
 db.teachers.find(
    {

    },{
        name : 1, experience :1 ,_id:0
    }
 ).sort({
    "experience.teaching": -1
 })

 8. Use save() method to insert one entry in teachers collection 
db.teachers.insertOne({
    name : "vivek ",
    experience : {teaching:8 , industry :  2},
    date_of_joining :new Date("2015-10-23")
})

 9. Use update() method to change the designation of teachers whose experience is 10 years or above to Professor 
 
 db.teachers.updateMany({
    "experience.teaching" : {$gte :10}
 },{
    $set : {
        designation : "ss"
    }
 })
 

db.teachers.updateMany(
  {
    $expr: {
      $gte: [
        { $add: ["$experience.teaching", "$experience.industry"] },
        10
      ]
    }
  },
  {
    $set: { designation: "Professor" }
  }
)



db.teachers.updateMany(
    {},
        [
         
         {
             $set :  {
              tot_exp : { $add : ["$experience.teaching", "$experience.industry"]}
            }
         }
        ]
    
)

db.teachers.updateMany(
    {
        tot_exp : {$gte : 10}
    },{
        $set : {
             designation: "vivek" 
        }
    }
)



 10. Use save() method to change the designation of teachers to Professor. 
teacher = db.teachers.findOne({ name: "Mrs. Sneha Deshmukh" })
teacher.designation = "Professor"
db.teachers.replaceOne({ _id: teacher._id }, teacher, { upsert: true })




db.teachers.replaceOne(
  { name: "Mr. Ramesh Pawar" },
  {
    name: "Mr. Ramesh Pawar",
    qualifications: "Ph.D.",
    deptname: "Computer",
    designation: "Professor",
    experience: { teaching: 12, industry: 0 },
    appointment_nature: "permanent",
    area_of_expertise: "AI"
  },
  { upsert: true }
)

 11. Delete the documents from teachers collection having appointment_nature as “adhoc”. 
db.teachers.deleteMany({ appointment_nature: "adhoc" })


 12. Display with pretty() method, the first 3 documents in teachers collection in ascending order of experience

 db.<collection_name>.find().sort(<sorting_condition>).limit(<number>).pretty()


db.teachers.find().sort({ experience: 1 }).limit(3).pretty()

db.teachers.find().sort().limit().pretty()



db.teachers.aggregate([
  { $sort: { marks: -1 } },
  { $limit: 5 }
])

db.teachers.aggregate([
  { $match: { appointment_nature: "permanent"  } },
  { $count: "Total_IT_Students" }
])

db.purchase_orders.countDocuments({ product: "toothbrush" })


////count types
db.teachers.countDocuments({ appointment_nature: "permanent"})

















When you define operators ($match, $project, $cond, $gte, etc.) or key–value pairs



{ $match: { marks: { $gte: 40 } } }


here there are both condtion $ and key value mapping
