@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZR_STOCK_MAINTAN'
@ObjectModel.semanticKey: [ 'PartyCode' ]
define root view entity ZC_STOCK_MAINTAN
  provider contract transactional_query
  as projection on ZR_STOCK_MAINTAN
{
  key PartyCode,
  OpeningBalance,
  LastChangedAt
  
}
