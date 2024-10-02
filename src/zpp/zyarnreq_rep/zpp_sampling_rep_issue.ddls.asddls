@AbapCatalog.sqlViewName: 'YISSUESAMPLE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Sampling Report Issue'
define view ZPP_SAMPLING_REP_ISSUE 
   with parameters
    p_fromdate : abap.dats,
    p_todate   : abap.dats
  as select from I_MaterialDocumentItem_2  as a
 
{
  key a.Material,
  key a.Plant,
  key a.StorageLocation,   
  key a.Batch,
      a.GoodsMovementType,
      case when( ( GoodsMovementType = '261' or GoodsMovementType = '201' or GoodsMovementType = '601' 
      or  a.GoodsMovementType = '311' ) and a.StorageLocation = 'SA01'  and a.DebitCreditCode = 'H'  ) 
      then sum( QuantityInBaseUnit ) end as Issue,
      a.MaterialBaseUnit,
      a.PostingDate
}
where 
       a.Batch != '' and
       a.PostingDate >= $parameters.p_fromdate
   and a.PostingDate <= $parameters.p_todate
 //  and StorageLocation != IssuingOrReceivingStorageLoc
   and StorageLocation = 'SA01'

group by
  a.Plant,
  a.Material,
  a.StorageLocation,
 // a.IssuingOrReceivingStorageLoc,
  a.Batch,
  a.GoodsMovementType,
  a.MaterialBaseUnit,
  a.PostingDate,
  a.DebitCreditCode
