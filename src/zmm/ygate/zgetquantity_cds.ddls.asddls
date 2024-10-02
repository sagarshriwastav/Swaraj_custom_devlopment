@AbapCatalog.sqlViewName: 'YGATESUM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Get Quantity'
define view ZGetQuantity_CDS as select from ygateitem1
{
    key ebeln,
    key ebelp,
        sum(gate_qty ) as gate_qty
}
    group by  
       ebeln,
       ebelp
