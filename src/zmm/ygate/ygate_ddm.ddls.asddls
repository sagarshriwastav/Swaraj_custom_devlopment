@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '##GENERATED zgate_repoj'
define root view entity YGATE_DDM
  as select from ygatehead1 as _zgate
{



 key gateno as Gateno,
 entry_type as EntryType,
 werks as Werks,
 plant_name as PlantName,
 operator as Operator,
 lifnr as Lifnr,
 kunnr as Kunnr,
 name1 as Name1,
 lr_date as LrDate,
 lr_no as LrNo,
 vehical_no as VehicalNo,
 gate_in_dt as GateInDt,
 gate_in_tm as GateInTm,
 driver as Driver,
 dr_lisc as DrLisc,
 gate_out_dt as GateOutDt,
 gate_out_tm as GateOutTm,
 remark as Remark,
 approved as Approved,
 gross_wt as GrossWt,
 tare_wt as TareWt,
 net_wt as NetWt,
 gr_unit as GrUnit,
 tr_unit as TrUnit,
 gr_oper as GrOper,
 tr_oper as TrOper,
 gr_date as GrDate,
 tr_date as TrDate,
 wt_br_no as WtBrNo,
 wt_port_no as WtPortNo,
 org_inv as OrgInv,
 e_way as EWay,
 eway_date as EwayDate,
 gate_in_date as GateInDate,
 ref_gate as RefGate,
 plant as Plant,
 driverno as Driverno,
 puchgrp as Puchgrp,
 cancelled as Cancelled ,
 invoice  as Invoice ,
 container as Container ,
 invdt   as Invdt, 
 entrydate as Entrydate,
 sleepno as sleepno,
 @Semantics.user.createdBy: true
  created_by as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  created_at as CreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  last_changed_by as LastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  last_changed_at as LastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  local_last_changed_at as LocalLastChangedAt
}
