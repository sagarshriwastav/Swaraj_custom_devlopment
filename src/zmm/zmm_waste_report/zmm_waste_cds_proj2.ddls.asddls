@EndUserText.label: 'ZMM_WASTE_CDS_PROJ2'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define  root view entity ZMM_WASTE_CDS_PROJ2
  provider contract transactional_query as projection on ZWASTE_REPORT_CDS2
{
    key posting_date,
    key Setno,
    key Sortno,
    SheetWeight,
    WarpingLengthInMtr,
    UnsizedWaste,
    SizedWaste,
    TotalWaste,
    Waste,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt
}
