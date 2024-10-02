@AbapCatalog.sqlViewName: 'YQUANTITY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMIS_RECEIVED_QUANTITY'
define view ZMIS_RECEIVED_QUANTITY as select from I_MaterialDocumentItem_2 as a
        left outer join I_MaterialDocumentItem_2 as c on ( c.Batch = a.Batch  and c.GoodsMovementType = '101') 
            

{

      a.IssgOrRcvgBatch as Batch1,
      a.Material as YarnMaterial,
      cast( 'KG'  as  abap.unit( 3 ) ) as  MaterialBaseUnit ,
      sum(c.QuantityInBaseUnit) as QuantityInBaseUnit
    
    
} where   a.Material like 'YGPC%' and a.GoodsMovementType = '311'
 
      group by 
                 a.IssgOrRcvgBatch,
                 a.Material
