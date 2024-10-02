@AbapCatalog.sqlViewName: 'YCOSTPMR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Cost Pr Mtr Report'
define view ZPM_COST_PR_MTR_CDS2 as select from I_MaterialDocumentItem_2 as a 
{
     key a.Material,
    key a.Plant,
    key a.StorageLocation,
    key a.CompanyCode,
        a.GoodsMovementType ,
        a.PostingDate,
        a.DocumentDate,
        a.MaterialBaseUnit,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        a.QuantityInEntryUnit,
        a.CompanyCodeCurrency,
        @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
        a.TotalGoodsMvtAmtInCCCrcy,
        a.CostCenter,
        substring(a.PostingDate,1,6) as ZDATE
        
}  


where a.GoodsMovementType = '201' and a.StorageLocation = 'HU01' 
