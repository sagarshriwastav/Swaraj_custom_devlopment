@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  Material Receipt report'
define root view entity ZPP_GET_ENTRY_NO as select from ygatehead1 as a 
           left outer join ygateitem1 as b on ( b.gateno = a.gateno )
{
    
   key a.gateno,
   key b.ebeln,
       a.vehical_no,
       a.invoice,
       b.ebelp,
       a.gate_in_date
   
 
}   where a.cancelled = ' ' or a.cancelled = 'no'
  group by   
       a.gateno,
       a.vehical_no,
       a.invoice,
       b.ebeln,
       b.ebelp,
       a.gate_in_date
