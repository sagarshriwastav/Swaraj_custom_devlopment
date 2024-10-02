@AbapCatalog.sqlViewName: 'YGREAD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_GREADING_REPORT_CDD'
define view ZPP_GREADING_REPORT_CDD as select from ZPP_GREADING_REPORT_CD
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
  FRC ,  
    CD,
    SV,
    SL,
    fresh,
    SW,
    other,
    PD,
    QD,
    WARPSLUBBY,
    WEFTSLUBBY,
    CONTAMINATION,
    UNEVENWEFT,
    FAULTDMG105,
    FAULTDMG106,
    FAULTDMG107,
    FAULTDMG108,
    FAULTDMG109,
    FAULTDMG110,
    FAULTDMG111,
    FAULTDMG112,
    FAULTDMG113,
    FAULTDMG114,
    FAULTDMG115,
    FAULTDMG116,
    FAULTDMG117,
    FAULTDMG118,
    FAULTDMG119,
    FAULTDMG120,
    FAULTDMG121,
    FAULTDMG122,
    FAULTDMG123,
    FAULTDMG124,
    FAULTDMG125,
    FAULTDMG201,
    FAULTDMG202,
    FAULTDMG203,
    FAULTDMG204,
    FAULTDMG205,
    FAULTDMG206,
    FAULTDMG207,
    FAULTDMG208,
    FAULTDMG209,
    FAULTDMG210,
    FAULTDMG211,
    FAULTDMG212,
    FAULTDMG213,
    FAULTDMG214,
    FAULTDMG215,
    FAULTDMG216,
    FAULTDMG217,
    FAULTDMG218,
    FAULTDMG301,
    FAULTDMG302,
    FAULTDMG303,
    FAULTDMG304,
    FAULTDMG305,
    FAULTDMG306,
    FAULTDMG307,
    FAULTDMG308,
    FAULTDMG309,
    FAULTDMG310,
    FAULTDMG311,
    FAULTDMG312,
    FAULTDMG313,
    FAULTDMG314,
    FAULTDMG315,
    FAULTDMG316,
    FAULTDMG317,
    FAULTDMG318,
    FAULTDMG319,
    FAULTDMG320,
    FAULTDMG321,
    FAULTDMG322,
    FAULTDMG323,
    FAULTDMG324,
    FAULTDMG325,
    FAULTDMG326,
    FAULTDMG327,
    FAULTDMG328,
    FAULTDMG329,
    FAULTDMG330,
    FAULTDMG331,
    FAULTDMG332,
    FAULTDMG333,
    FAULTDMG334,
    FAULTDMG335,
    FAULTDMG336,
    FAULTDMG337,
    FAULTDMG338,
    FAULTDMG339,
    FAULTDMG340,
    FAULTDMG341,
    FAULTDMG401,
    FAULTDMG402,
    FAULTDMG403,
    FAULTDMG404,
    FAULTDMG405,
    FAULTDMG406,
    FAULTDMG407,
    FAULTDMG408,
    FAULTDMG409,
    FAULTDMG410,
    FAULTDMG411,
    FAULTDMG412,
    FAULTDMG413,
    FAULTDMG414,
    FAULTDMG415,
    FAULTDMG416,
    FAULTDMG417,
    FAULTDMG418,
    FAULTDMG419,
    FAULTDMG420,
    FAULTDMG421,
    FAULTDMG422,
    FAULTDMG423,
    FAULTDMG424,
    FAULTDMG425,
    FAULTDMG426,
    FAULTDMG427,
    FAULTDMG428,
    FAULTDMG429,
    FAULTDMG430,
    FAULTDMG431,
    FAULTDMG432,
    FAULTDMG501,
    FAULTDMG502,
  cast( cast( case when WARPSLUBBY is not null then WARPSLUBBY else 0 end as abap.dec( 13, 3 )) +
  cast( case when WEFTSLUBBY is not null then WEFTSLUBBY else 0 end as abap.dec( 13, 3 )) + 
    cast( case when CONTAMINATION is not null then CONTAMINATION else 0 end as abap.dec( 13, 3 )) +
    cast( case when UNEVENWEFT is not null then UNEVENWEFT else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG105 is not null then FAULTDMG105 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG106 is not null then FAULTDMG106 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG107 is not null then FAULTDMG107 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG108 is not null then FAULTDMG108 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG109 is not null then FAULTDMG109 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG110 is not null then FAULTDMG110 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG111 is not null then FAULTDMG111 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG112 is not null then FAULTDMG112 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG113 is not null then FAULTDMG113 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG114 is not null then FAULTDMG114 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG115 is not null then FAULTDMG115 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG116 is not null then FAULTDMG116 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG117 is not null then FAULTDMG117 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG118 is not null then FAULTDMG118 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG119 is not null then FAULTDMG119 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG120 is not null then FAULTDMG120 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG121 is not null then FAULTDMG121 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG122 is not null then FAULTDMG123 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG123 is not null then FAULTDMG123 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG124 is not null then FAULTDMG124 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG125 is not null then FAULTDMG125 else 0 end as abap.dec( 13, 3 )) + 
    
    cast( case when FAULTDMG201 is not null then FAULTDMG201 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG202 is not null then FAULTDMG202 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG203 is not null then FAULTDMG203 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG204 is not null then FAULTDMG204 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG205 is not null then FAULTDMG205 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG206 is not null then FAULTDMG206 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG207 is not null then FAULTDMG207 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG208 is not null then FAULTDMG208 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG209 is not null then FAULTDMG209 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG210 is not null then FAULTDMG210 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG211 is not null then FAULTDMG211 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG212 is not null then FAULTDMG212 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG213 is not null then FAULTDMG213 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG214 is not null then FAULTDMG214 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG215 is not null then FAULTDMG215 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG216 is not null then FAULTDMG216 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG217 is not null then FAULTDMG217 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG218 is not null then FAULTDMG218 else 0 end as abap.dec( 13, 3 )) + 
    
    cast( case when FAULTDMG301 is not null then FAULTDMG301 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG302 is not null then FAULTDMG302 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG303 is not null then FAULTDMG303 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG304 is not null then FAULTDMG304 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG305 is not null then FAULTDMG305 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG306 is not null then FAULTDMG306 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG307 is not null then FAULTDMG307 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG308 is not null then FAULTDMG308 else 0 end as abap.dec( 13, 3 )) +
    cast( case when FAULTDMG309 is not null then FAULTDMG309 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG310 is not null then FAULTDMG310 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG311 is not null then FAULTDMG311 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG312 is not null then FAULTDMG312 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG313 is not null then FAULTDMG313 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG314 is not null then FAULTDMG314 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG315 is not null then FAULTDMG315 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG316 is not null then FAULTDMG316 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG317 is not null then FAULTDMG317 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG318 is not null then FAULTDMG318 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG319 is not null then FAULTDMG319 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG320 is not null then FAULTDMG320 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG321 is not null then FAULTDMG321 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG322 is not null then FAULTDMG322 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG323 is not null then FAULTDMG323 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG324 is not null then FAULTDMG324 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG325 is not null then FAULTDMG325 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG326 is not null then FAULTDMG326 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG327 is not null then FAULTDMG327 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG328 is not null then FAULTDMG328 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG329 is not null then FAULTDMG329 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG330 is not null then FAULTDMG330 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG331 is not null then FAULTDMG331 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG332 is not null then FAULTDMG332 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG333 is not null then FAULTDMG333 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG334 is not null then FAULTDMG334 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG335 is not null then FAULTDMG335 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG336 is not null then FAULTDMG336 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG337 is not null then FAULTDMG337 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG338 is not null then FAULTDMG338 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG339 is not null then FAULTDMG339 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG340 is not null then FAULTDMG340 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG341 is not null then FAULTDMG341 else 0 end as abap.dec( 13, 3 )) + 
    
    cast( case when FAULTDMG401 is not null then FAULTDMG401 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG402 is not null then FAULTDMG402 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG403 is not null then FAULTDMG403 else 0 end as abap.dec( 13, 3 )) +     
    cast( case when FAULTDMG404 is not null then FAULTDMG404 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG405 is not null then FAULTDMG405 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG406 is not null then FAULTDMG406 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG407 is not null then FAULTDMG407 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG408 is not null then FAULTDMG408 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG409 is not null then FAULTDMG409 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG410 is not null then FAULTDMG410 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG411 is not null then FAULTDMG411 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG412 is not null then FAULTDMG412 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG413 is not null then FAULTDMG413 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG414 is not null then FAULTDMG414 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG415 is not null then FAULTDMG415 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG416 is not null then FAULTDMG416 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG417 is not null then FAULTDMG417 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG418 is not null then FAULTDMG418 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG419 is not null then FAULTDMG419 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG420 is not null then FAULTDMG420 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG421 is not null then FAULTDMG421 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG422 is not null then FAULTDMG422 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG423 is not null then FAULTDMG423 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG424 is not null then FAULTDMG424 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG425 is not null then FAULTDMG425 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG426 is not null then FAULTDMG426 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG427 is not null then FAULTDMG427 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG428 is not null then FAULTDMG428 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG429 is not null then FAULTDMG429 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG430 is not null then FAULTDMG430 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG431 is not null then FAULTDMG431 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG432 is not null then FAULTDMG432 else 0 end as abap.dec( 13, 3 )) + 
    
    cast( case when FAULTDMG501 is not null then FAULTDMG501 else 0 end as abap.dec( 13, 3 )) + 
    cast( case when FAULTDMG502 is not null then FAULTDMG502 else 0 end as abap.dec( 13, 3 )) as abap.dec( 13, 3 ) )  
    as TotalQuantity  
    
}
group by Plant,
        PostingDate,
        MaterialNumber,
        Batch,
        RecBatch,
        MatDoc,
        MatDocitem,
        MatDocyear,
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
    FRC,
    CD,
    SV,
    SL,
    fresh,
    SW,
    other,
    PD,
    QD,
    WARPSLUBBY,
    WEFTSLUBBY,
    CONTAMINATION,
    UNEVENWEFT,
    FAULTDMG105,
    FAULTDMG106,
    FAULTDMG107,
    FAULTDMG108,
    FAULTDMG109,
    FAULTDMG110,
    FAULTDMG111,
    FAULTDMG112,
    FAULTDMG113,
    FAULTDMG114,
    FAULTDMG115,
    FAULTDMG116,
    FAULTDMG117,
    FAULTDMG118,
    FAULTDMG119,
    FAULTDMG120,
    FAULTDMG121,
    FAULTDMG122,
    FAULTDMG123,
    FAULTDMG124,
    FAULTDMG125,
    FAULTDMG201,
    FAULTDMG202,
    FAULTDMG203,
    FAULTDMG204,
    FAULTDMG205,
    FAULTDMG206,
    FAULTDMG207,
    FAULTDMG208,
    FAULTDMG209,
    FAULTDMG210,
    FAULTDMG211,
    FAULTDMG212,
    FAULTDMG213,
    FAULTDMG214,
    FAULTDMG215,
    FAULTDMG216,
    FAULTDMG217,
    FAULTDMG218,
    FAULTDMG301,
    FAULTDMG302,
    FAULTDMG303,
    FAULTDMG304,
    FAULTDMG305,
    FAULTDMG306,
    FAULTDMG307,
    FAULTDMG308,
    FAULTDMG309,
    FAULTDMG310,
    FAULTDMG311,
    FAULTDMG312,
    FAULTDMG313,
    FAULTDMG314,
    FAULTDMG315,
    FAULTDMG316,
    FAULTDMG317,
    FAULTDMG318,
    FAULTDMG319,
    FAULTDMG320,
    FAULTDMG321,
    FAULTDMG322,
    FAULTDMG323,
    FAULTDMG324,
    FAULTDMG325,
    FAULTDMG326,
    FAULTDMG327,
    FAULTDMG328,
    FAULTDMG329,
    FAULTDMG330,
    FAULTDMG331,
    FAULTDMG332,
    FAULTDMG333,
    FAULTDMG334,
    FAULTDMG335,
    FAULTDMG336,
    FAULTDMG337,
    FAULTDMG338,
    FAULTDMG339,
    FAULTDMG340,
    FAULTDMG341,
    FAULTDMG401,
    FAULTDMG402,
    FAULTDMG403,
    FAULTDMG404,
    FAULTDMG405,
    FAULTDMG406,
    FAULTDMG407,
    FAULTDMG408,
    FAULTDMG409,
    FAULTDMG410,
    FAULTDMG411,
    FAULTDMG412,
    FAULTDMG413,
    FAULTDMG414,
    FAULTDMG415,
    FAULTDMG416,
    FAULTDMG417,
    FAULTDMG418,
    FAULTDMG419,
    FAULTDMG420,
    FAULTDMG421,
    FAULTDMG422,
    FAULTDMG423,
    FAULTDMG424,
    FAULTDMG425,
    FAULTDMG426,
    FAULTDMG427,
    FAULTDMG428,
    FAULTDMG429,
    FAULTDMG430,
    FAULTDMG431,
    FAULTDMG432,
    FAULTDMG501,
    
    FAULTDMG502
