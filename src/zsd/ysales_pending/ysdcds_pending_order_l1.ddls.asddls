@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Pending Order CDS View L1'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YSDCDS_PENDING_ORDER_L1
  as select from    I_SalesDocument     as a
    left outer join I_SalesDocumentItem as b on b.SalesDocument = a.SalesDocument
    left outer join I_ProductText       as c on  c.Product  = b.Product
                                             and c.Language = $session.system_language
   left outer join ZSD_PENDING_ORDER_STOCK_1 as k on k.SDDocument = b.SalesDocument  and k.SDDocumentItem = b.SalesDocumentItem  
                                               and k.Material =  b.Product
   left outer join zpp_sortmaster as l on ( l.material = b.Product and l.plant = b.Plant )
   left outer join I_SalesDocumentPartner  as gs on  gs.PartnerFunction = 'ZA'
                                                            and gs.SalesDocument   = a.SalesDocument 
   left outer join I_Supplier as Gss on     Gss.Supplier  = gs.Supplier
                                      
  association [0..1] to I_CustomerPaymentTermsText     as d on  d.Language              = 'E'
                                                            and d.CustomerPaymentTerms = a.CustomerPaymentTerms
  association [0..1] to I_DistributionChannelText      as e on  e.Language            = 'E'
                                                            and e.DistributionChannel = a.DistributionChannel
  association [0..1] to I_SalesDocumentPartner         as f on  f.PartnerFunction = 'AG'
                                                            and f.SalesDocument   = a.SalesDocument
  association [0..1] to I_SalesDocumentPartner         as g on  g.PartnerFunction = 'ZT'
                                                            and g.SalesDocument   = a.SalesDocument
  //  association [0..*] to I_DeliveryDocumentItem     as h on  h.ReferenceSDDocument = $projection.SalesDocument
  association [0..*] to YDELIVERY_QUANTITY_L1          as i on  i.ReferenceSDDocument     = $projection.SalesDocument
                                                            and i.ReferenceSDDocumentItem = $projection.SalesDocumentItem
  association [0..*] to ZSD_PENDING_ELEMENT_PRIC_1 as j on  j.SalesOrder     = $projection.SalesDocument
                                                            and j.SalesOrderItem = $projection.SalesDocumentItem
  
                                                                                                               
                                                            
                                                            
                                                            
{
  key a.SalesDocument,
  key b.SalesDocumentItem,
      b.SalesDocumentItemText                                                                                         as Item_Description,
      a.SalesDocumentDate,
      a.DistributionChannel,
      b.MaterialByCustomer,
      b.CreatedByUser,
//      b.YY1_PDName_SDI,
      b.YY1_PDNumber_SDI,
      b.Division,
      a.SalesOffice,
      a.SalesGroup,
      a.SoldToParty,
      a.CustomerPaymentTerms                                                                                          as Terms_of_Payment,
      d.CustomerPaymentTermsName                                                                                      as Description,
      f.Partner                                                                                                       as Agent,
      b._BillToParty.CustomerName                                                                                     as CustomerName,
      b.PurchaseOrderByCustomer                                                                                       as Customer_Reference,
      b.CustomerPurchaseOrderDate                                                                                     as Customer_Reference_Date,
      b.Plant,
//      b.YY1_ShipmentDate_SDI                                                                                          as Shipment_Date,
      g.Partner                                                                                                       as Transporter,
      i.TransactionCurrency                                                                                           as Document_Currency,
      b.Product,
      c.ProductName,
 //     c._Product.YY1_FullDescription_PRD                                                                              as Material_Long,
      a.CompleteDeliveryIsDefined,
      b.SalesDocumentRjcnReason,
      l.dyeingsort,
      l.pdno,
      b.OrderQuantityUnit,
//      cast( 'M' as abap.unit( 3 ) ) as OrderQuantityUnit,
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      k.OrStock as Frstock,
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      b.OrderQuantity,
 //     b.OrderQuantityUnit,
      @Semantics.quantity.unitOfMeasure: 'DeliveryQuantityUnit'
      i.Delivery_Quantity                                                                                             as Delivery_Quantity,
      i.DeliveryQuantityUnit,
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      case when i.Delivery_Quantity is not initial
           then b.OrderQuantity - i.Delivery_Quantity
           else b.OrderQuantity end                                                                                   as Pending_Order_Qty,
      a.IncotermsLocation1,
//      b.YY1_CustomerMaterialDe_SDI,
      j.Rate,
      j.CDPercent,
      b.YY1_Grade1_SDI,
      Gss.SupplierName
      //      b.YY1_ConditionRateValue_SDI       as Rate

}
  where  b.SalesDocumentRjcnReason = '' and  a.CompleteDeliveryIsDefined != 'X'   and b.PartialDeliveryIsAllowed <> 'A'
