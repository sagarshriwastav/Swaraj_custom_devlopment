@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds for yarn tasting itam'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_YARN_ITAM_TEAST as select from zpp_yarn_testtem
{
    key partybillnumber as Partybillnumber,
    key sno as Sno,
    key parmeters as Parmeters,
    key  partycode as  partycode,
    zresult as Zresult,
    remark as Remark,
    status as Status
   
}
