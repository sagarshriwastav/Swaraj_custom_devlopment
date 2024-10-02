@AbapCatalog.sqlViewName: 'YFOLDINGAMOUN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZFOLDING_AMOUNT_CD'
define view ZFOLDING_AMOUNT_CD as select from I_SalesOrderItemPricingElement
{
    key SalesOrder,
        SalesOrderItem,
        ConditionType,
        ConditionCurrency,
        @Semantics.amount.currencyCode: 'ConditionCurrency'
        case when ConditionType = 'ZPIK' then ConditionRateAmount end as ConditionAmount,
        @Semantics.amount.currencyCode: 'ConditionCurrency'
        case when ConditionType = 'ZROL' then ConditionRateAmount end as ConditionAmount1,
        @Semantics.amount.currencyCode: 'ConditionCurrency'
        case when ConditionType = 'ZMND' then ConditionRateAmount end as ConditionAmount2
   
}
