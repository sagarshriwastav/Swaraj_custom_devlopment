@AbapCatalog.sqlViewName: 'YMMYARNREPORT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  Yarn Stock Report Date on'
define view ZMM_YARN_CDS 
     with parameters
    p_fromdate : abap.dats,
    p_todate   : abap.dats
  as select from    ZMM_YARN_STOCK_DATE_ON( p_fromdate:$parameters.p_fromdate , p_todate:$parameters.p_todate ) as a
  
      left outer join I_MaterialStock_2 as j on ( j.Batch = a.Batch  and j.Material = a.Material 
                                              and j.StorageLocation = a.StorageLocation 
                                              and j.Plant = a.Plant ) 
                                                
   left outer join I_BatchDistinct                                          as b on ( b.Batch    = a.Batch 
                                                                            and b.Material = a.Material )
                                                                            
  left outer join ZMM_JOB_REC_REG_INTERNALID_1 as t on ( t.ClassType = '023' and t.ClfnObjectTable = 'MCH1'
                                                               and t.ClfnObjectInternalID = b.ClfnObjectInternalID )   
                                                                                                                                     
  left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as c on 
                                                               ( c.ClassType = '023' and c.ClfnObjectTable = 'MCH1'
                                                               and c.ClfnObjectInternalID = t.ClfnObjectInternalID
                                                               and c.CharcInternalID = t.Lotnumber ) // '0000000807' ) // lotnumber  
                                                               
  left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as h on ( h.ClassType = '023' and h.ClfnObjectTable = 'MCH1'
                                                               and h.ClfnObjectInternalID = t.ClfnObjectInternalID
                                                               and h.CharcInternalID = t.Milname ) // '0000000806' ) // millname   
                                                                
  left outer join ZI_ClfnCharcValueDesc_cds as i on ( i.mil = h.CharcValue and i.CharcInternalID =  t.Milname and // '0000000806' and 
                                                  i.Language = 'E' )     
                                                                                                                                                                                                                                         
      left outer join YMM_YARNSTK_ISSUE_CDS_BEAM_SUM as v on (  v.Plant = a.Plant 
                               and v.StorageLocation = a.StorageLocation and v.Batch = a.Batch 
                                 )

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
      j.SDDocument,
      j.SDDocumentItem,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      a.Opening,     
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      a.Receipt ,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      a.RevReceipt ,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      a.Issue,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      a.RevIssue,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      a.Closing,
      a.MaterialBaseUnit,
      e.ProductType,
      e.ProductGroup,
      f.MaterialTypeName,
      g.ProductGroupName,
       cast ( cast( case  when a.Opening is not null then a.Opening else 0 end as abap.dec( 13, 3 ) ) +
             cast( case  when a.Receipt is not null then a.Receipt else 0 end as abap.dec( 13, 3 ) ) +
             cast( case  when a.RevReceipt is not null then a.RevReceipt else 0 end as abap.dec( 13, 3 ) ) +
             cast( case  when a.Issue is not null then a.Issue else 0 end as abap.dec( 13, 3 ) ) +
             cast( case  when a.RevIssue is not null then a.RevIssue else 0 end as abap.dec( 13, 3 ) ) +
             cast( case  when a.Closing is not null then a.Closing else 0 end as abap.dec( 13, 3 ) )
             as abap.dec( 13, 3 ) ) as total,
      
      b.ClfnObjectInternalID,
      c.CharcValue as lotno,
      h.CharcValue  as milno,
      i.CharcValueDescription as MillName,
      v.PrBagKg,
      v.PrConeKg
} // where   a.tot > 0  or   a.tot1  > 0 
group by
  a.Material,
  d.ProductDescription,
  a.Plant,
  a.StorageLocation,
  a.Batch,
  j.SDDocument,
  j.SDDocumentItem,
  a.Opening,
  a.Receipt,
  a.RevReceipt,
  a.Issue,
  a.RevIssue,
  a.Closing,
  a.MaterialBaseUnit,
  e.ProductType,
  e.ProductGroup,
  f.MaterialTypeName,
  g.ProductGroupName,
  b.ClfnObjectInternalID,
  c.CharcValue,
  h.CharcValue,
  i.CharcValueDescription,
  v.PrBagKg,
  v.PrConeKg
