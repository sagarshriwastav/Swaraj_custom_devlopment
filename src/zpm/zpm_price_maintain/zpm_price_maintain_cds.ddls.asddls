@AbapCatalog.sqlViewName: 'YPRICE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Price Maintain'
define view ZPM_PRICE_MAINTAIN_CDS as select from zpm_price_mainta
{
    key zdate as Zdate,
    transactioncurrency,
    @Semantics.amount.currencyCode : 'transactioncurrency'
    freshwaterprice as Freshwaterprice,
    @Semantics.amount.currencyCode : 'transactioncurrency'
    electricityprice as Electricityprice,
    @Semantics.amount.currencyCode : 'transactioncurrency'
    steamprice as Steamprice
}
