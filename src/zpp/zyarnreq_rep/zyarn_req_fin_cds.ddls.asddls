//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Cds For Yrarn Requirement Report'
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Yrarn Requirement Report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZYARN_REQ_FIN_CDS as  select from ZYARN_REQ_2 as a  
              left outer join ZYARN_PLANTMAT_STOCK as b on ( b.Material = a.BillOfMaterialComponent 
                                                and b.Plant = a.Plant )       

{    
   key a.SalesDocument,
   key a.SalesDocumentItem,
       a.Plant,
   a.BillOfMaterialComponent,
   a.BomnO,
   a.BOMHeaderBaseUnit,
   a.LEVEL1,
   a.GRADE,
   b.StorageLocation,
   b.MaterialBaseUnit,
   cast( case when b.StorageLocation <> ' ' then 'KG'
    else  'M' end as abap.unit( 2 ) ) as MaterialBaseUnit1 ,
    
   @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit1'
   a.BillOfMaterialItemQuantity,
 //  cast( a.BillOfMaterialItemQuantity as abap.quan( 10, 3 ) ) as BillOfMaterialItemQuantity,
   @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit1'
   a.ReqQunatity,
 //  cast(a.ReqQunatity as abap.quan( 10, 3 ) ) as ReqQunatity,
   
   @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit1'
   b.StockQty
 //  cast(b.StockQty as abap.quan( 10, 3 ) ) as StockQty
   
   
   } // where ( a.BillOfMaterialComponent like 'Y%' and b.StorageLocation like 'YRM1'  ) 
     // or ( a.BillOfMaterialComponent like 'S%' and b.StorageLocation like 'ST01')  
