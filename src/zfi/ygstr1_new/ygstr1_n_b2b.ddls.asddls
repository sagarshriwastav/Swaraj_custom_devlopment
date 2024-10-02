//@AbapCatalog.sqlViewName: 'YGSTR1B2B'
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 B2B'
define view entity YGSTR1_N_B2B as select from YGSTR1_BILL_DATA
{
 key BillingDocument
    // BillingDocumentItem
  /*    NetAmount,
      TaxAmount,
     TaxCode,
     SoldToParty,
     BillingDocumentType,
     BillingDocumentDate,
     BaseUnit,
     @Semantics.quantity.unitOfMeasure: 'BaseUnit'
     BillingQuantity,
   //  ConditionType,
     TransactionCurrency,   
     @Semantics.amount.currencyCode: 'TransactionCurrency'      
     case ConditionType 
     when 'JOIG' then IGST end as IGST,
     @Semantics.amount.currencyCode: 'TransactionCurrency'   
     case ConditionType 
     when 'JOSG' then SGST end as SGST,
     @Semantics.amount.currencyCode: 'TransactionCurrency'   
     case ConditionType 
     when 'JOCG' then CGST end as CGST,
     @Semantics.amount.currencyCode: 'TransactionCurrency'   
     case ConditionType 
     when 'JOUG' then UGST end as UGST,
    @Semantics.amount.currencyCode: 'TransactionCurrency'   
     case ConditionType 
     when 'JTC1' then TCS 
     when 'ZTCS' then TCS
     end as TCS,
     CustomerFullName,
     Region,
     TaxNumber3 */
}/* where ( ConditionType = 'JOIG' or ConditionType = 'JOCG' or ConditionType = 'JOSG' or ConditionType = 'JOUG'
          or ConditionType = 'JTC1' or ConditionType = 'ZTCS' ) and TaxNumber3 <> ''  */
         
          
          
          
        
 