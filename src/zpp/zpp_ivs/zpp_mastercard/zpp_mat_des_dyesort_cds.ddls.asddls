@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  Mat & Des For Dyesort'
define root view entity ZPP_MAT_DES_DYESORT_CDS as select from I_Product as a 
             inner join I_ProductDescription as b on ( b.Product = a.Product and b.Language = 'E' )
             left outer join ZPP_DYEING_SHADE_CDS as c on (c.dyeingsort = a.Product )
{
    key a.Product ,
        b.ProductDescription,
        c.dyeingshade


} where  a.Product like 'BDO%' //or a.Product like 'FG%'
