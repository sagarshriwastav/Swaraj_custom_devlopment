@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Yenvoice Cds For E-envoicing'
define root view entity Ybilling_datta
  as select from    I_BillingDocumentItem          as a

    left outer join I_BillingDocumentPartner       as bILLINGPARTNR            on  a.BillingDocument             = bILLINGPARTNR.BillingDocument
                                                                               and bILLINGPARTNR.PartnerFunction = 'RE'

    left outer join I_BillingDocumentPartner       as SHIPPINGPARTNR           on  a.BillingDocument              = SHIPPINGPARTNR.BillingDocument
                                                                               and SHIPPINGPARTNR.PartnerFunction = 'WE'

    left outer join I_BillingDocumentPartner       as transporterPARTNR        on  a.BillingDocument                 = transporterPARTNR.BillingDocument
                                                                               and transporterPARTNR.PartnerFunction = 'ZT'


    left outer join I_Customer                     as bILLINGPARTNRADDRESS     on bILLINGPARTNR.Customer = bILLINGPARTNRADDRESS.Customer


    left outer join I_Supplier                     as transporterPARTNRADDRESS on transporterPARTNR.Supplier = transporterPARTNRADDRESS.Supplier



    left outer join I_Customer                     as SHIPPINGPARTNRADDRESS    on SHIPPINGPARTNR.Customer = SHIPPINGPARTNRADDRESS.Customer

    left outer join I_BillingDocumentItemPrcgElmnt as ZROO                     on  a.BillingDocument     = ZROO.BillingDocument
                                                                               and a.BillingDocumentItem = ZROO.BillingDocumentItem
                                                                               and ZROO.ConditionType    = 'ZR00'
                                                                               and (
                                                                                  ZROO.ConditionInactiveReason != 'X'
                                                                                  and ZROO.ConditionInactiveReason != 'M'
                                                                                  and ZROO.ConditionInactiveReason != 'T'
                                                                                  and ZROO.ConditionInactiveReason != 'K'
                                                                                  and ZROO.ConditionInactiveReason != 'Y'
                                                                                )

    left outer join I_BillingDocumentItemPrcgElmnt as ZRO1                     on  a.BillingDocument     = ZRO1.BillingDocument
                                                                               and a.BillingDocumentItem = ZRO1.BillingDocumentItem
                                                                               and ZRO1.ConditionType    = 'ZR01'
                                                                               and (
                                                                                  ZRO1.ConditionInactiveReason != 'X'
                                                                                  and ZRO1.ConditionInactiveReason != 'M'
                                                                                  and ZRO1.ConditionInactiveReason != 'T'
                                                                                  and ZRO1.ConditionInactiveReason != 'K'
                                                                                  and ZRO1.ConditionInactiveReason != 'Y'
                                                                                )


    left outer join I_BillingDocumentItemPrcgElmnt as ZFFA                     on  a.BillingDocument     = ZFFA.BillingDocument
                                                                               and a.BillingDocumentItem = ZFFA.BillingDocumentItem
                                                                               and ZFFA.ConditionType    = 'ZFFA'
                                                                               and (
                                                                                  ZFFA.ConditionInactiveReason != 'X'
                                                                                  and ZFFA.ConditionInactiveReason != 'M'
                                                                                  and ZFFA.ConditionInactiveReason != 'T'
                                                                                  and ZFFA.ConditionInactiveReason != 'K'
                                                                                  and ZFFA.ConditionInactiveReason != 'Y'
                                                                                )



    left outer join I_BillingDocumentItemPrcgElmnt as ZFMK                     on  a.BillingDocument     = ZFMK.BillingDocument
                                                                               and a.BillingDocumentItem = ZFMK.BillingDocumentItem
                                                                               and ZFMK.ConditionType    = 'ZFMK'
                                                                               and (
                                                                                  ZFMK.ConditionInactiveReason != 'X'
                                                                                  and ZFMK.ConditionInactiveReason != 'M'
                                                                                  and ZFMK.ConditionInactiveReason != 'T'
                                                                                  and ZFMK.ConditionInactiveReason != 'K'
                                                                                  and ZFMK.ConditionInactiveReason != 'Y'
                                                                                )


    left outer join I_BillingDocumentItemPrcgElmnt as JOIG                     on  a.BillingDocument     = JOIG.BillingDocument
                                                                               and a.BillingDocumentItem = JOIG.BillingDocumentItem
                                                                               and JOIG.ConditionType    = 'JOIG'
                                                                               and (
                                                                                  JOIG.ConditionInactiveReason != 'X'
                                                                                  and JOIG.ConditionInactiveReason != 'M'
                                                                                  and JOIG.ConditionInactiveReason != 'T'
                                                                                  and JOIG.ConditionInactiveReason != 'K'
                                                                                  and JOIG.ConditionInactiveReason != 'Y'
                                                                                )


    left outer join I_BillingDocumentItemPrcgElmnt as JOCG                     on  a.BillingDocument     = JOCG.BillingDocument
                                                                               and a.BillingDocumentItem = JOCG.BillingDocumentItem
                                                                               and JOIG.ConditionType    = 'JOCG'
                                                                               and (
                                                                                  JOCG.ConditionInactiveReason != 'X'
                                                                                  and JOCG.ConditionInactiveReason != 'M'
                                                                                  and JOCG.ConditionInactiveReason != 'T'
                                                                                  and JOCG.ConditionInactiveReason != 'K'
                                                                                  and JOCG.ConditionInactiveReason != 'Y'
                                                                                )


    left outer join I_BillingDocumentItemPrcgElmnt as JOSG                     on  a.BillingDocument     = JOSG.BillingDocument
                                                                               and a.BillingDocumentItem = JOSG.BillingDocumentItem
                                                                               and JOSG.ConditionType    = 'JOSG'
                                                                               and (
                                                                                  JOSG.ConditionInactiveReason != 'X'
                                                                                  and JOSG.ConditionInactiveReason != 'M'
                                                                                  and JOSG.ConditionInactiveReason != 'T'
                                                                                  and JOSG.ConditionInactiveReason != 'K'
                                                                                  and JOSG.ConditionInactiveReason != 'Y'
                                                                                )


    left outer join I_BillingDocumentItemPrcgElmnt as ZINS                     on  a.BillingDocument     = ZINS.BillingDocument
                                                                               and a.BillingDocumentItem = ZINS.BillingDocumentItem
                                                                               and ZINS.ConditionType    = 'ZINS'
                                                                               and (
                                                                                  ZINS.ConditionInactiveReason != 'X'
                                                                                  and ZINS.ConditionInactiveReason != 'M'
                                                                                  and ZINS.ConditionInactiveReason != 'T'
                                                                                  and ZINS.ConditionInactiveReason != 'K'
                                                                                  and ZINS.ConditionInactiveReason != 'Y'
                                                                                )



    left outer join I_BillingDocumentItemPrcgElmnt as JTC1                     on  a.BillingDocument     = JTC1.BillingDocument
                                                                               and a.BillingDocumentItem = JTC1.BillingDocumentItem
                                                                               and JTC1.ConditionType    = 'JTC1'
                                                                               and (
                                                                                  JTC1.ConditionInactiveReason != 'X'
                                                                                  and JTC1.ConditionInactiveReason != 'M'
                                                                                  and JTC1.ConditionInactiveReason != 'T'
                                                                                  and JTC1.ConditionInactiveReason != 'K'
                                                                                  and JTC1.ConditionInactiveReason != 'Y'
                                                                                )

    left outer join I_BillingDocumentItemPrcgElmnt as JTC2                     on  a.BillingDocument     = JTC2.BillingDocument
                                                                               and a.BillingDocumentItem = JTC2.BillingDocumentItem
                                                                               and JTC2.ConditionType    = 'JTC2'
                                                                               and (
                                                                                  JTC2.ConditionInactiveReason != 'X'
                                                                                  and JTC2.ConditionInactiveReason != 'M'
                                                                                  and JTC2.ConditionInactiveReason != 'T'
                                                                                  and JTC2.ConditionInactiveReason != 'K'
                                                                                  and JTC2.ConditionInactiveReason != 'Y'
                                                                                )


    left outer join I_BillingDocumentItemPrcgElmnt as ZPCA                     on  a.BillingDocument     = ZPCA.BillingDocument
                                                                               and a.BillingDocumentItem = ZPCA.BillingDocumentItem
                                                                               and ZPCA.ConditionType    = 'ZPCA'
                                                                               and (
                                                                                  ZPCA.ConditionInactiveReason != 'X'
                                                                                  and ZPCA.ConditionInactiveReason != 'M'
                                                                                  and ZPCA.ConditionInactiveReason != 'T'
                                                                                  and ZPCA.ConditionInactiveReason != 'K'
                                                                                  and ZPCA.ConditionInactiveReason != 'Y'
                                                                                )




    left outer join I_BillingDocumentItemPrcgElmnt as ROF                      on  a.BillingDocument     = ROF.BillingDocument
                                                                               and a.BillingDocumentItem = ROF.BillingDocumentItem
                                                                               and ROF.ConditionType     = 'ROF'
                                                                               and (
                                                                                  ROF.ConditionInactiveReason != 'X'
                                                                                  and ROF.ConditionInactiveReason != 'M'
                                                                                  and ROF.ConditionInactiveReason != 'T'
                                                                                  and ROF.ConditionInactiveReason != 'K'
                                                                                  and ROF.ConditionInactiveReason != 'Y'
                                                                                )
  //  'ZLDA','ZPCA','JTC1','JTC2'
    left outer join I_BillingDocumentItemPrcgElmnt as ZLDA                     on  a.BillingDocument     = ZLDA.BillingDocument
                                                                               and a.BillingDocumentItem = ZLDA.BillingDocumentItem
                                                                               and ZLDA.ConditionType    = 'ZLDA'
                                                                               and (
                                                                                  ZLDA.ConditionInactiveReason != 'X'
                                                                                  and ZLDA.ConditionInactiveReason != 'M'
                                                                                  and ZLDA.ConditionInactiveReason != 'T'
                                                                                  and ZLDA.ConditionInactiveReason != 'K'
                                                                                  and ZLDA.ConditionInactiveReason != 'Y'
                                                                                )
  // ZDIN , ZFDO,ZFOC  "1.DOMINS  2.DOMFRT 3.OCEAN_FREIGHT
    left outer join I_BillingDocumentItemPrcgElmnt as ZDIN                     on  a.BillingDocument     = ZDIN.BillingDocument
                                                                               and a.BillingDocumentItem = ZDIN.BillingDocumentItem
                                                                               and ZDIN.ConditionType    = 'ZDIN'
                                                                               and (
                                                                                  ZDIN.ConditionInactiveReason != 'X'
                                                                                  and ZDIN.ConditionInactiveReason != 'M'
                                                                                  and ZDIN.ConditionInactiveReason != 'T'
                                                                                  and ZDIN.ConditionInactiveReason != 'K'
                                                                                  and ZDIN.ConditionInactiveReason != 'Y'
                                                                                )

    left outer join I_BillingDocumentItemPrcgElmnt as ZFDO                     on  a.BillingDocument     = ZFDO.BillingDocument
                                                                               and a.BillingDocumentItem = ZFDO.BillingDocumentItem
                                                                               and ZFDO.ConditionType    = 'ZFDO'
                                                                               and ZFDO.ConditionAmount  is not initial
                                                                               and (
                                                                                  ZFDO.ConditionInactiveReason != 'X'
                                                                                  and ZFDO.ConditionInactiveReason != 'M'
                                                                                  and ZFDO.ConditionInactiveReason != 'T'
                                                                                  and ZFDO.ConditionInactiveReason != 'K'
                                                                                  and ZFDO.ConditionInactiveReason != 'Y'
                                                                                )

    left outer join I_BillingDocumentItemPrcgElmnt as ZFOC                     on  a.BillingDocument     = ZFOC.BillingDocument
                                                                               and a.BillingDocumentItem = ZFOC.BillingDocumentItem
                                                                               and ZFOC.ConditionType    = 'ZFOC'
                                                                               and (
                                                                                  ZFOC.ConditionInactiveReason != 'X'
                                                                                  and ZFOC.ConditionInactiveReason != 'M'
                                                                                  and ZFOC.ConditionInactiveReason != 'T'
                                                                                  and ZFOC.ConditionInactiveReason != 'K'
                                                                                  and ZFOC.ConditionInactiveReason != 'Y'
                                                                                )


    left outer join I_BillingDocumentItemPrcgElmnt as ZEIN                     on  a.BillingDocument     = ZEIN.BillingDocument
                                                                               and a.BillingDocumentItem = ZEIN.BillingDocumentItem
                                                                               and ZEIN.ConditionType    = 'ZEIN'
                                                                               and (
                                                                                  ZEIN.ConditionInactiveReason != 'X'
                                                                                  and ZEIN.ConditionInactiveReason != 'M'
                                                                                  and ZEIN.ConditionInactiveReason != 'T'
                                                                                  and ZEIN.ConditionInactiveReason != 'K'
                                                                                  and ZEIN.ConditionInactiveReason != 'Y'
                                                                                )



    left outer join I_ProductText                  as maktx                    on  a.Material     = maktx.Product
                                                                               and maktx.Language = 'E'

    left outer join I_ProductPlantBasic            as HSNCODE                  on  a.Material = HSNCODE.Product
                                                                               and a.Plant    = HSNCODE.Plant
    left outer join I_BillingDocumentBasic         as DOCHEAD                  on a.BillingDocument = DOCHEAD.BillingDocument 
    left outer join YJ1IG_EWAYBILLDD               as EWAYBILL                 on a.BillingDocument = EWAYBILL.Docno
    left outer join Y1IG_INVREFNUM_DD              as IRNDETALS                on a.BillingDocument = IRNDETALS.Docno
    left outer join I_DeliveryDocument             as deliverydata             on a.ReferenceSDDocument = deliverydata.DeliveryDocument
    left outer join I_DeliveryDocumentItem         as deliverydataitem         on deliverydataitem.DeliveryDocument = deliverydata.DeliveryDocument and deliverydataitem.DeliveryDocumentItem = a.ReferenceSDDocumentItem 
    left outer join I_SalesDocument                as salesdocumentz           on a.SalesDocument = salesdocumentz.SalesDocument
    left outer join yaddress_4shipto               as billtoaddrs              on billtoaddrs.AddressID = bILLINGPARTNR.AddressID
    left outer join yaddress_4shipto               as shiptoaddrs              on shiptoaddrs.AddressID = SHIPPINGPARTNR.AddressID
    left outer join Y_deliverydatacustom           as calculationfields        on deliverydata.DeliveryDocument = calculationfields.DeliveryDocument
    left outer join yinvdata_final                 as eximdata                 on a.BillingDocument = eximdata.BillingDocument
    left outer join   I_PaymentTermsText                as d                        on  d.PaymentTerms = DOCHEAD.CustomerPaymentTerms and d.Language = 'E' 

