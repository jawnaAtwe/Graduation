const mysql = require("mysql");
const util = require("util");
var express = require('express');
var app       = express();
// const sendemail = require("./route/sendemail");

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



app.get('/infouser', function(request, response){
    console.log("information");

    let query1 = `SELECT *  FROM users where username='${request.query.username}' `;
    
    pool.query(query1, function(error, results){
        if ( error ){
            response.status(400).send('Error in database operation');
        } else {
             console.log(results);
            response.send(results);
        }
    });
});
//1




app.get('/listelement', function(request, response){
    console.log("backjojo");
    //compare if less go to insert
    //else send res notification
    let query1 = `INSERT INTO listselement (productName,listName,marketName,userName,manufacturing,price,amount) 
    VALUES ('${request.query.productName}','${request.query.listName}'
    ,' ${request.query.marketName}',' ${request.query.userName}',' ${request.query.manufacturing}', '${request.query.price}','${request.query.amount}')`;
    
    pool.query(query1, function(error, results){
        if ( error ){
            response.status(400).send('Error in database operation');
        } else {
             console.log(results);
            response.send("Success");
           
        }});});

        app.get('/deleteproduct', function(request, response){
            console.log("yes");
           
            let query1 = `DELETE FROM listselement  where listName ='${request.query.listname}' and productName='${request.query.nameproduct}' and username LIKE '%${request.query.username}%'
            and amount ='${request.query.amount}'`;
    
            pool.query(query1, function(error, results){
                if ( error ){
                    response.status(400).send('Error in database operation');
                } else {
                     
                   
                }
            });
        
        
        });
        
    app.get('/listelementselect', function(request, response){
            console.log("select");
           
            let query1 = `SELECT *  FROM list where listname LIKE '%${request.query.listname}%' `;
            
            pool.query(query1, function(error, results){
                if ( error ){
                    response.status(400).send('Error in database operation');
                } else {
                     
                     const p= results[0].username;
                     var number = p;
                     response.send((number).toString());
               
                   
                }
            });
        
        
        });

app.get('/update', function(request, response){
      //compare if less go to update
    //else nothing
    console.log("update");
let query11 = `SELECT *  FROM list where username LIKE '%${request.query.userName}%' and listname='${request.query.listName}' `;
 
    pool.query(query11, function(error, results){
        if ( error ){
            response.status(400).send('Error in database operation');
        } else {
            const p= results[0].price;
            console.log(p);
            const  j=request.query.price;
            const y=j.replace(/[$ ,]+/g,"");
            const j1=parseInt(y);
            // const fin= subtract(p, p1);
            console.log( p-j1);
           
        
            var number = p-j1;
            response.send((number).toString());
               
                console.log("yes");
  
           
                     
        }
    });
   
});


app.get('/nowupdate', function(request, response){
 
  console.log("nowupdate");
let query11 = `UPDATE list SET price ='${request.query.price}' where username LIKE '%${request.query.userName}%' and listname='${request.query.listName}' `;

  pool.query(query11, function(error, results){
      if ( error ){
          response.status(400).send('Error in database operation');
      } else {
        

         
                   
      }
  });
 
});


app.get('/deletelist', function(request, response){
    console.log("deletelist");
    let query1 = `DELETE FROM list  where listname ='${request.query.listname}' and username LIKE '%${request.query.username}%'`;
    
    pool.query(query1, function(error, results){
        if ( error ){
            response.status(400).send('Error in database operation');
        } else {
             
           
        }
    });
});
app.get('/deletelistitems', function(request, response){
    console.log("deletelist");
    let query1 = `DELETE FROM listselement  where listName ='${request.query.listName}' and username LIKE '%${request.query.userName}%'`;
    
    pool.query(query1, function(error, results){
        if ( error ){
            response.status(400).send('Error in database operation');
        } else {
             
           
        }
    });
});

app.get('/updatelist', function(request, response){
    console.log("updateee");
    let query1 = `UPDATE list SET listname = '${request.query.listnamenew}' 
    , price = '${request.query.pricenew}' 
   where listname ='${request.query.listname}' and username LIKE '%${request.query.username}%'`;
    
    pool.query(query1, function(error, results){
        if ( error ){
            response.status(400).send('Error in database operation');
        } else {
             
           
        }
    });
});
//1
app.get('/listitems', function(request, response){
    console.log("listitems1");
    let query1 = `SELECT *  FROM listselement where listName='${request.query.listname}' and userName LIKE '%${request.query.userName}%' `;
    
    pool.query(query1, function(error, results){
        if ( error ){
            response.status(400).send('Error in database operation');
        } else {
             console.log(results);
            response.send(results);
        }
    });
});


app.get('/wish', function(request, response){
    console.log("back");
    let query1 = `SELECT *  FROM products `;
    
    pool.query(query1, function(error, results){
        if ( error ){
            response.status(400).send('Error in database operation');
        } else {
             console.log(results);
            response.send(results);
        }
    });
});
app.get('/usersonline', function(request, response){
    console.log("users");
    let query1 = `SELECT *  FROM users`;
    
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


app.get('/getusernametoshare', function(request, response){
 
    let query1 = `SELECT * FROM list Where username LIKE '%${request.query.username}%' and listname='${request.query.listname}'`;
    
    
    pool.query(query1, function(error, results){
        if ( error ){
            response.status(400).send('Error in database operation');
        } else {
            const p= results[0].username;
            response.send((p).toString());
             
        }
    });
});
app.get('/share', function(request, response){
 
    let query1 = `UPDATE list SET username = '${request.query.username}+${request.query.person}' where 
     username LIKE '%${request.query.username1}%' and listname='${request.query.listname}'`;
    
    console.log(request.query.username);
    pool.query(query1, function(error, results){
        if ( error ){
            response.status(400).send('Error in database operation');
        } else {
             
        }
    });
});


app.get('/share1', function(request, response){
 
    let query1 = `UPDATE listselement SET userName = '${request.query.userName}+${request.query.person}'where 
     userName LIKE '%${request.query.userName1}%' and listName='${request.query.listName}'`;
    
    
    pool.query(query1, function(error, results){
        if ( error ){
            response.status(400).send('Error in database operation');
        } else {
             
        }
    });
});
app.get('/showlist', function(request, response){
    console.log("backshow");
    let query1 = `SELECT *  FROM list where username LIKE '%${request.query.username}%'`;
    
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

app.get('/sendemail', function(request, response){
    console.log("email");
    let query1 = `SELECT *  FROM listselement where listName='${request.query.listname}' and userName LIKE '%${request.query.username}%' `;
    
    pool.query(query1, function(error, results){
        if ( error ){
            response.status(400).send('Error in database operation');
        } else {
             console.log(results);
            response.send(results);
            



        }
    });

    // app.use('/sendemail', sendemail);
});
app.get('/reglist', function(request, response){
    console.log("backjojo");
    let query1 = `INSERT INTO list (username,listname,price) VALUES ('${request.query.username}','${request.query.listname}',' ${request.query.price}')`;
    
    pool.query(query1, function(error, results){
        if ( error ){
            response.status(400).send('Error in database operation');
        } else {
             console.log(results);
            response.send("Success");
           
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



