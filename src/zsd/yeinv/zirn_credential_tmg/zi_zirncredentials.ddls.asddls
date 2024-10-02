@EndUserText.label: 'ZIRN CREDENTIALS'
@AccessControl.authorizationCheck: #CHECK
define view entity ZI_ZirnCredentials
  as select from ZIRN_CREDENTIALS
  association to parent ZI_ZirnCredentials_S as _ZirnCredentialsAll on $projection.SingletonID = _ZirnCredentialsAll.SingletonID
{
  key PLANT as Plant,
  GSTIN as Gstin,
  ID as Id,
  PASSWORD as Password,
  @Semantics.user.createdBy: true
  CREATED_BY as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  CREATED_AT as CreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  LAST_CHANGED_BY as LastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LAST_CHANGED_AT as LastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  LOCAL_LAST_CHANGED_AT as LocalLastChangedAt,
  1 as SingletonID,
  _ZirnCredentialsAll
  
}
