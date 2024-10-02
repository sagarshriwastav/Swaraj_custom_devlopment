@AbapCatalog.sqlViewName: 'YCDSNET'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For ZSSOR Report'
define view ZSSOR_NET_WT_CDS as select from I_DeliveryDocumentItem as A
 left outer join ZJOB_GREY_NETWT_DISPATCH_CDS as C on ( C.Material = A.Material 
                                 and C.Recbatch = A.Batch and C.Plant = A.Plant ) 
{
  key A.DeliveryDocument,
  key A.HigherLvlItmOfBatSpltItm as DELIVERYDOCUMENTITEM,
      cast('KG' as abap.unit( 3 ) ) as ukg,
      @Semantics.quantity.unitOfMeasure : 'ukg'
       sum(C.Netwt) as netwt
}  
   where A.HigherLvlItmOfBatSpltItm is not initial
group by 
         A.DeliveryDocument, 
         A.HigherLvlItmOfBatSpltItm
       
