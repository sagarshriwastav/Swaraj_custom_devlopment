@AbapCatalog.sqlViewName: 'zapproval'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds View For Approval Program'

define view ZPP_APPROVAL_CDS as select from ZPP_APPROVAL_TAB
{
    key programno as Programno,
    key setnumber as Setnumber,
    postingdate as Postingdate
}
