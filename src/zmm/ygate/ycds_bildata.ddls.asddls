@AbapCatalog.sqlViewName: 'YBILCDS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Billing Data Details'
define view YCDS_BILDATA as select from I_BillingDocumentItem as a
left outer join I_BillingDocument as G on ( G.BillingDocument = a.BillingDocument  )
{
     key a.BillingDocument,
     key a.ReferenceSDDocument,
     key a.ReferenceSDDocumentItem
}
  where G.BillingDocumentIsCancelled != 'X'  and  G.SDDocumentCategory != 'N'  
