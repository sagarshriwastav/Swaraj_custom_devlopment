@AbapCatalog.sqlViewName: 'ZPURCG1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PURCDATA'
define view YPURCHASE_ORDERDATA as select from I_PurchaseOrderAPI01 as _A 
{ key PurchaseOrder,
  PurchaseOrderType,
  PurchaseOrderSubtype,
   PurchaseOrderDate,
  CorrespncInternalReference,
  PurchasingDocumentDeletionCode,
  ReleaseIsNotCompleted,
  PurchasingCompletenessStatus,
  PurchasingProcessingStatus,
  PurgReleaseSequenceStatus,
  ReleaseCode,
  CompanyCode,
  PurchasingOrganization,
  PurchasingGroup,
  Supplier,
  ManualSupplierAddressID,
  SupplierRespSalesPersonName,
  SupplierPhoneNumber,
  SupplyingSupplier,
  SupplyingPlant,
  InvoicingParty,
  Customer,
  SupplierQuotationExternalID,
  PaymentTerms,
  CashDiscount1Days,
  CashDiscount2Days,
  NetPaymentDays,
  CashDiscount1Percent,
  CashDiscount2Percent,
  DownPaymentType,
  DownPaymentPercentageOfTotAmt,
  DownPaymentAmount,
  DownPaymentDueDate,

  PurgReleaseTimeTotalAmount
//  YY1_SUPPLIERREFDATE_PDH,
//  YY1_SUPPLIERREF_PDH,
//  YY1_EMAIL1_PDH,
//  YY1_SHIPTOADDRESS_PDH,
//  YY1_EPCGLICENCE_PDH,
//  /* Associations */
//  _PurchaseOrderItem ,
//  _YY1_EMAIL1_PDH,
//  _YY1_EPCGLICENCE_PDH,
//  _YY1_SHIPTOADDRESS_PDH

}
