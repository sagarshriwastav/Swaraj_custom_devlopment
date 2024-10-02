@AbapCatalog.sqlViewName: 'YQAREP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Qm Quality Report'
define view ZQM_FINAL_QUALITY_REP as select from zpp_quality_item as a 
        left outer join zpp_quality_item as b on (b.matdoc_no = a.matdoc_no and b.matdoc_year = a.matdoc_year 
                                                  and  b.zparameter = 'FINISH EPI' )
        left outer join zpp_quality_item as c on (c.matdoc_no = a.matdoc_no and c.matdoc_year = a.matdoc_year 
                                                  and  c.zparameter = 'FINISH PPI' )
        left outer join zpp_quality_item as d on (d.matdoc_no = a.matdoc_no and d.matdoc_year = a.matdoc_year 
                                                  and  d.zparameter = 'FINISH GSM' )                                          
       left outer join zpp_quality_item as e on (e.matdoc_no = a.matdoc_no and e.matdoc_year = a.matdoc_year 
                                                  and  e.zparameter = 'FINISH Oz/YD' ) 
       left outer join zpp_quality_item as f on (f.matdoc_no = a.matdoc_no and f.matdoc_year = a.matdoc_year 
                                                  and  f.zparameter = 'WASH GSM' )  
       left outer join zpp_quality_item as g on (g.matdoc_no = a.matdoc_no and g.matdoc_year = a.matdoc_year 
                                                  and  g.zparameter = 'SKEW (BEFORE A)' )
        left outer join zpp_quality_item as h on (h.matdoc_no = a.matdoc_no and h.matdoc_year = a.matdoc_year 
                                                  and  h.zparameter = 'SKEW ( BEFORE B)' )
        left outer join zpp_quality_item as i on (i.matdoc_no = a.matdoc_no and i.matdoc_year = a.matdoc_year 
                                                  and  i.zparameter like 'SKEW LEVI%S AC%' )                                          
       left outer join zpp_quality_item as j on (j.matdoc_no = a.matdoc_no and j.matdoc_year = a.matdoc_year 
                                                  and  j.zparameter like 'SKEW LEVI%S BD%' ) 
       left outer join zpp_quality_item as k on (k.matdoc_no = a.matdoc_no and k.matdoc_year = a.matdoc_year 
                                                  and  k.zparameter = 'SKEW MOVEMENT' )   
       left outer join zpp_quality_item as l on (l.matdoc_no = a.matdoc_no and l.matdoc_year = a.matdoc_year 
                                                  and  l.zparameter like 'SKEW MOVEMENT LEVI%' )
        left outer join zpp_quality_item as m on (m.matdoc_no = a.matdoc_no and m.matdoc_year = a.matdoc_year 
                                                  and  m.zparameter = 'FINISH WIDTH (INCH)' )
        left outer join zpp_quality_item as n on (n.matdoc_no = a.matdoc_no and n.matdoc_year = a.matdoc_year 
                                                  and  n.zparameter = 'FINISH WIDTH (CM)' )                                          
       left outer join zpp_quality_item as o on (o.matdoc_no = a.matdoc_no and o.matdoc_year = a.matdoc_year 
                                                  and  o.zparameter = 'Width Useable(In Inch)' ) 
       left outer join zpp_quality_item as p on (p.matdoc_no = a.matdoc_no and p.matdoc_year = a.matdoc_year 
                                                  and  p.zparameter = 'Width Useable(In Cms)' )  
       left outer join zpp_quality_item as q on (q.matdoc_no = a.matdoc_no and q.matdoc_year = a.matdoc_year 
                                                  and  q.zparameter = 'WASH WIDTH (INCH)' )
        left outer join zpp_quality_item as r on (r.matdoc_no = a.matdoc_no and r.matdoc_year = a.matdoc_year 
                                                  and  r.zparameter = 'WASH WIDTH (CM)' )
        left outer join zpp_quality_item as s on (s.matdoc_no = a.matdoc_no and s.matdoc_year = a.matdoc_year 
                                                  and  s.zparameter = 'RESIDULE WARP SHRINKAGE' )                                          
       left outer join zpp_quality_item as t on (t.matdoc_no = a.matdoc_no and t.matdoc_year = a.matdoc_year 
                                                  and  t.zparameter = 'RESIDULE WEFT SHRINKAGE' ) 
       left outer join zpp_quality_item as u on (u.matdoc_no = a.matdoc_no and u.matdoc_year = a.matdoc_year 
                                                  and  u.zparameter = 'BOWING' )  
       left outer join zpp_quality_item as v on (v.matdoc_no = a.matdoc_no and v.matdoc_year = a.matdoc_year 
                                                  and  v.zparameter = 'REMARK' )
        left outer join zpp_quality_item as w on (w.matdoc_no = a.matdoc_no and w.matdoc_year = a.matdoc_year 
                                                  and  w.zparameter = 'RESULT' )
        left outer join zpp_quality_item as x on (x.matdoc_no = a.matdoc_no and x.matdoc_year = a.matdoc_year 
                                                  and  x.zparameter = 'BOWING %' )                                          
       left outer join zpp_quality_item as y on (y.matdoc_no = a.matdoc_no and y.matdoc_year = a.matdoc_year 
                                                  and  y.zparameter = 'Growth' ) 
       left outer join zpp_quality_item as z on (z.matdoc_no = a.matdoc_no and z.matdoc_year = a.matdoc_year 
                                                  and  z.zparameter = 'Growth %' )   
       left outer join zpp_quality_item as bb on (bb.matdoc_no = a.matdoc_no and bb.matdoc_year = a.matdoc_year 
                                                  and  bb.zparameter = 'Tear Warp (kgF)' )
        left outer join zpp_quality_item as cc on (cc.matdoc_no = a.matdoc_no and cc.matdoc_year = a.matdoc_year 
                                                  and  cc.zparameter = 'Tear Weft (kgF)' )
        left outer join zpp_quality_item as dd on (dd.matdoc_no = a.matdoc_no and dd.matdoc_year = a.matdoc_year 
                                                  and  dd.zparameter = 'Tensile Warp (Gram)' )                                          
       left outer join zpp_quality_item as ee on (ee.matdoc_no = a.matdoc_no and ee.matdoc_year = a.matdoc_year 
                                                  and  ee.zparameter = 'Tensile Weft (Gram)' ) 
       left outer join zpp_quality_item as ff on (ff.matdoc_no = a.matdoc_no and ff.matdoc_year = a.matdoc_year 
                                                  and  ff.zparameter = 'Ph Value' )  
       left outer join zpp_quality_item as gg on (gg.matdoc_no = a.matdoc_no and gg.matdoc_year = a.matdoc_year 
                                                  and  gg.zparameter = 'Crocking WET' )
        left outer join zpp_quality_item as hh on (hh.matdoc_no = a.matdoc_no and hh.matdoc_year = a.matdoc_year 
                                                  and  hh.zparameter = 'Crocking DRY' )
        left outer join zpp_quality_item as ii on (ii.matdoc_no = a.matdoc_no and ii.matdoc_year = a.matdoc_year 
                                                  and  ii.zparameter = 'Stretch' )                                          
       left outer join zpp_quality_item as jj on (jj.matdoc_no = a.matdoc_no and jj.matdoc_year = a.matdoc_year 
                                                  and  jj.zparameter = 'Stretch %' ) 
                                                                                                                                                                                                                                                                 
