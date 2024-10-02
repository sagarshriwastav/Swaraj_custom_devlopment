@AbapCatalog.sqlViewName: 'YARN2CON1200'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Yarn Consumption Report'
define view ZMM_YARN_CONSUMPTION_CDS2_1200  with parameters 
             @Environment.systemField: #SYSTEM_DATE    
                p_posting:abap.dats,
             @Environment.systemField: #SYSTEM_DATE
                p_posting1:abap.dats
  as select from ZMM_YARN_CONSUMPTION_CDS_1200(p_posting:$parameters.p_posting , p_posting1:$parameters.p_posting1 ) as a  
  left outer join I_MaterialDocumentItem_2    as b on ( b.Material = a.Material and b.Batch = a.Batch and b.Plant = a.Plant 
                                                        and b.GoodsMovementType = '101' and b.GoodsMovementIsCancelled = '' )  
  left outer join I_MaterialDocumentHeader_2  as c on ( c.MaterialDocument = b.MaterialDocument and c.MaterialDocumentYear = b.MaterialDocumentYear )                                                                                                  
{
    key a.Material,
    key a.Batch,
    key a.Plant,       
    a.ProductDescription,
    a.Supplier,
    a.MaterialBaseUnit,  
    a.Supplier541,
    a.PurchaseOrder,
    a.PurchaseOrderItem,
    c.ReferenceDocument,
    sum(a.YARNRECEIVED)  as YARNRECEIVED,
    sum(a.YARNRETURN)    as YARNRETURN
    

}
   group by
    a.Material,
    a.Batch,
    a.Plant,
    a.Supplier,
    a.Supplier541,
    a.PurchaseOrder,
    a.PurchaseOrderItem,
    c.ReferenceDocument,
    a.MaterialBaseUnit,
    a.ProductDescription
