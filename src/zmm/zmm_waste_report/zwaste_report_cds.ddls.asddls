@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZWASTE_REPORT_CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZWASTE_REPORT_CDS
  as select from zmm_waste_table
{
 
  key      setno                 as Setno,
  key      sortno                as Sortno,
           zdate                 as posting_date,
           sheet_weight          as SheetWeight,
           warping_length_in_mtr as WarpingLengthInMtr,
           unsized_waste         as UnsizedWaste,
           sized_waste           as SizedWaste,
           total_waste           as TotalWaste,
           waste                 as Waste,
           @Semantics.user.createdBy: true
           created_by            as CreatedBy,
           @Semantics.systemDateTime.createdAt: true
           created_at            as CreatedAt,
           @Semantics.user.localInstanceLastChangedBy: true
           last_changed_by       as LastChangedBy,
           @Semantics.systemDateTime.localInstanceLastChangedAt: true
           last_changed_at       as LastChangedAt,
           @Semantics.systemDateTime.lastChangedAt: true
           local_last_changed_at as LocalLastChangedAt
}
