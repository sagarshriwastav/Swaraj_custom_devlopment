@AbapCatalog.sqlViewName: 'YFINISHDMG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Dnm Fault Dmg Mtr'
define view ZDMAGE_REPORT_FINISHDMGMTR with parameters
    p_fromdate : abap.dats,
    p_todate   : abap.dats
    as select from   zdnmfault  as a 
     
 
{
      key a.material_number,
          a.plant,
      sum( a.meter ) as meter,
      sum( a.tometer ) as tometer

}    where a.ftype like  '4%'
   and  a.posting_date >= $parameters.p_fromdate
  and   a.posting_date <= $parameters.p_todate
 group by  
 
  a.material_number,
  a.plant
 
 
 
 