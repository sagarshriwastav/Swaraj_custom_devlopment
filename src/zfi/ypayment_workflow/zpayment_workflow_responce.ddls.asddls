@EndUserText.label: 'RESPONCE CDS'
@Metadata.allowExtensions: true

@ObjectModel: {
    query: {
        implementedBy: 'ABAP:YPAYMENT_WORKFLOW_CLASS'
    }
}

define root custom entity ZPAYMENT_WORKFLOW_RESPONCE



{

      @UI.lineItem               : [{ position: 12 }]
      @UI.selectionField         : [{position: 12}]
      @UI.identification         : [{position: 12}]
      @Search.defaultSearchElement: true
      @EndUserText.label         : 'Company Code'
  key companycode                : abap.char( 4 );

      @UI.lineItem               : [{ position: 20 }]
      @UI.selectionField         : [{position: 20}]
      @UI.identification         : [{position: 20}]
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold : 0.8
      @Search.ranking            : #HIGH
      @EndUserText.label         : 'Year'
  key fiscalyear                 : abap.char( 4 );

      @UI.lineItem               : [{ position: 20 }]
      @UI.selectionField         : [{position: 20}]
      @UI.identification         : [{position: 20}]
      @EndUserText.label         : 'Posting Date'
  key postingdate                : abap.dats;

      @UI.lineItem               : [{ position: 20 }]
      @UI.selectionField         : [{position: 20}]
      @UI.identification         : [{position: 20}]
      @EndUserText.label         : 'Over Due by Days'
  key overdue_by_days            : abap.int4;


      @UI.lineItem               : [{ position: 20 }]
      @UI.selectionField         : [{position: 20}]
      @UI.identification         : [{position: 20}]
      @EndUserText.label         : 'Supplier'
  key supplier                   : abap.char( 10 );

      @UI.lineItem               : [{ position: 20 }]
      @UI.selectionField         : [{position: 20}]
      @UI.identification         : [{position: 20}]
      @EndUserText.label         : 'Accounting Document'
  key accountingdocument         : abap.char( 10 );

      @UI.lineItem               : [{ position: 20 }]
      @UI.selectionField         : [{position: 20}]
      @UI.identification         : [{position: 20}]
      @EndUserText.label         : 'Accounting Document Type'
  key accountingdocumenttype     : abap.char( 10 );

      @UI.lineItem               : [{ position: 20 }]
      @UI.selectionField         : [{position: 20}]
      @UI.identification         : [{position: 20}]
      @EndUserText.label         : 'Clearing Journalentry'
  key clearingjournalentry       : abap.char( 20 );

      @UI.lineItem               : [{ position: 20 }]
      @UI.selectionField         : [{position: 20}]
      @UI.identification         : [{position: 20}]
      @EndUserText.label         : 'Transaction Currency'
  key transactioncurrency        : abap.char( 10 );

      @UI.lineItem               : [{ position: 20 }]
      @UI.selectionField         : [{position: 20}]
      @UI.identification         : [{position: 20}]
      @EndUserText.label         : 'Cost Center'
  key amountinbalancetransaccrcy : abap.dec( 15,2  );

      @UI.lineItem               : [{ position: 20 }]
      @UI.selectionField         : [{position: 20}]
      @UI.identification         : [{position: 20}]
      @EndUserText.label         : 'Payment Terms'
  key paymentterms               : abap.char( 10 );

      @UI.lineItem               : [{ position: 20 }]
      @UI.selectionField         : [{position: 20}]
      @UI.identification         : [{position: 20}]
      @EndUserText.label         : 'Net Due Date '
  key netduedate                 : abap.int4;

      @UI.lineItem               : [{ position: 20 }]
      @UI.selectionField         : [{position: 20}]
      @UI.identification         : [{position: 20}]
      @EndUserText.label         : 'Additional Currency1'
  key additionalcurrency1        : abap.char( 10 );

      @UI.lineItem               : [{ position: 20 }]
      @UI.selectionField         : [{position: 20}]
      @UI.identification         : [{position: 20}]
      @EndUserText.label         : 'Assignment Reference'
  key assignmentreference        : abap.char( 10 );

      @UI.lineItem               : [{ position: 20 }]
      @UI.selectionField         : [{position: 20}]
      @UI.identification         : [{position: 20}]
      @EndUserText.label         : 'Document Date'
  key documentdate               : abap.dats;

      @UI.lineItem               : [{ position: 20 }]
      @UI.selectionField         : [{position: 20}]
      @UI.identification         : [{position: 20}]
      @EndUserText.label         : 'Supplier Name'
  key suppliername               : abap.char( 40 );


      @UI.lineItem               : [{ position: 20 }]
      @UI.selectionField         : [{position: 20}]
      @UI.identification         : [{position: 20}]
      @EndUserText.label         : 'Supplier Accountgroup'
  key supplieraccountgroup       : abap.char( 40 );

      @UI.lineItem               : [{ position: 20 }]
      @UI.selectionField         : [{position: 20}]
      @UI.identification         : [{position: 20}]
      @EndUserText.label         : 'Document Referenceid'
  key documentreferenceid        : abap.char( 10 );

      @UI.lineItem               : [{ position: 20 }]
      @UI.selectionField         : [{position: 20}]
      @UI.identification         : [{position: 20}]
      @EndUserText.label         : 'Account Groupname'
  key accountgroupname           : abap.char( 40 );

      @UI.lineItem               : [{ position: 20 }]
      @UI.selectionField         : [{position: 20}]
      @UI.identification         : [{position: 20}]
      @EndUserText.label         : 'Request'
  key request                    : abap.char( 20 );

      @UI.lineItem               : [{ position: 20 }]
      @UI.selectionField         : [{position: 20}]
      @UI.identification         : [{position: 20}]
      @EndUserText.label         : 'Amt 0-30'
  key amt_0_30                   : abap.dec( 15,2 );

      @UI.lineItem               : [{ position: 20 }]
      @UI.selectionField         : [{position: 20}]
      @UI.identification         : [{position: 20}]
      @EndUserText.label         : 'Amt 30-60'
  key amt_30_60                  : abap.dec( 15,2 );

      @UI.lineItem               : [{ position: 20 }]
      @UI.selectionField         : [{position: 20}]
      @UI.identification         : [{position: 20}]
      @EndUserText.label         : 'Amt 60-90'
  key amt_60_90                  : abap.dec( 15,2 );

      @UI.lineItem               : [{ position: 20 }]
      @UI.selectionField         : [{position: 20}]
      @UI.identification         : [{position: 20}]
      @EndUserText.label         : 'Amt '
  key amt_above_90               : abap.dec( 15,2 );

      @UI.lineItem               : [{ position: 20 }]
      @UI.selectionField         : [{position: 20}]
      @UI.identification         : [{position: 20}]
      @EndUserText.label         : 'Flag'
  key FLAG                       : abap.char( 10 );

      @UI.lineItem               : [{ position: 20 }]
      @UI.selectionField         : [{position: 20}]
      @UI.identification         : [{position: 20}]
      @EndUserText.label         : 'Special Gl Code'
  key SpecialGLCode              : abap.char( 20 );

      @UI.lineItem               : [{ position: 20 }]
      @UI.selectionField         : [{position: 20}]
      @UI.identification         : [{position: 20}]
      @EndUserText.label         : 'Reference Text'
  key InvoiceReference           : abap.char( 40 );

      @UI.lineItem               : [{ position: 20 }]
      @UI.selectionField         : [{position: 20}]
      @UI.identification         : [{position: 20}]
      @EndUserText.label         : 'Reference Text'
  key ItemText                   : abap.char( 50 );
  
      @UI.lineItem               : [{ position: 20 }]
      @UI.selectionField         : [{position: 20}]
      @UI.identification         : [{position: 20}]
      @EndUserText.label         : 'Remark '
  key  remark                 : abap.char(50); 
  
      @UI.lineItem               : [{ position: 20 }]
      @UI.selectionField         : [{position: 20}]
      @UI.identification         : [{position: 20}]
      @EndUserText.label         : 'Journalentry type  '
  key  journalentrytype          : abap.char(2);   
  
  
  
  
  
  
  
}
