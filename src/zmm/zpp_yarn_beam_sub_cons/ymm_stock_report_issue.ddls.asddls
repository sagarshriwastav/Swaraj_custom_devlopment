@AbapCatalog.sqlViewName: 'YMM_STORE_ISSUE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MM Stock Report Issue'
define view YMM_STOCK_REPORT_ISSUE
  with parameters
    p_fromdate : abap.dats,
    p_todate   : abap.dats
  as select from I_MaterialDocumentItem_2 as a 
 
    inner join   ymseg4                   as b on  b.MaterialDocument     = a.MaterialDocument
                                               and b.MaterialDocumentItem = a.MaterialDocumentItem
                                               and b.MaterialDocumentYear = a.MaterialDocumentYear                                 
{
  key a.Material,
  key a.Plant,
  key a.Batch,
      a.Supplier,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case when a.GoodsMovementType = '541' and a.DebitCreditCode = 'S'  then sum( QuantityInBaseUnit ) else 0 end as Issue,
      case when a.GoodsMovementType = '542'  then sum( QuantityInBaseUnit ) else 0 end as RestunQty,
      case when a.GoodsMovementType = '543' then sum( QuantityInBaseUnit ) else 0 end as Consumption,
      a.MaterialBaseUnit,
      a.PostingDate
}
where   
       a.PostingDate     > $parameters.p_fromdate
  and  a.PostingDate     <= $parameters.p_todate
group by
  a.Plant,
  a.Material,
  a.Batch,
  a.Supplier,
  a.DebitCreditCode ,
  a.GoodsMovementType,
  a.MaterialBaseUnit,
  a.PostingDate
