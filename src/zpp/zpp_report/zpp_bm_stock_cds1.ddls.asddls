@AbapCatalog.sqlViewName: 'YBMSTCOK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Beam Stock Report'
define view ZPP_BM_STOCK_CDS1 as select from ZPP_BM_STOCK as a   
              inner join I_ProductDescription as f on ( f.Product = a.Product and f.Language = 'E')
            left outer join ZPP_DYEINGR_CDS as b on ( b.Beamno=  a.Batch ) 
            left outer join I_Supplier as c on ( c.Supplier = a.Supplier )
{
   key a.Product,
   key a.Plant,
   key a.StorageLocation,
   key a.Batch,
   a.MaterialBaseUnit,
   a.SDDocument,
   a.SDDocumentItem,
   a.Supplier,
   a.InventorySpecialStockType,
   cast( 'KG' as abap.unit( 3 ) ) as ZUNIT,
   @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
   a.CurrentStock,
   b.Greyshort,
   b.Grossweight,
   b.Netweight,
   b.Optname,
   b.Pipenumber,
   b.Tareweight,
   f.ProductDescription,
   c.SupplierName
}
 where a.CurrentStock > 0
