var mysql = require('mysql2');

var con = mysql.createConnection(
    {
        port: 3306,
        host: "127.0.0.1",
        user: "simon",
        password: "7MquJK8HrgpWKh",
        database:"products"
    }
);

con.connect(function(err) {
  if (err) throw err;
  console.log("Connected!");
});

// 
/* mysqlConnection.query(`
SELECT
    sku AS 'SKU'
FROM
    product_common;
`, function (err, result, fields) {
// if any error while executing above query, throw error
if (err) throw err;
// if there is no error, you have the result
// iterate for all the rows in result
Object.keys(result).forEach(function(key) {
  var row = result[key];
console.log(row.SKU)
});
});
*/


//const mysql = require('promise-mysql');
//const fs = require('fs');

// createTcpPool initializes a TCP connection pool for a Cloud SQL
// instance of MySQL.
const createTcpPool = async config => {
  // Note: Saving credentials in environment variables is convenient, but not
  // secure - consider a more secure solution such as
  // Cloud Secret Manager (https://cloud.google.com/secret-manager) to help
  // keep secrets safe.
  const dbConfig = {
    host: "127.0.0.1", // e.g. '127.0.0.1'
    port: "3306", // e.g. '3306'
    user: "root", // e.g. 'my-db-user'
    password: "7MquJK8HrgpWKh", // e.g. 'my-db-password'
    database: "products" // e.g. 'my-database'
    // ... Specify additional properties here.
    // ...config,
  };
  // Establish a connection to the database.
  return mysql.createPool(dbConfig);
};

app.get('/api/items',(req, res) => {
  let sqlQuery = "SELECT * FROM items";
  
  let query = conn.query(sqlQuery, (err, results) => {
    if(err) throw err;
    res.send(apiResponse(results));
  });
});
