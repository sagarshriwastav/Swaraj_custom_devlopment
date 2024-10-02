@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'yarn requirement report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zyarn_req as select from
I_SalesDocumentItem as P inner join 

 I_MaterialBOMLink as A   on ( P.Material = A.Material    )    
 left outer join  I_BillOfMaterialItemDEX   as  B on ( A.BillOfMaterial = B.BillOfMaterial 
 and A.BillOfMaterialVariant = '01'   ) 
 
 left outer join I_MaterialBOMLink as c on ( B.BillOfMaterialComponent  = c.Material and
   B.BillOfMaterialComponent like 'FG%' ) //and c.Plant = '1200'   )   
 left outer join I_BillOfMaterialItemDEX as D on  ( c.BillOfMaterial = D.BillOfMaterial 
 and   c.BillOfMaterialVariant = '01'   )
 
 left outer join I_MaterialBOMLink as e on ( D.BillOfMaterialComponent  = e.Material and
   D.BillOfMaterialComponent like 'BD%' and e.Plant = '1200'  )   
 left outer join I_BillOfMaterialItemDEX as F on ( F.BillOfMaterial = e.BillOfMaterial  and F.BillOfMaterialVariant = '01' 
   )
 
 left outer join I_MaterialBOMLink as G on (  F.BillOfMaterialComponent  = G.Material and F.BillOfMaterialComponent like 'BW%'    )
 left outer join I_BillOfMaterialItemDEX as H on ( H.BillOfMaterial =  G.BillOfMaterial and
  H.BillOfMaterialVariant = '01'  )
 
{
P.SalesDocument ,
P.SalesDocumentItem,
P.Plant,
P.OrderQuantityUnit ,
@Semantics.quantity.unitOfMeasure: 'BOMHEADERBASEUNIT'
P.OrderQuantity ,
P.Material as SalesOrderMaterial ,
A.Material,
A.BillOfMaterialVariant ,
B.BOMHeaderBaseUnit , 
B.BillOfMaterial ,
B.BillOfMaterialItemUnit,

B.BillOfMaterialComponent,
@Semantics.quantity.unitOfMeasure: 'BOMHEADERBASEUNIT'
B.BillOfMaterialItemQuantity ,

//@Semantics.quantity.unitOfMeasure: 'BOMHEADERBASEUNIT'
//cast ( ( B.BillOfMaterialItemQuantity * P.OrderQuantity ) / 100 as abap.quan( 10, 2 ) )   as Fgquantity ,



c.BillOfMaterial as BomnO_FG 
,
D.BillOfMaterialComponent as Bom_COMPONENT_FG ,
@Semantics.quantity.unitOfMeasure: 'BOMHEADERBASEUNIT'
D.BillOfMaterialItemQuantity as FG_REQ_QTY ,


e.BillOfMaterial as BomnO_BD ,
F.BillOfMaterialComponent as Bom_COMPONENT_BD, 
@Semantics.quantity.unitOfMeasure: 'BOMHEADERBASEUNIT'
F.BillOfMaterialItemQuantity as BD_REQ_QTY , 


G.BillOfMaterial as BomnO_BW , 
H.BillOfMaterialComponent as Bom_COMPONENT_BW , 
@Semantics.quantity.unitOfMeasure: 'BOMHEADERBASEUNIT' 
H.BillOfMaterialItemQuantity as BW_REQ_QTY
 

}
//where 
//P.SalesDocument = '0070000004' 
//A.Material = 'FFO00090904'  
