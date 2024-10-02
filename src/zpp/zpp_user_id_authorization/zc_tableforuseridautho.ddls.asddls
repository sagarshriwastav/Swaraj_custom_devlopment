@EndUserText.label: 'Maintain Table For User Id Authorization'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_TableForUserIdAutho
  as projection on ZI_TableForUserIdAutho
{
  key Username,
  key Password,
  mattpye,
  LocalCreatedBy,
  LocalCreatedAt,
  @Consumption.hidden: true
  LocalLastChangedBy,
  @Consumption.hidden: true
  LocalLastChangedAt,
  LastChangedAt,
  @Consumption.hidden: true
  SingletonID,
  _TableForUserIdAuAll : redirected to parent ZC_TableForUserIdAutho_S
  
}