{

  key a.BillingDocument,
  key a.BillingDocumentItem,
      a.Plant,
      //      a.sh
      a.Material,
      a.Division,
      maktx.ProductName                                                                              as MaterialDescription,
      HSNCODE.ConsumptionTaxCtrlCode                                                                 as Hsncode,
      a.BillingQuantityUnit,
      @Semantics.quantity.unitOfMeasure: 'BillingQuantityUnit'
      a.BillingQuantity,
      a.TransactionCurrency,
      a.BillingQuantityUnit                                                                          as unit,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      a.NetAmount,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      a.GrossAmount,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      a.TaxAmount,

      a.ReferenceSDDocument                                                                          as DELIVERY_NUMBER,
      a.ReferenceSDDocumentItem                                                                      as DELIVERY_NUMBER_item,
      a.SalesDocument                                                                                as SDDOCU,
      a.SalesDocumentItem                                                                            as SDDOCUITEM,
      d.PaymentTermsDescription                                                                      as PaymentTermsDescription, 
                                               
                                               
      bILLINGPARTNR.Customer                                                                         as BILLTOPARTY,
      bILLINGPARTNRADDRESS.CustomerName,
      bILLINGPARTNRADDRESS.CustomerFullName,
      bILLINGPARTNRADDRESS.TaxNumber3                                                                as billinggstin,
      bILLINGPARTNRADDRESS.StreetName,
      bILLINGPARTNRADDRESS.Region,
      bILLINGPARTNRADDRESS.CityName,
      bILLINGPARTNRADDRESS.PostalCode,

      SHIPPINGPARTNR.Customer                                                                        as ShippingPartner,
      SHIPPINGPARTNRADDRESS.CustomerName                                                             as SHIPTONAME,
      SHIPPINGPARTNRADDRESS.CustomerFullName                                                         as SHIPTOFULLNAME,
      SHIPPINGPARTNRADDRESS.StreetName                                                               as SHIPTOADDRSS,
      SHIPPINGPARTNRADDRESS.TaxNumber3                                                               as SHIPPINGPARTNRgstin,
      SHIPPINGPARTNRADDRESS.Region                                                                   as SHIPTOREGION,
      SHIPPINGPARTNRADDRESS.CityName                                                                 as SHIPTOCITY,
      SHIPPINGPARTNRADDRESS.PostalCode                                                               as SHIPTOPO,


      transporterPARTNR.AddressID                                                                    as transpoter1,
      transporterPARTNR.Customer                                                                     as transpotercustomer,
      transporterPARTNR.Supplier                                                                     as transpotersupplier,


      transporterPARTNRADDRESS.TaxNumber3                                                            as TRANSID,
      transporterPARTNRADDRESS.SupplierName                                                          as transname,
      transporterPARTNRADDRESS.SupplierFullName                                                      as TRANSPORTERNAME,
      transporterPARTNRADDRESS.Supplier                                                              as TransDocNo1,
      transporterPARTNRADDRESS.TaxNumber4                                                            as VEHICLENUMBER2,



      ZROO.ConditionType                                                                             as CONDTYPE,
      ZROO.ConditionCurrency                                                                         as CURRENCY,
      ZROO.ConditionRateAmount                                                                       as BASICRATE,


      ZROO.ConditionAmount                                                                           as Basic_Amount,

      //      CASE ZROO.ConditionType WHEN 'ZR00' THEN zroo.ConditionAmount end as Basic_Amount,
      //      CASE ZROO.ConditionType WHEN 'ZINS' THEN zroo.ConditionAmount end as Insurance,

      ZINS.ConditionType                                                                             as CONDTY,
      ZINS.ConditionRateRatioUnit,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      ZINS.ConditionRateRatio                                                                        as INSURANCEPERCENTAGE,
      ZINS.ConditionAmount                                                                           as insuranceamt,

      ZFFA.ConditionType                                                                             as FREIGHT1,
      ZFFA.ConditionAmount                                                                           as FREIGHT1AMT,

      ZFMK.ConditionType                                                                             as FREIGHT2,
      ZFMK.ConditionAmount                                                                           as FREIGHT1AMT2,

      ZPCA.ConditionAmount                                                                           as ZPCA_AMT,
      ZPCA.ConditionType                                                                             as ZPCA_COND,

      ZLDA.ConditionAmount                                                                           as ZLDA_AMT,
      ZLDA.ConditionType                                                                             as ZLDA_COND,



      // ZDIN , ZFDO,ZFOC

      ZDIN.ConditionAmount                                                                           as ZDIN_AMT,
      ZDIN.ConditionType                                                                             as ZDIN_COND,

      ZFDO.ConditionAmount                                                                           as ZFDO_AMT,
      ZFDO.ConditionType                                                                             as ZFDO_COND,

      ZFOC.ConditionAmount                                                                           as Oceam_freight,
      ZFOC.ConditionType                                                                             as ZFOC_COND,

      ZEIN.ConditionAmount                                                                           as ZEIN_AMT,
      ZEIN.ConditionType                                                                             as ZEIN_COND,

      JOIG.ConditionType                                                                             as TAXCOND1,
      JOIG.ConditionRateRatioUnit                                                                    as igstunit,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      JOIG.ConditionRateRatio                                                                        as IGSTRATE,
      JOIG.ConditionAmount                                                                           as IGST,
      JOIG.ConditionBaseValue                                                                        as Assesmentvalue_inIgst,

      JOCG.ConditionType                                                                             as TAXCOND2,
      JOCG.ConditionRateRatioUnit                                                                    as cgstunit,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      JOCG.ConditionRateRatio                                                                        as CGSTRATE,
      JOCG.ConditionAmount                                                                           as CGST,
      JOCG.ConditionBaseValue                                                                        as Assesmentvalue_inGst,

      JOSG.ConditionType                                                                             as TAXCOND3,
      JOIG.ConditionRateRatioUnit                                                                    as sgstunit,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      JOSG.ConditionRateRatio                                                                        as SGSTRATE,
      JOSG.ConditionAmount                                                                           as SGST,
      //ZLDA','ZPCA','JTC1','JTC2'
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      ( JOCG.ConditionAmount  + JOSG.ConditionAmount + JOIG.ConditionAmount )                        as totalGST,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      ( JTC1.ConditionAmount + JTC2.ConditionAmount)                                                 as totalTCS,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      ( ZFFA.ConditionAmount + ZFMK.ConditionAmount)                                                 as totalfreight,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      ( ZLDA.ConditionAmount + ZPCA.ConditionAmount + JTC1.ConditionAmount + JTC2.ConditionAmount  ) as OTHERCHARGES,
      DOCHEAD.BillingDocumentDate,
      //      dochead.yy1
      DOCHEAD.TotalNetAmount                                                                         as docuhead_netamt,
      DOCHEAD.TotalTaxAmount                                                                         as docuhead_total_tax,
      DOCHEAD.IncotermsClassification,
      DOCHEAD.PaymentMethod,
      DOCHEAD.SDPricingProcedure,
      DOCHEAD.CustomerPaymentTerms,
      DOCHEAD.IncotermsTransferLocation,
      DOCHEAD.YY1_TransporterVehicle_BDH                                                                  as VEHICLENUMBER,
      DOCHEAD.YY1_LRNumber_BDH                                                                       as TransDocNo,
      DOCHEAD.YY1_LRDate_BDH                                                                         as lrdate,
   //   DOCHEAD.YY1_RFIDNumber_BDH                                                                     as rfidnumber,
     ''  as rfidnumber,
   //   DOCHEAD.YY1_LineSealNumber_BDH                                                                 as linesealnum,
    ''  as linesealnum,
   //   DOCHEAD.YY1_VesselFlightNo_BDH                                                                 as vesselflightnu,
    ''  as vesselflightnu,
   //   DOCHEAD.YY1_PortofLoading_BDH                                                                  as portofloading,
    ''  as portofloading,
   //   DOCHEAD.YY1_PortofDischarge_BDH                                                                as portofdis,
    ''  as portofdis ,
   //   DOCHEAD.YY1_VehicleContainerNu_BDH                                                             as containernumber,
    ''  as containernumber,
   //   DOCHEAD.YY1_EPCGDate_BDH                                                                       as epcgdate,
    ''  as epcgdate,
   //   DOCHEAD.YY1_EPCGMIESNo_BDH                                                                     as epcgno,
    ''  as epcgno,
   //   DOCHEAD.YY1_Remarks_BDH                                                                        as remark,
    ''  as remark,
  //    DOCHEAD.YY1_Remakrs1_BDH                                                                       as remark1,
   ''  as remark1,
      DOCHEAD.IncotermsClassification                                                                as deliveryterm,
      DOCHEAD.CustomerPaymentTerms                                                                   as paymentterms,
   //   DOCHEAD.YY1_PreCarrier_BDH                                                                     as PRECARRIER,
   ''  as PRECARRIER,
  //    DOCHEAD.YY1_PreCarrierByTransp_BDH                                                             as PRECARRIERBYTRANSPORT,
     ''  as PRECARRIERBYTRANSPORT,
      DOCHEAD.IncotermsLocation1                                                                     as incotermlocation,
      DOCHEAD.AccountingExchangeRate                                                                 as exchangerate,
   //   DOCHEAD.YY1_ShippingMark_BDH                                                                   as shippingmark,
   ''  as shippingmark,
   //   DOCHEAD.YY1_LCNo_BDH                                                                           as LcNo,
   ''  as  LcNo,
   //   DOCHEAD.YY1_LCDate_BDH                                                                         as LcDate,
   ''  as LcDate,
   //   DOCHEAD.YY1_BankName_BDH                                                                       as BankName,
   ''  as BankName,


      //DOCHEAD.
      IRNDETALS.SignedInv,
      IRNDETALS.SignedQrcode,
      IRNDETALS.Irn,
      IRNDETALS.IrnStatus,
      IRNDETALS.AckNo,
      IRNDETALS.AckDate,
      EWAYBILL.Ebillno,
      EWAYBILL.EgenDat,
      EWAYBILL.Status,
      EWAYBILL.Distance,
      deliverydata.DeliveryDate,
      deliverydata.IncotermsTransferLocation                                                         as TransferLocation,
  //    deliverydataitem.YY1_LotNo_DLI,
     ''  as YY1_LotNo_DLI,
      salesdocumentz.SalesDocumentDate,
      salesdocumentz.PurchaseOrderByCustomer                                                         as Buyerrefrence,
      salesdocumentz.CustomerPurchaseOrderDate                                                       as Buyerrefrencedate,
      billtoaddrs.StreetPrefixName1                                                                  as billtostreet1,
      billtoaddrs.StreetPrefixName2                                                                  as billtostreet2,
      billtoaddrs.StreetSuffixName1                                                                  as billltostreet3,
      billtoaddrs.CountryName                                                                        as billltocountry,

      shiptoaddrs.StreetPrefixName1                                                                  as shiptostreet1,
      shiptoaddrs.StreetPrefixName2                                                                  as shiptostreet2,
      shiptoaddrs.StreetSuffixName1                                                                  as shiptostreet3,
      shiptoaddrs.CountryName                                                                        as shiptocountry,
      calculationfields.totalgrossquantity,
      calculationfields.unit1,
      @Semantics.quantity.unitOfMeasure:'unit1'
      calculationfields.totalnetquantity,
      calculationfields.zpackage,

      eximdata.TransactionCurrency                                                                   as trancurr,         
      eximdata.gst_exim,
      eximdata.assesible,
      eximdata.freightX1                                                                             as frt1_exim,
      //cast( eximdata.freight1 as abap.int4 ) as freightvalue1 ,
      eximdata.freightX2                                                                             as frt2_exim,
      //cast( eximdata.FREIGHT2 as abap.int4 ) as freightvalue2 ,
      eximdata.OCEANFREIGHT                                                                          as OCEANFREIGHT_exim,
      eximdata.INSURANCE                                                                             as INSURANCE_exim,
      eximdata.ADDAMT                                                                                as ADDAMT_exim,
      eximdata.COMMISION1                                                                            as COMMISION1_exim,
      eximdata.COMMISION2                                                                            as commision_exim,
      eximdata.INSURANCEPREMIUM,
      eximdata.DISCOUNT                                                                              as DISCOUNT_exim 
   

}
where
  a.Batch is initial 



//and a.BillingDocument = '0090000004'
//;
