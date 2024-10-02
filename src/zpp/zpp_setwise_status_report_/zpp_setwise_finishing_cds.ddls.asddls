@AbapCatalog.sqlViewName: 'YFINISHSET'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_SETWISE_FINISHING_CDS'
define view ZPP_SETWISE_FINISHING_CDS as select from ZPP_DENIM_FINISH_ENTRY_REP
{
    key Beam as BeamNo,
        Postingdate,
        Set_code,
        Material101,
        Material261,
        Zunit,
        @Semantics.quantity.unitOfMeasure : 'zunit'
        Greigemtr as Greymtr,
        @Semantics.quantity.unitOfMeasure : 'zunit'
        Finishmtr,
        Shrinkageperc,
        @Semantics.quantity.unitOfMeasure : 'zunit'
        Actualmtr 
        
        
        
        
}
