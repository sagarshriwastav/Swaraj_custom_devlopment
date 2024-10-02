@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: ' pc monogram CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
 }

define root view entity zpc_monogram_CDS as select from zpc_monogram

{
    
    key zpno as Zpno,
    key zpmsno as Zpmsno,
    zpmmonog as Zpmmonog,
    zpmsaveas as Zpmsaveas,
    zpmlength as Zpmlength,
    zpmmktordno as Zpmmktordno,
    zpmremarks as Zpmremarks,
    mark as Mark,
    zname as Zname,
    kunnr as Kunnr
}
