@AbapCatalog.sqlViewName: 'YSETWISE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_SETWISE_STATUS_REPORT_CDS'
define view ZPP_SETWISE_STATUS_REPORT_CDS as select from ZPP_WARPING_REP1  

{
    key ZfsetNo as SetNo,
        PostingDate,
        Beamno ,
        Ends,
        Totends,
        Zlength as Length,
        zunit,
        Material as SortNo,
        @Semantics.quantity.unitOfMeasure: 'zunit'
        Grooswt as Grooswt,
        @Semantics.quantity.unitOfMeasure: 'zunit'
        Tarewt as Tarewt,
        @Semantics.quantity.unitOfMeasure: 'zunit'
        Netwt as Netwt,
        Breaks,
        Warper
        
        
    
}
