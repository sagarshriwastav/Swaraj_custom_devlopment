@AbapCatalog.sqlViewName: 'YCHEMICALPA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_CHEMICAL_TEST_PARAMTR_CDS'
define view ZPP_CHEMICAL_TEST_PARAMTR_CDS as select from ZPP_CHEMICAL_TEST_PARAMETR_CDS as a
          left outer join ZPP_CHEMICAL_TEST_PARAMETR_CDS as b on ( b.Partybillnumber = a.Partybillnumber 
                                                                  and b.parameters = 'MOISTURE%' )
          left outer join ZPP_CHEMICAL_TEST_PARAMETR_CDS as c on ( c.Partybillnumber = a.Partybillnumber 
                                                                  and c.parameters = 'PURITY%' )                                             
          left outer join ZPP_CHEMICAL_TEST_PARAMETR_CDS as d on ( d.Partybillnumber = a.Partybillnumber 
                                                                  and d.parameters = 'SOLID CONTENT' )                                             
          left outer join ZPP_CHEMICAL_TEST_PARAMETR_CDS as e on ( e.Partybillnumber = a.Partybillnumber 
                                                                  and e.parameters = 'SELF Ph' )                                             
          left outer join ZPP_CHEMICAL_TEST_PARAMETR_CDS as f on ( f.Partybillnumber = a.Partybillnumber 
                                                                  and f.parameters = 'DRAVE TEST' )                                             
          left outer join ZPP_CHEMICAL_TEST_PARAMETR_CDS as g on ( g.Partybillnumber = a.Partybillnumber 
                                                                  and g.parameters = 'DENSITY' )                                             
          left outer join ZPP_CHEMICAL_TEST_PARAMETR_CDS as h on ( h.Partybillnumber = a.Partybillnumber 
                                                                  and h.parameters = 'RF%' )    
          left outer join ZPP_CHEMICAL_TEST_PARAMETR_CDS as i on ( i.Partybillnumber = a.Partybillnumber 
                                                                  and i.parameters = 'VISCOSITY' ) 
          left outer join ZPP_CHEMICAL_TEST_PARAMETR_CDS as j on ( j.Partybillnumber = a.Partybillnumber 
                                                                  and j.parameters = 'ODURE' )    
          left outer join ZPP_CHEMICAL_TEST_PARAMETR_CDS as k on ( k.Partybillnumber = a.Partybillnumber 
                                                                  and k.parameters = 'COLOR' )                                                                                                                                  
{
    key a.Partybillnumber,
        b.zresult as MOISTURE, 
        c.zresult as PURITY,
        d.zresult as SOLIDCONTENT,
        e.zresult as SELFPh,
        f.zresult as DRAVETEST,
        g.zresult as DENSITY,
        h.zresult as RF,
        i.zresult as VISCOSITY,
        j.zresult as ODURE,
        k.zresult as COLOR
}group by 
      a.Partybillnumber,
      b.zresult,
      c.zresult,
      d.zresult,
      e.zresult,
      f.zresult,
      g.zresult,
      h.zresult,
      i.zresult,
      j.zresult,
      k.zresult

    
