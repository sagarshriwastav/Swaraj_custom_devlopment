@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '##GENERATED ZPACKHDR'
define root view entity ZPACK_HDR_DEF
  as select from zpackhdr as ZPACK_HDR_  
  
{
  key ZPACK_HDR_.plant as Plant, 
  key ZPACK_HDR_.posting_date as PostingDate,
  key ZPACK_HDR_.material_number as MaterialNumber,
  key ZPACK_HDR_.batch as Batch,  
  key ZPACK_HDR_.rec_batch as RecBatch,
  key ZPACK_HDR_.mat_doc as MatDoc,
  key ZPACK_HDR_.mat_docitem as MatDocitem,
  key ZPACK_HDR_.mat_docyear as MatDocyear,
  ZPACK_HDR_.storage_location as StorageLocation,
  ZPACK_HDR_.receving_location as RecevingLocation,
  ZPACK_HDR_.operator_name as OperatorName,
  ZPACK_HDR_.pack_grade as PackGrade,
  ZPACK_HDR_.inspection_mc_no as InspectionMcNo,
  ZPACK_HDR_.re_grading as ReGrading,
  ZPACK_HDR_.no_of_tp as NoOfTp,
  ZPACK_HDR_.shift as Shift,
  ZPACK_HDR_.folio_number as FolioNumber,
  ZPACK_HDR_.unit_field as UnitField,
  cast( ZPACK_HDR_.finish_width as abap.dec( 13, 3 ) ) as FinishWidth,
  @Semantics.quantity.unitOfMeasure: 'UnitField' 
  ZPACK_HDR_.gross_weight as GrossWeight,
  @Semantics.quantity.unitOfMeasure: 'UnitField' 
  ZPACK_HDR_.net_weight as NetWeight,
  ZPACK_HDR_.stdwidth as Stdwidth,
  ZPACK_HDR_.cutablewidth as cutablewidth ,
  ZPACK_HDR_.stdnetwt as Stdnetwt,
  ZPACK_HDR_.totalpoint as Totalpoint,
  ZPACK_HDR_.point4 as Point4,
  ZPACK_HDR_.remark1 as Remark1,
  ZPACK_HDR_.remark2 as Remark2,
  ZPACK_HDR_.stdozs as Stdozs,
  ZPACK_HDR_.actozs as Actozs,
  ZPACK_HDR_.party as Party,
  ZPACK_HDR_.tpremk as Tpremk,      
  ZPACK_HDR_.flag_quantity_total as FlagQuantityTotal,
  ZPACK_HDR_.roll_length as RollLength,
  ZPACK_HDR_.sales_order as SalesOrder,
  ZPACK_HDR_.so_item as SoItem,
  ZPACK_HDR_.setno as Setno,
  ZPACK_HDR_.trollyno as Trollyno,
  ZPACK_HDR_.loomno as Loomno,
  ZPACK_HDR_.document_date as DocumentDate,
  ZPACK_HDR_.cancelflag as Cancelflag
  
}
