@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Denim Packing Rep'
define root view entity ZPP_DENIM_CDS as select from zpackhdr

{
    key plant as Plant,
    key posting_date as PostingDate,
    key material_number as MaterialNumber
//    key batch as Batch,
//    key rec_batch as RecBatch,
//    key mat_doc as MatDoc,
//    storage_location as StorageLocation,
//    receving_location as RecevingLocation,
//    operator_name as OperatorName,
//    pack_grade as PackGrade,
//    re_grading as ReGrading,
//    no_of_tp as NoOfTp,
//    shift as Shift,
//    folio_number as FolioNumber,
//    unit_field as UnitField,
//    cast(case when unit_field = ' ' then 
//    'M' end as abap.unit( 2 ) ) as unit,
//    cast(case when unit_field = ' ' then 
//    'KG' end as abap.unit( 2 ) ) as unit1,
//    @Semantics.quantity.unitOfMeasure : 'unit'
//    finish_width as FinishWidth,
//    @Semantics.quantity.unitOfMeasure : 'unit1'
//    gross_weight as GrossWeight,
//    @Semantics.quantity.unitOfMeasure : 'unit1'
//    net_weight as NetWeight,
//    inspection_mc_no as InspectionMcNo,
//    roll_length as RollLength,
//    sales_order as SalesOrder,
//    so_item as SoItem,
//    remark1 as Remark1,
//    remark2 as Remark2,
//    flag as Flag,
//    flag_quantity as FlagQuantity,
//    flag_quantity_total as FlagQuantityTotal,
//    document_date as DocumentDate,
//    etime as Etime,
//    peice,
//    user_name as UserName,
//    cancelflag as Cancelflag,
//    created_by as CreatedBy,
//    created_at as CreatedAt,
//    last_changed_by as LastChangedBy,
//    last_changed_at as LastChangedAt,
//    local_last_changed_at as LocalLastChangedAt
}
