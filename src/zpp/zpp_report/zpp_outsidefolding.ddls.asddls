@AbapCatalog.sqlViewName: 'YOUTSIDEREP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Out Side Folding  Report'
define view ZPP_OUTSIDEFOLDING as select from zsubcon_head
{
    key party as Party,
    key dyebeam as Dyebeam,
        partyname,
    partybeam as Partybeam,
    date1 as Date1,
    loom as Loom,
    grsortno as Grsortno,
    beampipe as Beampipe,
    length as Length,
    t_ends as TEnds,
    shade as Shade,
    pick as Pick,
    reed_spac as ReedSpac,
    reed as Reed,
    dent as Dent,
    date2 as Date2
}
