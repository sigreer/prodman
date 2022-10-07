const mysql = require('mysql');
const express = require('express');
const bodyparser = require('body-parser');
const app = express();
app.use(bodyparser.json());

// Login ASCII Art
const loginart = `
_____               _                       
|  __ \\             | |                      
| |__) | __ ___   __| |_ __ ___   __ _ _ __  
|  ___/ \'__/ _ \\ / _\` | \'_ \` _ \\ / _\` \| \'_ \\ 
| |   | | | (_) | (_| | | | | | | (_| | | | |
|_|   |_|  \\___/ \\__,_|_| |_| |_|\\__,_|_| |_|
                                             
                                             `

// IMPORT ENVIRONMENT VARIABLES/CREDENTIALS
// -- yes, I know you shouldn't but it's handy during dev!
require('dotenv').config();
const dbhost = process.env.DBHOST;
const dbrootpass = process.env.DBROOTPASS;
const dbname = process.env.DBNAME;

// DATABASE CONNECTION DETAILS
var sqlConn = mysql.createConnection({
host: dbhost,
user: 'root',
password: dbrootpass,
database: dbname,
multipleStatements: true
});

// CONNECT TO DATABASE AND OPEN API PORT
sqlConn.connect((err) =>{if(err) throw err; console.log(loginart); console.log('READY!');});
const port = process.env.PORT || 8080;
app.listen(port, () => console.log(`Frontend listening on port  ${port}`));

// VARIABLES
let productType;
let productTypeLabel;
let joinAttrQueries;
let attrGroup;
let attrTable = [];
let row;
let typeTable = [];
let sqlQuery;
// SQL queries as variables
const getAttrTable = `SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE REFERENCED_TABLE_SCHEMA = 'products' AND TABLE_NAME = '`+productType+`' AND REFERENCED_COLUMN_NAME = 'id' AND NOT REFERENCED_TABLE_NAME = 'product_common';`;
const getProductDetails = 'SELECT * FROM '+productType + joinAttrQueries+';';
const joinProductCommon = 'RIGHT JOIN product_common ON thin_client.product_id=product_common.id';
const joinAttr = 'LEFT JOIN '+attrGroup+' ON '+productType+'.'+attrGroup+'_id='+attrGroup+'.id';
const qryProductTypeName = 'SELECT product_type_name FROM product_type_enforcer;';
const qryProductType = 'SELECT * FROM product_type_enforcer;';
const qryProductTypeLabel = 'SELECT * FROM product_type_enforcer;';
// API - GET ALL PRODUCTS
/**
 * Get All Items
 *
 * @return response()
 */

// Create GET Router to fetch all items from product table
app.get('/api/products' , (req, res) => {
  sqlConn.query('SELECT * FROM product_common', (err, rows, fields) => {
  if (!err)
  res.send(apiResponse(rows));
  else
  console.log(err);
  });
  });


app.get('/api/product-types/:product_type/attributes', (req, res) => 
  {
    sqlConn.query('SELECT product_type, product_type_name FROM product_type_enforcer WHERE product_type_name = \''+req.params.product_type+'\';', (err, rows, fields) => {
      if (!err)
      res.send(apiResponse(rows[0].product_type));
      else
      console.log(err);
    });
  }
);

// /////////////IWASHERE
sqlConn.query('SELECT product_type FROM product_type_enforcer WHERE product_type_name = \'thin_client\';', (err, rows, fields) => {
      if (!err)
      Object.keys(rows).forEach(function(key) {
        let row = rows[key];
        tblProductType.push(row);
      })
      else console.log('err');
      console.log(tblProductType[0])
});



      // WORKING

app.get('/api/product-types' , (req, res) => {  
    sqlConn.query(qryProductType, (err, rows, fields) => {
      let tblProductType = [];
      if (!err) 
      Object.keys(rows).forEach(function(key) {
        let row = rows[key];
        tblProductType.push(row);
    })
    else console.log('Error');
    res.send(apiResponse(tblProductType));  
    });
  });
  //res.send(apiResponse((listProductTypes(), tblProductTypes)));


