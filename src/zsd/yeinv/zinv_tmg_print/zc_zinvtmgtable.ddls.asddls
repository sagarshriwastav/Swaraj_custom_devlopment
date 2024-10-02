@EndUserText.label: 'Maintain ZINV TMG TABLE'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_ZinvTmgTable
  as projection on ZI_ZinvTmgTable
{
  key Plant,
  key Policyname,
  key Policynumber,
  LocalCreatedBy,
  LocalCreatedAt,
  @Consumption.hidden: true
  LocalLastChangedBy,
  @Consumption.hidden: true
  LocalLastChangedAt,
  LastChangedAt,
  @Consumption.hidden: true
  SingletonID,
  _ZinvTmgTableAll : redirected to parent ZC_ZinvTmgTable_S
  
}
