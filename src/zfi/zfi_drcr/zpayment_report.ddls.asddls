@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Payment Report For fi Vendor'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zpayment_report as select from I_OperationalAcctgDocItem as a
inner join I_OperationalAcctgDocItem as z on a.AccountingDocument = z.AccountingDocument 
and z.Supplier is not initial 
left outer join I_Supplier as b on z.Supplier =  b.Supplier 
left outer join I_SuplrBankDetailsByIntId as y on b.Supplier = y.Supplier 
left  outer join  I_AddressEmailAddress_2  as c on c.AddressID = b.AddressID 
left  outer join I_Bank_2 as D on ( y.Bank = D.BankInternalID )

{
 key a.AccountingDocument,
 a.AccountingDocumentType ,
 a.PostingDate ,
 a.GLAccount,
 a.HouseBank,
 a.HouseBankAccount ,
 a.CompanyCodeCurrency ,
 @DefaultAggregation: #SUM
 @Semantics.amount.currencyCode: 'CompanyCodeCurrency' 
 a.AmountInCompanyCodeCurrency ,
 z.Supplier ,
 b.SupplierName ,
 c.EmailAddress , 
 y.Bank ,
 y.BankAccount ,
 y.BankControlKey , 
 D.Branch ,
//y._Bank.BankBranch  ,
 '293389'  as Customercode  ,
 'Sagar Manufacturers Pvt Ltd. '
 as CustomerName ,
 '32788541297' as DebitAccountNumber ,
 'NEFT' as PRODUCTCODE ,
 ''  as REMARK1 ,
 ' ' as ADD1 ,
 '' as ADD2
  }

where a.AccountingDocumentType = 'KZ' and a.HouseBank is not initial 
;
