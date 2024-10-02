@AbapCatalog.sqlViewName: 'YLOOMWISE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Loom Wise Production Report'
define view ZPP_LOOMWISE_PRODUCTION_CDS as select from ZPP_BCO_CDS
{
    key Party,
    key Zdate,
    key Shortno,
    key Loomno,
        sum(Acshifta) as Acshifta,
        sum(Acshiftb) as AcshiftB
}
   group by 
     Party,
     Zdate,
     Shortno,
     Loomno
