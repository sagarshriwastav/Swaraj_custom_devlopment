@AbapCatalog.sqlViewName: 'YCUSTMAT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Customer  Material Detail'
define view YMATERIALCUS as select from YMATERIAL
{
    key Product,
    ProductExternalID,
    ProductOID,
    BaseUnit,
    ProductType,
    DESCRIPTION,
    HSN
}  where Product like 'YGJ%' or Product like 'BDJ%' or Product like 'YDJ%' 
