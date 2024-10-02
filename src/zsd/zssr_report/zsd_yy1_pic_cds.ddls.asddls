@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZSD_YY1_PIC_CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity ZSD_YY1_PIC_CDS as select from I_BillingDocumentItem
{
    BillingDocument,
  //  YY1_PICKGS_BDI,
  //  BaseUnit,
  //  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
    cast( YY1_PICKGS_BDI as abap.numc( 10 )
      ) as PICK
   
}
 //group by BillingDocument
