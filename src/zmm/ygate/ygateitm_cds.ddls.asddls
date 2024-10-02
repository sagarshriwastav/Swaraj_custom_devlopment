//@AbapCatalog.sqlViewName: 'zcdsawesd'
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'zgateitm_cds'
define root view entity YGATEITM_CDS as select from ygateitem1
{
    key gateno as Gateno,
    key gate_item as GateItem,
    lifnr as Lifnr,
    matnr as Matnr,
    ebeln as Ebeln,
    ebelp as Ebelp,
    mblnr as Mblnr,
    zeile as Zeile,
    delievery as Delievery,
    posnr as Posnr,
    banfn as Banfn,
    bnfpo as Bnfpo,
    maktx as Maktx,
    order_qty as OrderQty,
    open_qty as OpenQty,
    gate_qty as GateQty,
    out_qty as OutQty,
    out_value as OutValue,
    in_qty as InQty,
    in_value as InValue,
    uom as Uom,
    rspl_name as RsplName,
    expdat as Expdat,
    remark as Remark,
    zinvoice as Zinvoice,
    name1 as Name1,
    zbag_qty as ZbagQty,
    refgateno as Refgateno,
    refgateit as Refgateit,
    reject as Reject,
    lpnum as Lpnum,
    lppos as Lppos,
    sono as Sono,
    soitm as Soitm,
    deldat as Deldat,
    address1 as Address1 
//    _association_name // Make association public
}
