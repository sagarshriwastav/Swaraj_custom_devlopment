@AbapCatalog.sqlViewName: 'YFINISH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMIS_REPORT_FINISH'
define view ZMIS_REPORT_FINISH as select from ZPP_DENIM_FINISH_ENTRY_REP
{
    
        Set_code,
        Zunit,
        @Semantics.quantity.unitOfMeasure : 'zunit'
        sum(Finishmtr) as Finishmtr,
        @Semantics.quantity.unitOfMeasure : 'zunit'
        sum(Greigemtr) as GreyReceived
}
     group by 
              Set_code,
              Zunit
