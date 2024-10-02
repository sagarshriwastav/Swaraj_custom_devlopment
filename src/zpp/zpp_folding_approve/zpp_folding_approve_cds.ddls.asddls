@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '  FOLDING APPROVE CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_FOLDING_APPROVE_CDS as select from I_ManufacturingOrderItem as A
   left outer join  zpp_fold_approve as b on ( b.sno = A.Batch  )
   left outer join  I_MfgOrderWithStatus as c on (  c.ManufacturingOrder = A.ManufacturingOrder  )
{
  key    A.ManufacturingOrder,
         c.OrderIsTechnicallyCompleted,
            
        case when b.sno is not null or b.sno <> '' or b.sno is not initial
         then 'Approved' else '' end as SetApproved
}
    
