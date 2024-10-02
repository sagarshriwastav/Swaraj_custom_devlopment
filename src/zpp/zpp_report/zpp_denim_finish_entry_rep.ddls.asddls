@AbapCatalog.sqlViewName: 'YDENIMREP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Denim Finish Entry Report'
define view ZPP_DENIM_FINISH_ENTRY_REP as select from zpp_finishing as a 
          left outer join I_MaterialDocumentItem_2 as c on ( c.MaterialDocument = a.materialdocument101  
                                                        and c.MaterialDocumentYear = a.materialdocumentyear101 
                                                        and c.Material = a.material101 
                                                        and c.Batch = a.finishrollno )
         left outer join I_MaterialDocumentItem_2 as d on ( d.MaterialDocument = a.materialdocument261 
                                                        and d.MaterialDocumentYear = a.materialdocumentyear261 
                                                        and d.Material = a.material261 
                                                        and d.Batch = a.greigebatch )                                                
             left outer join ymseg4 as b on ( b.MaterialDocument = c.MaterialDocument 
                                     and b.MaterialDocumentItem = c.MaterialDocumentItem 
                                     and b.MaterialDocumentYear = c.MaterialDocumentYear )
{
    key a.plant as Plant,
    key a.material101 as Material101,
    key a.setno as Setno,
    key a.finishrollno as Finishrollno,
    a.materialdocument101 as Materialdocument101,
    c.MaterialDocumentItem as Materialdocumentitem101,
    a.materialdocumentyear101 as Materialdocumentyear101,
    a.orderno as Orderno,
    a.salesorder as Salesorder,
    a.soitem as Soitem,
    a.mcno as Mcno,
    a.shift as Shift,
    a.postingdate  as Postingdate,
    a.consloc as Consloc,
    a.recloc as Recloc,
    a.trollyno as Trollyno,
    a.shadeno as Shadeno,
    @Semantics.quantity.unitOfMeasure : 'zunit'
    a.greigemtr as Greigemtr,
    @Semantics.quantity.unitOfMeasure : 'zunit'
    a.actualmtr as Actualmtr,
    @Semantics.quantity.unitOfMeasure : 'zunit'
    a.finishmtr as Finishmtr,
    a.shrinkageperc as Shrinkageperc,
    a.partyname as Partyname,
    a.greigebatch as Greigebatch,
    a.remark as Remark,
    a.material261 as Material261,
    a.materialdocument261 as Materialdocument261,
    d.MaterialDocumentItem as Materialdocumentitem261,
    a.materialdocumentyear261 as Materialdocumentyear261,
    a.sinzing as Sinzing,
    cast( 'M' as abap.unit( 3 ) ) as 
    Zunit,
//    cast( a.material101 as abap.char(18)  ) as materail,
    a.route as Route,
    a.peice  as  Peice ,
    a.optname  as Optname,
    a.loomnumber as Loomnumber,
    a.regnumber  as  Regnumber ,
    a.setpeiceno  as Setpeiceno,
    right(             a.setpeiceno, 1            ) as Beam,
     left(             a.setpeiceno, 7            ) as Set_code,
    
    
    a.supplier   as  Supplier,
    a.greywidth as Greywidth  
} where c.GoodsMovementIsCancelled = ''

