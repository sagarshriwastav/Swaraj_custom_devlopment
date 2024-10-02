@EndUserText.label: 'Cds For Fents Regs Chindi Report'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity ZPP_FRC_REP as select from zpp_frc_tab  as a
    left outer join ZPP_STOCK_QUANTITY_SUM2 as b on (  b.Material = a.recevingmaterial and b.Batch = a.recbatch 
                                                      and b.StorageLocation = a.recstoloc and b.Plant = a.plant )
 
{
    key a.plant as Plant,
    key a.recbatch as Recbatch,
    a.materialdocument411 as Materialdocument411,
    a.materialdocumentyear411 as Materialdocumentyear411,
    a.materialdocument309 as Materialdocument309,
    a.materialdocumentyear309 as Materialdocumentyear309,
    a.materialdocument201 as Materialdocument201,
    a.materialdocumentyear201 as Materialdocumentyear201,
    a.materialdocument202 as Materialdocument202,
    a.materialdocumentyear202 as Materialdocumentyear202,
    a.postingdate as Postingdate,
    a.storagelocation as Storagelocation,
    a.recstoloc as Recstoloc,
    a.recevingmaterial as Recevingmaterial,
    a.baleqty as Baleqty,
    a.noofbale as Noofbale,
    a.costcenter as Costcenter,
    cast( case when a.uom = 'M'  then 'KG' else a.uom end as abap.unit( 3 ) ) as Uom,
    cast( 'M' as abap.unit( 3 ) ) as UnitMtr,
    @Semantics.quantity.unitOfMeasure : 'uom'
    a.totalmtr as Totalmtr,
    @Semantics.quantity.unitOfMeasure : 'uom'
    a.totalwt as Totalwt,
    a.gfrctype as Gfrctype,
    a.gctype as Gctype,
    @Semantics.quantity.unitOfMeasure : 'uom'
    a.gcgrosswt as Gcgrosswt,
    @Semantics.quantity.unitOfMeasure : 'uom'
    b.StcoKQuantity,
    case when b.StcoKQuantity <> 0 then 'X' else '' end as Stock
}
