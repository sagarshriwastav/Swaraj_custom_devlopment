@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Dyeing  Entry'
define root view entity ZPP_BEM_MAT as select from I_MaterialStock_2 as a 
//                   inner join I_MaterialDocumentItem_2 as c on ( c.Batch = a.Batch  )
//                   inner join ymseg4 as d on ( d.MaterialDocument = c.MaterialDocument and d.MaterialDocumentItem = c.MaterialDocumentItem
//                                               and d.MaterialDocumentYear = c.MaterialDocumentYear )
//                 left outer join I_Supplier as e on ( e.Supplier = c.Supplier )                            
{
    
    key a.Material,
    key a.Plant,
    key a.Batch, 
//        c.GoodsRecipientName as Tarewt,
//        e.SupplierName,
        a.MaterialBaseUnit,
         @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        sum(a.MatlWrhsStkQtyInMatlBaseUnit) as STOCKQTY
        
          
} where a.Material like 'BEAM%' 
      group by  
        a.Material,
        a. Plant,
        a.Batch, 
//       c.GoodsRecipientName,
//       e.SupplierName,
        a.MaterialBaseUnit
       
      
          
