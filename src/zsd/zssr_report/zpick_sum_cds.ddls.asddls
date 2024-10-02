@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPICK_SUM_CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPICK_SUM_CDS as select from ZSD_YY1_PIC_CDS 
{
    BillingDocument,
    PICK as PICK
    
}//group by BillingDocument
