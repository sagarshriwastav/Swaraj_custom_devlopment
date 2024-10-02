@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Dyeing Entry Beam Number Check'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_BEAM_NUMBER_CHECK as select from ZPP_DYEINGR_CDS
{
    key Zorder,
        max(Beamno) as Beamno

} 
  group by  
        Zorder 
       // Beamno 
 