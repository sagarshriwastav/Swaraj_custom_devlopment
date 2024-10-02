@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZWASTE_REPORT_CDS'
define root view entity ZWASTE_REPORT_CDS2 as select from zmm_waste_table

{
    key zdate as posting_date ,
    key setno as Setno,
    key sortno as Sortno,
    sheet_weight as SheetWeight,
    warping_length_in_mtr as WarpingLengthInMtr,
    unsized_waste as UnsizedWaste,
    sized_waste as SizedWaste,
    total_waste as TotalWaste,
    waste as Waste,
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt,
    local_last_changed_at as LocalLastChangedAt
     // Make association public
}
