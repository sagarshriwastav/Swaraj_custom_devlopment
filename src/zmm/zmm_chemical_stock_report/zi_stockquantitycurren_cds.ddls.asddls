@AbapCatalog.sqlViewName: 'YSUMQUANTITY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Mat & Plant Sum Quantity'
define view ZI_StockQuantityCurren_CDS as select from I_StockQuantityCurrentValue_2( P_DisplayCurrency:'INR')as A

{
   key A.Product,
   key A.Plant ,
       sum( A.MatlWrhsStkQtyInMatlBaseUnit )  as TotalStockInPlant   

}  where A.ValuationAreaType = '1'
 group by   
     A.Product,
      A.Plant
