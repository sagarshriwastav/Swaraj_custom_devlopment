@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SUPPLIER_OUTSTANDIN_CDS_FINAL'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSUPPLIER_OUTSTANDIN_CDS_FINAL as select from ZSUPPLIER_OUTSTANDNING_CDS
{

      @UI.lineItem   : [{ position: 10 , label: 'Company Code ' }]
 //   @UI.lineItem: [{ position: 559, label: 'Old Contractor '}]
    @UI.identification: [{position: 10 }] 
    @EndUserText.label:  'Company Code'
     @UI.selectionField: [{ position: 10 }] 
      @Consumption.valueHelpDefinition: [ 
        { entity:  { name:    'I_CompanyCode',
                     element: 'CompanyCode' }
        }] 
    key CompanyCode,
    
      @UI.lineItem   : [{ position: 20 }]
    @UI.identification: [{position: 20 }] 
    @EndUserText.label:  'Fiscal Year'
//     @UI.selectionField: [{ position: 20 }] 
    key FiscalYear,
    
      @UI.lineItem   : [{ position: 30 }]
    @UI.identification: [{position: 30 }] 
    @EndUserText.label:  'Accounting Document'
//     @UI.selectionField: [{ position: 30 }] 
    key AccountingDocument,
    
//    @UI.lineItem   : [{ position: 40 }]
//    @UI.identification: [{position: 40 }] 
//    @EndUserText.label:  ' Accounting Document Item'
//    AccountingDocumentItem,
    
    @UI.lineItem   : [{ position: 50  , label: 'Accounting Document Type ' }]
    @UI.identification: [{position: 50 }] 
    @EndUserText.label:  'Accounting Document Type'
     @UI.selectionField: [{ position: 20 }] 
 
    @Consumption.valueHelpDefinition: [ 
        { entity:  { name:    'I_AccountingDocumentType',
                     element: 'AccountingDocumentType' }
        }] 
  key  AccountingDocumentType,
    
    @UI.lineItem   : [{ position: 60 , label: 'Supplier ' }]
    @UI.identification: [{position: 50 }] 
    @EndUserText.label:  ' Supplier'
     @UI.selectionField: [{ position: 30 }] 
     @Consumption.valueHelpDefinition: [ 
        { entity:  { name:    'I_Supplier',
                     element: 'Supplier' }
        }] 
  key  Supplier,
  
    
    @UI.lineItem   : [{ position: 50  , label: ' Profit Center ' }]
    @UI.identification: [{position: 60 }] 
    @EndUserText.label:  ' Profit Center'
     @UI.selectionField: [{ position: 40 }] 
     @Consumption.valueHelpDefinition: [ 
        { entity:  { name:    'I_ProfitCenter',
                     element: 'ProfitCenter' }
        }] 
 key   ProfitCenter,
    
//    @UI.lineItem   : [{ position: 50 }]
//    @UI.identification: [{position: 50 }] 
//    @EndUserText.label:  'Plant'
//    Plant,
    
    @UI.lineItem   : [{ position: 70 }]
    @UI.identification: [{position: 70 }] 
    @EndUserText.label:  'Business Place'
key    BusinessPlace,
    
    @UI.lineItem   : [{ position: 80 , label: 'Posting Date' }]
    @UI.identification: [{position: 80 }] 
    @EndUserText.label:  ' Posting Date'
     @UI.selectionField: [{ position: 50 }] 
 key   PostingDate,
    
    @UI.lineItem   : [{ position: 90 }]
    @UI.identification: [{position: 90 }] 
    @EndUserText.label:  '  Document Date'
 key   DocumentDate,
    
    @UI.lineItem   : [{ position: 100 }]
    @UI.identification: [{position: 100 }] 
    @EndUserText.label:  'Net Due Date'
 key   NetDueDate,
    
    @UI.lineItem   : [{ position: 101 }]
    @UI.identification: [{position: 101 }] 
    @EndUserText.label:  ' Company Code Currency'
 key   CompanyCodeCurrency,
    
    @UI.lineItem   : [{ position: 102 }]
    @UI.identification: [{position: 102 }] 
    @EndUserText.label:  'Amount'
    @Aggregation.default: #SUM
 key   cast(AmountInCompanyCodeCurrency as abap.dec( 13, 2 ) ) as AmountInCompanyCodeCurrency ,
    
    @UI.lineItem   : [{ position: 103 }]
    @UI.identification: [{position: 103 }] 
    @EndUserText.label:  'Original Reference Document'
 key   OriginalReferenceDocument,
    
    @UI.lineItem   : [{ position: 104 , label: ' Document Item Text' }]
    @UI.identification: [{position: 104 }] 
    @EndUserText.label:  ' Document Item Text'
     @UI.selectionField: [{ position: 50 }] 
    @Consumption.valueHelpDefinition: [ 
        { entity:  { name:    'ZFI_MATERIAL_WISE_CDS',
                     element: 'material' }
        }] 
  key  DocumentItemText,
    
    @UI.lineItem   : [{ position: 105 }]
    @UI.identification: [{position: 105 }] 
    @EndUserText.label:  '  Document Reference ID'
  key  DocumentReferenceID,
    
    @UI.lineItem   : [{ position: 106 }]
    @UI.identification: [{position: 106 }] 
    @EndUserText.label:  ' Last Change Date'
 key   LastChangeDate,
    
    @UI.lineItem   : [{ position: 107 }]
    @UI.identification: [{position: 107 }] 
    @EndUserText.label:  'Plant'
  key  Plant,
    
    @UI.lineItem   : [{ position: 108 }]
    @UI.identification: [{position: 108 }] 
    @EndUserText.label:  'Purchasing Document'
  key  PurchasingDocument,
    
//    @UI.lineItem   : [{ position: 109 }]
//    @UI.identification: [{position: 109 }] 
//    @EndUserText.label:  'ProfitCenter'
//     @Consumption.valueHelpDefinition: [ 
//        { entity:  { name:    'I_ProfitCenter',
//                     element: 'ProfitCenter' }
//        }] 
//    
//    ProfitCenter,
    
//    @UI.lineItem   : [{ position: 110 }]
//    @UI.identification: [{position: 110 }] 
//    @EndUserText.label:  'DAYS'
//    zdaysS,
    
    @UI.lineItem   : [{ position: 120 }]
    @UI.identification: [{position: 120 }] 
    @EndUserText.label:  'Days In Arrears  '
  key  zdays,
    
    
//     @UI.lineItem: [{ position: 559, label: 'Old Contractor '}]
//    @UI.identification: [{ position:559 }] 
//    @EndUserText.label: 'Old Contractor' 
//    supp.SupplierFullName
//    @UI.lineItem   : [{ position: 130 }]
//    @UI.identification: [{position: 130 }] 
//    @EndUserText.label:  'ITEAM'
//    ITEAM,
    
           @UI.lineItem             : [{position: 140 }]
                  @UI.selectionField       : [{position: 140  }]
                  @UI.identification       : [{position: 14  }]

                  @Consumption.filter.multipleSelections: false
                  @Consumption.filter.mandatory: true
                  //      @Consumption.defaultValue: 'CDNR'
                  @EndUserText.label       : 'Status'
                  @Consumption.valueHelpDefinition: [
                  { entity                  :  { name:    'ZSUPPLIER_OUTSTANDNING_F4',
                              element      : 'Status' }
                  }]
         key         Status,
                  
    @UI.lineItem   : [{ position: 150 , label: 'Supplier Name' }]
    @UI.identification: [{position: 150 }] 
    @EndUserText.label:  'Supplier Name '
//     @UI.selectionField: [{ position: 150 }] 
  key  SupplierFullName
              
//    
}// where Plant > '0'
group by 
    CompanyCode,
    FiscalYear,
    AccountingDocument,
  //  AccountingDocumentItem,
    AccountingDocumentType,
    Supplier,
    ProfitCenter,
     BusinessPlace,
     PostingDate,
      DocumentDate,
      NetDueDate,
       CompanyCodeCurrency,
       AmountInCompanyCodeCurrency,
        OriginalReferenceDocument,
         DocumentItemText,
           DocumentReferenceID,
             LastChangeDate,
             Plant,
              PurchasingDocument,
               zdays,
               ITEAM,
                Status,
                SupplierFullName
              
    
    


