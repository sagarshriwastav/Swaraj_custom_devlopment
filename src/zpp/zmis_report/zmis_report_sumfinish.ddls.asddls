@AbapCatalog.sqlViewName: 'YFINISHSUM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMIS_REPORT_SUMFINISH'
define view ZMIS_REPORT_SUMFINISH as select from ZMIS_REPORT_FINISH
{
    
    Set_code,
    Zunit,
    @Semantics.quantity.unitOfMeasure : 'zunit'
    sum(Finishmtr) as Finishmtr,
    @Semantics.quantity.unitOfMeasure : 'zunit'
    sum(GreyReceived) as GreyReceived
}
 group by 
              Set_code,
              Zunit
