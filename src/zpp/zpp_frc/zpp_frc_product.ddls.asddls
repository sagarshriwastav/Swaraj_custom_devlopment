@AbapCatalog.sqlViewName: 'YPRODUCT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Fents Regs Chindi Screen'
define view ZPP_FRC_PRODUCT as select from I_Product as a 
        inner join I_ProductDescription as b on (  b.Product = a.Product and b.Language = 'E' )
{
    key a.Product,
        a.BaseUnit,
        b.ProductDescription
}    where a.ProductDocumentNumber = 'GOODCUT' or a.ProductDocumentNumber = 'FRC'
   group by 
        a.Product ,
        a.BaseUnit,
        b.ProductDescription
