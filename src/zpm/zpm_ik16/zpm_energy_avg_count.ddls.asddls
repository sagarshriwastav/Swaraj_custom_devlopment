@AbapCatalog.sqlViewName: 'YPSCDS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Energy Consumption Report'
define view ZPM_ENERGY_AVG_COUNT as select from I_MeasurementDocument as a 
        
         
{
   
    key a.MeasurementDocument,
  key a.MsmtRdngDate as MeasuringPoint,
      a.MsmtRdngDate,  
      a.MeasurementReadingEntryUoM,
      a._UnitOfMeasure,
      substring(a.MsmtRdngDate,1,6) as ZDATE
   
  } 
    where a.MsmtRdngIsReversed != 'X'
  group by  
      a.MeasurementDocument,  
      a.MsmtRdngDate,
      a.MeasurementReadingEntryUoM
