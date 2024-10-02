@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: ' CDS FORZACTUAL_PLANT_JOURNAL_ITEAM'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZACTUAL_PLANT_JOURNAL_ITEAM as select from I_ActualPlanJournalEntryItem 
    
{ 
  key    WBSElementExternalID,
      WBSElementInternalID
    
} group by
     WBSElementExternalID,
      WBSElementInternalID
