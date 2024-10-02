@AbapCatalog.sqlViewName: 'YSML3'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_SAMPLING_REPORT3'
define view ZPP_SAMPLING_REPORT3 
 with parameters
    p_fromdate : abap.dats,
    p_todate   : abap.dats
  as select from    ZPP_SAMPLING_REPORT2( p_fromdate:$parameters.p_fromdate , p_todate:$parameters.p_todate ) as a
                                              
    inner join I_ProductDescription                                         as d on  d.Product  = a.Material
                                                                            and d.Language = $session.system_language
     inner join I_Product                                                   as e on  e.Product = a.Material  
     inner join I_ProductTypeText                                           as f on  f.ProductType = e.ProductType  
                                                                            and f.Language = $session.system_language 
    inner join I_ProductGroupText_2                                         as g on  g.ProductGroup = e.ProductGroup  
                                                                            and g.Language = $session.system_language                                                                                                                                                                                                                  
                                                                                                                   
{
  key a.Material,
  key a.Plant,
  key a.StorageLocation, 
  key a.Batch,
      d.ProductDescription,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      a.Opening,     
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      a.Receipt ,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      a.Issue,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      a.Closing,
      a.MaterialBaseUnit,
      e.ProductType,
      e.ProductGroup,
      f.MaterialTypeName,
      g.ProductGroupName
    //   cast ( cast( case  when a.Opening is not null then a.Opening else 0 end as abap.dec( 13, 3 ) ) +
    //         cast( case  when a.Receipt is not null then a.Receipt else 0 end as abap.dec( 13, 3 ) ) +
    //         cast( case  when a.Issue is not null then a.Issue else 0 end as abap.dec( 13, 3 ) ) +
    //         cast( case  when a.Closing is not null then a.Closing else 0 end as abap.dec( 13, 3 ) )
    //         as abap.dec( 13, 3 ) ) as total
      
} // where a.StorageLocation = 'SA01'  //  a.tot > 0  or   a.tot1  > 0 
group by
  a.Material,
  d.ProductDescription,
  a.Plant,
  a.StorageLocation,
  a.Batch,
  a.Opening,
  a.Receipt,
  a.Issue,
  a.Closing,
  a.MaterialBaseUnit,
  e.ProductType,
  e.ProductGroup,
  f.MaterialTypeName,
  g.ProductGroupName
