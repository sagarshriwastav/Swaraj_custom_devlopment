@EndUserText.label: 'Table For Dyeing Shade Tmg'
@AccessControl.authorizationCheck: #CHECK
define view entity ZI_DyeingShade
  as select from zpp_dye_shad_tmg
  association to parent ZI_DyeingShade_S as _DyeingShAll on $projection.SingletonID = _DyeingShAll.SingletonID
{
  key srno as Srno,
  key dyeingshade as Dyeingshade,
  dyeindesc,
  @Semantics.user.createdBy: true
  created_by as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  created_at as CreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  last_changed_by as LastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  last_changed_at as LastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  1 as SingletonID,
  _DyeingShAll
  
}
