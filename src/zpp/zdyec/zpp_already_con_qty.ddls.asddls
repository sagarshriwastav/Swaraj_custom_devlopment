@AbapCatalog.sqlViewName: 'YALREADYQTY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'QM_INSPECTION REPORT'
define view ZPP_ALREADY_CON_QTY as select from  I_MaterialDocumentItem_2 as a 
            inner join ymseg4 as f on    ( f.MaterialDocument = a.MaterialDocument and f.MaterialDocumentItem = a.MaterialDocumentItem )
            left outer join   zpp_dyec_chemica as b on (a.Material = b.chemical and a.Batch = b.consbatch 
                                                             and a.MaterialDocument = b.materialdocumentno 
                                                             and a.MaterialDocumentYear = b.materialdocumentyear 
                                                             and a.Plant = b.plant )

{
   
   key a.Material as Material ,
   key a.Plant as Plant,
   key a.OrderID as OrderID,
       a.MaterialDocument,
       b.reciepeno,
       a.MaterialBaseUnit,
       @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
       b.consqty  as AlreadyQty   
      
      } where GoodsMovementType = '261'

   group by 
       a.Material,
       a.Plant,
       a.OrderID,
       b.consqty ,
       a.MaterialBaseUnit,
       b.reciepeno,
       a.MaterialDocument
