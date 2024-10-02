@AbapCatalog.sqlViewName: 'YGREYFEBRIC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Grey Febric Stock Report As On Date'
define view ZMM_GREY_FEBRIC_STOCK_CDS as select from I_StockQuantityCurrentValue_2( P_DisplayCurrency:'INR') as a 
left outer join ZMM_GREY_RECEIPT_MAX_PIECE as e on (e.itemcode = a.Product and e.piecenumber = a.Batch )
left outer join zmm_grey_receipt as b on ( b.matdocument = e.matdocument and b.matdocumentyear = e.matdocumentyear 
                                         and  b.itemcode = e.itemcode and b.piecenumber = e.piecenumber ) 
//left outer join I_Supplier as c on ( c.Supplier = a.Supplier ) 
inner join I_ProductDescription as d on ( d.Product = a.Product and d.Language = 'E' )
left outer join I_MaterialDocumentItem_2 as ee on ( ee.Material = a.Product and ee.Plant = a.Plant and ee.Batch = a.Batch    )
left outer join I_MaterialDocumentHeader_2 as mat on ( mat.MaterialDocument = ee.MaterialDocument and  mat.MaterialDocumentYear = ee.MaterialDocumentYear )
left outer join I_Supplier as sup on ( sup.Supplier = ee.Supplier  )
{
  key a.Product ,
  key a.Batch ,
  key a.Plant   ,
      a.StorageLocation,
      a.Supplier,
      a.SDDocument,
      a.SDDocumentItem,
      a.MaterialBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum(a.MatlWrhsStkQtyInMatlBaseUnit) as MatlWrhsStkQtyInMatlBaseUnit,
      case when b.setnumber is  null then ee.MaterialDocumentItemText   else  b.setnumber end as setnumber,
      case when  b.partychlaan is null then  mat.MaterialDocumentHeaderText else b.partychlaan end as partychlaan,
      b.loom,
      b.grossweight,
      b.tareweight,
      b.netweight,
      b.permtravgweight, 
       case when b.suppliername is null then sup.SupplierName else b.suppliername end as SupplierName,
      d.ProductDescription,
      a.ValuationAreaType
         } 
   
 
 where a.InventorySpecialStockType = 'E' and a.ValuationAreaType = '1'  and a.MatlWrhsStkQtyInMatlBaseUnit > 0 
    and  (a.Product like 'FGO%' or a.Product like '0000000000077%' )  and a.StorageLocation = 'PH01' and a.Plant = '1200'
     and  ee.GoodsMovementType = '101' and ee.GoodsMovementIsCancelled = ''
     
   group by   a.Product ,
  a.Batch ,
   a.Plant   ,
      a.StorageLocation,
      a.Supplier,
      a.SDDocument,
      a.SDDocumentItem,
      a.MaterialBaseUnit,
      b.setnumber, 
      b.partychlaan ,
      b.loom,
      b.grossweight,
      b.tareweight,
      b.netweight,
      b.permtravgweight, 
      b.suppliername,
      sup.SupplierName,
      d.ProductDescription,
      ee.MaterialDocumentItemText,
      a.ValuationAreaType,
      mat.MaterialDocumentHeaderText
