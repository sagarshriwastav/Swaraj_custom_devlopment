@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  Mat & Des For SortMaster'
define root view entity ZPP_PD_SORT as select from I_Product as a 
             inner join I_ProductDescription as b on ( b.Product = a.Product and b.Language = 'E' )
             left outer join zpp_sortmaster as c on ( c.pdno = b.ProductDescription )
{
    key a.Product ,
        b.ProductDescription,
        substring(a.Product,1,1) as TYPE,
        c.pdno


}    where  a.ProductType like 'ZPDN%'  and c.pdno is null

