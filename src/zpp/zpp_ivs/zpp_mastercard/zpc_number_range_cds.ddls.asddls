@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: ' pc number range CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
 }

define root view entity zpc_number_range_cds as select from zpc_number_range
{
     key werks as Werks,
     key zpbrand as Zpbrand,
     curzpno as Curzpno 
}
