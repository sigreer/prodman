const mysql = require('mysql');
let product_type = ''
//MySQL Server and Database connection
var mysqlConnection = mysql.createConnection({
host: 'localhost',
user: 'root',
password: '7MquJK8HrgpWKh',
database: 'products',
multipleStatements: true
});



//If error encountered, pass exception to error handler
mysqlConnection.connect((err) =>{
    if(err) throw err;
    console.log('Mysql Connected with App...');



// function getAttrTable(product_type) {   
let product_type = 'monitor';
let attrTable = [];
let row;
mysqlConnection.query(`
  SELECT
    COLUMN_NAME
  FROM
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
    WHERE REFERENCED_TABLE_SCHEMA = 'products'
    AND TABLE_NAME = '`+product_type+`'
    AND REFERENCED_COLUMN_NAME = 'id'
    AND NOT REFERENCED_TABLE_NAME = 'product_common';
  `,
  function (err, result, fields) {
    if (err) throw err;
    Object.keys(result).forEach(function(key) {
    let row = result[key];
    attrTable.push(row.COLUMN_NAME);
  });
  console.log(attrTable);
});

// };



const port = process.env.PORT || 8080;
//app.listen(port, () => console.log(`Listening on port ${port}..`));
});