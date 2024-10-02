@AbapCatalog.sqlViewName: 'ZDYEING'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS FOR APPROVAL'
define view ZPP_DYEING_APPROVAL as select from I_ManufacturingOrderItem as a 
left outer join zpp_approval_tab as b on (b.setnumber = a.Batch and b.programno = '07')
left outer join I_MfgOrderWithStatus as c on (c.ManufacturingOrder = a.ManufacturingOrder)
{
    
    key a.ManufacturingOrder,
         c.OrderIsTechnicallyCompleted,
         c.CreationDate,
         b.setnumber,
            
       case when b.setnumber is not null or b.setnumber <> '' or b.setnumber is not initial
         then 'Approved' else '' end as TechoApproved
}
