@AbapCatalog.sqlViewName: 'ZRECON'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GST RECON DATA'
define view YRECON as select from zgst_recon_data
{
  key documentnumber as Documentnumber,
  key itemdescription as Itemdescription,
  documenttype as Documenttype,
  documentdate as Documentdate,
  erpsource as Erpsource,
  vouchernumber as Vouchernumber,
  voucherdate as Voucherdate,
  isbillofsupply as Isbillofsupply,
  isreversecharge as Isreversecharge,
  isdocumentcancelled as Isdocumentcancelled,
  suppliername as Suppliername,
  suppliergstin as Suppliergstin,
  customername as Customername,
  customeraddress as Customeraddress,
  customerstate as Customerstate,
  customergstin as Customergstin,
  placeofsupply as Placeofsupply,
  itemcategory as Itemcategory,
  hsnsaccode as Hsnsaccode,
  itemquantity as Itemquantity,
  itemunitcode as Itemunitcode,
  itemunitprice as Itemunitprice,
  itemdiscount as Itemdiscount,
  itemtaxableamount as Itemtaxableamount,
  cgstrate as Cgstrate,
  cgstamount as Cgstamount,
  sgstrate as Sgstrate,
  sgstamount as Sgstamount,
  igstrate as Igstrate,
  igstamount as Igstamount,
  cessrate as Cessrate,
  cessamount as Cessamount,
  documenttotalamount as Documenttotalamount,
  templateid as Templateid,
  groupid as Groupid  
}
