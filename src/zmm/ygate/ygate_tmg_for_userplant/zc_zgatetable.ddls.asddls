@EndUserText.label: 'Maintain ZGATE TABLE'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_ZgateTable
  as projection on ZI_ZgateTable
{
  key Plant,
  key UserId,
  key UserName,
  key GateEntryType,
  LocalCreatedBy,
  LocalCreatedAt,
  @Consumption.hidden: true
  LocalLastChangedBy,
  @Consumption.hidden: true
  LocalLastChangedAt,
  LastChangedAt,
  @Consumption.hidden: true
  SingletonID,
  _ZgateTableAll : redirected to parent ZC_ZgateTable_S
  
}
