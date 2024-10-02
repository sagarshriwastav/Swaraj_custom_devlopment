@AbapCatalog.sqlViewName: 'YGREYDATE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Grey Entry Date SetWise'
define view ZPP_GREY_ENTRY_DATE_SETWISE2 as select from ZPP_GREY_ENTRY_DATE_SETWISE
{
    key Plant,
    key SetNumber,
    min(GreyDate) as GreyDate
} 
 group by 
       Plant,
       SetNumber
