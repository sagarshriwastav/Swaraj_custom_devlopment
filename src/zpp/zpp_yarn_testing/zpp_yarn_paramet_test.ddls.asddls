@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'pp yarn parameter'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_YARN_PARAMET_TEST as select from ZPP_YARN_ITAM_TEAST as a 
                   left outer join ZPP_YARN_ITAM_TEAST as b on ( b.Partybillnumber = a.Partybillnumber 
                                                                and b.Parmeters = 'Actual Count' and b.partycode = a.partycode )
                   left outer join ZPP_YARN_ITAM_TEAST as c on ( c.Partybillnumber = a.Partybillnumber 
                                                                and c.Parmeters = 'MIN COUNT' and c.partycode = a.partycode )                                             
                   left outer join ZPP_YARN_ITAM_TEAST as d on ( d.Partybillnumber = a.Partybillnumber 
                                                                and d.Parmeters = 'MAX COUNT' and d.partycode = a.partycode )                                             
                   left outer join ZPP_YARN_ITAM_TEAST as e on ( e.Partybillnumber = a.Partybillnumber 
                                                                and e.Parmeters = 'Count CV%' and e.partycode = a.partycode )                                             
                   left outer join ZPP_YARN_ITAM_TEAST as f on ( f.Partybillnumber = a.Partybillnumber 
                                                                and f.Parmeters = 'CSP' and f.partycode = a.partycode )                                             
                   left outer join ZPP_YARN_ITAM_TEAST as g on ( g.Partybillnumber = a.Partybillnumber 
                                                                and g.Parmeters = 'MIN CSP' and g.partycode = a.partycode )                                             
                   left outer join ZPP_YARN_ITAM_TEAST as h on ( h.Partybillnumber = a.Partybillnumber 
                                                                and h.Parmeters = 'MAX CSP' and h.partycode = a.partycode )    
                   left outer join ZPP_YARN_ITAM_TEAST as i on ( i.Partybillnumber = a.Partybillnumber 
                                                                and i.Parmeters = 'CSP CV%' and i.partycode = a.partycode )                                                                                      
{
    key a.Partybillnumber,
    key a.partycode,
      b.Zresult as ActualCount, 
      c.Zresult as MINCOUNT,
      d.Zresult as MAXCOUNT,
      e.Zresult as CountCVper,
      f.Zresult as CSP,
      g.Zresult as MINCSP,
       h.Zresult as MAXCSP,
       i.Zresult as CSPCVper
}group by 
      a.Partybillnumber,
      b.Zresult,
      c.Zresult,
      d.Zresult,
      e.Zresult,
      f.Zresult,
      g.Zresult,
      h.Zresult,
      i.Zresult,
      a.partycode
    
