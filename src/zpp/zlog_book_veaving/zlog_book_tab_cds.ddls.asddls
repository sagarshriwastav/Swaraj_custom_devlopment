@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data Defination for ZLOG_BOOK_TAB'
define root view entity ZLOG_BOOK_TAB_CDS 
as select from zlog_book_tab
{
    key date1 as Date1,
    key unitname as UnitName,
    key loomnumber as LoomNumber,
    sortnumber as SortNumber,
    rpm_a_shift  as RPM_A_Shift,
    efficiency_a_shiftper as Efficiency_A_ShiftPer,
    rpm_b_shift as RPM_B_Shift,
    efficiency_b_shiftper as Efficiency_B_ShiftPer,
    production_a_shift as Production_A_Shift,
    production_b_shift as Production_B_Shift
}
