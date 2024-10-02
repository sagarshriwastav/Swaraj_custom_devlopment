@AbapCatalog.sqlViewName: 'ZLASTINSTDATE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Loan Moduel Report'
define view ZlastInstalmentDate_CDS with parameters 
                p_posting:abap.dats
  as select from I_OperationalAcctgDocItem
{   
    key GLAccount,
    key CompanyCode,
    key AccountingDocument,
    max(PostingDate) as lastInstalmentDate,
       TransactionCurrency,
    sum(AmountInCompanyCodeCurrency) as lastInstalmentAmount
} 
where  PostingDate <= $parameters.p_posting
  group by  
         CompanyCode,
         GLAccount,
         TransactionCurrency,
         AccountingDocument
