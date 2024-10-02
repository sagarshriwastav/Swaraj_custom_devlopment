@AbapCatalog.sqlViewName: 'YPSREPORTS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Energy Consumption Report'

define view YPS_ENERGY_CONSUMPTION_CDS1 as select from  ZPM_ENERGY_AVG_COUNT as a  

                       left outer join I_MeasurementDocument as B on (B.MeasurementDocument = a.MeasurementDocument 
                                                          and B.MeasuringPoint = '000000000022' )  // warpingmtr  '000000000019' 000000000011
                                                          
                      left outer join I_MeasurementDocument as c on (c.MeasurementDocument = a.MeasurementDocument 
                                                          and c.MeasuringPoint = '000000000033' )   //indgodyeing1  '000000000020' 000000000012
                                                          
                     left outer join I_MeasurementDocument as d on (d.MeasurementDocument = a.MeasurementDocument 
                                                            and d.MeasuringPoint = '000000000036' )   // indgodyeing2  '000000000021' 000000000013
                                                            
                     left outer join I_MeasurementDocument as e on (e.MeasurementDocument = a.MeasurementDocument 
                                                            and e.MeasuringPoint = '000000000037' )      // compressor '000000000011' 000000000016
                  
                    left outer join I_MeasurementDocument as t on (t.MeasurementDocument = a.MeasurementDocument 
                                                            and t.MeasuringPoint = '000000000038' )    //  fiNISHIng1 000000000017
                                                            
                    left outer join I_MeasurementDocument as u on (u.MeasurementDocument = a.MeasurementDocument 
                                                            and u.MeasuringPoint = '000000000039' )   //  fiNISHIng2  000000000018
                                                            
                   left outer join I_MeasurementDocument as v on (v.MeasurementDocument = a.MeasurementDocument 
                                                            and v.MeasuringPoint = '000000000040' )    // singingmc  000000000021
                                                            
                  left outer join I_MeasurementDocument as w on (w.MeasurementDocument = a.MeasurementDocument 
                                                            and w.MeasuringPoint = '000000000042' )    // foldiingdp   000000000023
                                                                                                  
                     left outer join I_MeasurementDocument as f on (f.MeasurementDocument = a.MeasurementDocument 
                                                            and f.MeasuringPoint = '000000000026' )  // boiler    '000000000026' 000000000027
                                                            
                    left outer join I_MeasurementDocument as g on (g.MeasurementDocument = a.MeasurementDocument 
                                                            and g.MeasuringPoint = '000000000024' )    // etp  '000000000028' 000000000025
                    left outer join I_MeasurementDocument as h on (h.MeasurementDocument = a.MeasurementDocument 
                                                            and h.MeasuringPoint = '000000000025' )  //    aro   '000000000029'  000000000026
                   left outer join I_MeasurementDocument as i on (i.MeasurementDocument = a.MeasurementDocument 
                                                            and i.MeasuringPoint = '000000000023' )    // mee        '000000000030'  000000000024
                   left outer join I_MeasurementDocument as j on (j.MeasurementDocument = a.MeasurementDocument 
                                                            and j.MeasuringPoint = '00000000028' )    // rawwater   '000000000032'   000000000029
                   left outer join I_MeasurementDocument as k on (k.MeasurementDocument = a.MeasurementDocument 
                                                            and k.MeasuringPoint = '000000000027' ) //  edm       '000000000020'  000000000028
                   left outer join I_MeasurementDocument as l on (l.MeasurementDocument = a.MeasurementDocument 
                                                            and l.MeasuringPoint = '000000000029' )  // eot   '000000000021'   000000000030
                   left outer join I_MeasurementDocument as m on (m.MeasurementDocument = a.MeasurementDocument 
                                                            and m.MeasuringPoint = '000000000030' )   //  canteen  '000000000022'  000000000031
                   left outer join I_MeasurementDocument as n on (n.MeasurementDocument = a.MeasurementDocument 
                                                            and n.MeasuringPoint = '000000000023' )  // fireendsafty    000000000023
               left outer join I_MeasurementDocument as o on (o.MeasurementDocument = a.MeasurementDocument 
                                                            and o.MeasuringPoint = '000000000041' )   // leb  '000000000024' 000000000022
                left outer join I_MeasurementDocument as p on (p.MeasurementDocument = a.MeasurementDocument 
                                                            and p.MeasuringPoint = '000000000034' )    //  dg50kva     '000000000034'  000000000034
                left outer join I_MeasurementDocument as q on (q.MeasurementDocument = a.MeasurementDocument 
                                                            and q.MeasuringPoint = '000000000032' )    //  dg600kva    '000000000033'   
                left outer join I_MeasurementDocument as r on (r.MeasurementDocument = a.MeasurementDocument 
                                                            and r.MeasuringPoint = '000000000035' )    //  trubine  '000000000027'   000000000035 
               left outer join I_MeasurementDocument as s on ( s.MeasurementDocument = a.MeasurementDocument 
                                                            and s.MeasuringPoint = '000000000031' )    //  mpeb    '000000000035'  000000000031
               left outer join I_MeasurementDocument as Gs on ( Gs.MeasurementDocument = a.MeasurementDocument 
                                                            and Gs.MeasuringPoint = '000000000043' )    //  SteamConsumption    '000000000035'  000000000031
               left outer join I_MeasurementDocument as Gss on ( Gss.MeasurementDocument = a.MeasurementDocument 
                                                            and Gss.MeasuringPoint = '000000000071' )      // FreshWateConsumption                                         
              left outer join ZPM_PRICE_MAINTAIN_CDS as Z on ( Z.Zdate = a.ZDATE)                                                                                                                                                                                      
                
