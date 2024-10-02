@EndUserText.label: 'Table For Denim Finishing Entry Tmg - Ma'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_TableForDenimFinish
  as projection on ZI_TableForDenimFinish
{
  key Plant,
  Route,
  LocalCreatedBy,
  LocalCreatedAt,
  @Consumption.hidden: true
  LocalLastChangedBy,
  @Consumption.hidden: true
  LocalLastChangedAt,
  LastChangedAt,
  @Consumption.hidden: true
  SingletonID,
  _TableForDenimFinAll : redirected to parent ZC_TableForDenimFinish_S
  
}
