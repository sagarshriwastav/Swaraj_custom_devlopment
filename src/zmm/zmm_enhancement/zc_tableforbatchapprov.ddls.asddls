@EndUserText.label: 'Maintain Table For Batch Approval'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_TableForBatchApprov
  as projection on ZI_TableForBatchApprov
{
  key Batch,
  key Supplier,
  Approved,
  Kg ,
  Remark ,
  Description ,
  LocalCreatedBy,
  LocalCreatedAt,
  @Consumption.hidden: true
  LocalLastChangedBy,
  @Consumption.hidden: true
  LocalLastChangedAt,
  LastChangedAt,
  @Consumption.hidden: true
  SingletonID,
  _TableForBatchAppAll : redirected to parent ZC_TableForBatchApprov_S
  
}
