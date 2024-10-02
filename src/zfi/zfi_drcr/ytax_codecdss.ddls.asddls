@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'YTAX_CODECDSS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YTAX_CODECDSS as select from ytax_code2
{
    key taxcode as Taxcode,
    taxcodedescription as Taxcodedescription,
    gstrate as gstrate
 }  
