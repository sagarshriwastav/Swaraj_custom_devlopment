@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Supplier Amount Total'
define root view entity ZSUPP_TOT 
as select from I_OperationalAcctgDocItem as a
inner join I_Supplier as b on ( b.Supplier = a.Supplier )
{ key a.Supplier,
      a.CompanyCodeCurrency,
      a.CompanyCode,
      b.SupplierAccountGroup,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum( a.AmountInCompanyCodeCurrency ) as amt
}

where a.ClearingJournalEntry = ' ' and a.SpecialGLCode <> 'F'

group by
  a.Supplier,
  a.CompanyCodeCurrency,
  a.CompanyCode,
  b.SupplierAccountGroup; 
