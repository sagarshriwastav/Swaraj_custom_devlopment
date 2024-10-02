@AbapCatalog.sqlViewName: 'YQTYTARGET'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Grey Receipt'
define view ZMM_GREY_RECEIPT_Target_QTY as select from I_MaterialDocumentItem_2 as a
                                                inner join ymseg4  as b on (b.MaterialDocument = a.MaterialDocument 
                                                                           and b.MaterialDocumentItem = a.MaterialDocumentItem
                                                                           and b.MaterialDocumentYear = a.MaterialDocumentYear )
{
    
  key a.PurchaseOrder,
  key a.PurchaseOrderItem,
      a.MaterialBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum( a.QuantityInEntryUnit ) as Qty
      
 }  where a.GoodsMovementType = '541' and a.DebitCreditCode = 'H'  and a.Material like 'BDO%' 
     group by  
      a.PurchaseOrder,
      a.PurchaseOrderItem,
      a.MaterialBaseUnit
