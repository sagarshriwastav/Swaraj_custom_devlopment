@AbapCatalog.sqlViewName: 'YPMCOST'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Cost Pr Mtr Report'
define view ZPM_COST_PR_MTR_CDS as select from ZPM_COST_PR_MTR_CDS2 as a 
                                 inner join I_ProductDescription as b on ( b.Product = a.Material and b.Language = 'E' )
                      left outer join  I_CostCenterText as c on ( c.CostCenter = a.CostCenter  and c.Language = 'E' )
                      left outer join YPS_ENERGY_CONSUMPTION_CDS1 as d on ( d.MsmtRdngDate = a.PostingDate and d.MeasurementReadingEntryUoM = 'KWH' )
                     left outer join YPS_ENERGY_CONSUMPTION_CDS1 as GS on ( GS.MsmtRdngDate = a.PostingDate 
                                                                  and GS.MeasurementReadingEntryUoM = 'TO' )
                      left outer join YPS_ENERGY_CONSUMPTION_CDS1 as GSS on ( GSS.MsmtRdngDate = a.PostingDate 
                                                                  and  GSS.MeasurementReadingEntryUoM = 'ZKL' )
                      left outer join ZPM_COST_PR_MTR_CDS1 as e on ( e.PostingDate = a.PostingDate )
                      left outer join ZPM_PRICE_MAINTAIN_CDS as Z on ( Z.Zdate = a.ZDATE ) 
    
{
    key a.Material,
    key a.Plant,
    key a.StorageLocation,
    key a.CompanyCode,
        a.GoodsMovementType ,
        a.PostingDate,
        a.DocumentDate,
        a.MaterialBaseUnit,
        a.QuantityInEntryUnit,
        a.CompanyCodeCurrency,
        a.TotalGoodsMvtAmtInCCCrcy,
        a.CostCenter,
        b.ProductDescription,
        c.CostCenterDescription,
        d.etp,
        d.aro,
        d.boiler,
        GS.SteamConsumption,
        GSS.FreshWateConsumption,
        e.MaterialBaseUnit1,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit1'
        e.OrderQTY,
        Z.Freshwaterprice,
        Z.Steamprice,
        @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
        Z.Electricityprice
}   
  
