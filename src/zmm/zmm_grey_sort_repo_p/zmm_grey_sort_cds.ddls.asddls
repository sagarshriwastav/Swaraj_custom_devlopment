@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS FOR GERY SORT'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_GREY_SORT_CDS as select from zpp_sortmaster as A
left outer join  zpp_dyeing1 as B on (  B.greyshort =   A.material  )
left outer   join ZPP_BCO_CDS_SUM  as C on ( C.shortno = B.material  and C.sizbeemno = B.beamno)//  and   C.balancemtr > 0    )
left outer join ZMM_STOCK_SUBCON_CDS as D on ( D.Greyshort = A.material   and D.Batch = B.beamno )
left outer join ZMM_DISPATCH_CDS as E on (  E.Product = A.material )// and E.Delivery_Quantity < 0 )
left outer join   ZMM_STORAGE_SUM   as F  on ( F.Product = A.material )// and F.Batch = B.beamno )
// and F.StorageLocation = 'FG01'  and F.StorageLocation =  'VJOB' and  F.StorageLocation = 
//   'FN01' and F.StorageLocation = 'INS1' ) 

{ key A.material as greysort,
    
     A.pdno  as PD_SORT,
      A.dyeingsort,
      A.totalends as REED,
      A.reedspace,
      A.totalends,
//      B.totends ,
      C.balancemtr as BALANCE_MTR_ON_LOOM,
      C.loomno  as TOTAL_RUNNING_LOOM,
      C.NoofPeaces as batch_tot,
      
      D.MaterialBaseUnit,
 //     D.zunit,
         @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
//      @Semantics.quantity.unitOfMeasure: 'zunit'
      sum(D.MatlWrhsStkQtyInMatlBaseUnit)  as BEAM_MTR,
      D.Batch  as TOTAL_BEAM, 
      E.OrderQuantityUnit,
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
     sum( E.OrderQuantity) as OrderQuantity,
       @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      sum(E.Delivery_Quantity) as Delivery_Quantity,
       @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      E.Pending_Order_Qty,
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      sum(F.MatlWrhsStkQtyInMatlBaseUnit) as LOC_QTY,
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      E.fresh,
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      E.SW,
//      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
//      E.DG,
       @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      F.AT_GREY_GODOWAN,
       @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      F.AT_JOB_WORK,
       @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      F.FINISH_GODOWAN,
       @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      F.AT_INSPECTION,
      F.StorageLocation,
      
      cast(  E.Pending_Order_Qty as abap.dec( 13, 2 ) ) - cast(  E.fresh as abap.dec( 13, 2 ) ) as required   , 
        
      cast(coalesce (cast( C.balancemtr   as abap.dec( 13, 2 ) ) ,0 ) * cast(0.79 as abap.dec( 10, 2 ) )  as abap.dec(23,2) )  +
      cast(coalesce (cast( D.MatlWrhsStkQtyInMatlBaseUnit  as abap.dec( 13, 2 ) ) ,0 )  * cast(0.79 as abap.dec( 10, 2 ) )  as abap.dec(23,2) ) + 
      cast(coalesce (cast( F.AT_GREY_GODOWAN as abap.dec( 13, 2 ) ) ,0 )  * cast(0.86 as abap.dec( 10, 2 ) )      as abap.dec(23,2) ) +
      cast(coalesce (cast( F.AT_JOB_WORK  as abap.dec( 13, 2 ) ) ,0 )   * cast(0.86 as abap.dec( 10, 2 ) ) as abap.dec(23,2) )  +
      cast(coalesce (cast( F.AT_INSPECTION  as abap.dec( 13, 2 ) ) ,0 ) as abap.dec(23,2) ) as ESTIMATED_FIN_GREY_IN_PRO,
      
//      case when  C.balancemtr > 0
//      then
//     cast(  C.balancemtr as abap.dec( 13, 2 ) ) + cast(D.MatlWrhsStkQtyInMatlBaseUnit as abap.dec( 13, 2 ) ) / 290 / cast(  C.loomno as abap.dec( 13, 2 ) )  as estimated_days
    cast( cast(  C.balancemtr as abap.dec( 13, 2 ) ) + cast(D.MatlWrhsStkQtyInMatlBaseUnit as abap.dec( 13, 2 ) ) /  cast(290  as abap.dec( 13, 2 ) ) / cast(  C.loomno as  abap.dec( 13, 2 ) ) as abap.dec( 16, 3 ) )  as estimated_days,
//    sum(cast( E.CD as abap.dec( 13, 2 ) ) + cast(  E.SV as abap.dec( 13, 2 )) +   cast(  E.SL as abap.dec( 13, 2 )) ) as DG
     
     sum(
         cast( 
         coalesce( cast( E.CD as abap.dec(13, 2) ), 0 ) +
         coalesce( cast( E.SV as abap.dec(13, 2) ), 0 ) +
         coalesce( cast( E.SL as abap.dec(13, 2) ), 0 ) as abap.dec(13, 2) ) )  as DG
    
}
 where A.material like 'FFO%'   
 
 group by 
     A.material,
      A.pdno,
       A.dyeingsort,
       A.totalends ,
        A.reedspace,
      A.totalends,
       C.balancemtr ,
        C.loomno ,
         D.MaterialBaseUnit,
         D.Batch ,
         D.MatlWrhsStkQtyInMatlBaseUnit,
           E.OrderQuantityUnit,
//             E.OrderQuantity,
//              E.Delivery_Quantity,
                E.Pending_Order_Qty,
      F.MatlWrhsStkQtyInMatlBaseUnit,
       E.fresh,
        E.SW,
//         E.DG,
           F.AT_GREY_GODOWAN,
             F.AT_JOB_WORK,
              F.FINISH_GODOWAN,
               F.AT_INSPECTION,
                C.NoofPeaces,
      F.StorageLocation
     
      
     
