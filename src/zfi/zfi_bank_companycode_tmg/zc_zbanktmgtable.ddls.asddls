@EndUserText.label: 'Maintain ZBANK TMG TABLE'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_ZbankTmgTable
  as projection on ZI_ZbankTmgTable
{
  key Companycode,
  key Customer,
  Profitcenter,
  LocalCreatedBy,
  LocalCreatedAt,
  @Consumption.hidden: true
  LocalLastChangedBy,
  @Consumption.hidden: true
  LocalLastChangedAt,
  LastChangedAt,
  @Consumption.hidden: true
  SingletonID,
  _ZbankTmgTableAll : redirected to parent ZC_ZbankTmgTable_S
  
}
