@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'qcd cds'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zqcd_cds as select from zqcd
{
    key cbcode as Cbcode,
    cgcode as Cgcode,
    rescnt as Rescnt,
    maktx as Maktx,
    waste as Waste,
    erdat as Erdat,
    ernam as Ernam
}
