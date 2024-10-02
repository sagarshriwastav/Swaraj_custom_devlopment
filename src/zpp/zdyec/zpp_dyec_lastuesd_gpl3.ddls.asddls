@AbapCatalog.sqlViewName: 'YDYECSIBCON'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Dyec Last Used Gpl'
define view ZPP_DYEC_LASTUESD_GPL3 as select from ZPP_DYEC_LASTUESD_GPL as a 
          left outer join ZPP_DYEC_LASTUESD_GPL2 as b on ( b.Materialdocumentyear = a.Materialdocumentyear 
                                                         and b.materialdocumentno = a.Materialdocumentno )
{
    
    key a.Materialdocumentno,
    key a.Materialdocumentyear,
    key b.Plant,
    key b.chemical,
    key b.Dyeingsort,   
        b.reciepeno,
        b.consqty
        
}
