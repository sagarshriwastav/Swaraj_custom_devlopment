@AbapCatalog.sqlViewName: 'YGREYREC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Grey Receipt Module Pool Screen'
define view ZMM_GREY_RECEIPT_MAT as select from ZMM_GREY_RECEIPT_COMPONENT_CDS
{
    key Material, 
    case when BaseUnit = '' and Material not like 'Y%' then 'M' 
         when BaseUnit = '' and Material like 'Y%' then 'KG' else
         BaseUnit end as BaseUnit
   
}  group by  
        Material, 
        BaseUnit
