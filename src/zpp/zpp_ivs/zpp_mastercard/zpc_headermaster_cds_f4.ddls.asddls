//@AbapCatalog.sqlViewName: 'YMASTERF4'
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Production Order Master Card Custom Field F4'
define view entity zpc_headermaster_CDS_F4 as select from zpc_headermaster
{
    key zpno,
        zpqlycode,
        zpreed1,
        zppicks,
        zpreedspace,
        zdent,
        zpdytype
        
}  group by 
         zpno,
        zpqlycode,
        zpreed1,
        zppicks,
        zpreedspace,
        zdent,
        zpdytype
