module.exports = {
getAttrTable:`SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE REFERENCED_TABLE_SCHEMA = 'products' AND TABLE_NAME = '`+req.params.product_type+` AND REFERENCED_COLUMN_NAME = 'id' AND NOT REFERENCED_TABLE_NAME = 'product_common';`,
getProductDetails: 'SELECT * FROM '+req.params.product_type + joinAttrQueries;,
joinProductCommon: 'RIGHT JOIN product_common ON thin_client.product_id=product_common.id',
joinAttr: 'LEFT JOIN attr_'+attrGroup+' ON '+product_type+'.'+attrGroup+'_id='+attrGroup+'.id',
}