@AbapCatalog.sqlViewName: 'ZCONSMP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ENERGY CONSUMPTION REPORT FOR PLANT 1300'
define view YPS_ENERGY_CONSUMP_CDS_1300 as select from I_MeasurementDocument as a  

                       left outer join I_MeasurementDocument as B on (B.MeasurementDocument = a.MeasurementDocument 
                                                          and B.MeasuringPoint = '000000000044' )  // Loomunit1  '000000000019'
                                                          
                      left outer join I_MeasurementDocument as c on (c.MeasurementDocument = a.MeasurementDocument 
                                                          and c.MeasuringPoint = '000000000045' )   //Loomunit2   '000000000020'
                                                          
                     left outer join I_MeasurementDocument as d on (d.MeasurementDocument = a.MeasurementDocument 
                                                            and d.MeasuringPoint = '000000000046' )   // Loomunit3  '000000000021'
                                                            
                     left outer join I_MeasurementDocument as e on (e.MeasurementDocument = a.MeasurementDocument 
                                                            and e.MeasuringPoint = '000000000047' )      // compressor1 '000000000011'
                  
                    left outer join I_MeasurementDocument as t on (t.MeasurementDocument = a.MeasurementDocument 
                                                            and t.MeasuringPoint = '000000000048' )    //  compressor2
                                                            
                    left outer join I_MeasurementDocument as u on (u.MeasurementDocument = a.MeasurementDocument 
                                                            and u.MeasuringPoint = '000000000049' )   //  compressor3
                                                            
                   left outer join I_MeasurementDocument as v on (v.MeasurementDocument = a.MeasurementDocument 
                                                            and v.MeasuringPoint = '000000000050' )    // compressor4
                                                            
                  left outer join I_MeasurementDocument as w on (w.MeasurementDocument = a.MeasurementDocument 
                                                            and w.MeasuringPoint = '000000000051' )    // compressor5  
                                                                                                  
                     left outer join I_MeasurementDocument as f on (f.MeasurementDocument = a.MeasurementDocument 
                                                            and f.MeasuringPoint = '000000000052' )  // compressorFS440    '000000000026'
                                                            
                    left outer join I_MeasurementDocument as g on (g.MeasurementDocument = a.MeasurementDocument 
                                                            and g.MeasuringPoint = '000000000053' )    // compressorFS442  '000000000028'
                    left outer join I_MeasurementDocument as h on (h.MeasurementDocument = a.MeasurementDocument 
                                                            and h.MeasuringPoint = '000000000054' )  //    HumidityPlantUnit1   '000000000029'
                   left outer join I_MeasurementDocument as i on (i.MeasurementDocument = a.MeasurementDocument 
                                                            and i.MeasuringPoint = '000000000055' )    // HumidityPlantUnit2       '000000000030'
                   left outer join I_MeasurementDocument as j on (j.MeasurementDocument = a.MeasurementDocument 
                                                            and j.MeasuringPoint = '000000000056' )    // HumidityPlantUnit3   '000000000032'
                   left outer join I_MeasurementDocument as k on (k.MeasurementDocument = a.MeasurementDocument 
                                                            and k.MeasuringPoint = '000000000057' ) //  RsebMaintMtr       '000000000020'
                   left outer join I_MeasurementDocument as l on (l.MeasurementDocument = a.MeasurementDocument 
                                                            and l.MeasuringPoint = '000000000058' )  // Solor1st   '000000000021' 
                   left outer join I_MeasurementDocument as m on (m.MeasurementDocument = a.MeasurementDocument 
                                                            and m.MeasuringPoint = '000000000059' )   //  Solor2nd  '000000000022'
                   left outer join I_MeasurementDocument as n on (n.MeasurementDocument = a.MeasurementDocument 
                                                            and n.MeasuringPoint = '000000000060' )  // Solor3rd  
                                                            
                  left outer join I_MeasurementDocument as o on (o.MeasurementDocument = a.MeasurementDocument 
                                                            and o.MeasuringPoint = '000000000101' )  // Solor4th                                         
                
{

  key a.MsmtRdngDate as MeasurementDocument,
  key a.MsmtRdngDate as MeasuringPoint,
      a.MsmtRdngDate,
      a._UnitOfMeasure,
      a.MeasurementReadingEntryUoM,
      @Semantics.quantity.unitOfMeasure: 'MeasurementReadingEntryUoM'
     sum( B.MeasurementReading )  as Loomunit1,            // MeasurementReading
       @Semantics.quantity.unitOfMeasure: 'MeasurementReadingEntryUoM'
     sum( c.MeasurementReading ) as Loomunit2,
       @Semantics.quantity.unitOfMeasure: 'MeasurementReadingEntryUoM'
     sum( d.MeasurementReading ) as Loomunit3,
       @Semantics.quantity.unitOfMeasure: 'MeasurementReadingEntryUoM'
      sum( e.MeasurementReading ) as compressor1,
       @Semantics.quantity.unitOfMeasure: 'MeasurementReadingEntryUoM'
       sum(t.MeasurementReading ) as compressor2,
       @Semantics.quantity.unitOfMeasure: 'MeasurementReadingEntryUoM'
       sum(u.MeasurementReading ) as compressor3,
       @Semantics.quantity.unitOfMeasure: 'MeasurementReadingEntryUoM'
       sum(v.MeasurementReading ) as compressor4,
       @Semantics.quantity.unitOfMeasure: 'MeasurementReadingEntryUoM'
      sum( w.MeasurementReading ) as compressor5,
       @Semantics.quantity.unitOfMeasure: 'MeasurementReadingEntryUoM'
      sum( f.MeasurementReading ) as compressorFS440,
       @Semantics.quantity.unitOfMeasure: 'MeasurementReadingEntryUoM'
     sum( g.MeasurementReading ) as  compressorFS442,
       @Semantics.quantity.unitOfMeasure: 'MeasurementReadingEntryUoM'
     sum( h.MeasurementReading ) as HumidityPlantUnit1,
       @Semantics.quantity.unitOfMeasure: 'MeasurementReadingEntryUoM'
      sum(i.MeasurementReading ) as HumidityPlantUnit2,
       @Semantics.quantity.unitOfMeasure: 'MeasurementReadingEntryUoM'
     sum( j.MeasurementReading ) as HumidityPlantUnit3,
       @Semantics.quantity.unitOfMeasure: 'MeasurementReadingEntryUoM'
     sum( k.MeasurementReading )  as RsebMaintMtr,
           @Semantics.quantity.unitOfMeasure: 'MeasurementReadingEntryUoM'
     sum( l.MeasurementReading )  as Solor1st,
           @Semantics.quantity.unitOfMeasure: 'MeasurementReadingEntryUoM'
     sum( m.MeasurementReading )  as Solor2nd,
         @Semantics.quantity.unitOfMeasure: 'MeasurementReadingEntryUoM'
     sum( n.MeasurementReading )  as Solor3rd,
      @Semantics.quantity.unitOfMeasure: 'MeasurementReadingEntryUoM'
      sum( o.MeasurementReading )  as Solor4th
      
     
      
     
      
      }
      where a.MsmtRdngIsReversed != 'X'  and a.MeasurementReadingEntryUoM = 'KWH'
      group by 
      a.MsmtRdngDate,
      a.MeasurementReadingEntryUoM
