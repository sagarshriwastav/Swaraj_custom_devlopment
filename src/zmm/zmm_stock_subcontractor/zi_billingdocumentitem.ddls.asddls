@AbapCatalog.sqlViewName: 'YBILL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Stock Subcontractor Report'
define view ZI_BillingDocumentItem as select from I_BillingDocumentItem as a
    left outer join I_BillingDocument as b on ( b.BillingDocument = a.BillingDocument )
{
   key a.BillingDocument,
       a.ReferenceSDDocument ,
       a.CreationDate
       
       
}  where b.BillingDocumentIsCancelled = '' and b.BillingDocumentType <> 'S1' and b.BillingDocumentType <> 'S2'
       and b.BillingDocumentType <> 'S3'
  group by 
       a.BillingDocument,
       a.ReferenceSDDocument ,
       a.CreationDate
  
