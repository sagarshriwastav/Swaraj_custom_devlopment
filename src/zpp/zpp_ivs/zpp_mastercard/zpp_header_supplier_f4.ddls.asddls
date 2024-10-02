@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Master Card Supplier F4'
define root view entity ZPP_HEADER_SUPPLIER_F4 as select from I_Customer

{
    key CustomerName
}   

 group by  CustomerName
