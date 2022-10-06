const mysql = require('mysql');
const express = require('express');
const bodyparser = require('body-parser');
const app = express();
app.use(bodyparser.json());

// DATABASE CONNECTION DETAILS
var mysqlConnection = mysql.createConnection({
host: 'localhost',
user: 'root',
password: '7MquJK8HrgpWKh',
database: 'products',
multipleStatements: true
});

// CONNECT TO DATABASE AND OPEN API PORT
mysqlConnection.connect((err) =>{if(err) throw err; console.log('Ready!');});
const port = process.env.PORT || 8080;
app.listen(port, () => console.log(`API listening on ${port}..`));

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
app.get('/api/product' , (req, res) => {
  mysqlConnection.query('SELECT * FROM product_common', (err, rows, fields) => {
  if (!err)
  res.send(apiResponse(rows));
  else
  console.log(err);
  });
  });


// Function - List product types
let setProductTypes = [];
const tblProductTypes = {
  productTypeLabel: function () {
      mysqlConnection.query(qryProductTypeLabel, (err, rows, fields) => {
        if (!err) 
        Object.keys(rows).forEach(function(key) {
          let row = rows[key];
          setProductTypes.push(row.product_type_label);
        });
      });
   },
  productTypeName:function () {
      mysqlConnection.query(qryProductTypeName, (err, rows, fields) => {
        if (!err) 
        Object.keys(rows).forEach(function(key) {
          let row = rows[key];
          setProductTypes.push(row.product_type_name);
        });
      });
  },  
  productType:function () {
    mysqlConnection.query(qryProductType, (err, rows, fields) => {
      if (!err) 
      Object.keys(rows).forEach(function(key) {
        let row = rows[key];
        setProductTypes.push(row.product_type);
      });
    });
  }
};

app.get('/api/product-types2' , (req, res) => {  
  res.send(apiResponse(tblProductTypes.productTypeName(setProductTypes[0])));  
  });




// WORKING

app.get('/api/product-types' , (req, res) => {  
    mysqlConnection.query(qryProductType, (err, rows, fields) => {
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
let query = mysqlConnection.query(sqlQuery, (err, result) => {
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
mysqlConnection.query('SELECT * FROM product', (err, rows, fields) => {
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
mysqlConnection.query(listProductQuery, (err, rows, fields) => {
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
    let query = mysqlConnection.query(sqlQuery, (err, results) => {
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
  let query = mysqlConnection.query(sqlQuery, (err, results) => {
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
  console.log('Server started on port 3000...');
});