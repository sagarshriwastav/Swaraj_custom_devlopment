@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Yarn Mat & Des'
define root view entity ZPP_MAT_DES_YARN_CDS as select from I_Product as a 
             inner join I_ProductDescription as b on ( b.Product = a.Product and b.Language = 'E' )
{
    key a.Product ,
        a.ProductOldID,
        b.ProductDescription,
        substring(a.Product,1,1) as TYPE


}    
  where  a.IndustryStandardName like 'W' or  a.IndustryStandardName like 'WE' 
// where   a.Product like 'Y%'
