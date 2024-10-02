//@AbapCatalog.sqlViewName: ''
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Cds for sales policy head report'

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For EPCG Obligation Report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
    
    
}    
define root view entity ZSALES_POLICY_HEAD_CDS 
 as select from ZSALES_POLICY_REP_CDS association
   [1..*] to   ZSALES_POLICY_ITEM_CDS  as _item on 
   $projection.plant  = _item.plant
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
    
    
     { position: 10, label: 'plant'}]
      @UI.identification: [{ position:10 } ]
      @ObjectModel.text.association: '_item'
      @UI.selectionField: [{ position: 10 }]
      @Search.defaultSearchElement: true
      @EndUserText.label: 'plant'
      key plant,
       @UI.lineItem: [{ position: 20, label: 'policyno'}]
      @UI.identification: [{ position:20 }]
      key ZSALES_POLICY_REP_CDS.policyno,
      @UI.lineItem: [{ position: 30 , label: 'nameofpolicyprovider'}]
      @UI.identification: [{ position:30 }] 
      key ZSALES_POLICY_REP_CDS.nameofpolicyprovider,
      @UI.lineItem: [{ position: 40, label: 'policystartdate'}]
      @UI.identification: [{ position:40 }]  
      key ZSALES_POLICY_REP_CDS.policystartdate,
        @UI.lineItem: [{ position: 50, label: 'policycoverageperiod'}]
      @UI.identification: [{ position:50 }]  
      key ZSALES_POLICY_REP_CDS.policycoverageperiod,
        @UI.lineItem: [{ position: 60, label: 'policyrenweldate'}]
      @UI.identification: [{ position:60 }]  
     key ZSALES_POLICY_REP_CDS.policyrenweldate,
      @UI.lineItem: [{ position: 70, label: 'policycoverageamount'}]
      @UI.identification: [{ position:70 }] 
   //   @Semantics.amount.currencyCode: 'TransactionCurrency' 
      ZSALES_POLICY_REP_CDS.policycoverageamount,
      @UI.lineItem: [{ position: 80, label: 'TransactionCurrency'}]
      @UI.identification: [{ position:80 }]  
       ZSALES_POLICY_REP_CDS.TransactionCurrency,
         @UI.lineItem: [{ position: 90, label: 'invoicevalue'}]
      @UI.identification: [{ position:90 }]  
       @Semantics.amount.currencyCode: 'TransactionCurrency'
       ZSALES_POLICY_REP_CDS.invoicevalue,
         @UI.lineItem: [{ position: 100, label: 'RemainingVakueInPolicy'}]
      @UI.identification: [{ position:100 }]  
       @Semantics.amount.currencyCode: 'TransactionCurrency'
       ZSALES_POLICY_REP_CDS.RemainingVakueInPolicy,
       _item
}
