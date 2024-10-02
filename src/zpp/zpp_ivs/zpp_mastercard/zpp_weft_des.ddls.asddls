@AbapCatalog.sqlViewName: 'YPPWEFTPP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  MasterCard Weft F4'
define view ZPP_WEFT_DES  as select from I_Product as a 
             inner join I_ProductDescription as b on ( b.Product = a.Product and b.Language = 'E' )
{
    key a.Product , 
        a.ProductOldID,
        b.ProductDescription,
        substring(a.Product,1,1) as TYPE


}    
  where  a.IndustryStandardName like 'E'  or  a.IndustryStandardName like 'WE'
