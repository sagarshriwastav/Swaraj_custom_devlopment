@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PP Stock Report Final View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_YARN_BEAM_SUB_CONS_CDS
  with parameters
    p_fromdate : abap.dats,
    p_todate   : abap.dats
  as select from    YMM_STOCK_REPORT_QTY( p_fromdate:$parameters.p_fromdate , p_todate:$parameters.p_todate ) as a 
    left outer join I_Supplier as Supp on ( Supp.Supplier = a.Supplier )
    left outer join I_ProductDescription                as d on  d.Product  = a.Material
                                                          and d.Language = $session.system_language
          left outer join I_BatchDistinct as b on ( b.Batch = a.Batch and b.Material = a.Material )
     
      left outer join ZMM_JOB_REC_REG_INTERNALID_1 as t on ( t.ClassType = '023' and t.ClfnObjectTable = 'MCH1'
                                                               and t.ClfnObjectInternalID = b.ClfnObjectInternalID )
     
     left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as c on ( c.ClassType = '023' and c.ClfnObjectTable = 'MCH1'
                                                               and c.ClfnObjectInternalID = t.ClfnObjectInternalID
                                                               and c.CharcInternalID = t.Lotnumber )  // '0000000807' ) // lotnumber
                                                               
     left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as e on ( e.ClassType = '023' and e.ClfnObjectTable = 'MCH1'
                                                               and e.ClfnObjectInternalID = t.ClfnObjectInternalID
                                                               and e.CharcInternalID = t.Milname ) // '0000000806' ) // millname
      left outer join ZI_ClfnCharcValueDesc_cds as h on ( h.mil = e.CharcValue and h.CharcInternalID = t.Milname and // '0000000806' and 
                                                  h.Language = 'E' )                                                            
                                                                                                                                                                                                                           
{
  key a.Material,
  key a.Plant,
      d.ProductDescription,
      Supp.SupplierName as Supplier,
      a.Batch,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      a.Opening, 
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      a.Consumption,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      a.RestunQty,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      a.Issue,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      a.Closing,
 //    cast( cast( sum( a.Issue ) as abap.dec( 13, 3 ) ) * cast( a.Closing as abap.dec( 13, 3 ) )   as abap.dec( 13, 3 ) )  as test, 
      a.MaterialBaseUnit,
      a.CompanyCodeCurrency,
      c.CharcValue as lotno,
      h.CharcValueDescription as millname
}

group by
  a.Material,
  d.ProductDescription,
  a.Plant,
  a.Batch,
  Supp.SupplierName,
  a.Opening,
  a.Issue,
  a.RestunQty,
  a.Consumption,
  a.Closing,
  a.MaterialBaseUnit,
  a.CompanyCodeCurrency,
  c.CharcValue ,
  h.CharcValueDescription

  
