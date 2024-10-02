@AbapCatalog.sqlViewName: 'YEXPORT1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1'
define view YGSTR1_EXPORT_1 as select from I_BillingDocument as B
inner join I_BillingDocItemPrcgElmntBasic as C on (C.BillingDocument = B.BillingDocument )
 and (  C.ConditionType = 'ZFOC'
 or C.ConditionType = 'ZEIN' ) 

{
   key B.BillingDocument,
     B.TransactionCurrency,  
    C.ConditionType,
      @Semantics.amount.currencyCode: 'TransactionCurrency'   
    case C.ConditionType
    when 'ZFOC' then sum(C.ConditionAmount)  end as FREIGHT_OCEAN,
      @Semantics.amount.currencyCode: 'TransactionCurrency'   
    case C.ConditionType
    when 'ZEIN' then sum(C.ConditionAmount)  end as EXPORT_INS

} where ( B.BillingDocumentType = 'F2' or B.BillingDocumentType = 'CBRE' or B.BillingDocumentType = 'L2' or B.BillingDocumentType = 'G2'  or B.BillingDocumentType = 'S1' )
        and ( B.DistributionChannel = '02')
  group by B.BillingDocument,
     B.TransactionCurrency,
     C.ConditionType
  
