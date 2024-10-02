@AbapCatalog.sqlViewName: 'YGOODSOPEN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Goods Transaction Report'
define view ZGOODS_OPENING_CDS  with parameters 
   @Consumption.hidden: true
    @Environment.systemField: #SYSTEM_DATE
    P_KeyDate : vdm_v_key_date
  as select from I_MaterialStock_2 as a
  left outer join I_Product as b on (b.Product = a.Material )
{
  case when a.Material like 'Y%'  then 'YARN' 
      when a.Material like 'FG%'  then 'GREY FABRIC'
      when a.Material like 'FF%' or  a.Material like '776%' then 'FINISH FABRIC'
      when a.Material like 'HUS%' then 'HUSK'
      when a.Material like 'SD%' and a.MaterialBaseUnit = 'KG' then 'DYES CHEMICAL' else '' end as Material,
  a.Plant,
  a.MaterialBaseUnit,
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  sum( a.MatlWrhsStkQtyInMatlBaseUnit ) as MatlWrhsStkQtyInMatlBaseUnit
 // b.StandardPricePrevYear
}
where ( a.Material like 'Y%' or a.Material like 'FG%' or  a.Material like 'FF%' or  a.Material like 'HUS%' 
       or ( a.Material like 'SD%' and a.MaterialBaseUnit = 'KG' ) ) and 
      MatlDocLatestPostgDate <= dats_add_days ($parameters.P_KeyDate,-1,'UNCHANGED')
 // a.MatlDocLatestPostgDate <= $parameters.P_KeyDate 
      and  b.ProductType <> 'ZDYJ' and b.ProductType <> 'ZFIJ' and b.ProductType <> 'ZGFJ'
       and b.ProductType <> 'ZWRJ' and b.ProductType <> 'ZYRJ'
  group by
  a.Material,
  a.Plant,
  a.MaterialBaseUnit
//  b.StandardPricePrevYear
