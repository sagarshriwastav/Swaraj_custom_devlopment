@AbapCatalog.sqlViewName: 'YMISQUANTITY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMIS_REPORT_QUANTITY'
define view ZMIS_REPORT_QUANTITY as select from ZMIS_REPORT_PP as a 
            left outer join ZMIS_REPORT_LENGTH as b on ( b.Setno = a.Batch  and b.DyeingSort = a.Dying_Short) 
            left outer join ZMIS_REPORT_PACKGRADE_SUM as c on ( c.Setno = a.Batch ) 
            left outer join ZMIS_REPORT_RECEIVED as d on ( d.Set_code = a.Batch )
            left outer join ZMIS_REPORT_SUMFINISH as e on ( e.Set_code = a.Batch )
            left outer join ZMIS_RECEIVED_QUANTITY_CDS as f on ( f.Batch = a.Batch )
            left outer join ZMIS_REPORT_CDS as g on ( g.Batch = a.Batch )
            left outer join ZMIS_WARPING_SUM as H on ( H.Batch = a.Batch )
//            left outer join I_MfgOrderWithStatus as i on (  i.Batch = a.Batch and i.ManufacturingOrderType = 'SFF1' )
            
            
                                                                                                                                                                                                                                      
 
            
{  
   key a.Warping_Short, 
       a.PostingDate,
       a.Batch,
       a. millname, 
       a.lotnumber,
       a.ZCount,
 //      a.MaterialBaseUnit as MaterialBaseUnit4,
 //      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit4' 
  //     a.WarpingLength as WarpingLength1,
  //     a.zunit as zunit4,
  //     @Semantics.quantity.unitOfMeasure: 'zunit4'
  //     a.CottonIssueWeight as CottonIssueWeight1,
//       a.BaseUnit as BaseUnit4,
//       a.Bottom as Bottom1,
       b.DyeingSort,
       b.luom,
       @Semantics.quantity.unitOfMeasure : 'luom'
       b.Length ,
       b.wuom,
       @Semantics.quantity.unitOfMeasure : 'wuom'       
       b.Weight,
       c.CD as CD1,
       c.SV1 as SV2,
       c.SL as SL1,
       c.F1 as F2,
       c.SW as SW1,
       c.OTH as OTH1,
       c.PDS as PDS1,
       c.QDS as QDS1,
       c.FR as FR1,
       cast( 'M' as abap.unit( 3 ))  as Zunit,
   //    d.MaterialBaseUnit as MaterialBaseUnit3,
       @Semantics.quantity.unitOfMeasure : 'zunit'
       e.GreyReceived as QuantityInBaseUnit,
       e.Zunit as Zunit3,
       @Semantics.quantity.unitOfMeasure : 'zunit3'
       e.Finishmtr as Finishmtr1,
       f.MaterialBaseUnit,
       @Semantics.quantity.unitOfMeasure : 'MaterialBaseUnit'
       f.QuantityInBaseUnit as QuantityInBaseUnit1,
       f.YarnMaterial as YarnMaterial,
       
       H.MaterialBaseUnit as MaterialBaseUnit4,
       @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit4' 
       H.WarpingLength as WarpingLength1,
       g.zunit as zunit4,
       @Semantics.quantity.unitOfMeasure: 'zunit4'
       g.CottonIssueWeight as CottonIssueWeight1,
       g.BaseUnit as  BaseUnit4 ,
       g.Bottom as Bottom1
//       i.ManufacturingOrderType,
//       i.ManufacturingOrder,
//       max(i.CreationDate) as CreationDate,
//       i.OrderIsTechnicallyCompleted
       
      
      
} where f.YarnMaterial like 'YGPC%'  //and i.ManufacturingOrderType = 'SFF1'

 group by  a.Warping_Short, 
         a.PostingDate,
       a.Batch,
       a. millname, 
       a.lotnumber,
       a.ZCount,
        b.DyeingSort,
       b.luom,
      
       b.Length ,
       b.wuom, 
       b.Weight,
       c.CD ,
       c.SV1 ,
       c.SL ,
       c.F1 ,
       c.SW ,
       c.OTH ,
       c.PDS ,
       c.QDS ,
       c.FR ,
       e.GreyReceived ,
       e.Zunit ,
       e.Finishmtr ,
       f.MaterialBaseUnit,
       f.QuantityInBaseUnit ,
       f.YarnMaterial ,
       
       H.MaterialBaseUnit, 
       H.WarpingLength ,
       g.zunit ,
       g.CottonIssueWeight ,
       g.BaseUnit  ,
       g.Bottom 
//       i.ManufacturingOrderType,
//       i.CreationDate,
//       i.OrderIsTechnicallyCompleted,
//       i.ManufacturingOrder
       

//       group by a.Warping_Short,
//        a.PostingDate,
//        a.Batch,
//       a.Cotton_Yarn_Mill_Name,
//       a.Cotton_Yarn_Lotno,
//       a.Zcount,
//       b.DyeingSort,
//       b.luom,
//       b.Length ,
//       b.wuom,
//       b.Weight,
//       f.Material,
//       f.Batch ,
//       g.MaterialBaseUnit ,
//       g.QuantityInBaseUnit,
//       i.CD ,
//       i.SV1,
//       i.SL,
//       i.F1,
//       i.SW ,
//       i.OTH ,
//       i.PDS ,
//       i.QDS ,
//       i.FR ,
//       j.MaterialBaseUnit,
//       j.QuantityInBaseUnit,
//       k.Zunit,
//       k.Finishmtr,
//       k.Shrinkageperc,
//       L.MaterialBaseUnit,
//       L.WarpingLength,
//       L.zunit,
//       L.CottonIssueWeight,
//       L.BaseUnit,
//       L.Bottom,
//       m.MaterialBaseUnit

