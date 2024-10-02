@AbapCatalog.sqlViewName: 'YDENIMFINSTOK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Denim Finish Entry'
define view ZPP_FINISH_ENTRY_STOCK as select from I_MaterialStock_2 as a 
   inner join I_Product as b on ( b.Product = a.Material  )
{
    key a.Material,
    key a.Plant,
    key a.StorageLocation,
    key a.Batch,
        a.MaterialBaseUnit,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
       sum(a.MatlWrhsStkQtyInMatlBaseUnit) as Stock
} where b.ProductType = 'ZFFO' or b.ProductType = 'ZGFO' or b.ProductType = 'ZPDN'
   group by  
       a.Material,
       a.Plant,
       a.StorageLocation,
       a.Batch,
       a.MaterialBaseUnit
