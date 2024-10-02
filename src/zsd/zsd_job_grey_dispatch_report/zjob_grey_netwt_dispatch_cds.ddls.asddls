@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds Job  Grey DispatcH Report'
define root view entity ZJOB_GREY_NETWT_DISPATCH_CDS as select from ZJOB_GREY_CANCEL_REMOVE
{
    key Plant,
    key Batch,
    key Recbatch,
    Partybeam,
    Quantity,
    Netwt,
    Loomno,
    Material,
    Materialdec,
    Prodorder,
    Stdwt,
    Wtmtr,
    grosswt,
    Remark,
    Sloc,
    Uom,
    Shadeno,
    setno,
    pick,
    GoodsMovementIsCancelled,
    postingdate
}  

 
 where GoodsMovementIsCancelled = ''  // or GoodsMovementIsCancelled is null
