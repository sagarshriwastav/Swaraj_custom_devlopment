//@EndUserText.label: 'ZMM_SHRINK_REPORT_CDS'
//@AccessControl.authorizationCheck: #NOT_REQUIRED
@AbapCatalog.sqlViewName: 'YSHRINKAGRE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMM_SHRINK_REPORT_CDS'
define view  ZMM_SHRINK_REPORT_CDS as select from ZSUBCON_tabl2

{ 
 key Party,
 key Dyebeam,
  sum(Est_FabricToReceived) as Est_FabricToReceived,
  sum(Mtr)   as Mtr
}
group by Party,
        Dyebeam
