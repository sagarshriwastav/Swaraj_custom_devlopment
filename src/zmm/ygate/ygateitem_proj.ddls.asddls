@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZGATE_DDM'
define root view entity YGATEITEM_PROJ
provider contract transactional_query 
as projection on YGATEITM_CDS
{

key  Gateno,
  key  GateItem,
     Lifnr,
     Matnr,
     Ebeln,
     Ebelp,
     Mblnr,
     Zeile,
    Delievery,
   Posnr,
   Banfn,
  Bnfpo,
   Maktx,
    OrderQty,
   OpenQty,
   GateQty,
   OutQty,
    OutValue,
    InQty,
    InValue,
     Uom,
     RsplName,
     Expdat,
     Remark,
     Zinvoice,
     Name1,
     ZbagQty,
     Refgateno,
     Refgateit,
     Reject,
    Lpnum,
    Lppos,
    Sono,
     Soitm,
     Deldat,
     Address1




}
