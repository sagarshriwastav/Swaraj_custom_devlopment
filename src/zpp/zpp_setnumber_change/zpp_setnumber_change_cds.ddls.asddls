@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '##GENERATED Denim Set table'
define root view entity ZPP_SETNUMBER_CHANGE_CDS
  as select from zdnm_set as ZDNM_ALIAS 
  left outer join zpp_approval_tab as C on ( C.setnumber = ZDNM_ALIAS.zfset_no and C.programno = '06' )
{
  key ZDNM_ALIAS.werks as Werks,
    @UI.lineItem: [ {
    label : 'Plant',
    position: 10 , 
    importance: #HIGH
  } ]
  @UI.identification: [ {
    label : 'Plant',
    position: 10 
  } ]
  key ZDNM_ALIAS.zmc_no as ZmcNo,
    @UI.lineItem: [ {
    label : 'Machine Number.',
    position: 20 , 
    importance: #HIGH
  } ]
  @UI.identification: [ {
    label : 'Machine Number.',
    position: 20 
  } ]
  key ZDNM_ALIAS.zset_no as ZsetNo,
    @UI.lineItem: [ {
    label : 'Set Number',
    position: 30 , 
    importance: #HIGH
  } ]
  @UI.identification: [ {
    label : 'Set Number',
    position: 30 
  } ]
  key ZDNM_ALIAS.zfset_no as ZfsetNo,
    @UI.lineItem: [ {
    label : 'Fieldname CDS view',
    position: 40 , 
    importance: #HIGH
  } ]
  @UI.identification: [ {
    label : 'Final Set No.',
    position: 40 
  } ]
   ZDNM_ALIAS.zset_std as ZsetStd,
    @UI.lineItem: [ {
    label : 'Fieldname CDS view',
    position: 50 , 
    importance: #HIGH
  } ]
  @UI.identification: [ {
    label : 'Zet',
    position: 50 
  } ]
  ZDNM_ALIAS.unit_field as UnitField,

//'Meters' as UnitField,
  @Semantics.quantity.unitOfMeasure: 'UnitField'
    @UI.lineItem: [ {
    label : 'Fieldname CDS view',
    position: 60 , 
    importance: #HIGH
  } ]
  @UI.identification: [ {
    label : 'Unit',
    position: 60 
  } ]
  ZDNM_ALIAS.zlength as Zlength,
   @UI.lineItem: [ {
    label : 'Fieldname CDS view',
    position: 70 , 
    importance: #HIGH
  } ]
  @UI.identification: [ {
    label : 'Length',
    position: 70 
  } ]
  
  ZDNM_ALIAS.zfn_date as ZfnDate,
    @UI.lineItem: [ {
    label : 'Fieldname CDS view',
    position: 80 , 
    importance: #HIGH
  } ]
  @UI.identification: [ {
    label : 'Date',
    position: 80 
  } ]
  ZDNM_ALIAS.zfn_time as ZfnTime,
    @UI.lineItem: [ {
    label : 'Fieldname CDS view',
    position: 90 , 
    importance: #HIGH
  } ]
  @UI.identification: [ {
    label : 'Time',
    position: 90 
  } ]
  
  substring(ZDNM_ALIAS.zfn_date,3,4) as ZfnDate1,
    @UI.lineItem: [ {
    label : 'Fieldname CDS view',
    position: 100 , 
    importance: #HIGH
  } ]
  @UI.identification: [ {
    label : 'Date',
    position: 100 
  } ]
  
    cast( case ZDNM_ALIAS.unit_field when ' ' then 'M' else ZDNM_ALIAS.unit_field end as abap.unit( 2 ) ) as UnitField1,
     @UI.lineItem: [ {
    label : 'Fieldname CDS view',
    position: 110 , 
    importance: #HIGH
  } ]
  @UI.identification: [ {
    label : 'UNIT',
    position: 110 
  } ]
  ZDNM_ALIAS.mat_des as mat_des,
      @UI.lineItem: [ {
    label : 'Fieldname CDS view',
    position: 120 , 
    importance: #HIGH
  } ]
  @UI.identification: [ {
    label : 'mat_des',
    position: 120 
  } ]
  ZDNM_ALIAS.material as material,
    @UI.lineItem: [ {
    label : 'Fieldname CDS view',
    position: 130 , 
    importance: #HIGH
  } ]
  @UI.identification: [ {
    label : 'material',
    position: 130 
  } ]
   ZDNM_ALIAS.zset_std as SateDate,
    @UI.lineItem: [ {
    label : 'Fieldname CDS view',
    position: 130 , 
    importance: #HIGH
  } ]
  @UI.identification: [ {
    label : 'Date',
    position: 130 
  } ]
  case when C.setnumber is not null or C.setnumber <> '' or C.setnumber is not initial
         then 'Approved' else '' end as SetApproved,
    @UI.lineItem: [ {
    label : 'Fieldname CDS view',
    position: 130 , 
    importance: #HIGH
  } ]
  @UI.identification: [ {
    label : 'Date',
    position: 130 
  } ]
  @Semantics.user.createdBy: true
  ZDNM_ALIAS.created_by as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  ZDNM_ALIAS.created_at as CreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  ZDNM_ALIAS.last_changed_by as LastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  ZDNM_ALIAS.last_changed_at as LastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  ZDNM_ALIAS.local_last_changed_at as LocalLastChangedAt
  
}
