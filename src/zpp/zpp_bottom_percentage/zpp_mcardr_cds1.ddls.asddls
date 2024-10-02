@AbapCatalog.sqlViewName: 'YMASTER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Master Card'
define view ZPP_MCARDR_CDS1 as select from ZPP_MCARDR_CDS
{
     key zpno,
         dyesort,
         zptotends,
          case when zptotends > 8990 then cast( '2' as abap.dec( 15, 0 ) ) else   cast( '1' as abap.dec( 15, 0 ) )  end as COMPARE  
         ,
         bodyends,
         pvends
}  
 where Type = 'Warp'
 group by 
 
         zpno,
         dyesort,
         zptotends,
         bodyends,
         pvends
