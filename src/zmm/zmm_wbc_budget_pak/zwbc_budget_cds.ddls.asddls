@EndUserText.label: 'CDS FOR RESPO'
@Metadata.allowExtensions: true
@ObjectModel: {
    query: {
        implementedBy: 'ABAP:ZWBC_BUDGET_REPORT'
    }
}
define root custom entity ZWBC_BUDGET_CDS
{


   @UI.lineItem           : [{position: 140}]
      @UI.identification     : [{position: 140}]
      @UI.selectionField: [{position: 140}]
      @EndUserText.label     :     ' WBSElementInternalID'
  key    WBSElementInternalID_2   : abap.numc( 8);
      
  
      @UI.lineItem           : [{position: 10}]
      @UI.identification     : [{position: 10}]
      @UI.selectionField     : [{position: 10}]
      @EndUserText.label     :     'MaterialDocument'
 key  MaterialDocument       : abap.char(10);
  
  
  
    @UI.lineItem           : [{position: 110}]
      //      @UI.selectionField: [{position: 20}]
      @UI.identification     : [{position: 110}]
      @EndUserText.label     :     'PurchaseOrderItem'
 key     PurchaseOrderItem      : abap.numc( 5);
 
  @UI.lineItem           : [{position: 100}]
            @UI.selectionField: [{position: 100}]
      @UI.identification     : [{position: 100}]
      @EndUserText.label     :     'PurchaseOrder'
 key    PurchaseOrder          : abap.char( 10);
  
  
   @UI.lineItem           : [{position: 40}]
           @UI.selectionField: [{position: 40}]
      @UI.identification     : [{position: 40}]
      @EndUserText.label     :     'SupplierInvoice'
     SupplierInvoice        : abap.char( 10 );
  
   
   
   @UI.lineItem           : [{position: 50}]
      //      @UI.selectionField: [{position: 20}]
      @UI.identification     : [{position: 50}]
      @EndUserText.label     :     'Material'
      Material               : abap.char( 40 );
    
   
      @UI.lineItem           : [{position: 20}]
//      @UI.selectionField     : [{position: 20}]
      @UI.identification     : [{position: 20}]
      @EndUserText.label     :     'INVOICE_POSTING_DATE'
      PostingDate            : abap.dats(8);

      @UI.lineItem           : [{position: 130}]
//      @UI.selectionField     : [{position: 130}]
      @UI.identification     : [{position: 130}]
      @EndUserText.label     :     'GRN_POSTING_DATE'
      PostingDate02          : abap.dats(8);


      @UI.hidden             : true
      @EndUserText.label     : 'CompanyCodeCurrency'
      CompanyCodeCurrency    : abap.cuky( 5 );

      @UI.lineItem           : [{position: 30}]
      //      @UI.selectionField: [{position: 20}]
      @UI.identification     : [{position: 30}]
      @EndUserText.label     :     'InvoiceAmt'
      @Aggregation.default   : #SUM
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      InvoiceAmtInCoCodeCrcy : abap.curr( 30, 2);



      @UI.hidden             : true
      @EndUserText.label     : 'MaterialBaseUnit'
      MaterialBaseUnit       : abap.unit( 3 );

      
      

      @UI.lineItem           : [{position: 60}]
      //      @UI.selectionField: [{position: 20}]
      @UI.identification     : [{position: 60}]
      @EndUserText.label     :     'QuantityInEntryUnit'
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @Aggregation.default   : #SUM
      QuantityInEntryUnit    : abap.quan( 30, 3 );


      @UI.lineItem           : [{position: 70}]
      //      @UI.selectionField: [{position: 20}]
      @UI.identification     : [{position: 70}]
      @EndUserText.label     :     'Supplier'
      Supplier               : abap.char( 10 );

      @UI.lineItem           : [{position: 80}]
      //      @UI.selectionField: [{position: 20}]
      @UI.identification     : [{position: 80}]
      @EndUserText.label     :     'SupplierName'
      SupplierName           : abap.char( 80 );

      @UI.lineItem           : [{position: 90}]
      //      @UI.selectionField: [{position: 20}]
      @UI.identification     : [{position: 90}]
      @EndUserText.label     :     'PurchaseOrderItemText'
      PurchaseOrderItemText     : abap.char( 40 );

      
      
      @UI.lineItem           : [{position: 120}]
      //      @UI.selectionField: [{position: 20}]
      @UI.identification     : [{position: 120}]
      @EndUserText.label     :     'NetPriceAmount'
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      @Aggregation.default   : #SUM
      NetPriceAmount         : abap.curr( 30,2 );


      
      
///      @UI.lineItem           : [{position: 150}]
//      @UI.identification     : [{position: 150}]
 //     @UI.selectionField: [{position: 20}]
//      @EndUserText.label     :     ' WBSElementInternalID-2'
//      WBSElementInternalID01   : abap.numc( 8);



     @UI.lineItem           : [{position: 150}]
      @UI.identification     : [{position: 150}]
//      @UI.selectionField: [{position: 20}]
     @EndUserText.label     :     ' WBSElementExternalID'
      WBSElementExternalID   : abap.char(24);
     
     
     @UI.lineItem           : [{position: 160}]
      @UI.identification     : [{position: 160}]
//      @UI.selectionField: [{position: 20}]
     @EndUserText.label     :     ' WBSNAME'
      ProjectElementDescription   : abap.char(60);
      
      @UI.lineItem           : [{position: 170}]
      @UI.identification     : [{position: 170}]
//      @UI.selectionField: [{position: 20}]
     @EndUserText.label     :     'INVOICE'
      SupplierInvoiceIDByInvcgParty   : abap.char(16);
     

     








}
