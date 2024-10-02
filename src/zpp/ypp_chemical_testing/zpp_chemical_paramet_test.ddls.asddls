@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'pp chemical parameter'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_CHEMICAL_PARAMET_TEST as select from ZPP_YARN_ITAM_TEAST as a 
                   left outer join ZPP_YARN_ITAM_TEAST as b on ( b.Partybillnumber = a.Partybillnumber 
                                                                and b.Parmeters = 'MOISTURE%' )
                   left outer join ZPP_YARN_ITAM_TEAST as c on ( c.Partybillnumber = a.Partybillnumber 
                                                                and c.Parmeters = 'PURITY%' )                                             
                   left outer join ZPP_YARN_ITAM_TEAST as d on ( d.Partybillnumber = a.Partybillnumber 
                                                                and d.Parmeters = 'SOLID CONTENT' )                                             
                   left outer join ZPP_YARN_ITAM_TEAST as e on ( e.Partybillnumber = a.Partybillnumber 
                                                                and e.Parmeters = 'SELF PH' )                                             
                   left outer join ZPP_YARN_ITAM_TEAST as f on ( f.Partybillnumber = a.Partybillnumber 
                                                                and f.Parmeters = 'DRAVE TEST' )                                             
                   left outer join ZPP_YARN_ITAM_TEAST as g on ( g.Partybillnumber = a.Partybillnumber 
                                                                and g.Parmeters = 'DENSITY' )                                             
                   left outer join ZPP_YARN_ITAM_TEAST as h on ( h.Partybillnumber = a.Partybillnumber 
                                                                and h.Parmeters = 'RF%' )    
                   left outer join ZPP_YARN_ITAM_TEAST as i on ( i.Partybillnumber = a.Partybillnumber 
                                                                and i.Parmeters = 'VISCOSITY' )
                   left outer join ZPP_YARN_ITAM_TEAST as j on ( j.Partybillnumber = a.Partybillnumber 
                                                                and j.Parmeters = 'ODURE' )
                   left outer join ZPP_YARN_ITAM_TEAST as k on ( k.Partybillnumber = a.Partybillnumber 
                                                                and k.Parmeters = 'COLOUR' )                                                                                                                                                                                                                      
{
    key a.Partybillnumber,
        b.Zresult as Moisture, 
        c.Zresult as Purity,
        d.Zresult as SolidContent,
        e.Zresult as SelfPh,
        f.Zresult as DraveTest,
        g.Zresult as Density,
        h.Zresult as RF,
        i.Zresult as Viscosity,
        j.Zresult as Odure,
        k.Zresult as Colour
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
      j.Zresult,
      k.Zresult
