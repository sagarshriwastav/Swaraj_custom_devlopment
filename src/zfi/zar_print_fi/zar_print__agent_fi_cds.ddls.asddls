@AbapCatalog.sqlViewName: 'YAGENT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For AR  Report'
define view ZAR_PRINT__AGENT_FI_CDS as select from I_OperationalAcctgDocItem as a
left outer join I_BillingDocumentPartner as b on ( b.BillingDocument = a.OriginalReferenceDocument and b.PartnerFunction = 'ZA' ) 
left outer join I_Supplier  as c on ( c.Supplier = b.Supplier )
{
    key b.Supplier,
        c.SupplierName
}
 where  
    a.AccountingDocumentType = 'RV'
    group by  
    b.Supplier,
    c.SupplierName
