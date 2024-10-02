@AbapCatalog.sqlViewName: 'YCONDAMT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds Job  Grey DispatcH Report'
define view ZJOB_CONDITIONAMT_CDS as select from I_SalesDocItemPricingElement as a 
    //  left outer join I_BillingDocumentItemPrcgElmnt as c on ( c.BillingDocument = a.BillingDocument and
   //                                                    c.BillingDocumentItem = a.BillingDocumentItem )
{
     
     key a.SalesDocument,
     key a.SalesDocumentItem,
       //  a.ReferenceSDDocument,
       //  a.ReferenceSDDocumentItem ,
         a.TransactionCurrency as ConditionCurrency,
        @Semantics.amount.currencyCode: 'ConditionCurrency'
        case when a.ConditionType = 'ZPIK'
        then a.ConditionRateValue else 0 end as PIKRATE,
        @Semantics.amount.currencyCode: 'ConditionCurrency'
        case when a.ConditionType = 'ZMND'
        then a.ConditionRateValue else 0 end as MandingCHargeS,
        @Semantics.amount.currencyCode: 'ConditionCurrency'
        case when a.ConditionType = 'ZROL'
        then a.ConditionRateValue else 0 end as ROLLCHARGES,
         @Semantics.amount.currencyCode: 'ConditionCurrency'
        cast( case when a.ConditionType = 'ZBAS'
        then a.ConditionBaseValue else 0 end as abap.dec( 13, 2 ) ) as TotalBasicAmt,
        @Semantics.amount.currencyCode: 'ConditionCurrency'
        cast( case when a.ConditionType = 'JOIG'
        then a.ConditionRateValue else 0 end as abap.dec( 13, 2 ) ) as IgstPercent
}   

where a.ConditionType = 'ZPIK' or 
      a.ConditionType = 'ZMND' or 
       a.ConditionType = 'ZROL' or 
       a.ConditionType = 'ZBAS' or 
       a.ConditionType = 'JOIG'
