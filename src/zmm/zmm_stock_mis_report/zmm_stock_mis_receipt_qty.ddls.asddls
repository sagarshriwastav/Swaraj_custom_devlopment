@AbapCatalog.sqlViewName: 'YMIS_RECEIPT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMM_STOCK_MIS_RECEIPT_QTY'
define view ZMM_STOCK_MIS_RECEIPT_QTY
with parameters
     p_fromdate : abap.dats,
    p_todate   : abap.dats
as  select from ZMM_STOCK_MIS_OPENING_CDS( p_fromdate:$parameters.p_fromdate , p_todate:$parameters.p_todate)
 
{
   Plant,
 // PostingDate,
   ProductType,
 //  cast( case when MaterialBaseUnit = 'KG'  then 'M'  else  MaterialBaseUnit end as  abap.unit( 3 ) ) as  MaterialBaseUnit ,
   MaterialBaseUnit,
   CompanyCodeCurrency,
   @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
   sum(RECEIPTVALUE) as RECEIPTVALUE,
   @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
   sum(Receiptqty) as Receiptqty,
   @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
   sum(Issueqty) as Issueqty,
   @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
   sum(issuevalue) as issuevalue 
      
} where PostingDate between $parameters.p_fromdate  and $parameters.p_todate

   group by Plant,
   ProductType,
   MaterialBaseUnit,
 CompanyCodeCurrency
