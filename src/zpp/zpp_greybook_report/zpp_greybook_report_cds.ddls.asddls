@AbapCatalog.sqlViewName: 'YGREYBOOK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Grey Book Report cds'
define view ZPP_GREYBOOK_REPORT_CDS as select from ZPP_MCARDR_CDS as a
      left outer join ZPC_HEADERMASTER_CDS as b on ( a.zpqlycode = b.Zpqlycode )
      

{
    key a.dyesort,
        a.zpqlycode as Sort,
        a.pdnumber,
        a.zppicks,
        a.zpreed1,
        a.zpreedspace,
        a.zpepi,
        b.Zdent
      
        
        
        
        
        
        
}
