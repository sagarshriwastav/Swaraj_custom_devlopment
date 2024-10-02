@EndUserText.label: 'Id Wise Auth - Maintain'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_IdWiseAuth
  as projection on ZI_IdWiseAuth
{
  key Plant,
  key Userid,
  key Zprogram,
  key Department,
  CreatedBy,
  CreatedAt,
  @Consumption.hidden: true
  LastChangedBy,
  @Consumption.hidden: true
  LastChangedAt,
  LocalLastChangedAt,
  @Consumption.hidden: true
  SingletonID,
  _IdWiseAuAll : redirected to parent ZC_IdWiseAuth_S
  
}
