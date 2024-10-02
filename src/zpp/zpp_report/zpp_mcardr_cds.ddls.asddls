@AbapCatalog.sqlViewName: 'YMASTERCARD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  Master Card Report'
define view ZPP_MCARDR_CDS as select from zpc_headermaster as a 
left outer join  zpc_warppattern as b on ( b.zpno = a.zpno )
   
{
   key a.zpno,
       a.zpdate,
       a.zpdevno,
       a.zpunit,
       a.ploom,
       a.zpqlycode,
       a.zpreed1,
       a.zppicks,
       a.zpreedspace,
       a.zpbrand,
       a.zptotends,
       a.zpepi,
       a.zpdytype,
       a.zpweavetype,
       a.zpfinwdth,
       a.zwawtpermtr,
       a.zwewtpermtr,
       a.ztowtpermtr,
       a.zpusername,
       a.zptime,
       a.bodyends,   
       a.crimp,
       a.plength,
       a.dyesort,
       a.pdnumber,
       a.pvends,
       b.zpmsno,
       b.pattern,
       b.grp,
       case b.grp when '1' then 'Warp'
       else 'Weft' end as Type, 
       b.rescnt,
       b.zpmyqlty,
       b.maktx,
       b.wpmtr   
}
   where b.zpmyqlty <> ''
