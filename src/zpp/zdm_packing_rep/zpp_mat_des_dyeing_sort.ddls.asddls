@AbapCatalog.sqlViewName: 'YBDODES'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Mat & Des Dyeing Sort'
define view ZPP_MAT_DES_DYEING_SORT as select from I_Product as a 
             inner join I_ProductDescription as b on ( b.Product = a.Product and b.Language = 'E' )
{
    key a.Product ,
        b.ProductDescription


} where  a.Product like 'BDO%'  

group by 
      a.Product ,
        b.ProductDescription

