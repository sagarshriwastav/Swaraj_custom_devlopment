//@AbapCatalog.sqlViewName: ''
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Cds For EPCG Obligation Report'
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For EPCG Obligation Report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZEPCG_OBLIGATION_ITEM_CDS as  
    select from ZEPCG_OBLIGATION_HEAD_CDS1 as  _item
   association[1] to ZEPCG_OBLIGATION_REP_CDS as head
   on  $projection.epcgno  = head.epcg_license_no
{
     @UI.lineItem: [{ position: 10, label: 'Invoice'}]
      @UI.identification: [{ position:10 }] 
    key _item.docno,
     @UI.lineItem: [{ position: 20, label: 'EPCG No'}]
      @UI.identification: [{ position:20 }] 
    key _item.epcgno,
    @UI.lineItem: [{ position: 30, label: 'TransactionCurrency'}]
      @UI.identification: [{ position:30 }] 
    _item.TransactionCurrency,
    @UI.lineItem: [{ position: 40, label: 'InvoiceValue'}]
      @UI.identification: [{ position:40 }] 
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    @Aggregation.default: #SUM
    _item.invoicevalue,
    head
}
