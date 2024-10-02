@AbapCatalog.sqlViewName: 'ZDELIEVERY1DATA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Delivery'
define view y_deliverydata
  as select from    I_DeliveryDocumentItem as a
    inner join      I_DeliveryDocument     as b        on a.DeliveryDocument = b.DeliveryDocument
    left outer join I_BillingDocumentItem  as d        on(
                                                       a.DeliveryDocument          = d.ReferenceSDDocument
                                                       and a.ReferenceSDDocumentItem = d.BillingDocumentItem )
    left outer join I_Customer             as e        on(
                                                          b.ShipToParty = e.Customer   )
    left outer join I_DeliveryDocumentItem as f        on(
                                                        a.DeliveryDocument         = f.DeliveryDocument
                                                       and a.DeliveryDocumentItem = f.HigherLvlItmOfBatSpltItm )
    left outer join ZPACKN_CDS             as PACKDATA on f.Batch = PACKDATA.Batch
{
  key d.BillingDocument,
  key d.BillingDocumentItem,
      a.DeliveryDocument,
      a.DeliveryDocumentItem,
      a.SDDocumentCategory,
      a.TransactionCurrency,
      a.BaseUnit,
      a.DeliveryDocumentItemCategory,
      a.SalesDocumentItemType,
      b.SoldToParty,
      b.ShipToParty,
      e.CustomerName,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      sum( f.ActualDeliveryQuantity  ) as delievered_quantity,
      count( distinct(f.Batch) )       as zpackage,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      sum( PACKDATA.Grosswt  )         as Grosweight
}
where 
  ( a.Batch is initial or a.Batch = ' ' or a.Batch is null  )
//and  G.SDDocumentCategory != 'N'
//and G.BillingDocumentIsCancelled != 'X'
group by
  a.DeliveryDocument,
  a.DeliveryDocumentItem,
  a.SDDocumentCategory,
  a.TransactionCurrency,
  a.BaseUnit,
  a.DeliveryDocumentItemCategory,
  a.SalesDocumentItemType,
  b.SoldToParty,
  b.ShipToParty,
  //    c.ProductName ,
  d.BillingDocument,
  d.BillingDocumentItem,
  e.CustomerName;
