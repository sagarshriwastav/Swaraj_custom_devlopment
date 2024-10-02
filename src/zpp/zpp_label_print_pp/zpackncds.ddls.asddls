@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Packing  Cds View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zpackncds as select from zpackn as Persistence {
    key plant1 as Plant1,
    key material as Material,
    key material_document as MaterialDocument,
    key material_documentitem as MaterialDocumentitem,
    key documentdate as Documentdate,
    key shift as Shift,
    key lot_number as LotNumber,
    key batch as Batch,
    netwt as Netwt,
    grosswt as Grosswt,
    tareweight as Tareweight,
    conetip as Conetip,
    tape1 as Tape1,
    packing_type as PackingType,
    noofcones as Noofcones,
    cone_weight as ConeWeight,
    bag_number as BagNumber,
    packername as Packername,
    remark as Remark
}