{
    key a.matdoc_no,
    key a.matdoc_year,
        a.zresult as HeadResult,
        b.remark  as FINISHEPI,
        c.remark as FINISHPPI, 
        d.remark as FINISHGSM,
        e.remark as FINISHOzYD,
        f.remark as WASHGSM,
        g.remark as SKEWBEFOREA,
        h.remark as SKEWBEFOREB,
        i.remark as SKEWLEVISAC,
        j.remark as SKEWLEVISBD,
        k.remark as SKEWMOVEMENT,
        l.remark as SKEWMOVEMENTLEVIS,
        m.remark as FINISHWIDTHINCH,
        n.remark as FINISHWIDTHCM,
        o.remark as WidthUseableInInch,
        p.remark as WidthUseableInCms,
        q.remark as WASHWIDTHINCH,
        r.remark as WASHWIDTHCM,
        s.remark as RESIDULEWARPSHRINKAGE,
        t.remark as RESIDULEWEFTSHRINKAGE,
        u.remark as BOWING,
        v.remark as REMARK,
        w.remark as ZRESULT,
        x.remark as BOWINGPERCENT,
        y.remark as Growth,
        z.remark as GrowthPercent,
        bb.remark as TearWarpkgF,
        cc.remark as TearWeftkgF,
        dd.remark as TensileWarpGram,
        ee.remark as TensileWeftGram,
        ff.remark as PhValue,
        gg.remark as CrockingWET,
        hh.remark as CrockingDRY,
        ii.remark as Stretch,
        jj.remark as StretchPer

}  
 group by 
     a.matdoc_no,
     a.matdoc_year,
     a.zresult,
     b.remark,
     c.remark,
     d.remark,
     e.remark,
     f.remark,
     g.remark,
     h.remark,
     i.remark,
     j.remark,
     k.remark,
     l.remark,
     m.remark,
     n.remark,
     o.remark,
     p.remark,
     q.remark,
     r.remark,
     s.remark,
     t.remark,
     u.remark,
     v.remark,
     w.remark,
     x.remark,
     y.remark,
     z.remark,
     bb.remark,
     cc.remark,
     dd.remark,
     ee.remark,
     ff.remark,
     gg.remark,
     hh.remark,
     ii.remark,
     jj.remark
