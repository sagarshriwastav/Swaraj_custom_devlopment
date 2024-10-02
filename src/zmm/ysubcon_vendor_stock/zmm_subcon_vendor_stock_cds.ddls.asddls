@AbapCatalog.sqlViewName: 'YMMSUBCONSTOCK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Subcon Vendor  Stock Report'
define view ZMM_SUBCON_VENDOR_STOCK_CDS as select from ZMM_SUBCON_VENDOR_STOCK as a
left outer join zpp_dyeing1 as b on ( b.beamno = a.Batch )
left outer join I_SalesDocument as c on ( c.SalesDocument = a.SDDocument )
{
    key a.Product,
    key a.Plant,
    key a.Batch,
        a.StorageLocation,
        a.MaterialBaseUnit,
        a.STOCK,
        a.Supplier,
        a.SDDocument,
        c.SalesDocumentDate,
        b.pipenumber,
        b.shade,
        b.avgweight,
        b.beamno,
        b.greyshort,
        b.grossweight,
        b.netweight,
        b.setno,
        b.tareweight,
        b.unsizedwt
        
}
