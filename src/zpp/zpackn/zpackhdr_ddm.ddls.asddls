@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '##GENERATED ZPACKHDR_D Line Item Table'
define root view entity ZPACKHDR_DDM
  as select from zpackhdr_d as ZPACKHDR_Dpack
{
  key plant as Plant,
  key posting_date as PostingDate,
  key material_number as MaterialNumber,
  key batch as Batch,
  key rec_batch as RecBatch,
  key mat_doc as MatDoc,
  key mat_docitem as MatDocitem,
  key mat_docyear as MatDocyear,
  storage_location as StorageLocation,
  receving_location as RecevingLocation,
  operator_name as OperatorName,
  pack_grade as PackGrade,
  inspection_mc_no as InspectionMcNo,
  re_grading as ReGrading,
  no_of_tp as NoOfTp,
  shift as Shift,
  folio_number as FolioNumber,
  unit_field as UnitField,
  unitinch as Unitinch,
  unitmtr as Unitmtr,
  finish_width as FinishWidth,
  gross_weight as GrossWeight,
  net_weight as NetWeight,
  sendinglength as Sendinglength,
  stdwidth as Stdwidth,
  stdnetwt as Stdnetwt,
  totalpoint as Totalpoint,
  point4 as Point4,
  remark1 as Remark1,
  remark2 as Remark2,
  stdozs as Stdozs,
  actozs as Actozs,
  party as Party,
  tpremk as Tpremk,
  flag_quantity_total as FlagQuantityTotal,
  roll_length as RollLength,
  sales_order as SalesOrder,
  so_item as SoItem,
  setno as Setno,
  trollyno as Trollyno,
  loomno as Loomno,
  document_date as DocumentDate,
  cancelflag as Cancelflag
  
  
}