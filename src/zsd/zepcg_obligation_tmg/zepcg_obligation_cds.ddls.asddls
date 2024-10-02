@AbapCatalog.sqlViewName: 'YEPCGREP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For EPCG Obligation Report'
define view ZEPCG_OBLIGATION_CDS as select from zpregen_exim
{
    key  docno,
    key epcgno
} 
 
 group by 
   docno,
   epcgno
