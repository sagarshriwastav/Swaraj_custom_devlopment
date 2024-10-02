@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZTMG_MIGO_VALIDA'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZTMG_MIGO_VALIDA_cds as select from ztmg_migo_valida
{
    key sr_no as SrNo,
    username as Username,
     user_id  as  userid ,
      remark as  remark,
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt, 
    local_last_changed_at as LocalLastChangedAt
}
