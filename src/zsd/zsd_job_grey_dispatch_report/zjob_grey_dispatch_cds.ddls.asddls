@AbapCatalog.sqlViewName: 'ZJOB'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds Job  Grey DispatcH Report'
define view ZJOB_GREY_DISPATCH_CDS as select from I_DeliveryDocumentItem as a 
          
           left outer join I_DeliveryDocument as d on ( d.DeliveryDocument = a.DeliveryDocument )
           left outer join I_SalesDocument as f on ( f.SalesDocument = a.ReferenceSDDocument )
           left outer join I_SalesDocumentItem as g on ( g.SalesDocument = a.ReferenceSDDocument 
                                                          and g.SalesDocumentItem = a.ReferenceSDDocumentItem
                                                        )
           left outer join I_BillingDocumentItem as c on ( c.ReferenceSDDocument = a.DeliveryDocument and  c.ReferenceSDDocumentItem = a.DeliveryDocumentItem 
                                                           )
          left outer join ZJOB_CONDITIONAMT_SUM_CDS as b on ( b.SalesDocument = a.ReferenceSDDocument 
                                                          and b.SalesDocumentItem = a.ReferenceSDDocumentItem
                                                        )
          inner join I_ProductDescription  as e on ( e.Product = a.Material and e.Language = 'E' )                                           
           left outer join ZJOB_GREY_NETWT_DISPATCH_CDS as h on ( h.Material = a.Material and h.Batch = a.Batch )
{
    key a.DeliveryDocument,
    key a.DeliveryDocumentItem,
        d.DocumentDate as DeliveryDate,
        f.CreationDate as OrderDate,
        c.CreationDate as BillDate,
        a.Material,
        a.Plant,
        a.StorageLocation,
        a.Batch,
        a.ReferenceSDDocument,
        a.ReferenceSDDocumentItem,
        a.DeliveryQuantityUnit,
        b.ConditionCurrency,
        c.BillingDocument,
        c.BillingDocumentItem,
        e.ProductDescription,
        g.MaterialPricingGroup,
        @Semantics.quantity.unitOfMeasure: 'DeliveryQuantityUnit'
        a.ActualDeliveryQuantity as  QUANTITY,
       @Semantics.amount.currencyCode: 'ConditionCurrency'
        b.PIKRATE   as PIKRATE,
        @Semantics.amount.currencyCode: 'ConditionCurrency'
        b.ROLLCHARGES  as ROLLCHARGES,
        @Semantics.amount.currencyCode: 'ConditionCurrency'
         b.MandingCHargeS   as MandingCHargeS,
         @Semantics.amount.currencyCode: 'ConditionCurrency'
        b.IgstPercent   as IgstPercent,
         @Semantics.amount.currencyCode: 'ConditionCurrency'
        b.TotalBasicAmt   as TotalBasicAmt,
        @Semantics.amount.currencyCode: 'ConditionCurrency'
     (( (b.TotalBasicAmt ) * b.IgstPercent ) ) as TotalIgstAmt,     
     @Semantics.quantity.unitOfMeasure: 'DeliveryQuantityUnit'
        sum(h.Netwt) as NetWt,
        count( distinct a.Batch ) as PcsNo
        
}  where a.DeliveryDocumentItemCategory = 'CB99'

   group by 
        a.DeliveryDocument,
        a.DeliveryDocumentItem,
        d.DocumentDate,
        f.CreationDate,
        c.CreationDate,
        a.Material,
        a.Plant,
        a.StorageLocation,
        a.Batch,
        a.ReferenceSDDocument,
        a.ReferenceSDDocumentItem,
        a.DeliveryQuantityUnit,
        b.ConditionCurrency,
        c.BillingDocument,
        c.BillingDocumentItem,
        e.ProductDescription,       
        g.MaterialPricingGroup,
        a.ActualDeliveryQuantity,        
        b.PIKRATE,
        b.ROLLCHARGES,
        b.MandingCHargeS,
        b.IgstPercent,
        b.TotalBasicAmt
        
        
