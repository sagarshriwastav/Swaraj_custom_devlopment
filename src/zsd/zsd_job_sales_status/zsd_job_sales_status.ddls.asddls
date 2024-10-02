@AbapCatalog.sqlViewName: 'YJOBSALES'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Job Sales Status'
define view ZSD_JOB_SALES_STATUS as select from I_SalesDocument as a
    left outer join I_SalesDocumentItem  as c on ( c.SalesDocument = a.SalesDocument )
    left outer join ZSD_JOB_SALES_STATUS_SUM_CDS as d on ( d.SalesOrder = c.SalesDocument and d.SalesOrderItem = c.SalesDocumentItem )
    left outer join I_Customer  as e on ( e.Customer = a.SoldToParty )
 //   left outer join I_ManufacturingOrderItem as f on ( f.SalesOrder = a.SalesDocument 
 //                                                          and f.SalesOrderItem = c.SalesDocumentItem 
  //                                                         and f.PlanningPlant = c.Plant 
 //                                                          and f.OrderIsReleased = 'X' 
 //                                                          and f.IsMarkedForDeletion = '')
   left outer join ZSD_JOB_SALES_STATUS_SUM as h on  ( h.ReferenceSDDocument = a.SalesDocument  and h.PlanningPlant = c.Plant )                                             

{  
   key a.SalesDocument , 
   key c.SalesDocumentItem,
       a.SoldToParty,
       c.Material,
       c.SalesDocumentItemText,
       c.Plant,
       e.CustomerName,
       c.BaseUnit,
       cast( cast( c.RequestedQuantity as abap.dec( 13, 3 ) ) as abap.char(16) ) as RequestedQuantity,
       d.PrPicRate,
       d.MendingCharge,
       d.RollingCharge,
       @Semantics.quantity.unitOfMeasure: 'BaseUnit'
       c.OrderQuantity,
       cast( h.BeamLength    as abap.dec( 13, 3 ) )
       as BeamLength,
       h.BeamLength as SummaryBeamLength,
       cast ( cast( case  when c.RequestedQuantity is not null then c.RequestedQuantity else 0 end as abap.dec( 13, 3 ) ) -
      cast( case  when h.BeamLength is not null then h.BeamLength else 0 end as abap.dec( 13, 3 ) )
      as abap.dec( 13, 3 ) )
      as BalMtrs
      
       
       
       
}  where c.Material like 'A%'  and a.SDDocumentCategory = 'C' 
and  c.SalesDocumentRjcnReason = '' and  a.CompleteDeliveryIsDefined != 'X'   and c.PartialDeliveryIsAllowed <> 'A'
    group by 
       c.Material,
       c.Plant,
       a.SoldToParty,
       e.CustomerName,
       c.BaseUnit,
       c.RequestedQuantity,
       a.SalesDocument,
       c.SalesDocumentItem,
       c.Material,
       c.SalesDocumentItemText,
       d.PrPicRate,
       d.PrMtrRate,
       d.MendingCharge,
       d.RollingCharge,
       c.OrderQuantity,
       h.BeamLength
    
