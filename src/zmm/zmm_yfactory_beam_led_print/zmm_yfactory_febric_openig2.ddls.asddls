@AbapCatalog.sqlViewName: 'YAOPENING2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Yarn Factory Febric Wight Opening'
define view  ZMM_YFACTORY_FEBRIC_OPENIG2  with parameters
    @Consumption.hidden: true
    @Environment.systemField: #SYSTEM_DATE
    P_KeyDate : vdm_v_key_date 
    as select from ZMM_YFACTORY_FEBRIC_OPENIG1( P_KeyDate: $parameters.P_KeyDate )  as a
    left outer join ZJOB_GREY_NETWT_DISPATCH_CDS as c on ( c.Material = a.Material and c.Recbatch = a.Batch ) 
{
    key a.Plant,
    key a.SoldToParty,
        sum( a.MatlWrhsStkQtyInMatlBaseUnit ) as MatlWrhsStkQtyInMatlBaseUnit,
        sum( c.Netwt ) as Netwt,
        sum( c.Quantity) as Quantity 
//        c.Material
        

}  
   where a.MatlWrhsStkQtyInMatlBaseUnit > 0
     group by 
        a.Plant,
        a.SoldToParty
//        c.Material
