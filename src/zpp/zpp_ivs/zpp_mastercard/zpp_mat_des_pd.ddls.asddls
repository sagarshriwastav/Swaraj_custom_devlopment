@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Materail Des PD'
define root view entity ZPP_MAT_DES_PD as select from I_Product as a 
             left outer join ZPP_MAT_DES_FG1 as c on ( c.Product = a.Product )
             inner join I_ProductDescription as b on ( b.Product = a.Product and b.Language = 'E' )
             left outer join ZPP_SORTMASTER_CDS as d on ( d.Material = a.Product )
{
    key a.Product ,
        b.ProductDescription,
        substring(a.Product,1,1) as TYPE,
        d.Dent,
        d.Reed,
        d.Epi,
        d.Reedspace,
        d.Pick,
        d.Weave,
        d.Dyeingsort,
        d.Dyeingshade,
        d.Extraends,
        d.Pdno,
        d.Totalends,
        d.Loomtype


} where  a.Product like 'PD%' and c.Zpno is null 
