@AbapCatalog.sqlViewName: 'YREVSE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Job Grey Dispatch Report'
define view ZJOB_GREY_CANCEL_REMOVE as select from zpp_grey_grn_tab as a 
 left outer join I_MaterialDocumentItem_2 as e on ( e.MaterialDocument = a.materialdocument101  
                                                        and e.MaterialDocumentYear = a.materialdocumentyear101 
                                                        and e.Material = a.material
                                                        and e.Batch = a.recbatch 
                                                        and ( e.GoodsMovementType = '101' or e.GoodsMovementType = '561' ) ) 

{
    key a.plant as Plant,
    key a.batch as Batch,
    key a.recbatch as Recbatch,
    a.partybeam as Partybeam,
    a.quantity as Quantity,
    @Semantics.quantity.unitOfMeasure : 'uOM'
    a.netwt  as Netwt,
    a.loomno as Loomno,
    a.material as Material,
    a.materialdec as Materialdec,
    a.prodorder as Prodorder,
    @Semantics.quantity.unitOfMeasure : 'uOM'
    a.stdwt as Stdwt,
    @Semantics.quantity.unitOfMeasure : 'uOM'
    a.wtmtr as Wtmtr,
    @Semantics.quantity.unitOfMeasure : 'uOM'
    a.grosswt,
    a.remark as Remark,
    a.sloc as Sloc,
    a.uom as Uom,
    a.shadeno as Shadeno,
    a.setno,
    a.pick,
    e.GoodsMovementIsCancelled,
    a.postingdate
    
}   where GoodsMovementIsCancelled = ' '  or GoodsMovementIsCancelled is null
 