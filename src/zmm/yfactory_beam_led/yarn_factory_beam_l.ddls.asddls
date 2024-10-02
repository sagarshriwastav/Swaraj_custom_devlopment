@AbapCatalog.sqlViewName: 'YARN_FACT_BEAM_L'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Yarn Factory Beam Leadger'
define view Yarn_Factory_Beam_L 
with parameters 
                p_plant : abap.char( 4 ) ,
                p_cust  : abap.char( 10 ) ,
            @Environment.systemField: #SYSTEM_DATE    
                p_posting:abap.dats,
             @Environment.systemField: #SYSTEM_DATE
                p_posting1:abap.dats
as select from YARN_FACTORY_BEAM_L_1( p_plant:$parameters.p_plant ,p_cust:$parameters.p_cust ,
                                     p_posting:$parameters.p_posting , p_posting1:$parameters.p_posting1 ) as a 
      left outer join zmm_fabricwise as b on ( b.material = a.Material )                               
{
    key a.Customer,
    key a.PostingDate,
    key a.Challan_no,
    key a.Material,
    key a.MaterialDocument,
    a.MaterialBaseUnit,
    cast( cast( a.Opening_Stk as abap.dec( 13, 3 ) ) as abap.char(16) ) as OpeningQty,
   //  a.Opening_Stk,
    cast( cast( a.Closing_Stk as abap.dec( 13, 3 ) ) as abap.char(16) ) as ClosingQty,
   // a.Closing_Stk,
    cast( 'KG' as abap.unit( 3 ) ) as ZunitKg,
    a.Netwt,
    a.Reciept_Qty,
    a.Return_Qty,
    a.Dispatc_QTY,
    a.CustomerName,
    a.ProductDescription,
    b.wastegpersantage,
     cast ( cast( case  when a.Opening_Stk is not null then a.Opening_Stk else 0 end as abap.dec( 13, 3 ) ) +
             cast( case  when a.Reciept_Qty is not null then a.Reciept_Qty else 0 end as abap.dec( 13, 3 ) ) +
             cast( case  when a.Return_Qty is not null then a.Return_Qty else 0 end as abap.dec( 13, 3 ) ) +
             cast( case  when a.Dispatc_QTY is not null then a.Dispatc_QTY else 0 end as abap.dec( 13, 3 ) ) 
             as abap.dec( 13, 3 ) ) as total
 
 }  


