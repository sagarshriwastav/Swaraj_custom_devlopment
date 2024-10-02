@AbapCatalog.sqlViewName: 'YFINAL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Final Quality'
define view zpp_finishing_CDS as select from zpp_finishing  as a 
   left outer join I_MaterialDocumentItem_2 as b on ( b.MaterialDocument = a.materialdocument101 
                                                   and b.MaterialDocumentYear = a.materialdocumentyear101
                                                   and b.Material = a.material101 
                                                   and b.Batch = a.finishrollno)
           inner join ymseg4    as c on ( c.MaterialDocument = b.MaterialDocument 
                                    and c.MaterialDocumentItem = b.MaterialDocumentItem 
                                    and c.MaterialDocumentYear = b.MaterialDocumentYear )                                              
{
    key a.finishrollno,
    key a.material101,
    key a.setno,
    key a.plant,
    key a.materialdocument101,
        a.materialdocumentyear101, 
        a.loomnumber,
        a.trollyno,
        a.greigemtr,
        a.finishmtr,
        a.partyname,
        a.optname,
        a.route,
        a.peice,
        a.orderno as orderno,
        a.greywidth  
}
