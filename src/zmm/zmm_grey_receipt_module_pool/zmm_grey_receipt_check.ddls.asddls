@AbapCatalog.sqlViewName: 'YCHECKGREY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Grey Receipt Check'
define view ZMM_GREY_RECEIPT_CHECK as select from zmm_grey_receipt as a
left outer join I_MaterialDocumentItem_2  as b on ( b.Material = a.itemcode and b.Batch = a.piecenumber 
                                                   and b.MaterialDocument = a.matdocument 
                                                   and b.MaterialDocumentYear = a.matdocumentyear  )
left outer join I_JournalEntry            as c  on(
       c.OriginalReferenceDocument = concat(
         b.MaterialDocument, b.MaterialDocumentYear
         
       ) )
    
{
    key a.sno as Sno,
    key a.itemcode as Itemcode,
    key a.setnumber as Setnumber,
    key a.po as Po,
    key a.poitem as Poitem,
    key a.matdocument as Matdocument,
    key a.matdocumentyear as Matdocumentyear,
    a.piecenumber as Piecenumber,
    a.supplier,
    a.partychlaan,
    a.partybeam,
    c.FiscalYear
    
}   
   where b.GoodsMovementIsCancelled = ''
