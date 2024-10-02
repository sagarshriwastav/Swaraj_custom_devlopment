@EndUserText.label: 'ZWASTE_REPORT_CDS FOR PROJA'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZMM_WASTE_CDS_PROJ
  provider contract transactional_query
  as projection on ZWASTE_REPORT_CDS
{
 
  key            Setno,
  key            Sortno,
                 posting_date,
                 SheetWeight,
                 WarpingLengthInMtr,
                 UnsizedWaste,
                 SizedWaste,
                 TotalWaste,
                 Waste,
                 LastChangedAt,
                 CreatedBy,
                 CreatedAt,
                 LastChangedBy,
                 LocalLastChangedAt

}
