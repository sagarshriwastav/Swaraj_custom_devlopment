@AbapCatalog.sqlViewName: 'YMASTERF4'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Master Headr F4'
define view ZPP_MASTERCARD_MAT_F4  as select from ZPC_HEADERMASTER_CDS as a 
             inner join I_ProductDescription as b on ( b.Product = a.Zpqlycode and b.Language = 'E' )
{
    key a.Zpno,
        a.Zpqlycode,
        a.Zpunit,
        a.DyeSort,
        b.ProductDescription
}  
  group by  
        a.Zpno,
        a.Zpqlycode,
        a.Zpunit,
        a.DyeSort,
        b.ProductDescription
