@AbapCatalog.sqlViewName: 'YSEKVEDGRF4'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Selvedge Grey Grn Screen'
define view ZPP_SELVEDGE_F4_cds as select from ZPP_SELVEDGE_CHANGE
{
    key Plant,
    key Beamno,
    key Selvedge,
        remark
}  
  group by  
  
      Plant,
      Beamno,
      Selvedge,
      remark
