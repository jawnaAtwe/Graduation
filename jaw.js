

const mysql = require("mysql");
const util = require("util");
var express = require('express');
var app       = express();
const pool = mysql.createConnection({

    host: 'localhost',
    user: 'root',
    password: '',
    database: 'graduation',
  
  });

  console.log("hii");

// const query=util.promisify(pool.query).bind(pool);
// const server=app.listen(3000, ()=>{

// console.log("it is working")
// pool.connect(function(err) {
 
//   pool.query("SELECT * FROM users", function (err, result, fields) {
  
//     console.log(result);
//   });
// });


// });


pool.connect();

// app.get('/login', loginuser = async(request, res, next) => {
//     console.log("enter");
 
// 	let query1 = `SELECT *  FROM users where username='${request.query.username}' and userpass='${request.query.userpass}'`;
//     let result = await query(query1);
//     if ( error ){
//         response.status(400).send('Error in database operation');
//     } else {
        
//          console.log(results);
//         response.send(results);
//     }
   

// });




// app.listen(3000, function loginuser() {
//         console.log('Express server is listening on port 3000');
//     });
//     pool.connect();





app.get('/wish', function(request, response){
    console.log("back");
    let query1 = `SELECT *  FROM wish `;
    
    pool.query(query1, function(error, results){
        if ( error ){
            response.status(400).send('Error in database operation');
        } else {
             console.log(results);
            response.send(results);
        }
    });
});

app.get('/login', function(request, response){
    console.log("back");
    let query1 = `SELECT *  FROM users where username='${request.query.username}' and userpass='${request.query.userpass}'`;
    
    pool.query(query1, function(error, results){
        if ( error ){
            response.status(400).send('Error in database operation');
        } else {
             console.log(results);
            response.send(results);
        }
    });
});




app.get('/loginadmin', function(request, response){
    console.log("back");
    let query1 = `SELECT *  FROM admin where AdminName='${request.query.AdminName}' and AdminPass='${request.query.AdminPass}'`;
    
    pool.query(query1, function(error, results){
        if ( error ){
            response.status(400).send('Error in database operation');
        } else {
             console.log(results);
            response.send(results);
        }
    });
});



app.get('/register', function(request, response){
   
    let query1 = `INSERT INTO users (username,userpass,email,place,phone) VALUES ('${request.query.username}','${request.query.userpass}',' ${request.query.email}','${request.query.place}','${request.query.phone}')`;
    
    pool.query(query1, function(error, results){
        if ( error ){
            response.status(400).send('Error in database operation');
        } else {
             console.log(results);
            response.send("Success");
           
        }
    });
});

app.listen(3000, function () {
    console.log('Express server is listening on port 3000');
});
    



//delete
// pool.connect(function(err) {
//   if (err) throw err;
//   var sql = "DELETE FROM users WHERE username = 'amjad'";
//   pool.query(sql, function (err, result) {
//     if (err) throw err;
//     console.log("Number of records deleted: " + result.affectedRows);
//   });
// });






// //update
// pool.connect(function(err) {
//   if (err) throw err;
//   var sql = "UPDATE users SET username = 'jawna1' WHERE username = 'jawna'";
//   pool.query(sql, function (err, result) {
//     if (err) throw err;
//     console.log(result.affectedRows + " record(s) updated");
//   });
// });



