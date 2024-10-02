@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Operator table'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zoperator_table as select from zdenim_oprat_tab
{
    key bukrs as Bukrs,
    key plant as Plant,
    key empcode as Empcode,
    empname as Empname,
    deptname as Deptname,
    cancel as Cancel
   
}
