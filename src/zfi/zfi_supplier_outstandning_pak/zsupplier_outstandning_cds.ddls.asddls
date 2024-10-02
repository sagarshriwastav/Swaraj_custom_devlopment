@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SUPPLIER_OUTSTANDNING_CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSUPPLIER_OUTSTANDNING_CDS as select from  I_OperationalAcctgDocItem as A
left outer join   I_JournalEntry as B on (  B.CompanyCode = A.CompanyCode  and B.PostingDate = A.PostingDate 
                     and B.AccountingDocument = A.AccountingDocument and B.FiscalYear = A.FiscalYear  )
                     // and B.FiscalPeriod = A.AccountingDocumentItem                  )
left outer join ZI_OperationalAcctgDocItem_CDS as C on (   C.AccountingDocument = A.AccountingDocument and C.CompanyCode = A.CompanyCode and C.FiscalYear = A.FiscalYear  and C.PurchasingDocument = A.PurchasingDocument  )    
left outer join I_Supplier as D on (   D.Supplier = A.Supplier    ) 
left outer join  ZI_Operational_PROFITCENTER as E on ( E.CompanyCode = A.CompanyCode and E.FiscalYear = A.FiscalYear and E.AccountingDocument = A.AccountingDocument )    
left outer join YFI_PAYMENT_PROFITCENTER as F on ( F.CompanyCode = A.CompanyCode and F.FiscalYear = A.FiscalYear 
                                                     and F.AccountingDocument = A.AccountingDocument)
//left outer join ZI_OperationalAMOUNT_SUM  as G on (   G.CompanyCode = A.CompanyCode and G.AccountingDocument = A.AccountingDocument and G.FiscalYear = A.FiscalYear  and G.ProfitCenter = A.ProfitCenter    )                                                                                         
//and B.FiscalYear = A.FiscalYear and B.AccountingDocument = A.AccountingDocument         )

{ key A.CompanyCode,
  key  A.FiscalYear,
  key  A.AccountingDocument,
  key   A.AccountingDocumentItem,
      A.AccountingDocumentType,
      A.Supplier,
  //    A.ProfitCenter,
///      A.Plant,
      A.BusinessPlace,
      A.PostingDate,
      A.DocumentDate,
      A.NetDueDate,
      A.CompanyCodeCurrency,
       @Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} }
      A.AmountInCompanyCodeCurrency  as AmountInCompanyCodeCurrency ,
      left(A.OriginalReferenceDocument , 10) as   OriginalReferenceDocument,
      A.DocumentItemText,
      B.DocumentReferenceID,
      B.LastChangeDate,
      C.Plant ,
      D.SupplierFullName,
     // C.ProfitCenter,
      C.PurchasingDocument,
      case when E.ProfitCenter <> '' then E.ProfitCenter
      else F.ProfitCenter end as  ProfitCenter,
      
//      case 
//    when A.NetDueDate is not null then 
//        case 
//            when dats_days_between($session.system_date, A.NetDueDate) > 0 then 
//                dats_days_between($session.system_date, A.NetDueDate)
//            else 
//                dats_days_between($session.system_date, A.NetDueDate)
//        end 
//    else 
//        0 
//end as zdaysS,
      
      
case when dats_days_between( A.NetDueDate,  $session.system_date  ) > 0 and  A.NetDueDate is not initial
then dats_days_between( A.NetDueDate ,  $session.system_date )
when  A.NetDueDate is not initial then
dats_days_between(   A.NetDueDate , $session.system_date  )    else 0 end as   zdays,

   case when  A.FinancialAccountType = 'K' then  A.ClearingItem   end as ITEAM,
   
//   



case 
    when cast(A.ClearingItem as abap.dec(5, 0)) = 0 then 'Open Items'
    when cast(A.ClearingItem as abap.dec(5, 0)) > 0 then 'Cleared Items'
    else 'All Items' 
end as Status

// case 
//    when cast(A.ClearingItem as abap.dec(5, 0)) = 0 then 'Open Items'
//    when cast(A.ClearingItem as abap.dec(5, 0)) > 0 then 'Cleared Items'
//    when cast(A.ClearingItem as abap.dec(5, 0))  is not null  then 'All Items'
//    else 'Other Status' 
//  end as Status,
  
//  case 
//    when cast(A.ClearingItem as abap.dec(5, 0)) = 0 then 'Open Items'
//    when cast(A.ClearingItem as abap.dec(5, 0)) >= 1 and cast(A.ClearingItem as abap.dec(5, 0)) <= 999 then 'Cleared Items'
//    when A.ClearingItem is not null then 'All Items'  -- Specifically checking for null
//    else  null  
//  end as Status
   
 

      
 
     
}where  A.FinancialAccountType = 'K'    and    A.SpecialGLCode <> 'F'  and  B.ReversalReferenceDocument = ''  

group by
 A.CompanyCode,                                      
 A.FiscalYear,                                      
 A.AccountingDocument,                              
A.AccountingDocumentType,                           
A.Supplier,                                         
 // A.ProfitCenter,                                   
 // A.Plant,                                          
A.BusinessPlace,                                    
A.PostingDate,                                      
A.DocumentDate,                                     
A.NetDueDate,                                       
A.CompanyCodeCurrency,                              
A.AmountInCompanyCodeCurrency,                      
A.OriginalReferenceDocument,                        
A.DocumentItemText,                                 
B.DocumentReferenceID,                              
B.LastChangeDate,                                   
C.Plant,                                            
C.ProfitCenter,                                     
C.PurchasingDocument ,
 F.ProfitCenter  ,
 E.ProfitCenter    ,
    A.AccountingDocumentItem  ,
    A.FinancialAccountType    ,
     A.ClearingItem  ,
      D.SupplierFullName                 

                                                    
