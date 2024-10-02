@AbapCatalog.sqlViewName: 'YARN2CON'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Yarn Consumption Report'
define view ZMM_YARN_CONSUMPTION_CDS2  with parameters 
             @Environment.systemField: #SYSTEM_DATE    
                p_posting:abap.dats,
             @Environment.systemField: #SYSTEM_DATE
                p_posting1:abap.dats
  as select from ZMM_YARN_CONSUMPTION_CDS(p_posting:$parameters.p_posting , p_posting1:$parameters.p_posting1 ) as a                                                     
{ 
    key a.Material,
    key a.Batch,    
    key a.Plant,
    a.Customer,
    a.ProductDescription,
    a.MaterialBaseUnit,
    sum(a.YARNRECEIVED) as YARNRECEIVED,
    sum(a.YARNRETURN) as YARNRETURN

}
   group by
    a.Material,
    a.Batch,
    a.Plant,
    a.Customer,
    a.MaterialBaseUnit,
    a.ProductDescription
