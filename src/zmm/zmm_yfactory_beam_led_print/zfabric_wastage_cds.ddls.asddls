@AbapCatalog.sqlViewName: 'YFEBRICWISE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Fabric Wise Wastage'
define view ZFABRIC_WASTAGE_CDS as select from zfabric_wastage
{
    key material as Material,
    wastegpersantage as Wastegpersantage,
    materialdescription
}
