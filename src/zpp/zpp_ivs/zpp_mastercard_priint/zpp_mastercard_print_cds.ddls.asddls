@AbapCatalog.sqlViewName: 'YMASTERCARDPRINT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  MasterCard Print'
define view ZPP_MASTERCARD_PRINT_CDS as select from ZPC_HEADERMASTER_CDS
{
    key Zpunit,
    key Zpno ,
    key Zpqlycode,
       DyeSort,
       Zpdytype,
       pdnumber
    
}
