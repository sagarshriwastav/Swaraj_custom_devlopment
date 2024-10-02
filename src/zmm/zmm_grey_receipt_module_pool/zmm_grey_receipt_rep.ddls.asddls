@AbapCatalog.sqlViewName: 'YGREYREP2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Grey Receipt Report'
define view ZMM_GREY_RECEIPT_REP as select from ZMM_REVERSE_JOB_RECEIPT as b
inner join zmm_grey_receipt as a on ( b.Material = a.itemcode and b.Batch = a.piecenumber
                                 and b.MaterialDocument = a.matdocument and b.MaterialDocumentYear = a.matdocumentyear
                                 )
{
    key a.sno as Sno,
    key a.itemcode as Itemcode,
    key a.setnumber as Setnumber,
    key a.po as Po,
    key a.poitem as Poitem,
    key a.matdocument as Matdocument,
    key a.matdocumentyear as Matdocumentyear,
    a.descrption as Descrption,
    a.movtype as Movtype,
    a.supplier as Supplier,
    a.suppliername as Suppliername,
    a.piecenumber as Piecenumber,
    a.qtylength as Qtylength,
    a.pick as Pick,
    a.partychlaan as Partychlaan,
    a.loom as Loom,
    a.grossweight as Grossweight,
    a.tareweight as Tareweight,
    a.netweight as Netweight,
    a.permtravgweight as Permtravgweight,
    a.salesorder as Salesorder,
    a.solineitem as Solineitem,
    a.internalbatch,
  //  case when  a.internalbatch = '0000003115A' then '' else a.internalbatch end  as  internalbatch,
    b.MaterialDocumentItem
}
 where b.GoodsMovementIsCancelled <> 'X'
 
// group by a.sno,
//    a.itemcode ,
//    a.setnumber,
//    a.po ,
//    a.poitem ,
//    
//    a.matdocumentyear ,
//    a.descrption ,
//    a.movtype ,
//    a.supplier ,
//    a.suppliername,
//    a.piecenumber ,
//    a.qtylength ,
//    a.pick ,
//    a.partychlaan ,
//    a.loom ,
//    a.grossweight ,
//    a.tareweight ,
//    a.netweight ,
//    a.permtravgweight ,
//    a.salesorder ,
//    a.solineitem ,
//    a.internalbatch,
//    b.MaterialDocumentItem
