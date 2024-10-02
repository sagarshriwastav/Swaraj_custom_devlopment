@AbapCatalog.sqlViewName: 'YPACKNCDSN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'YPACKNCDS_N'
define view YPACKNCDS_N as select from zpackn
{
key lot_number as LotNumber,   
 key batch as Batch,
 key material as Material,
  sum(netwt) as Netwt
} group by lot_number, batch,material
