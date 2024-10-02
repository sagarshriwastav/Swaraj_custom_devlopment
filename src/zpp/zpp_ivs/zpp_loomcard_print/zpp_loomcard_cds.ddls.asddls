@AbapCatalog.sqlViewName: 'YLOOM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Loom Card Print'
define view ZPP_LOOMCARD_CDS as select from I_ManufacturingOrderItem as  a
 {
    key a.ManufacturingOrder,
        a.Product,
        a.Batch
}
      group by   
        a.ManufacturingOrder,
        a.Product,
        a.Batch
 