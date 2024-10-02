@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZSUBCON_tabl2'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSUBCON_tabl2 as select from zsubcon_item as a
left outer join  ZMM_GREY_RECEIPT_REGISTER_CDS as b on (  b.Batch= a.rollno   and b.Supplier = concat( '000',a.party )  )
 left outer join  I_ManufacturingOrder as GG on (  GG.Batch  = a.dyebeam ) 
  left outer join I_MfgOrderWithStatus as F on ( F.ManufacturingOrder = GG.ManufacturingOrder  )
  

 

{
    key a.party as Party,
    key a.dyebeam as Dyebeam,
    key a.partybeam as Partybeam,
    key a.roll_no as RollNo,
    key a.folding_no as foldingno,
    key   a.rollno as Rollno1,
    a.shift as Shift,
    a.setno as Setno,
    a.date1 as Date1,
    a.loom as Loom,
   a.grsortno as Grsortno,
    a.beampipe as Beampipe,
    a.length as Length,
    a.t_ends as TEnds,
   a. shade as Shade,
    a.pick as Pick,
   a. reed_spac as ReedSpac,
    a.reed as Reed,
   a. dent as Dent,
    a.remarks as Remarks,
    a.netwt as netwt,
    a.est_fabrictoreceived as Est_FabricToReceived,
   a. mtr as Mtr,
   @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
   b.QuantityInBaseUnit,
  b.MaterialBaseUnit,
  F.OrderIsTechnicallyCompleted,
      F.CreationDate,

  
  
  
      case when a.dyebeam is not null or a.dyebeam <> '' or a.dyebeam is not initial
         then 'Approved' else '' end as TechoApproved
 
}
      where  b.QuantityInBaseUnit is null
      //  and b.QuantityInBaseUnit is null
