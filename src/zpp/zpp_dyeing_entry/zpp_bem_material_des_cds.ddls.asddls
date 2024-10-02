@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Dyeing  Entry'
define root view entity ZPP_BEM_MATERIAL_DES_CDS as select from ZPP_BEM_MAT as a 
                   inner join I_MaterialDocumentItem_2 as c on ( c.Batch = a.Batch  )
                   inner join ymseg4 as d on ( d.MaterialDocument = c.MaterialDocument and d.MaterialDocumentItem = c.MaterialDocumentItem
                                               and d.MaterialDocumentYear = c.MaterialDocumentYear )
                 left outer join I_Supplier as e on ( e.Supplier = c.Supplier )                            
{
    
    key a.Batch, 
        c.GoodsRecipientName as Tarewt,
        e.SupplierName,
        a.MaterialBaseUnit,
         @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        sum( a.STOCKQTY ) as STOCKQTY
        
          
} where  c.GoodsMovementType = '501' and a.STOCKQTY > 0
      group by  
       a.Batch, 
       c.GoodsRecipientName,
       e.SupplierName,
       a.MaterialBaseUnit
       
      
          
