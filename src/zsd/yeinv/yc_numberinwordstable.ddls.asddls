@EndUserText.label: 'NUMBER IN WORDS TABLE - Maintain'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity YC_NumberInWordsTable
  as projection on YI_NumberInWordsTable
{
  key Value,
  Words,
  CreatedBy,
  CreatedAt,
  LastChangedBy,
  @Consumption.hidden: true
  LastChangedAt,
  @Consumption.hidden: true
  LocalLastChangedAt,
  @Consumption.hidden: true
  SingletonID,
  _NumberInWordsTabAll : redirected to parent YC_NumberInWordsTable_S
  
}
