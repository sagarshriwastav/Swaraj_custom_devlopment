@AbapCatalog.sqlViewName: 'YREPDYES'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Dyec Chemical Report'
define view ZPP_DYEC_REP as select from zpp_dyec_chemica  as a 
//  left outer join I_MaterialDocumentItem_2 as b on (b.Material = a.chemical and b.Batch = a.consbatch 
//                                                   and b.MaterialDocument = a.materialdocumentno 
//                                                   and b.MaterialDocumentYear = a.materialdocumentyear 
//                                                   and b.GoodsMovementType = '262'  
//                                                   and b.Plant = a.plant  and b.StorageLocation = a.consloc
//                                                   and b.OrderID = a.orderno  and   b.GoodsMovementIsCancelled = '4900002884' )
  left outer join I_ProductValuationBasic as c on ( c.Product = a.chemical and c.ValuationArea = a.plant )
  left outer join I_ManufacturingOrderItem as d on ( d.ManufacturingOrder = a.orderno )
  
  
   left outer join I_MaterialDocumentItem_2 as e on ( e.MaterialDocument = a.materialdocumentno 
                                                     and e.Material = a.chemical )
//                                                        and e.MaterialDocumentYear = a. materialdocumentyear    
//                                                        and e.Material = a.materialdocumentno or e.GoodsMovementType = '262' )
                                                     //   and e.Batch = a.bathadjustment )                                                
//             left outer join ymseg4 as b on ( b.MaterialDocument = e.MaterialDocument 
//                                     and b.MaterialDocumentItem = e.MaterialDocumentItem 
//
//                                       and b.MaterialDocumentYear = e.MaterialDocumentYear )
    
{
    key a.orderno as Orderno,
    key a.plant as Plant,
    key a.setno as Setno,
    key a.reciepeno as Reciepeno,
    key a.dyeingsort as Dyeingsort,
    key a.materialdocumentno as Materialdocumentno,
    key a.chemical as Chemical,
    a.materialdocumentyear as Materialdocumentyear,
    a.poastingdate as Poastingdate,
    a.matdes as Matdes,
    a.zunitkg as Zunitkg,
    a.zunitm as Zunitm,
    cast('INR' as abap.cuky( 5 ) ) as zcuky,
    cast('MTR' as abap.cuky( 5 ) )  as ZUNIT,
    @Semantics.quantity.unitOfMeasure : 'Zunitkg'
    a.stdgpl as Stdgpl,
    @Semantics.quantity.unitOfMeasure : 'Zunitkg'
    a.alreadycqty as Alreadycqty,
    @Semantics.quantity.unitOfMeasure : 'Zunitkg'
    a.lastusedgpl as Lastusedgpl,
    @Semantics.quantity.unitOfMeasure : 'Zunitkg'
    a.prodgpl as Prodgpl,
    @Semantics.quantity.unitOfMeasure : 'zunitm'
    a.feedltr as Feedltr,
    @Semantics.quantity.unitOfMeasure : 'Zunitkg'
    a.consqty  as Consqty,
    @Semantics.quantity.unitOfMeasure : 'zunitkg'     
    a.reqqty,
    @Semantics.amount.currencyCode : 'zcuky'
    a.costpermtr,
    @Semantics.amount.currencyCode : 'ZUNIT'
    sum(a.recipecostmtr) as recipecostmtr,
    a.consbatch as Consbatch,
    a.consloc as Consloc,
    a.bathadjustment,
    c.MovingAveragePrice as MvgAveragePriceInPreviousYear ,
    d.MfgOrderPlannedTotalQty as SetLength,
    
    
    cast ( cast ( cast( case  when  a.consqty is not null then  a.consqty else 0 end as abap.dec( 13, 3 ) ) +
    cast( case  when a.bathadjustment is not null then a.bathadjustment else 0 end as abap.dec( 13, 3 ) ) as abap.dec( 13, 3 ) ) * 
    cast( case  when c.MovingAveragePrice is not null then c.MovingAveragePrice else 0 end as abap.dec( 13, 3 ) )
    as abap.dec( 13, 3 ) ) as costperkkgg
    
    
     
   
}  where e.GoodsMovementIsCancelled = '' 

 group by a.orderno ,
    a.plant,
    a.setno ,
    a.reciepeno,
    a.dyeingsort,
    a.materialdocumentno,
    a.chemical,
    a.materialdocumentyear,
    a.poastingdate,
    a.matdes,
    a.zunitkg,
    a.zunitm,
    a.stdgpl ,
    a.alreadycqty,
    a.lastusedgpl,
    a.prodgpl,
    a.feedltr,
    a.consqty ,
    a.reqqty,
  //  a.recipecostmtr,
    a.consbatch,
    a.consloc ,
    a.bathadjustment,
  //  e.GoodsMovementIsCancelled,
    a.costpermtr,
    c.MovingAveragePrice,
    d.MfgOrderPlannedTotalQty
