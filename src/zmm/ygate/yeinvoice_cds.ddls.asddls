@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Yenvoice Cds For E-envoicing'
define root view entity Yeinvoice_cds as select from
 I_BillingDocumentItem as a

 left outer join I_BillingDocumentPartner as bILLINGPARTNR on a.BillingDocument = bILLINGPARTNR.BillingDocument and bILLINGPARTNR.PartnerFunction = 'RE'

 left outer join I_BillingDocumentPartner as SHIPPINGPARTNR on a.BillingDocument = bILLINGPARTNR.BillingDocument and bILLINGPARTNR.PartnerFunction = 'WE'

 left outer join I_BillingDocumentPartner as transporterPARTNR on a.BillingDocument = transporterPARTNR.BillingDocument and transporterPARTNR.PartnerFunction = 'ZT'


left outer join I_Customer as bILLINGPARTNRADDRESS on bILLINGPARTNR.Customer  =  bILLINGPARTNRADDRESS.Customer


left outer join I_Customer as transporterPARTNRADDRESS on bILLINGPARTNR.Customer  =  bILLINGPARTNRADDRESS.Customer



left outer join I_Customer as SHIPPINGPARTNRADDRESS on bILLINGPARTNR.Customer  =  SHIPPINGPARTNRADDRESS.Customer

left outer join I_BillingDocumentItemPrcgElmnt as  ZROO on a.BillingDocument = ZROO.BillingDocument and
 a.BillingDocumentItem = ZROO.BillingDocumentItem and ZROO.ConditionType = 'ZR00' and ZROO.ConditionInactiveReason != 'X'
 
left outer join I_BillingDocumentItemPrcgElmnt as  ZRO1 on a.BillingDocument = ZRO1.BillingDocument and
 a.BillingDocumentItem = ZRO1.BillingDocumentItem and ZRO1.ConditionType = 'ZR01' and ZRO1.ConditionInactiveReason != 'X' 
 
left outer join I_BillingDocumentItemPrcgElmnt as  ZFFA on a.BillingDocument = ZFFA.BillingDocument and
 a.BillingDocumentItem = ZFFA.BillingDocumentItem and ZFFA.ConditionType = 'ZFFA'  and ZFFA.ConditionInactiveReason != 'X'
 
 

left outer join I_BillingDocumentItemPrcgElmnt as  ZFMK on a.BillingDocument = ZFMK.BillingDocument and
 a.BillingDocumentItem = ZFMK.BillingDocumentItem and ZFMK.ConditionType = 'ZFMK' and ZFMK.ConditionInactiveReason != 'X'
 
 
left outer join I_BillingDocumentItemPrcgElmnt as  JOIG on a.BillingDocument = JOIG.BillingDocument and
 a.BillingDocumentItem = JOIG.BillingDocumentItem and JOIG.ConditionType = 'JOIG' and JOIG.ConditionInactiveReason != 'X' 
 
left outer join I_BillingDocumentItemPrcgElmnt as  JOCG on a.BillingDocument = JOCG.BillingDocument and
 a.BillingDocumentItem = JOCG.BillingDocumentItem and JOIG.ConditionType = 'JOCG' and JOCG.ConditionInactiveReason != 'X'
  
left outer join I_BillingDocumentItemPrcgElmnt as  JOSG on a.BillingDocument = JOSG.BillingDocument and
 a.BillingDocumentItem = JOSG.BillingDocumentItem and JOSG.ConditionType = 'JOSG' and JOSG.ConditionInactiveReason != 'X'
 
