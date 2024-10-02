@AbapCatalog.sqlViewName: 'YBILLQUANTITY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZOPENING_CLOSING_BILL'
define view ZOPENING_CLOSING_BILL as select from I_MaterialBOMLink as a
    left outer join I_BillOfMaterialItemDEX as b on ( b.BillOfMaterial = a.BillOfMaterial )
{
      a.Material,
      a.Plant,
      a.BillOfMaterial,
 //     b.BillOfMaterialComponent,
      b.BillOfMaterialItemUnit,
      @Semantics.quantity.unitOfMeasure: 'BillOfMaterialItemUnit'
      sum(b.BillOfMaterialItemQuantity) as BillOfMaterialItemQuantity
      
} where b.BillOfMaterialComponent like 'Y%'

 group by  a.Material,
           a.Plant,
           a.BillOfMaterial,
  //         b.BillOfMaterialComponent,
           b.BillOfMaterialItemUnit
