@AbapCatalog.sqlViewName: 'YDYEINGR_CDS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS FOR NET WEIGHT SUM'
define view ZPP_DYEINGR_SETNO_CDS as select from ZPP_DYEINGR_CDS
{
    key Setno ,
       sum( Netweight ) as Netweight
    
}
group by
Setno
