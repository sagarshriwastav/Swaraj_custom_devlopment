@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data Defination for Agent Code'
define root view entity ZAGENT_CODE 
as select from I_Supplier as  A
{
    key A.Supplier as Supplier,
    A.SupplierFullName as SupplierFullName,
    A.SupplierAccountGroup
}
where A.SupplierAccountGroup = 'ZDOV'
