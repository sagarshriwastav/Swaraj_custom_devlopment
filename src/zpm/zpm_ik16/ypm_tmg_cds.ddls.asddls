@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'TMG PM'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YPM_TMG_CDS
  as select from ypm_tmg_table3
{     
  key plant,
  key workcenter,
      workcenterid,
      department,
      measuringpoint,
      inactive    
}
