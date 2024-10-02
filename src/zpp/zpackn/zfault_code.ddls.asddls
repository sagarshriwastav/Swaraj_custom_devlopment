@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Fault code  for Cds'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Zfault_code as select from  zpackfault
{
  key code as Code,
  description as Description,
  farea as Farea,
  ftype as Ftype,
  fname as Fname,
  deptno as Deptno,
  zdept as Zdept

}
