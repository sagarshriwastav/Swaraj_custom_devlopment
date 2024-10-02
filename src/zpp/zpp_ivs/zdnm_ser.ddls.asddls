@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZDNM_DD'
@ObjectModel.semanticKey: [ 'Werks', 'ZmcNo', 'ZsetNo', 'ZfsetNo', 'ZsetStd' ]
define root view entity ZDNM_SER
  provider contract transactional_query
  as projection on ZDNM_DD
{
  key Werks,
  key ZmcNo,
  key ZsetNo,
  key ZfsetNo,
  key ZsetStd,
  UnitField,
  UnitField1,
  Zlength,
  ZfnDate,
  ZfnDate1,
  ZfnTime,
  mat_des,
  material,
  LastChangedAt

}