left outer join I_BillingDocumentItemPrcgElmnt as  ZINS on a.BillingDocument = ZINS.BillingDocument and
 a.BillingDocumentItem = ZINS.BillingDocumentItem and ZINS.ConditionType = 'ZINS' and ZINS.ConditionInactiveReason != 'X'
 
 left outer join I_BillingDocumentItemPrcgElmnt as  JTC1 on a.BillingDocument = JTC1.BillingDocument and
 a.BillingDocumentItem = JTC1.BillingDocumentItem and JTC1.ConditionType = 'JTC1' and JTC1.ConditionInactiveReason != 'X'
  
  left outer join I_BillingDocumentItemPrcgElmnt as  JTC2 on a.BillingDocument = JTC2.BillingDocument and
 a.BillingDocumentItem = JTC2.BillingDocumentItem and JTC2.ConditionType = 'JTC2' and JTC2.ConditionInactiveReason != 'X'
 
 
 
   left outer join I_BillingDocumentItemPrcgElmnt as  ZPCA on a.BillingDocument = ZPCA.BillingDocument and
 a.BillingDocumentItem = ZPCA.BillingDocumentItem and ZPCA.ConditionType = 'ZPCA' and ZPCA.ConditionInactiveReason != 'X'
 
 left outer join I_BillingDocumentItemPrcgElmnt as  ROF on a.BillingDocument = ROF.BillingDocument and
 a.BillingDocumentItem = ROF.BillingDocumentItem and ROF.ConditionType = 'ROF' and ROF.ConditionInactiveReason != 'X'
//  'ZLDA','ZPCA','JTC1','JTC2'
  left outer join I_BillingDocumentItemPrcgElmnt as  ZLDA on a.BillingDocument = ZLDA.BillingDocument and
 a.BillingDocumentItem = ZLDA.BillingDocumentItem and ZLDA.ConditionType = 'ZLDA' and ZLDA.ConditionInactiveReason != 'X'
 

 
 left outer join I_ProductText as maktx on a.Material = maktx.Product and maktx.Language = 'E' 
 
 left outer join I_ProductPlantBasic as HSNCODE on a.Material = HSNCODE.Product and a.Plant = HSNCODE.Plant 
 left outer join I_BillingDocumentBasic as DOCHEAD  on a.BillingDocument  = DOCHEAD.BillingDocument
 left outer join YJ1IG_EWAYBILLDD as EWAYBILL on a.BillingDocument = EWAYBILL.Docno
 left outer join Y1IG_INVREFNUM_DD as IRNDETALS on a.BillingDocument = IRNDETALS.Docno

