@EndUserText.label: 'Table For Loom Type  Tmg - Maintain'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_TableForLoomTypeTmg
  as projection on ZI_TableForLoomTypeTmg
{
  key Serialno,
  Loomtype,
  LocalCreatedBy,
  LocalCreatedAt,
  @Consumption.hidden: true
  LocalLastChangedBy,
  @Consumption.hidden: true
  LocalLastChangedAt,
  LastChangedAt,
  @Consumption.hidden: true
  SingletonID,
  _TableForLoomTypeAll : redirected to parent ZC_TableForLoomTypeTmg_S
  
}
