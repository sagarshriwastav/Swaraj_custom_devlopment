@AbapCatalog.sqlViewName: 'YFINISHING2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Quality Testing'
define view ZPP_FINISHING_CDS1 as select from zpp_finishing_CDS
{
    key finishrollno,
    key material101,
    key setno,
    key plant,
    key materialdocument101,
    materialdocumentyear101,
    loomnumber,
    trollyno,
    greigemtr,
    finishmtr,
    partyname,
    optname,
    route,
    peice,
    orderno
}
