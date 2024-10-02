@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  Mat & Des For SortMaster'
define root view entity ZPP_MAT_DES_SORT as select from I_Product as a 
             inner join I_ProductDescription as b on ( b.Product = a.Product and b.Language = 'E' )
             left outer join zpp_sortmaster as c on ( c.material = a.Product )
{
    key a.Product ,
        b.ProductDescription,
        substring(a.Product,1,1) as TYPE


} where  a.Product like 'FF%' and c.pdno is null

