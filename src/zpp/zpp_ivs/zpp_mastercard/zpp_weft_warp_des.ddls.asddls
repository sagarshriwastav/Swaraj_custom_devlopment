@AbapCatalog.sqlViewName: 'YPPWEFTWARPPP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Mat Descripton Weft Warp'
define view ZPP_WEFT_WARP_DES  as select from I_Product as a 
             inner join I_ProductDescription as b on ( b.Product = a.Product and b.Language = 'E' )
{
    key a.Product , 
        a.ProductOldID,
        b.ProductDescription


}    
  where  a.IndustryStandardName like 'WE'  
    group by 
        a.Product , 
        a.ProductOldID,
        b.ProductDescription
