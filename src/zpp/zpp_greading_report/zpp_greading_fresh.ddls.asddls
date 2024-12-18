@AbapCatalog.sqlViewName: 'YFRESH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS FOR FRESH CASE'
define view ZPP_GREADING_FRESH as select from ZPP_GREADING_REPORT

{
 
 key Plant,
 key PostingDate,
 key MaterialNumber,
 key Batch,
 key RecBatch,
 key MatDoc,
 key MatDocitem,
 key MatDocyear,
 StorageLocation,
 RecevingLocation,
 OperatorName,
 PackGrade,
 InspectionMcNo,
 ReGrading,
 NoOfTp,
 Shift,
 FolioNumber,
 UnitField,
 FinishWidth,
 GrossWeight,
 NetWeight,
 Stdwidth,
 Stdnetwt,
 Totalpoint,
 Point4,
 Remark1,
 Remark2,
 Stdozs,
 Actozs,
 Party,
 Tpremk,
 FlagQuantityTotal,
 RollLength,
 SalesOrder,
 SoItem,
 Setno,
 Trollyno,
 Loomno,
 DocumentDate,
 Cancelflag,
 Dyeingsort,
 Stock,
 Delivery,
 CD,
 SV,
 SL,
 fresh,
 SW,
 other,
 PD,
 QD,
 MaterialBaseUnit,
 FRC,
 case when PackGrade = 'F1' and ftype = '101' then tometer   else WARPSLUBBY  end as  WARPSLUBBY, 

 case when PackGrade = 'F1' and ftype = '102'  then tometer  else  WEFTSLUBBY end as WEFTSLUBBY,
 case when PackGrade = 'F1' and ftype = '103'  then tometer  else CONTAMINATION end as CONTAMINATION,
 case when PackGrade = 'F1' and ftype = '104'  then tometer  else UNEVENWEFT end as UNEVENWEFT,
 case when PackGrade = 'F1' and ftype = '105'  then tometer  else  FAULTDMG105 end as FAULTDMG105,
 case when PackGrade = 'F1' and ftype = '106'  then tometer  else FAULTDMG106 end as FAULTDMG106,
 case when PackGrade = 'F1' and ftype = '107'  then tometer  else FAULTDMG107 end as FAULTDMG107,
 case when PackGrade = 'F1' and ftype = '108'  then tometer  else FAULTDMG108 end as FAULTDMG108,
 case when PackGrade = 'F1' and ftype = '109'  then tometer  else FAULTDMG109 end as FAULTDMG109,
 case when PackGrade = 'F1' and ftype = '110'  then tometer  else FAULTDMG110 end as FAULTDMG110,
 case when PackGrade = 'F1' and ftype = '111'  then tometer  else FAULTDMG111 end as FAULTDMG111,
 case when PackGrade = 'F1' and ftype = '112'  then tometer  else FAULTDMG112 end as FAULTDMG112,
 case when PackGrade = 'F1' and ftype = '113'  then tometer  else FAULTDMG113 end as FAULTDMG113,
 case when PackGrade = 'F1' and ftype = '114'  then tometer  else FAULTDMG114 end as FAULTDMG114 ,
 case when PackGrade = 'F1' and ftype = '115'  then tometer  else FAULTDMG115 end as FAULTDMG115,
 case when PackGrade = 'F1' and ftype = '116'  then tometer  else FAULTDMG116 end as FAULTDMG116,
 case when PackGrade = 'F1' and ftype = '117'  then tometer  else FAULTDMG117 end as FAULTDMG117,
 case when PackGrade = 'F1' and ftype = '118'  then tometer  else FAULTDMG118 end as FAULTDMG118,
 case when PackGrade = 'F1' and ftype = '119'  then tometer  else FAULTDMG119 end as FAULTDMG119,
 case when PackGrade = 'F1' and ftype = '120'  then tometer  else FAULTDMG120 end as FAULTDMG120,
 case when PackGrade = 'F1' and ftype = '121'  then tometer  else FAULTDMG121 end as FAULTDMG121,
 case when PackGrade = 'F1' and ftype = '122'  then tometer  else FAULTDMG122 end as FAULTDMG122,
 case when PackGrade = 'F1' and ftype = '123'  then tometer  else FAULTDMG123 end as FAULTDMG123,
 case when PackGrade = 'F1' and ftype = '124'  then tometer  else FAULTDMG124 end as FAULTDMG124,
 case when PackGrade = 'F1' and ftype = '125'  then tometer  else FAULTDMG125 end as FAULTDMG125,
 case when PackGrade = 'F1' and ftype = '201'  then tometer  else FAULTDMG201 end as FAULTDMG201,
 case when PackGrade = 'F1' and ftype = '202'  then tometer  else FAULTDMG202 end as FAULTDMG202,
 case when PackGrade = 'F1' and ftype = '203'  then tometer  else FAULTDMG203 end as FAULTDMG203,
 case when PackGrade = 'F1' and ftype = '204'  then tometer  else FAULTDMG204 end as FAULTDMG204,
 case when PackGrade = 'F1' and ftype = '205'  then tometer  else FAULTDMG205 end as FAULTDMG205,
 case when PackGrade = 'F1' and ftype = '206'  then tometer  else FAULTDMG206 end as FAULTDMG206,
 case when PackGrade = 'F1' and ftype = '207'  then tometer  else FAULTDMG207 end as FAULTDMG207,
 case when PackGrade = 'F1' and ftype = '208'  then tometer  else FAULTDMG208 end as FAULTDMG208,
 case when PackGrade = 'F1' and ftype = '209'  then tometer  else FAULTDMG209 end as FAULTDMG209,
 case when PackGrade = 'F1' and ftype = '210'  then tometer  else FAULTDMG210 end as FAULTDMG210,
 case when PackGrade = 'F1' and ftype = '211'  then tometer  else FAULTDMG211 end as FAULTDMG211,
 case when PackGrade = 'F1' and ftype = '212'  then tometer  else FAULTDMG212 end as FAULTDMG212,
 case when PackGrade = 'F1' and ftype = '213'  then tometer  else FAULTDMG213 end as FAULTDMG213,
 case when PackGrade = 'F1' and ftype = '214'  then tometer  else FAULTDMG214 end as FAULTDMG214,
 case when PackGrade = 'F1' and ftype = '215'  then tometer  else FAULTDMG215 end as FAULTDMG215,
 case when PackGrade = 'F1' and ftype = '216'  then tometer  else FAULTDMG216 end as FAULTDMG216,
 case when PackGrade = 'F1' and ftype = '217'  then tometer  else FAULTDMG217 end as FAULTDMG217,
 case when PackGrade = 'F1' and ftype = '218'  then tometer  else FAULTDMG218 end as FAULTDMG218,
 case when PackGrade = 'F1' and ftype = '301'  then tometer  else FAULTDMG301 end as FAULTDMG301,
 case when PackGrade = 'F1' and ftype = '302'  then tometer  else FAULTDMG302 end as FAULTDMG302,
 case when PackGrade = 'F1' and ftype = '303'  then tometer  else FAULTDMG303 end as FAULTDMG303,
 case when PackGrade = 'F1' and ftype = '304'  then tometer  else FAULTDMG304 end as FAULTDMG304,
 case when PackGrade = 'F1' and ftype = '305'  then tometer  else FAULTDMG305 end as FAULTDMG305,
 case when PackGrade = 'F1' and ftype = '306'  then tometer  else FAULTDMG306 end as FAULTDMG306,
 case when PackGrade = 'F1' and ftype = '307'  then tometer  else FAULTDMG307 end as FAULTDMG307,
 case when PackGrade = 'F1' and ftype = '308'  then tometer  else FAULTDMG308 end as FAULTDMG308,
 case when PackGrade = 'F1' and ftype = '309'  then tometer  else FAULTDMG309 end as FAULTDMG309,
 case when PackGrade = 'F1' and ftype = '310'  then tometer  else FAULTDMG310 end as FAULTDMG310,
 case when PackGrade = 'F1' and ftype = '311'  then tometer  else FAULTDMG311 end as FAULTDMG311,
 case when PackGrade = 'F1' and ftype = '312'  then tometer  else FAULTDMG312 end as FAULTDMG312,
 case when PackGrade = 'F1' and ftype = '313'  then tometer  else FAULTDMG313 end as FAULTDMG313,
 case when PackGrade = 'F1' and ftype = '314'  then tometer  else FAULTDMG314 end as FAULTDMG314,
 case when PackGrade = 'F1' and ftype = '315'  then tometer  else FAULTDMG315 end as FAULTDMG315,
 case when PackGrade = 'F1' and ftype = '316'  then tometer  else FAULTDMG316 end as FAULTDMG316,
 case when PackGrade = 'F1' and ftype = '317'  then tometer  else FAULTDMG317 end as FAULTDMG317,
 case when PackGrade = 'F1' and ftype = '318'  then tometer  else FAULTDMG318 end as FAULTDMG318,
 case when PackGrade = 'F1' and ftype = '319'  then tometer  else FAULTDMG319 end as FAULTDMG319,
 case when PackGrade = 'F1' and ftype = '320'  then tometer  else FAULTDMG320 end as FAULTDMG320,
 case when PackGrade = 'F1' and ftype = '321'  then tometer  else FAULTDMG321 end as FAULTDMG321,
 case when PackGrade = 'F1' and ftype = '322'  then tometer  else FAULTDMG322 end as FAULTDMG322,
 case when PackGrade = 'F1' and ftype = '323'  then tometer  else FAULTDMG323 end as FAULTDMG323,
 case when PackGrade = 'F1' and ftype = '324'  then tometer  else FAULTDMG324 end as FAULTDMG324,
 case when PackGrade = 'F1' and ftype = '325'  then tometer  else FAULTDMG325 end as FAULTDMG325,
 case when PackGrade = 'F1' and ftype = '326'  then tometer  else FAULTDMG326 end as FAULTDMG326,
 case when PackGrade = 'F1' and ftype = '327'  then tometer  else FAULTDMG327 end as FAULTDMG327,
 case when PackGrade = 'F1' and ftype = '328'  then tometer  else FAULTDMG328 end as FAULTDMG328,
 case when PackGrade = 'F1' and ftype = '329'  then tometer  else FAULTDMG329 end as FAULTDMG329,
 case when PackGrade = 'F1' and ftype = '330'  then tometer  else FAULTDMG330 end as FAULTDMG330,
 case when PackGrade = 'F1' and ftype = '331'  then tometer  else FAULTDMG331 end as FAULTDMG331,
 case when PackGrade = 'F1' and ftype = '332'  then tometer  else FAULTDMG332 end as FAULTDMG332,
 case when PackGrade = 'F1' and ftype = '333'  then tometer  else FAULTDMG333 end as FAULTDMG333,
 case when PackGrade = 'F1' and ftype = '334'  then tometer  else FAULTDMG334 end as FAULTDMG334,
 case when PackGrade = 'F1' and ftype = '335'  then tometer  else FAULTDMG335 end as FAULTDMG335,
 case when PackGrade = 'F1' and ftype = '336'  then tometer  else FAULTDMG336 end as FAULTDMG336,
 case when PackGrade = 'F1' and ftype = '337'  then tometer  else FAULTDMG337 end as FAULTDMG337,
 case when PackGrade = 'F1' and ftype = '338'  then tometer  else FAULTDMG338 end as FAULTDMG338,
 case when PackGrade = 'F1' and ftype = '339'  then tometer  else FAULTDMG339 end as FAULTDMG339,
 case when PackGrade = 'F1' and ftype = '340'  then tometer  else FAULTDMG340 end as FAULTDMG340,
 case when PackGrade = 'F1' and ftype = '341'  then tometer  else FAULTDMG341 end as FAULTDMG341,
 case when PackGrade = 'F1' and ftype = '401'  then tometer  else FAULTDMG401 end as FAULTDMG401,
 case when PackGrade = 'F1' and ftype = '402'  then tometer  else FAULTDMG402 end as FAULTDMG402,
 case when PackGrade = 'F1' and ftype = '403'  then tometer  else FAULTDMG403 end as FAULTDMG403,
 case when PackGrade = 'F1' and ftype = '404'  then tometer  else FAULTDMG404 end as FAULTDMG404,
 case when PackGrade = 'F1' and ftype = '405'  then tometer  else FAULTDMG405 end as FAULTDMG405,
 case when PackGrade = 'F1' and ftype = '406'  then tometer  else FAULTDMG406 end as FAULTDMG406,
 case when PackGrade = 'F1' and ftype = '407'  then tometer  else FAULTDMG407 end as FAULTDMG407,
 case when PackGrade = 'F1' and ftype = '408'  then tometer  else FAULTDMG408 end as FAULTDMG408,
 case when PackGrade = 'F1' and ftype = '409'  then tometer  else FAULTDMG409 end as FAULTDMG409,
 case when PackGrade = 'F1' and ftype = '410'  then tometer  else FAULTDMG410 end as FAULTDMG410,
 case when PackGrade = 'F1' and ftype = '411'  then tometer  else FAULTDMG411 end as FAULTDMG411,
 case when PackGrade = 'F1' and ftype = '412'  then tometer  else FAULTDMG412 end as FAULTDMG412,
 case when PackGrade = 'F1' and ftype = '413'  then tometer  else FAULTDMG413 end as FAULTDMG413,
 case when PackGrade = 'F1' and ftype = '414'  then tometer  else FAULTDMG414 end as FAULTDMG414,
 case when PackGrade = 'F1' and ftype = '415'  then tometer  else FAULTDMG415 end as FAULTDMG415,
 case when PackGrade = 'F1' and ftype = '416'  then tometer  else FAULTDMG416 end as FAULTDMG416,
 case when PackGrade = 'F1' and ftype = '417'  then tometer  else FAULTDMG417 end as FAULTDMG417,
 case when PackGrade = 'F1' and ftype = '418'  then tometer  else FAULTDMG418 end as FAULTDMG418,
 case when PackGrade = 'F1' and ftype = '419'  then tometer  else FAULTDMG419 end as FAULTDMG419,
 case when PackGrade = 'F1' and ftype = '420'  then tometer  else FAULTDMG420 end as FAULTDMG420,
 case when PackGrade = 'F1' and ftype = '421'  then tometer  else FAULTDMG421 end as FAULTDMG421,
 case when PackGrade = 'F1' and ftype = '422'  then tometer  else FAULTDMG422 end as FAULTDMG422,
 case when PackGrade = 'F1' and ftype = '423'  then tometer  else FAULTDMG423 end as FAULTDMG423,
 case when PackGrade = 'F1' and ftype = '424'  then tometer  else FAULTDMG424 end as FAULTDMG424,
 case when PackGrade = 'F1' and ftype = '425'  then tometer  else FAULTDMG425 end as FAULTDMG425,
 case when PackGrade = 'F1' and ftype = '426'  then tometer  else FAULTDMG426 end as FAULTDMG426,
 case when PackGrade = 'F1' and ftype = '427'  then tometer  else FAULTDMG427 end as FAULTDMG427,
 case when PackGrade = 'F1' and ftype = '428'  then tometer  else FAULTDMG428 end as FAULTDMG428,
 case when PackGrade = 'F1' and ftype = '429'  then tometer  else FAULTDMG429 end as FAULTDMG429,
 case when PackGrade = 'F1' and ftype = '430'  then tometer  else FAULTDMG430 end as FAULTDMG430,
 case when PackGrade = 'F1' and ftype = '431'  then tometer  else FAULTDMG431 end as FAULTDMG431,
 case when PackGrade = 'F1' and ftype = '432'  then tometer  else FAULTDMG432 end as FAULTDMG432,
 case when PackGrade = 'F1' and ftype = '501'  then tometer  else FAULTDMG501 end as FAULTDMG501,
 case when PackGrade = 'F1' and ftype = '502'  then tometer  else FAULTDMG502 end as FAULTDMG502
    
}
