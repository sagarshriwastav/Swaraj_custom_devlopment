@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'yarn requirement report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZYARN_REQ_2 as select from zyarn_req  as a         

{
a.SalesDocument ,
a.SalesDocumentItem ,
a.Plant,
a.BillOfMaterialComponent ,
a.BillOfMaterial as  BomnO ,
a.BOMHeaderBaseUnit ,
@Semantics.quantity.unitOfMeasure: 'BOMHeaderBaseUnit'
 ( a.BillOfMaterialItemQuantity ) as BillOfMaterialItemQuantity ,
 @Semantics.quantity.unitOfMeasure: 'BOMHeaderBaseUnit'
 cast ( ( a.BillOfMaterialItemQuantity * a.OrderQuantity ) / 100 as abap.quan( 10, 3 ) )   as ReqQunatity ,
 
 
'2' as LEVEL1 ,
case
when  a.BillOfMaterialComponent   like 'FG%'
then 'A2' 
else 'A3' end as GRADE

}
where a.BillOfMaterialComponent is not initial  


union select from zyarn_req as a  
{
a.SalesDocument ,
a.SalesDocumentItem ,
a.Plant,
a.Bom_COMPONENT_FG as BillOfMaterialComponent ,
a.BomnO_FG as BomnO ,
a.BOMHeaderBaseUnit ,
(  a.FG_REQ_QTY   )  as BillOfMaterialItemQuantity ,
//@Semantics.quantity.unitOfMeasure: 'BOMHEADERBASEUNIT'
 cast ( ( a.FG_REQ_QTY  * ( ( a.BillOfMaterialItemQuantity * a.OrderQuantity ) / 100 ) / 100 )  as abap.quan( 10, 3 ) )   as ReqQunatity ,
//cast ( ( cast ( ( a.BillOfMaterialItemQuantity * a.OrderQuantity ) / 100 as abap.quan( 10, 2 ) )  * a.OrderQuantity ) / 100 as abap.quan( 10, 2 ) )   as ReqQunatity ,


'3' as LEVEL1 ,
case
when  a.Bom_COMPONENT_FG   like 'BD%'
then 'B2' 
else 'B3' end as GRADE

 }
 where a.Bom_COMPONENT_FG is not initial 
union select from zyarn_req  as a   
 {
 a.SalesDocument ,
a.SalesDocumentItem ,
a.Plant,
 a.Bom_COMPONENT_BD as BillOfMaterialComponent ,
 a.BomnO_BD as BomnO ,
 //OrderQuantity,
 a.BOMHeaderBaseUnit ,
 (  a.BD_REQ_QTY  ) as BillOfMaterialItemQuantity,
// @Semantics.quantity.unitOfMeasure: 'BOMHEADERBASEUNIT'
 // cast ( ( a.BD_REQ_QTY  * a.OrderQuantity ) / 100 as abap.quan( 10, 2 ) )   as ReqQunatity ,
 cast ( ( a.BD_REQ_QTY *  ( a.FG_REQ_QTY  * ( ( a.BillOfMaterialItemQuantity * a.OrderQuantity ) / 100 ) / 100 ) / 100 )
      as abap.quan( 10, 3 ) )   as ReqQunatity ,
 
 '4' as LEVEL1,
case
when  a.Bom_COMPONENT_BD   like 'BW%'
then 'C2' 
else 'C3' end as GRADE
 
 
 
 }
 where a.Bom_COMPONENT_BD is not initial 
 union select from zyarn_req as a  
 
 {
 a.SalesDocument ,
 a.SalesDocumentItem ,
 a.Plant,
 a.Bom_COMPONENT_BW as BillOfMaterialComponent ,
 a.BomnO_BW as BOMNO ,
 //OrderQuantity,
 a.BOMHeaderBaseUnit ,
 ( a.BW_REQ_QTY )   as BillOfMaterialItemQuantity , 
 cast ( ( a.BW_REQ_QTY * ( ( a.BD_REQ_QTY *  ( a.FG_REQ_QTY  * ( ( a.BillOfMaterialItemQuantity * a.OrderQuantity ) / 100 ) / 100 ) / 100 ) ) / 100 )
 as abap.quan( 10, 3 ) )   as ReqQunatity ,
 
 
  '4' as LEVEL1 ,
 'D1'  as GRADE

 } 
 where a.Bom_COMPONENT_BW is not initial 
 
 union select from zyarn_req as a   
 {
  a.SalesDocument , 
  a.SalesDocumentItem ,
  a.Plant,
  a.Material as BillOfMaterialComponent ,
  ' ' as Bomno ,
  //OrderQuantity,
  a.OrderQuantityUnit as BOMHeaderBaseUnit ,
 ( a.OrderQuantity   )  as BillOfMaterialItemQuantity ,
 
  cast ( ( a.OrderQuantity   * a.OrderQuantity ) / a.OrderQuantity as abap.quan( 10, 3 ) )   as ReqQunatity ,
  
  //  cast ( ( a.OrderQuantity * ( ( a.BW_REQ_QTY * ( ( a.BD_REQ_QTY *  ( a.FG_REQ_QTY  * ( ( a.BillOfMaterialItemQuantity * a.OrderQuantity ) / 100 ) / 100 ) / 100 ) ) / 100 ) ) / a.OrderQuantity ) 
  //  as abap.quan( 10, 2 ) )   as ReqQunatity ,
  
 
  '4' as LEVEL1,
 case
when  a.Material   like 'FF%'
then 'A1' 
else 'ZZ' end as GRADE
 
 
 
 
 }
 




  
