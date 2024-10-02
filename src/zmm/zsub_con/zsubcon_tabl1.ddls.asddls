@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZSUBCON_tab1'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZSUBCON_tabl1 as select from zsubcon_head as A
 left outer join ZSUBCON_tabl2 as b on (  b.Dyebeam = A.dyebeam and b.Party = A.party )
//   left outer join  I_ManufacturingOrder as b on (  b.Batch  = A.dyebeam )
//  left outer join  zsubcon_head as b on ( b.dyebeam  =  a.Batch  )
//  left outer join I_MfgOrderWithStatus as c on ( c.ManufacturingOrder = b.ManufacturingOrder  )
 
{
  key A.party     as Party,
  key A.dyebeam   as Dyebeam,
  key A.partyname as  partyname,
      A.partybeam as Partybeam,
      A.date1     as Date1,
      A.loom      as Loom,
      A.grsortno  as Grsortno,
      A.beampipe  as Beampipe,
      A.length    as Length,
      A.t_ends    as TEnds,
      A.shade     as Shade,
     A.pick      as Pick,
      A.reed_spac as ReedSpac,
      A.reed      as Reed,
      A.dent      as Dent,
      A.date2     as date2,
      b.Dyebeam as dyebeam1,
     A.startingdate as startingdate
  //  c.OrderIsTechnicallyCompleted,
   //   c.CreationDate,
   //   b.ManufacturingOrder,
       
    //    case when A.dyebeam is not null or A.dyebeam <> '' or A.dyebeam is not initial
    //     then 'Approved' else '' end as TechoApproved
} 
group by 

      A.party   ,
      A.dyebeam  ,
      A.partyname ,
      A.partybeam ,
      A.date1    ,
      A.loom      ,
      A.grsortno,
      A.beampipe  ,
      A.length  ,
      A.t_ends ,
      A.shade    ,
     A.pick    ,
      A.reed_spac ,
      A.reed     ,
      A.dent      ,
      A.date2   ,
      b.Dyebeam,
     A.startingdate 
