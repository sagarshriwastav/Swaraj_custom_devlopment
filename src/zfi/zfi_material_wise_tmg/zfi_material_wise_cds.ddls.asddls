@AbapCatalog.sqlViewName: 'YTMGMAT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Material Wise Text Field'
define view ZFI_MATERIAL_WISE_CDS as select from zfi_material_tmg
{
    key material as Material,
    key description as Description
}
