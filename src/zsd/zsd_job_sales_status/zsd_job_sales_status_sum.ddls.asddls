@AbapCatalog.sqlViewName: 'YSUMJIB'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Job Sales Status Sum'
define view ZSD_JOB_SALES_STATUS_SUM as select from I_ManufacturingOrderItem as a  
   left outer join I_ManufacturingOrder as b on (b.ManufacturingOrder = a.ManufacturingOrder )
                                                           
{
      key a.SalesOrder as ReferenceSDDocument, 
      cast( sum(a.MfgOrderItemPlannedTotalQty) as abap.dec( 13, 3 ) )
       as BeamLength,
       a.PlanningPlant
}  
     where a.OrderIsReleased = 'X' 
       and b.IsMarkedForDeletion = ''
   group by  a.SalesOrder,
             a.PlanningPlant
            
