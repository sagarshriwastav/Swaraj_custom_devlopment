@EndUserText.label: 'Mat_Stock'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity Ymat_STOCK1
  as select from    Ymat_STOCK1_SUM2           as a
    left outer join I_ProductDescription       as b  on(
       b.Product      = a.Material
       and b.Language = 'E'
     )
    left outer join ZPP_DENIM_FINISH_ENTRY_REP as c  on(
       c.Finishrollno    = a.Batch
       and c.Material101 = a.Material
     )
    left outer join I_Product                  as d  on(
       d.Product = a.Material
     )
    left outer join ZPACK_HDR_DEF              as Eg on(
      Eg.RecBatch = a.Batch
    )

{
  key a.Material ,
  key a.Plant,
  key a.StorageLocation,
  key a.Batch,
  key a.SDDocument,
  key a.SDDocumentItem,
  key a.MaterialBaseUnit,
      b.ProductDescription,
      c.Peice             as BatchBySupplier,
      case when c.Setpeiceno = '' or c.Setpeiceno is initial or c.Setpeiceno is null then Eg.Setno else
      c.Setpeiceno end    as Setno,
      case when c.Trollyno <> 0 then c.Trollyno else
      Eg.Trollyno end     as Trollyno,
      case when c.Loomnumber <> 0 then c.Loomnumber else
      Eg.Loomno end       as Loomnumber,
      case when c.Partyname = '' or c.Partyname is initial or c.Partyname  is null then Eg.Party else
       c.Partyname end    as Partyname,
       Eg.Party,
      //   cast( c.Supplier as abap.int4 ) as Supplier,
      right(c.Supplier,7) as Supplier,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      a.STock             as MatlWrhsStkQtyInMatlBaseUnit,
      d.ProductType

}
group by
  a.Material,
  a.Plant,
  Eg.Party,
  a.StorageLocation,
  a.Batch,
  a.SDDocument,
  a.SDDocumentItem,
  a.MaterialBaseUnit,
  b.ProductDescription,
  c.Peice,
  c.Setpeiceno,
  c.Trollyno,
  Eg.Trollyno,
  c.Loomnumber,
  Eg.Loomno,
  c.Partyname,
  Eg.Party,
  a.STock,
  c.Supplier,
  d.ProductType,
  Eg.Setno
