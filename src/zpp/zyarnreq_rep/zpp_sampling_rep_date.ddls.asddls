@AbapCatalog.sqlViewName: 'YDATE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'FOR POSTING DATE'
define view ZPP_SAMPLING_REP_DATE 
with parameters
    p_fromdate : abap.dats,
    p_todate   : abap.dats
  as select from I_MaterialDocumentItem_2  as a
 
{
  key a.Material,
  key a.Plant,
  key a.StorageLocation as StorageLocation,   
  key case when ( a.GoodsMovementType = '311' and a.StorageLocation <> 'SA01' //and  a.IssuingOrReceivingStorageLoc = 'SA01' 
      and a.DebitCreditCode = 'H' ) then a.IssgOrRcvgBatch else a.Batch end as Batch,
      case when ( a.GoodsMovementType = '101' or a.GoodsMovementType = '561'  or 
      ( a.GoodsMovementType = '311' ) and a.StorageLocation = 'SA01' //and a.IssuingOrReceivingStorageLoc = 'SA01' 
      and a.DebitCreditCode = 'S' )  
      then sum( a.QuantityInBaseUnit ) end as Receipt,
      a.MaterialBaseUnit,
      a.PostingDate  
}
where 
       a.Batch != '' and
       a.PostingDate >= $parameters.p_fromdate
   and a.PostingDate <= $parameters.p_todate
 //  and StorageLocation != IssuingOrReceivingStorageLoc
   and a.GoodsMovementIsCancelled = ''
 //  and IssuingOrReceivingStorageLoc = 'SA01'

group by
  a.Plant,
  a.Material,
  a.StorageLocation,
//  a.IssuingOrReceivingStorageLoc,
  a.Batch,
  a.IssgOrRcvgBatch,
  a.GoodsMovementType,
  a.MaterialBaseUnit,
  a.PostingDate,
  a.DebitCreditCode
