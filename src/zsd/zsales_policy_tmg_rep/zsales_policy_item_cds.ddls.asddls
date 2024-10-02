//@AbapCatalog.sqlViewName: 'YSALESPOLICYREPORT'
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Cds for sales policy'

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For EPCG Obligation Report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}    
define view entity ZSALES_POLICY_ITEM_CDS 
  as select from ZSALES_POLICY_HEAD_CDS1 as _item
  association[1] to ZSALES_POLICY_REP_CDS as head
  on $projection.plant = head.plant
{
    @UI.lineItem: [{ position: 10, label: 'plant'}]
     @UI.identification: [{ position:10 }]
key _item.plant , 
    @UI.lineItem: [{ position: 20, label: 'invoice'}]
    @UI.identification: [{ position:20 }]  
key _item.invoice,
    @UI.lineItem: [{ position: 30, label: 'TransactionCurrency'}]
    @UI.identification: [{ position:30 }]
 _item.TransactionCurrency ,  
    @UI.lineItem: [{ position: 40, label: 'invoicevalue'}]
     @UI.identification: [{ position:40 }]
   @Semantics.amount.currencyCode: 'TransactionCurrency'
   @Aggregation.default: #SUM    
 _item.invoicevalue,
   head
    
}
