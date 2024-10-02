@EndUserText.label: 'Authorization TMG'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZI_AuthorizationTmg
  as select from zauthorization
  association to parent ZI_AuthorizationTmg_S as _AuthorizationTmgAll on $projection.SingletonID = _AuthorizationTmgAll.SingletonID
{
  key profitcenter as Profitcenter,
  cbuser as Cbuser,
  itemtext as Itemtext,
  @Consumption.hidden: true
  1 as SingletonID,
  _AuthorizationTmgAll
  
}

 
 
  
