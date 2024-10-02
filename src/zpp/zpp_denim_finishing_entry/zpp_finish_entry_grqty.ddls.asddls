@AbapCatalog.sqlViewName: 'YPPRGSUM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Denim Finish Entry GrQty Sum'
define view ZPP_FINISH_ENTRY_GRQTY as select from I_MaterialDocumentItem_2 as a 
           inner join ymseg4 as b on ( b.MaterialDocument = a.MaterialDocument 
                                     and b.MaterialDocumentItem = a.MaterialDocumentItem 
                                     and b.MaterialDocumentYear = a.MaterialDocumentYear )
   
{
    key a.OrderID ,
        a.MaterialBaseUnit,
          @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        sum(a.QuantityInBaseUnit)  as GrQty
 }
   where a.GoodsMovementType = '101'
      group by  a.OrderID,
                a.MaterialBaseUnit

                
                
