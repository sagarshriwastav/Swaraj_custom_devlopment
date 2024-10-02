@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: ' pc warpmatching cds'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zpc_warpmatching_cds as select from zpc_warpmatching
{
    key zpno as Zpno,
    zmatch as Zmatch,
    zpmsno as Zpmsno
}
