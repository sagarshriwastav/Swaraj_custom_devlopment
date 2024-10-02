@AbapCatalog.sqlViewName: 'YPERFORMA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Performa Invoice F4'
define view ZSD_PERFORMA_INV_F4 as select from I_BillingDocument
{
    key BillingDocument as SalesDocument
}  where BillingDocumentType = 'F5'
 group by 
 BillingDocument
