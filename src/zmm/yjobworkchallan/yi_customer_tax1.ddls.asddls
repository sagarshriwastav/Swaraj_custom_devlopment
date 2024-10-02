@EndUserText.label: 'ACCOUNT'
@Search.searchable: false
@Metadata.allowExtensions: true
@AbapCatalog.dataMaintenance: #DISPLAY_ONLY
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.representativeKey: 'AccountingDocument'
define view entity YI_CUSTOMER_TAX1 as select from 
                        I_OperationalAcctgDocItem as A
                        left outer join I_OperationalAcctgDocItem as B 
                        on  B.AccountingDocument = A.AccountingDocument
                       and B.TaxItemAcctgDocItemRef = A.TaxItemAcctgDocItemRef  
                       and B.FiscalYear = A.FiscalYear  
                       and  B.TransactionTypeDetermination = 'JOI' 
                       
                       
                        left outer join I_OperationalAcctgDocItem as C 
                        on  C.AccountingDocument = A.AccountingDocument
                        and C.TaxItemAcctgDocItemRef = A.TaxItemAcctgDocItemRef  
                        and C.FiscalYear = A.FiscalYear  
                        and C.TransactionTypeDetermination = 'JOC' 
                       
                   
                        left outer join I_OperationalAcctgDocItem as D 
                        on  D.AccountingDocument = A.AccountingDocument
                        and D.TaxItemAcctgDocItemRef = A.TaxItemAcctgDocItemRef 
                        and D.FiscalYear = A.FiscalYear   
                        and D.TransactionTypeDetermination = 'JOS' 
                        
                        
                        
                       left outer join I_OperationalAcctgDocItem as E 
                        on  E.AccountingDocument = A.AccountingDocument
                        and E.FiscalYear = A.FiscalYear    
                        and E.Customer is not initial  
                        
                        
                        
                        inner join I_Customer as F
                        on  F.Customer = E.Customer 
               
                        
                        left outer join yirn_det as G 
                        on G.Docno = A.AccountingDocument 
                        
           
{
    key A.AccountingDocument, 
        A.FiscalYear,
        A.AccountingDocumentItem ,         
        A.AccountingDocumentItemType ,
        A.AccountingDocumentItemRef,
        A.AccountingDocumentType,
        A.TaxItemAcctgDocItemRef,
        A.TransactionCurrency ,
        A.IN_HSNOrSACCode as HSNCODE ,
        G.AckNo,
        G.AckDate,
        G.SignedQrcode,
        G.Irn,
        @Semantics.amount.currencyCode: 'TransactionCurrency' 
        A.AmountInCompanyCodeCurrency  as BASEAMT,
        B.TaxItemAcctgDocItemRef as BITEM , 
        B.TransactionTypeDetermination ,
       @Semantics.amount.currencyCode: 'TransactionCurrency' 
        B.AmountInCompanyCodeCurrency as IGST , 
       @Semantics.amount.currencyCode: 'TransactionCurrency' 
        C.AmountInCompanyCodeCurrency as CGST ,
        @Semantics.amount.currencyCode: 'TransactionCurrency' 
        D.AmountInCompanyCodeCurrency as SGST ,
        F.Customer,
        F.CustomerName ,
        F.TaxNumber3 as GST,
        @Semantics.amount.currencyCode: 'TransactionCurrency' 
        E.AmountInCompanyCodeCurrency as TOTAL_AMT
     
    }
  where A.AccountingDocumentItemType <> 'T' and A.TaxItemAcctgDocItemRef is not initial 
  
        
    