{ 

key a.BillingDocument,
key a.BillingDocumentItem,
a.Plant,
a.Material,
maktx.ProductName as MaterialDescription,
HSNCODE.ConsumptionTaxCtrlCode as Hsncode ,
a.BillingQuantityUnit,
@Semantics.quantity.unitOfMeasure: 'BillingQuantityUnit' 
a.BillingQuantity,
a.TransactionCurrency,
a.BillingQuantityUnit as unit,
@Semantics.amount.currencyCode: 'TransactionCurrency'
a.NetAmount, 
@Semantics.amount.currencyCode: 'TransactionCurrency'
a.GrossAmount,
@Semantics.amount.currencyCode: 'TransactionCurrency'
a.TaxAmount, 

a.ReferenceSDDocument as DELIVERY_NUMBER ,

bILLINGPARTNR.Customer as BILLTOPARTY,
bILLINGPARTNRADDRESS.CustomerName,
bILLINGPARTNRADDRESS.CustomerFullName,
bILLINGPARTNRADDRESS.TaxNumber3 as billinggstin,
bILLINGPARTNRADDRESS.StreetName,
bILLINGPARTNRADDRESS.Region, 
bILLINGPARTNRADDRESS.CityName,
bILLINGPARTNRADDRESS.PostalCode,

SHIPPINGPARTNR.Customer as ShippingPartner,
SHIPPINGPARTNRADDRESS.CustomerName as  SHIPTONAME,
SHIPPINGPARTNRADDRESS.CustomerFullName as  SHIPTOFULLNAME,
SHIPPINGPARTNRADDRESS.StreetName as  SHIPTOADDRSS,
SHIPPINGPARTNRADDRESS.TaxNumber3 as SHIPPINGPARTNRgstin,
SHIPPINGPARTNRADDRESS.Region as  SHIPTOREGION, 
SHIPPINGPARTNRADDRESS.CityName as SHIPTOCITY,
SHIPPINGPARTNRADDRESS.PostalCode as SHIPTOPO,

transporterPARTNRADDRESS.TaxNumber3 as TRANSID,
transporterPARTNRADDRESS.CustomerName as TRANSPORTERNAME,
transporterPARTNRADDRESS.Customer   as TransDocNo ,
transporterPARTNRADDRESS.TaxNumber4 as VEHICLENUMBER , 



ZROO.ConditionType as CONDTYPE ,
ZROO.ConditionCurrency as CURRENCY,
ZROO.ConditionRateAmount as BASICRATE,


ZROO.ConditionAmount as Basic_Amount ,

ZINS.ConditionType as CONDTY,
ZINS.ConditionRateRatioUnit,
@Semantics.amount.currencyCode: 'TransactionCurrency' 
ZINS.ConditionRateRatio as INSURANCEPERCENTAGE,
ZINS.ConditionAmount,

ZFFA.ConditionType as FREIGHT1,
ZFFA.ConditionAmount as FREIGHT1AMT,

ZFMK.ConditionType as FREIGHT2,
ZFMK.ConditionAmount as FREIGHT1AMT2,

ZPCA.ConditionAmount as ZPCA_AMT,
ZPCA.ConditionType as ZPCA_COND,

ZLDA.ConditionAmount as ZLDA_AMT,
ZLDA.ConditionType as ZLDA_COND,

JOIG.ConditionType as TAXCOND1,
JOIG.ConditionRateRatioUnit as igstunit,
@Semantics.amount.currencyCode: 'TransactionCurrency'
JOIG.ConditionRateRatio as IGSTRATE,
JOIG.ConditionAmount as IGST,
JOIG.ConditionBaseValue as Assesmentvalue_inIgst,

JOCG.ConditionType as TAXCOND2,
JOCG.ConditionRateRatioUnit as cgstunit,
@Semantics.amount.currencyCode: 'TransactionCurrency' 
JOCG.ConditionRateRatio as CGSTRATE,
JOCG.ConditionAmount as CGST,
JOCG.ConditionBaseValue as Assesmentvalue_inGst,

JOSG.ConditionType as TAXCOND3,
JOIG.ConditionRateRatioUnit as sgstunit,
@Semantics.amount.currencyCode: 'TransactionCurrency'
JOSG.ConditionRateRatio as SGSTRATE,
JOSG.ConditionAmount as SGST,
//ZLDA','ZPCA','JTC1','JTC2'
@Semantics.amount.currencyCode: 'TransactionCurrency'
( JOCG.ConditionAmount  + JOSG.ConditionAmount + JOIG.ConditionAmount ) as totalGST,
@Semantics.amount.currencyCode: 'TransactionCurrency'
( JTC1.ConditionAmount + JTC2.ConditionAmount) as totalTCS,
@Semantics.amount.currencyCode: 'TransactionCurrency' 
( ZFFA.ConditionAmount + ZFMK.ConditionAmount) as totalfreight ,
@Semantics.amount.currencyCode: 'TransactionCurrency'
( ZLDA.ConditionAmount + ZPCA.ConditionAmount + JTC1.ConditionAmount + JTC2.ConditionAmount  ) as OTHERCHARGES, 
DOCHEAD.BillingDocumentDate,
DOCHEAD.TotalNetAmount as docuhead_netamt,
DOCHEAD.TotalTaxAmount as docuhead_total_tax,
DOCHEAD.IncotermsClassification,
DOCHEAD.PaymentMethod,
DOCHEAD.SDPricingProcedure,
DOCHEAD.CustomerPaymentTerms,
DOCHEAD.IncotermsTransferLocation,
//DOCHEAD.
IRNDETALS.SignedInv ,
IRNDETALS.SignedQrcode,
IRNDETALS.Irn ,
IRNDETALS.IrnStatus ,
IRNDETALS.AckNo ,
IRNDETALS.AckDate,
EWAYBILL.Ebillno,
EWAYBILL.EgenDat





}
where a.Batch is initial 


//and a.BillingDocument = '0090000004'
 ;



