@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Denim Packing Report'
define root view entity ZDNMFAULT_DDN as select from zdnmfault as a
{
key rec_batch as RecBatch,
key mat_doc as MatDoc,
key mat_docitem as MatDocitem,
key mat_docyear as MatDocyear,
key plant as Plant,
key material_number as MaterialNumber,
key ftype as Ftype,
posting_date as PostingDate,
unit_field as UnitField,
meter as Meter,
tometer as Tometer,
point as Point,
erdat as Erdat,
zparty as Zparty,
batch as Batch
}
