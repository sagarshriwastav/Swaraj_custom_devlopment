@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPM_PRODUCTION_STOPAGE_CDS'
define root view entity ZPM_PRODTN_STOPAGE as select from zpm_prod_stopag1
{
    key machinenumber as Machinenumber,
    key plant as Plant,
    key stopagetime as Stopagetime,
    key postindate as Postindate,
    key reasoncode as Reasoncode,
    department as Department,
    departmentheader as Departmentheader ,
    reason as Reason ,
    shifta   as Shifta ,
    shiftb    as Shiftb ,
    stopagehour  as Stopagehour ,
    stopagepercent  as Stopagepercent ,
    tagetproduction as Tagetproduction ,
    @Semantics.user.createdBy: true
     created_by                as CreatedBy,
    @Semantics.systemDateTime.createdAt: true
    created_at                as CreatedAt,
    @Semantics.user.localInstanceLastChangedBy: true
    last_changed_by           as LastChangedBy,
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    last_changed_at           as LastChangedAt,
    @Semantics.systemDateTime.lastChangedAt: true
    local_last_changed_at     as LocalLastChangedAt
//    cast( stopagetime as abap.fltp ) / 60.00   as stohr ,
//    cast(  stopagetime as abap.fltp ) / 60.00 / 720.00   as stoppercent
}
