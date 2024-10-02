@AbapCatalog.sqlViewName: 'YDYEINGMASTER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'dyeing short master report cds'
define view ZPP_DYEING_SHORT_MASTER_CDS as select from ZPP_SORTMASTER_CDS as a
            left outer join ZPP_DYEING_SORT_MASTER_C as b on ( a.Dyeingsort = b.Dyeingsort
                                                              and a.Weftcount1 = b.Weft1count1 )
            left outer join ZPC_HEADERMASTER_CDS as c on ( a.Dyeingsort = c.DyeSort )

            
{
    key a.Dyeingsort as DyeingSort,
    key a.Warpcount1 as Count1,
        c.pvends,
        a.Totalends,
        a.Epi,
        a.Fppi,
        a.Weave,
        a.Weftcount1,
        a.Reedspace,
        a.shadepercen,
        a.Dyeingshade as Style,
        b.Ends,
        c.ztowtpermtr as GramPerMTR
       
      
} //group by a.Dyeingsort,
//        a.Warpcount1,
//        b.Ends,
//     //   c.pvends,
//        a.Totalends,
//        a.Epi,
//        a.Fppi,
//        a.Weave,
//        a.Weftcount1,
//        a.Reedspace,
//        a.shadepercen,
//        a.gsm,
//        a.Dyeingshade
