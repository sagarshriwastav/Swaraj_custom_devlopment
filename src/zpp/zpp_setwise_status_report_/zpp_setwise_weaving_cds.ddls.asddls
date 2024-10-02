@AbapCatalog.sqlViewName: 'YGYRYSET'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_SETWISE_WEAVING_CDS'
define view ZPP_SETWISE_WEAVING_CDS as select from ZPP_GREY_GRN_REPORT
{
    key Batch,
        Postingdate,
        setno,
        Material as GreySort,
        Partyname ,
        Partybeam,
        Uom,
        @Semantics.quantity.unitOfMeasure : 'uom'
        Quantity 
        
}
