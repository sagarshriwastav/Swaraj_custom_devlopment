@EndUserText.label: 'ZIRN CREDENTIALS - Maintain'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_ZirnCredentials
  as projection on ZI_ZirnCredentials
{
  key Plant,
  Gstin,
  Id,
  Password,
  CreatedBy,
  CreatedAt,
  @Consumption.hidden: true
  LastChangedBy,
  @Consumption.hidden: true
  LastChangedAt,
  LocalLastChangedAt,
  @Consumption.hidden: true
  SingletonID,
  _ZirnCredentialsAll : redirected to parent ZC_ZirnCredentials_S
  
}
