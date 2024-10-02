@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Account Group Wise Total'
define root view entity zfi_acc_group
 as select from ZSUPP_TOT as a

{
  key   
        a.SupplierAccountGroup,
        a.CompanyCodeCurrency,
        @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
        sum( amt ) as totamt
    
   
}
group by
  a.CompanyCodeCurrency,
  a.SupplierAccountGroup;
