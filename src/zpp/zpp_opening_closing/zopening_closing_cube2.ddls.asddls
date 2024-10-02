@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Opening Closing CUBE 2'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZOPENING_CLOSING_CUBE2
  with parameters
    p_fromdate : abap.dats,
    p_todate   : abap.dats

  as select from    I_ProductPlantBasic                                                                          as mat
    left outer join ZOPENING_CLOSING_QTY( p_fromdate: $parameters.p_fromdate , p_todate: $parameters.p_todate ) as A on(
      A.Material  = mat.Product
      and A.Plant = mat.Plant
    )
 //  left outer join I_MaterialDocumentItem_2 as GOODS on ( GOODS.Batch = A.Batch and GOODS.Material = A.Material )
   
    left outer join I_ProductDescription                                                                         as E on(
      E.Product      = A.Material
      and E.Language = 'E'
    )
    
   
//  GAJENDRA SINGH    
    left outer join ZPP_GREY_GRN_REPORT  as J on (  J.Material = A.Material and J.Recbatch = A.Batch and J.Plant = A.Plant )
    left outer join ZOPENING_CLOSING_BILL as L on ( L.Material = A.Material  )
{
   
  key mat.Product         as Material,
  key mat.Plant,
  key A.Batch,
      A.CompanyCode,
      E.ProductDescription,
      cast( 'M' as abap.unit( 3 ) ) as MaterialBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      A.openingquantity as openingquantity,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      A.closing as closing,
      J.Partyname,
//      k.BillOfMaterial,
  //    L.BillOfMaterialComponent,
      L.BillOfMaterialItemUnit,
      @Semantics.quantity.unitOfMeasure: 'BillOfMaterialItemUnit'
      L.BillOfMaterialItemQuantity as BillOfMaterialItemQuantity,
      L.BillOfMaterial
     
      
      


}// where GOODS.GoodsMovementIsCancelled = '' // and PostingDate between $parameters.p_fromdate  and $parameters.p_todate
         

 
//group by
//       A.CompanyCode,
//       mat.Product,
//       mat.Plant,
//       A.Batch,
//       A.CompanyCode,
//       E.ProductDescription,
//  //     A.MaterialBaseUnit,
//       A.openingquantity,
//       A.closing ,
//       J.Partyname
//   //    L.BillOfMaterialItemUnit
//  
  
