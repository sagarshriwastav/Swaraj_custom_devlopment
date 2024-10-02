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

define root view entity 
 ZEPCG_OBLIGATION_HEAD_CDS  
 as select from ZEPCG_OBLIGATION_REP_CDS association
   [1..*] to   ZEPCG_OBLIGATION_ITEM_CDS  as _item on 
   $projection.epcg_license_no  = _item.epcgno
{
   @UI.facet: [{ id: 'Connection'  ,
                    purpose:#STANDARD,
                    type: #IDENTIFICATION_REFERENCE,
                    position: 10,
                    label: 'Header Document' },
                    
                   { id: 'Header',
                    purpose: #STANDARD,
                    type: #LINEITEM_REFERENCE,
                    position: 20,
                    label: 'Items',
                    targetElement: '_item' 
                      }]
@UI.multiLineText: true  
               
 @UI.lineItem: [
    { position: 5  },
//    { position: 10, dataAction: 'Bank_data',  label: 'Bank Data 🏦', invocationGrouping: #CHANGE_SET },  
//    { type: #FOR_ACTION, dataAction: 'Bank_data', isCopyAction: true, label: 'Bank Data 🏦', invocationGrouping: #CHANGE_SET, position: 10  } ,
    { position: 10, label: 'EPCG No'}]
      @UI.identification: [{ position:10 } ]
      @ObjectModel.text.association: '_item'
      @UI.selectionField: [{ position: 10 }]
      @Search.defaultSearchElement: true
      @EndUserText.label: 'EPCG No'
   key epcg_license_no,
      @UI.lineItem: [{ position: 20, label: 'Valid From'}]
      @UI.identification: [{ position:20 }]  
   key ZEPCG_OBLIGATION_REP_CDS.valid_from,
     @UI.lineItem: [{ position: 30 , label: 'Valid To'}]
      @UI.identification: [{ position:30 }]  
   key ZEPCG_OBLIGATION_REP_CDS.valid_to,
     @UI.lineItem: [{ position: 40, label: 'Export Obligation'}]
      @UI.identification: [{ position:40 }]  
       ZEPCG_OBLIGATION_REP_CDS.export_obligation,
         @UI.lineItem: [{ position: 50, label: 'TransactionCurrency'}]
      @UI.identification: [{ position:50 }]  
       ZEPCG_OBLIGATION_REP_CDS.TransactionCurrency,
         @UI.lineItem: [{ position: 60, label: 'Invoice Value'}]
      @UI.identification: [{ position:60 }]  
       @Semantics.amount.currencyCode: 'TransactionCurrency'
       ZEPCG_OBLIGATION_REP_CDS.invoicevalue,
         @UI.lineItem: [{ position: 70, label: 'Balance Value'}]
      @UI.identification: [{ position:70 }]  
       @Semantics.amount.currencyCode: 'TransactionCurrency'
       ZEPCG_OBLIGATION_REP_CDS.BalanceValue,
       _item 
}
