@AbapCatalog.sqlViewName: 'YWARPMAT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Mat & Des Yarn'
define view ZPP_WARP_MAT as select from I_Product as a 
             inner join I_ProductDescription as b on ( b.Product = a.Product and b.Language = 'E' )
{
    key a.Product ,
        b.ProductDescription,
        a.ProductOldID


} where  a.IndustryStandardName like 'W'  

group by 
        a.Product ,
        b.ProductDescription,
        a.ProductOldID