// API - PRODUCT TYPE ATTRIBUTE GROUP LIST
app.get('/api/product-types/:product_type',(req, res) => {
let productType = req.params.product_type;
let sqlQuery = `SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE REFERENCED_TABLE_SCHEMA = 'products' AND TABLE_NAME = '`+productType+`' AND REFERENCED_COLUMN_NAME = 'id' AND NOT REFERENCED_TABLE_NAME = 'product_common';`;
let query = sqlConn.query(sqlQuery, (err, result) => {
    if (err) throw err;
    Object.keys(result).forEach(function(key) {
    let row = result[key];
    attrTable.push(row.COLUMN_NAME);
  });
  res.send(apiResponse(attrTable));
});
});


// Create GET Router to fetch all items from product table
app.get('/api/product' , (req, res) => {
sqlConn.query('SELECT * FROM product', (err, rows, fields) => {
if (!err)
res.send(rows);
else
console.log(err);
});
});

//Creating GET router for thin clients
app.get('/api/product/thin-client',(req, res) => {
  let listProductQuery = `
  SELECT * FROM thin_client 
    RIGHT JOIN product_common ON thin_client.product_id=product_common.id
    LEFT JOIN attr_cpu ON thin_client.attr_cpu_id=attr_cpu.id
    LEFT JOIN attr_ram ON thin_client.attr_ram_id=attr_ram.id
    LEFT JOIN attr_energy ON thin_client.attr_energy_id=attr_energy.id
    LEFT JOIN attr_security ON thin_client.attr_security_id=attr_security.id
    LEFT JOIN attr_graphics ON thin_client.attr_graphics_id=attr_graphics.id
    LEFT JOIN attr_network ON thin_client.attr_network_id=attr_network.id
    LEFT JOIN attr_physical ON thin_client.attr_physical_id=attr_physical.id
    LEFT JOIN attr_ports ON thin_client.attr_ports_id=attr_ports.id
    LEFT JOIN attr_ssd_storage ON thin_client.attr_ssd_storage_id=attr_ssd_storage.id
    LEFT JOIN attr_thin_client_software ON thin_client.attr_thin_client_software_id=attr_thin_client_software.id;
  `
sqlConn.query(listProductQuery, (err, rows, fields) => {
if (!err)
res.send(apiResponse(results));
else
console.log(err);
});
});

/**
 * Get Single Item
 *
 * @return response()
 */
 app.get('/api/product/thin-client/:sku',(req, res) => {
    let sqlQuery = `
    SELECT * FROM thin_client 
    RIGHT JOIN product_common ON thin_client.product_id=product_common.id
      LEFT JOIN attr_cpu ON thin_client.attr_cpu_id=attr_cpu.id
      LEFT JOIN attr_ram ON thin_client.attr_ram_id=attr_ram.id 
      LEFT JOIN attr_energy ON thin_client.attr_energy_id=attr_energy.id
      LEFT JOIN attr_security ON thin_client.attr_security_id=attr_security.id 
      LEFT JOIN attr_graphics ON thin_client.attr_graphics_id=attr_graphics.id
      LEFT JOIN attr_network ON thin_client.attr_network_id=attr_network.id 
      LEFT JOIN attr_physical ON thin_client.attr_physical_id=attr_physical.id
      LEFT JOIN attr_ports ON thin_client.attr_ports_id=attr_ports.id
      LEFT JOIN attr_ssd_storage ON thin_client.attr_ssd_storage_id=attr_ssd_storage.id
      LEFT JOIN attr_thin_client_software ON thin_client.attr_thin_client_software_id=attr_thin_client_software.id
      WHERE product_common.sku='`+req.params.sku+"';";
    let query = sqlConn.query(sqlQuery, (err, results) => {
      if(err) throw err;
      res.send(apiResponse(results));
    });
  });

  /**
 * Delete Item
 *
 * @return response()
 */
app.delete('/api/product/thin-client/:sku',(req, res) => {
  let sqlQuery = "DELETE thin_client FROM thin_client RIGHT JOIN product_common ON thin_client.product_id=product_common.id WHERE product_common.sku='"+req.params.sku+"'; DELETE product_common FROM product_common WHERE product_common.sku='"+req.params.sku+"';";
  let query = sqlConn.query(sqlQuery, (err, results) => {
    if(err) throw err;
      res.send(apiResponse(results));
  });
});

  /**
 * API Response
 *
 * @return response()
 */
function apiResponse(results){
    return JSON.stringify({"status": 200, "error": null, "response": results});
}

/*------------------------------------------
--------------------------------------------
Server listening
--------------------------------------------
--------------------------------------------*/
app.listen(3000,() =>{
  console.log('API Listening on port       3000');

});
