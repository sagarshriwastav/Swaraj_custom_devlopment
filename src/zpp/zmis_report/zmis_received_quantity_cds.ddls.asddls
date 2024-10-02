@AbapCatalog.sqlViewName: 'YRECEIVEDMIS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMIS_RECEIVED_QUANTITY_CDS'
define view ZMIS_RECEIVED_QUANTITY_CDS as select from ZMIS_RECEIVED_QUANTITY
{
      Batch1 as Batch,
      YarnMaterial,
      MaterialBaseUnit ,
      @Semantics.quantity.unitOfMeasure : 'MaterialBaseUnit'
      sum(QuantityInBaseUnit) as QuantityInBaseUnit
    
}  
     group by 
              YarnMaterial,
              Batch1,
              MaterialBaseUnit
