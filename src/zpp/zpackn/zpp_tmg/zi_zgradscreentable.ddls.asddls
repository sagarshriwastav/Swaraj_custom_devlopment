@EndUserText.label: 'ZPACKD SCREEN TABLE'
@AccessControl.authorizationCheck: #CHECK
define view entity ZI_ZGRADScreenTable
  as select from ZWEAV_GRAD_TAB
  association to parent ZI_ZpackdScreenGRAD_S as _ZpackdScreeGRAD on $projection.SingletonID = _ZpackdScreeGRAD.SingletonID
{
  key WERKS as Werks,
  key PRCTR as Prctr,
  key GRADE as Grade,
  ZDESC as Zdesc,
  ZSNRO as Zsnro,
  @Semantics.user.createdBy: true
  LOCAL_CREATED_BY as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  LOCAL_CREATED_AT as LocalCreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  LOCAL_LAST_CHANGED_BY as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LOCAL_LAST_CHANGED_AT as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  LAST_CHANGED_AT as LastChangedAt,
  1 as SingletonID,
  _ZpackdScreeGRAD
  
}
