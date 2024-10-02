@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZGATE_DDM'
//@ObjectModel.semanticKey: [ 'Gateno' ]
define root view entity YGALESR_PROJ
  provider contract transactional_query
  as projection on YGATE_DDM
{
  key Gateno,
  EntryType,
  Werks,
  PlantName,
  Operator,
  Lifnr,
  Kunnr,
  Name1,
  LrDate,
  LrNo,
  VehicalNo,
  GateInDt,
  GateInTm,
  Driver,
  DrLisc,
  GateOutDt,
  GateOutTm,
  Remark,
  Approved,
  GrossWt,
  TareWt,
  NetWt,
  GrUnit,
  TrUnit,
  GrOper,
  TrOper,
  GrDate,
  TrDate,
  WtBrNo,
  WtPortNo,
  OrgInv,
  EWay,
  EwayDate,
  GateInDate,
  RefGate,
  Plant,
  Driverno,
  Puchgrp,
  Cancelled,
  Invoice,
  Container ,
  Invdt,
  Entrydate,
  sleepno,
  CreatedBy,
  CreatedAt,
  LastChangedBy,
  LastChangedAt,
  LocalLastChangedAt
  
}
