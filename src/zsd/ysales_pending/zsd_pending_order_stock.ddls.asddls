@AbapCatalog.sqlViewName: 'YPENDING'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Pending Report Order Against Stock'
define view ZSD_PENDING_ORDER_STOCK as select from I_MaterialStock_2
{
     
    

     key SDDocument,
     key SDDocumentItem,
     key Material,
         MaterialBaseUnit,
         @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
         sum( MatlWrhsStkQtyInMatlBaseUnit ) as OrStock

}    where MaterialBaseUnit = 'M'
   group by 
         SDDocument,
         SDDocumentItem,
         Material,
         MaterialBaseUnit
