@AbapCatalog.sqlViewName: 'ZSUPPLIE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'supplier'
define view zsupplier as select from I_Supplier {
    key Supplier,
    SupplierAccountGroup,
    SupplierName,
    SupplierFullName,
    StreetName as Addrress,
    IsBusinessPurposeCompleted,
    CreatedByUser

}
