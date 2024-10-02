@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Mat % Des For Set No Screen'
define root view entity ZPP_SET_NO_MAT_DES as select from I_Product as a 
             inner join I_ProductDescription as b on ( b.Product = a.Product and b.Language = 'E' )
{
    key a.Product ,
        b.ProductDescription


} where  a.Product like 'BDO%'
