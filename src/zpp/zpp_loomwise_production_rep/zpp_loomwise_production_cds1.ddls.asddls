@AbapCatalog.sqlViewName: 'YLLOM2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Loom Wise Production Report'
define view ZPP_LOOMWISE_PRODUCTION_CDS1 as select from ZPP_LOOMWISE_PRODUCTION_CDS
{
    key Party,
    key Zdate,
    key Shortno,
    key count(distinct Loomno) as NOOFLoom,
    sum(Acshifta) as Acshifta,
    sum(AcshiftB) as AcshiftB
} 
  group by 
   Party,
   Zdate,
   Shortno
