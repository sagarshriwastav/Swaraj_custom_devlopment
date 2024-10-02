@AbapCatalog.sqlViewName: 'ZDPOMESTIC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Domestic Packing List Report'
define view ZDOMESTIC_PACKING_REPORT_CDS as select from I_DeliveryDocumentItem as a 
         left outer join I_DeliveryDocument as b on ( b.DeliveryDocument = a.DeliveryDocument )
         left outer join ZPACK_HDR_DEF as C on  ( C.RecBatch = a.Batch )
         left outer join I_Customer  as d on ( d.Customer = b.SoldToParty )
         left outer join zpp_sortmaster as e on (e.material = a.Material )
         left outer join I_BillingDocumentItem as f on ( f.ReferenceSDDocument = b.DeliveryDocument )
{
  key a.DeliveryDocument,
  key a.Batch,
  key a.Plant,
      b.SoldToParty,
      b.ActualGoodsMovementDate as DeliveryDate  ,
      a.ReferenceSDDocument,
      d.CustomerName ,
      a.BaseUnit,
      a.MaterialByCustomer as PartySort,
      a.Material  as SortMaster,
      e.pdno as PDNO,
      C.PackGrade,
      C.NoOfTp,
      C.RollLength,
      C.UnitField,
      @Semantics.quantity.unitOfMeasure: 'UnitField'
      C.GrossWeight,
      C.FinishWidth,
      e.dyeingshade as Shade,
      C.Tpremk  as Remark,
      f.BillingDocument,
      C.NetWeight
      
      
} 
  where a.Batch <> '' and b.DeliveryDocumentType = 'LF'
