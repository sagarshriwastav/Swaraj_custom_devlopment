@AbapCatalog.sqlViewName: 'YGATECHEAC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Gate Entry Cheack Invoice No'
define view ZMM_CHEACK_INVOCIE_NO as select from ygatehead1 as a 
    left outer join ygateitem1 as b on ( b.gateno = a.gateno )
{
   key a.gateno,
   key b.ebeln,
       a.invoice ,
       b.lifnr,
       a.entrydate
}   
  group by 
    a.gateno,
    b.ebeln,
    a.invoice ,
    b.lifnr,
    a.entrydate
