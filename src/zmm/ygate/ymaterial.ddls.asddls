@AbapCatalog.sqlViewName: 'ZPROFU'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MATERIAL F4 WITH  HSN'
define view YMATERIAL as select from I_Product as A 
left outer join I_ProductText as maktx on A.Product = maktx.Product and maktx.Language = 'E'  
left outer join I_ProductPlantBasic as HSNCODE on A.Product  = HSNCODE.Product 
//and  HSNCODE.Plant = '1101'
  {
    key A.Product,
    ProductExternalID,
    ProductOID,
    A.BaseUnit,
    ProductType,
    maktx.ProductName as DESCRIPTION,
    HSNCODE.ConsumptionTaxCtrlCode as HSN

}
