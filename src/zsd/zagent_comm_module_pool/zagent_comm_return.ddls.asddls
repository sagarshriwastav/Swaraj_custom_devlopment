@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'VA Report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define root view entity ZAGENT_COMM_return
    as select from I_BillingDocumentPartnerBasic as a 
    left outer join  I_BillingDocumentBasic as b on b.BillingDocument = a.BillingDocument 
    left outer join  I_Supplier as c on c.Supplier  = a.Supplier 
    left outer join  I_Customer  as d on d.Customer  = b.SoldToParty 
    left outer join  ZINVOICE_TOT  as e on e.BillingDocument  = a.BillingDocument 
    left outer join ZAGENT_TAB_cds as f on f.Invoicenumber = a.BillingDocument
    
{
  key a.Supplier,
      b.BillingDocumentDate,
      b.BillingDocument,
      b.SoldToParty,
      b.TransactionCurrency,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      b.TotalNetAmount,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      b.TotalTaxAmount,
      c.SupplierFullName,
      d.CustomerFullName,
      e.BillingQuantityUnit,
      @Semantics.quantity.unitOfMeasure: 'BillingQuantityUnit'
      e.bill_qty,
      f.Approve,
      f.Reject,
      f.Return_flag
      
}
where b.BillingDocumentType = 'CBRE' 
 and b.BillingDocumentIsCancelled = ''
 and a.PartnerFunction = 'ZA'
// and a.Supplier = 'SS'
