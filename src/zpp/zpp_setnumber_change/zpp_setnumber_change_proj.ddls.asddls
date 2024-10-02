@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection Cds For Set Number Change Program'
@ObjectModel.semanticKey: [ 'Werks', 'ZmcNo', 'ZsetNo', 'ZfsetNo', 'ZsetStd' ]
define root view entity ZPP_SETNUMBER_CHANGE_PROJ
  provider contract transactional_query
  as projection on ZPP_SETNUMBER_CHANGE_CDS
{
  key Werks,
  key ZmcNo,
  key ZsetNo,
  key ZfsetNo,  
  ZsetStd,
  UnitField,
  UnitField1,
  Zlength,
  ZfnDate,
  ZfnDate1,
  ZfnTime,
  mat_des,
  material,
  SetApproved,
  LastChangedAt

}
