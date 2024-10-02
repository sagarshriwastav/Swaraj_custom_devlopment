@AbapCatalog.sqlViewName: 'YHEADITEM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Out Side Folding  ItemReport'
define view ZPP_OUTSIDEFOLDING_item as select from zsubcon_item
{
    key party as Party,
    key dyebeam as Dyebeam,
    key partybeam as Partybeam,
    key roll_no as Roll_No,
    shift as Shift,
    setno as Setno,
    date1 as Date1,
    loom as Loom,
    grsortno as Grsortno,
    beampipe as Beampipe,
    rollno as Rollno,
    length as Length,
    t_ends as TEnds,
    netwt as Netwt,
    shade as Shade,
    pick as Pick,
    reed_spac as ReedSpac,
    reed as Reed,
    dent as Dent,
    remarks as Remarks
}
