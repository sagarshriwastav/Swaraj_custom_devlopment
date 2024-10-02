@AbapCatalog.sqlViewName: 'YBCO_GREY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_BCO_CDS'
define view ZPP_BCO_GREY_CDS as select from ZPP_BCO_CDS
{
    key SupplierName,
        Dyeingsort,
        Zdate,
        sum(Balancemtr) as Balancemtr,
        Reed
        
     //   Shortno as Sortno
        
        
} where SupplierName = 'JAIN SILK & SYNTHETICS MILLS'

    group by Dyeingsort,
    Zdate,
    SupplierName,
    Reed
  //  Shortno