{
     
  key a.MsmtRdngDate as MeasurementDocument,
  key a.MsmtRdngDate as MeasuringPoint,
      a.MsmtRdngDate,
      a._UnitOfMeasure,
      a.MeasurementReadingEntryUoM,
      cast( 'INR' as abap.cuky(5) ) as transactioncurrency,
      @Semantics.amount.currencyCode : 'transactioncurrency'
      Z.Electricityprice,
     sum( B.MeasurementReading )  as warpingmtr,            // Measure
     sum( c.MeasurementReading ) as indgodyeing1,
     sum( d.MeasurementReading ) as indgodyeing2,
      sum( e.MeasurementReading ) as compressor,
       sum(f.MeasurementReading ) as boiler,
       sum(g.MeasurementReading ) as etp,
       sum(h.MeasurementReading ) as aro,
      sum( i.MeasurementReading ) as mee,
      sum( j.MeasurementReading ) as rawwater,
     sum( k.MeasurementReading ) as edm,
     sum( l.MeasurementReading ) as eot,
      sum(m.MeasurementReading ) as canteen,
     sum( n.MeasurementReading ) as fireendsafty,
     sum( o.MeasurementReading) as leb,
     sum( p.MeasurementReading ) as dg50kva,
     sum( q.MeasurementReading  ) as dg600kva,
     sum( r.MeasurementReading ) as trubine,
     sum( s.MeasurementReading )  as mpeb,
     sum( t.MeasurementReading )  as fiNISHIng1,
     sum( u.MeasurementReading )  as fiNISHIng2,
     sum( v.MeasurementReading )  as singingmc,
     sum( w.MeasurementReading )  as foldiingdp,
     sum( Gs.MeasurementReading ) as SteamConsumption,   
     sum( Gss.MeasurementReading ) as FreshWateConsumption                 
   //   cast ( cast( case  when B.MeasurementReading is not null then B.MeasurementReading else 0 end as abap.dec( 13, 3 ) ) + 
    //         cast( case  when c.MeasurementReading is not null then c.MeasurementReading else 0 end as abap.dec( 13, 3 ) )
     //         as abap.dec( 13, 3 ) ) as total
     
      
      }
 //     where a.MsmtRdngIsReversed != 'X'  //and a.MeasurementReadingEntryUoM = 'KWH'
      group by 
      a.MsmtRdngDate,
      a.MeasurementReadingEntryUoM,
      Z.transactioncurrency,
      Z.Electricityprice
