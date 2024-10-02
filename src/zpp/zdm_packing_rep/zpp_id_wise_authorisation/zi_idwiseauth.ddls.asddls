@EndUserText.label: 'Id Wise Auth'
@AccessControl.authorizationCheck: #CHECK
define view entity ZI_IdWiseAuth
  as select from ZPP_ID_WISE_AUT
  association to parent ZI_IdWiseAuth_S as _IdWiseAuAll on $projection.SingletonID = _IdWiseAuAll.SingletonID
{
  key PLANT as Plant,
  key USERID as Userid,
  key ZPROGRAM as Zprogram,
  key DEPARTMENT as Department,
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
  _IdWiseAuAll
  
}
