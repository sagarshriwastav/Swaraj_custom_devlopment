@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Yarn Requirement Cds'
define view entity Zyarn_req1 as  select from I_MaterialBOMLink as A      
 left outer join  I_BillOfMaterialItemDEX   as  B on ( A.BillOfMaterial = B.BillOfMaterial 
 and A.BillOfMaterialVariant = '01' ) 
 
 left outer join I_MaterialBOMLink as c on ( B.BillOfMaterialComponent  = c.Material and
   B.BillOfMaterialComponent like 'FG%' and c.Plant = '1200'  )   
// left outer join I_BillOfMaterialItemDEX as D on  ( c.BillOfMaterial = D.BillOfMaterial and   c.BillOfMaterialVariant = '01'  )
// 
// left outer join I_MaterialBOMLink as e on ( D.BillOfMaterialComponent  = e.Material and
//   D.BillOfMaterialComponent like 'BD%' and e.Plant = '1200'  )   
// left outer join I_BillOfMaterialItemDEX as F on ( F.BillOfMaterial = e.BillOfMaterial  and F.BillOfMaterialVariant = '01'  )
// 
// left outer join I_MaterialBOMLink as G on (  F.BillOfMaterialComponent  = G.Material and F.BillOfMaterialComponent like 'BW%'    )
// left outer join I_BillOfMaterialItemDEX as H on ( H.BillOfMaterial =  G.BillOfMaterial and H.BillOfMaterialVariant = '01'  )
 
{

A.Material,
A.BillOfMaterialVariant ,
B.BOMHeaderBaseUnit , 
B.BillOfMaterialItemUnit,
B.BillOfMaterialComponent,
@Semantics.quantity.unitOfMeasure: 'BOMHEADERBASEUNIT'

B.BillOfMaterialItemQuantity 
,


c.BillOfMaterial as BomnO_FG 
//,
//D.BillOfMaterialComponent as Bom_COMPONENT_FG ,
//@Semantics.quantity.unitOfMeasure: 'BOMHEADERBASEUNIT'
//D.BillOfMaterialItemQuantity as FG_REQ_QTY 
//
//
//e.BillOfMaterial as BomnO_BD ,
//F.BillOfMaterialComponent as Bom_COMPONENT_BD, 
//@Semantics.quantity.unitOfMeasure: 'BOMHEADERBASEUNIT'
//F.BillOfMaterialItemQuantity as BD_REQ_QTY , 
//
//
//G.BillOfMaterial as BomnO_BW , 
//H.BillOfMaterialComponent as Bom_COMPONENT_BW , 
//@Semantics.quantity.unitOfMeasure: 'BOMHEADERBASEUNIT' 
//H.BillOfMaterialItemQuantity as BW_REQ_QTY
 

}
where A.Material = 'FFO00090904'  

