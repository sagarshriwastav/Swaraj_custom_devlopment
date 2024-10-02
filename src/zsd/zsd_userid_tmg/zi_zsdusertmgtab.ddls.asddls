@EndUserText.label: 'ZSD_USER_TMG_TAB'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZI_ZsdUserTmgTab
  as select from ZSD_USER_TMG_TAB
  association to parent ZI_ZsdUserTmgTab_S as _ZsdUserTmgTabAll on $projection.SingletonID = _ZsdUserTmgTabAll.SingletonID
{
  key ZUSERID as Zuserid,
  USERNAME as Username,
  @Semantics.user.createdBy: true
  LOCAL_CREATED_BY as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  LOCAL_CREATED_AT as LocalCreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  @Consumption.hidden: true
  LOCAL_LAST_CHANGED_BY as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  @Consumption.hidden: true
  LOCAL_LAST_CHANGED_AT as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  LAST_CHANGED_AT as LastChangedAt,
  @Consumption.hidden: true
  1 as SingletonID,
  _ZsdUserTmgTabAll
  
}
