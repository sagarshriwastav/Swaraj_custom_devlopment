@EndUserText.label: 'Table For Dyeing Shade Tmg - Maintain'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_DyeingShade
  as projection on ZI_DyeingShade
{
  key Srno,
  key Dyeingshade,
  dyeindesc,
  CreatedBy,
  CreatedAt,
  @Consumption.hidden: true
  LastChangedBy,
  @Consumption.hidden: true
  LastChangedAt,
  LocalLastChangedAt,
  @Consumption.hidden: true
  SingletonID,
  _DyeingShAll : redirected to parent ZC_DyeingShade_S
  
}
