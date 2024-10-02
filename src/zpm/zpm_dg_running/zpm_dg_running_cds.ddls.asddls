@AbapCatalog.sqlViewName: 'YPMDG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  DG Running Report'
define view ZPM_DG_RUNNING_CDS as select from zpm_dg_running
{
    key dgno as Dgno,
    zdate as Zdate,
    dgstarttime as Dgstarttime,
    dgendtime as Dgendtime,
    dgtotaltime as Dgtotaltime,
    disellevalstart as Disellevalstart,
    disellevelend as Disellevelend,
    totaldiselconsumption as Totaldiselconsumption,
    diselrec as Diselrec
}
