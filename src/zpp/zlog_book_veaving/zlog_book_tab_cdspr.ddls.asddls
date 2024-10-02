@EndUserText.label: 'Projection Data Defination for ZLOG_BOOK_TAB'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZLOG_BOOK_TAB_CDSPR
  provider contract transactional_query
   as projection on ZLOG_BOOK_TAB_CDS
{
    key Date1,
    key UnitName,
    key LoomNumber,
    SortNumber,
    RPM_A_Shift,
    Efficiency_A_ShiftPer,
    RPM_B_Shift,
    Efficiency_B_ShiftPer,
    Production_A_Shift,
    Production_B_Shift
}
