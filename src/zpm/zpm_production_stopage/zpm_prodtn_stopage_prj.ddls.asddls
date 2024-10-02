@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZQM_INSPECTION_DATA'
@ObjectModel.semanticKey: [ 'Machinenumber' , 'Plant' , 'Stopagetime' ,'Postindate' ]
define root view entity ZPM_PRODTN_STOPAGE_PRJ 
 provider contract transactional_query 
  as projection on ZPM_PRODTN_STOPAGE
{
    key Machinenumber,
    key Plant,
    key Stopagetime,
    key Postindate,
    key Reasoncode,
    Department,
    Reason,
    Shifta,
    Shiftb,
    Stopagehour,
    Stopagepercent ,
    Tagetproduction ,
    @Semantics.user.createdBy: true
    CreatedBy,
    @Semantics.systemDateTime.createdAt: true
    CreatedAt,
    @Semantics.user.localInstanceLastChangedBy: true
    LastChangedBy,
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    LastChangedAt,
    @Semantics.systemDateTime.lastChangedAt: true
    LocalLastChangedAt
}
