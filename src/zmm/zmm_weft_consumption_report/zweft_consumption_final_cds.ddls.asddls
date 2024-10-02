//@AbapCatalog.viewEnhancementCategory: [#NONE]
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'ZWEFT_CONSUMPTION_CDS'
//@Metadata.ignorePropagatedAnnotations: true
//@ObjectModel.usageType:{
//    serviceQuality: #X,
//    sizeCategory: #S,
//    dataClass: #MIXED
//}
@EndUserText.label: 'ZLEDGER_CUSTOMER_NEW_CDS'
@Metadata.allowExtensions: true
@ObjectModel: {
    query: {
        implementedBy: 'ABAP:ZWEFT_CONSUMPTION_REPORT_CLASS'
    }
}
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define custom entity ZWEFT_CONSUMPTION_FINAL_CDS 
//select distinct from ZWEFT_CONSUMPTION_CDS as a
{
      @UI.lineItem             : [{ position: 1 }]
      @EndUserText.label       : 'Material Document'
  key MaterialDocument   : abap.numc( 10 );
  
      @UI.lineItem             : [{ position: 2 }]
      @EndUserText.label       : 'Material Document Item'
  key MaterialDocumentItem   : abap.numc( 4 );
    
      @UI.lineItem             : [{ position: 3 }]
      @EndUserText.label       : 'Weft Item'
  key Material           : abap.char( 18 );
  
      @UI.lineItem             : [{ position: 4 }]
      @EndUserText.label       : 'Weft Item Nme'
  key ProductDescription  : abap.char( 40 );   
  
      @UI.lineItem             : [{ position: 5 }]
      @UI.selectionField       : [{position: 10}]
      @EndUserText.label       : 'Plant'
  key Plant   : abap.numc( 4 );
  
      @UI.lineItem             : [{ position: 6 }]
      @UI.selectionField       : [{position: 20}]
      @EndUserText.label       : 'Batch'
  key Batch    : abap.char( 10 );
  
  key MaterialBaseUnit : abap.unit( 3 );
      @UI.lineItem             : [{ position: 7 }]
      @EndUserText.label       : 'Consumption Qty'
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @Aggregation.default: #SUM
  key QuantityInBaseUnit   : abap.dec( 13, 3 );
  
  key CompanyCodeCurrency  : abap.cuky( 5 );
      @UI.lineItem             : [{ position: 8 }]
      @EndUserText.label       : 'Consumption value'
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      @Aggregation.default: #SUM
  key TotalGoodsMvtAmtInCCCrcy  : abap.curr( 13, 2 );
      
      @UI.lineItem             : [{ position: 9}]
      @EndUserText.label       : 'Consumption Date'
      @UI.selectionField       : [{position: 30}]
  key PostingDate   : abap.datn;
      
      @UI.lineItem             : [{ position: 10 }]
      @EndUserText.label       : 'Invoice Date'
  key DocumentDate  : abap.datn;
      
      @UI.lineItem             : [{ position: 11 }]
      @EndUserText.label       : 'Purchase Order'
      @UI.selectionField       : [{position: 40}]
  key PurchaseOrder  : abap.numc( 10 );
      
      @UI.lineItem             : [{ position: 12 }]
      @EndUserText.label       : 'Purchase Order Item'
  key PurchaseOrderItem   : abap.numc( 5 );
  
      @UI.lineItem             : [{ position: 13 }]
      @EndUserText.label       : 'Party'
      @UI.selectionField       : [{position: 50}]
  key Supplier   : abap.numc( 10 );   
      
      @UI.lineItem             : [{ position: 14}]
      @EndUserText.label       : 'Party Name'
  key SupplierName   : abap.char( 40 );
      
      @UI.lineItem             : [{ position: 15 }]
      @EndUserText.label       : 'Invoice No.'
  key MaterialDocumentHeaderText  : abap.char( 40 );
      
      @UI.lineItem             : [{ position: 16 }]
      @EndUserText.label       : 'Grey Sort'
  key material_e   : abap.char( 18 );
  
      @UI.lineItem             : [{ position: 17 }]
      @EndUserText.label       : 'Grey Sort Name'
  key Productdescription_h   : abap.char( 40 );
  
  
  
      
  }   
