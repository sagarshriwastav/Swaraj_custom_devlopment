@AbapCatalog.sqlViewName: 'ZGST_DATA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GST RECON PUSHED DATA WITH ERROR MESSAGE'
define view YGST_RECON_PUSHED_DATA as select from zgst_recon_data
{
   key documentnumber          as Documentnumber,
   key itemdescription         as Itemdescription,
//   documenttype                as Documenttype,
//   doc_type                    as Documenttype, 
//   document_type               as Documenttype,
   document_type               as Documenttype,
   documentdate                as Documentdate, 
   erpsource                   as Erpsource,
   vouchernumber               as DocumentReferenceID,
   voucherdate                 as Voucherdate,
   fiscalyear                  as FiscalYear,
   companycode                 as CompanyCode,
   businessplace               as BusinessPlace,
//   isbillofsupply              as Isbillofsupply,
//   isreversecharge             as Isreversecharge,
//   isdocumentcancelled         as Isdocumentcancelled,
//   suppliername                as Suppliername,
//   suppliergstin               as Suppliergstin,
//   supplier_gstin              as Suppliergstin,
     suppliername,
     supplier_add,
   supp_gstin                    as Suppliergstin,
   supplier_name,
   supplier_address,          
//   customername                as Customername,
//   customeraddress             as Customeraddress,
//   customerstate               as Customerstate,
//   customergstin               as Customergstin,
//    cust_gstin                 as Plant_GSTIN,
   customer_gstin              as Plant_GSTIN,       
   itemtaxableamount           as Itemtaxableamount,
   cgstrate                    as Cgstrate,
   cgstamount                  as Cgstamount,
   sgstrate                    as Sgstrate,
   sgstamount                  as Sgstamount,
   igstrate                    as Igstrate,
   igstamount                  as Igstamount,
//   cessrate                    as Cessrate,
//   cessamount                  as Cessamount,
//   documenttotalamount         as Documenttotalamount,
//   templateid                  as Templateid,
//   groupid                     as Groupid,
   success_indctr              as SuccessIndctr,
   report                     as report,
//   responce                    as Responce 
//   error_msg                   as ErrorMsg
    error_message             as ErrorMsg
   
}
