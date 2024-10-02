@AbapCatalog.sqlViewName: 'YPPWAWPRMTR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For WawPerMtr'
define view ZPP_ZWAWPERMT_CDS as select from ZPC_HEADERMASTER_CDS
{
    key DyeSort as DyeSort,
        Zptotends
        
} where Zptotends > 0
    group by  
        DyeSort ,
        Zptotends
