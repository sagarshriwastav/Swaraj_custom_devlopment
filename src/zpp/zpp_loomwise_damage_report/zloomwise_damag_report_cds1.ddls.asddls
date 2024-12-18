@AbapCatalog.sqlViewName: 'YLOOMWISE_CDS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'loomwise damage report'
define view ZLOOMWISE_DAMAG_REPORT_CDS1 as select from ZLOOMWISE_DAMAGE_PACKGRADE as a
          left outer join ZPP_LOOMWISE_DAMAGE_REP as b on ( b.PostingDate = a.PostingDate 
                                                            and b.Loomno = a.Loomno and b.SortNo = a.SortNo
                                                            and  b.dyesetno = a.dyesetno )                                            
            
{
 key a.dyesetno, 
     b.dyesetno as DyesetNo1,
     b.Loomno,
     b.Party,
     b.SortNo,
     b.PostingDate,
     b.CD,
     b.SV,
     b.SL,
     b.fresh,
     b.SW,
     b.other,
     b.PD,
     b.QD,
     a.MaterialBaseUnit,
     a.FRC,
    a.WARPSLUBBY,
    a.WEFTSLUBBY,
    a.CONTAMINATION,
    a.UNEVENWEFT,
    a.FAULTDMG105,
    a.FAULTDMG106,
    a.FAULTDMG107,
    a.FAULTDMG108,
    a.FAULTDMG109,
    a.FAULTDMG110,
    a.FAULTDMG111,
    a.FAULTDMG112,
    a.FAULTDMG113,
    a.FAULTDMG114,
    a.FAULTDMG115,
    a.FAULTDMG116,
    a.FAULTDMG117,
    a.FAULTDMG118,
    a.FAULTDMG119,
    a.FAULTDMG120,
    a.FAULTDMG121,
    a.FAULTDMG122,
    a.FAULTDMG123,
    a.FAULTDMG124,
    a.FAULTDMG125,
    a.FAULTDMG201,
    a.FAULTDMG202,
    a.FAULTDMG203,
    a.FAULTDMG204,
    a.FAULTDMG205,
    a.FAULTDMG206,
    a.FAULTDMG207,
    a.FAULTDMG208,
    a.FAULTDMG209,
    a.FAULTDMG210,
    a.FAULTDMG211,
    a.FAULTDMG212,
    a.FAULTDMG213,
    a.FAULTDMG214,
    a.FAULTDMG215,
    a.FAULTDMG216,
    a.FAULTDMG217,
    a.FAULTDMG218,
    a.FAULTDMG301,
    a.FAULTDMG302,
    a.FAULTDMG303,
    a.FAULTDMG304,
    a.FAULTDMG305,
    a.FAULTDMG306,
    a.FAULTDMG307,
    a.FAULTDMG308,
    a.FAULTDMG309,
    a.FAULTDMG310,
    a.FAULTDMG311,
    a.FAULTDMG312,
    a.FAULTDMG313,
    a.FAULTDMG314,
    a.FAULTDMG315,
    a.FAULTDMG316,
    a.FAULTDMG317,
    a.FAULTDMG318,
    a.FAULTDMG319,
    a.FAULTDMG320,
    a.FAULTDMG321,
    a.FAULTDMG322,
    a.FAULTDMG323,
    a.FAULTDMG324,
    a.FAULTDMG325,
    a.FAULTDMG326,
    a.FAULTDMG327,
    a.FAULTDMG328,
    a.FAULTDMG329,
    a.FAULTDMG330,
    a.FAULTDMG331,
    a.FAULTDMG332,
    a.FAULTDMG333,
    a.FAULTDMG334,
    a.FAULTDMG335,
    a.FAULTDMG336,
    a.FAULTDMG337,
    a.FAULTDMG338,
    a.FAULTDMG339,
    a.FAULTDMG340,
    a.FAULTDMG341,
    a.FAULTDMG401,
    a.FAULTDMG402,
    a.FAULTDMG403,
    a.FAULTDMG404,
    a.FAULTDMG405,
    a.FAULTDMG406,
    a.FAULTDMG407,
    a.FAULTDMG408,
    a.FAULTDMG409,
    a.FAULTDMG410,
    a.FAULTDMG411,
    a.FAULTDMG412,
    a.FAULTDMG413,
    a.FAULTDMG414,
    a.FAULTDMG415,
    a.FAULTDMG416,
    a.FAULTDMG417,
    a.FAULTDMG418,
    a.FAULTDMG419,
    a.FAULTDMG420,
    a.FAULTDMG421,
    a.FAULTDMG422,
    a.FAULTDMG423,
    a.FAULTDMG424,
    a.FAULTDMG425,
    a.FAULTDMG426,
    a.FAULTDMG427,
    a.FAULTDMG428,
    a.FAULTDMG429,
    a.FAULTDMG430,
    a.FAULTDMG431,
    a.FAULTDMG432,
    a.FAULTDMG501,
    a.FAULTDMG502
    
   
    
    
}
//group by a.dyesetno,
//    a.Loomno,
//    a.SortNo,
//    a.Party,
//    a.PostingDate,
//    a.MaterialBaseUnit,
//    a.FRC,
//    a.CD,
//    a.SV,
//    a.SL,
//    a.fresh,
//    a.SW,
//    a.other,
//    a.PD,
//    a.QD,
//    a.WARPSLUBBY,
//    a.WEFTSLUBBY,
//    a.CONTAMINATION,
//    a.UNEVENWEFT,
//    a.FAULTDMG105,
//    a.FAULTDMG106,
//    a.FAULTDMG107,
//    a.FAULTDMG108,
//    a.FAULTDMG109,
//    a.FAULTDMG110,
//    a.FAULTDMG111,
//    a.FAULTDMG112,
//    a.FAULTDMG113,
//    a.FAULTDMG114,
//    a.FAULTDMG115,
//    a.FAULTDMG116,
//    a.FAULTDMG117,
//    a.FAULTDMG118,
//    a.FAULTDMG119,
//    a.FAULTDMG120,
//    a.FAULTDMG121,
//    a.FAULTDMG122,
//    a.FAULTDMG123,
//    a.FAULTDMG124,
//    a.FAULTDMG125,
//    a.FAULTDMG201,
//    a.FAULTDMG202,
//    a.FAULTDMG203,
//    a.FAULTDMG204,
//    a.FAULTDMG205,
//    a.FAULTDMG206,
//    a.FAULTDMG207,
//    a.FAULTDMG208,
//    a.FAULTDMG209,
//    a.FAULTDMG210,
//    a.FAULTDMG211,
//    a.FAULTDMG212,
//    a.FAULTDMG213,
//    a.FAULTDMG214,
//    a.FAULTDMG215,
//    a.FAULTDMG216,
//    a.FAULTDMG217,
//    a.FAULTDMG218,
//    a.FAULTDMG301,
//    a.FAULTDMG302,
//    a.FAULTDMG303,
//    a.FAULTDMG304,
//    a.FAULTDMG305,
//    a.FAULTDMG306,
//    a.FAULTDMG307,
//    a.FAULTDMG308,
//    a.FAULTDMG309,
//    a.FAULTDMG310,
//    a.FAULTDMG311,
//    a.FAULTDMG312,
//    a.FAULTDMG313,
//    a.FAULTDMG314,
//    a.FAULTDMG315,
//    a.FAULTDMG316,
//    a.FAULTDMG317,
//    a.FAULTDMG318,
//    a.FAULTDMG319,
//    a.FAULTDMG320,
//    a.FAULTDMG321,
//    a.FAULTDMG322,
//    a.FAULTDMG323,
//    a.FAULTDMG324,
//    a.FAULTDMG325,
//    a.FAULTDMG326,
//    a.FAULTDMG327,
//    a.FAULTDMG328,
//    a.FAULTDMG329,
//    a.FAULTDMG330,
//    a.FAULTDMG331,
//    a.FAULTDMG332,
//    a.FAULTDMG333,
//    a.FAULTDMG334,
//    a.FAULTDMG335,
//    a.FAULTDMG336,
//    a.FAULTDMG337,
//    a.FAULTDMG338,
//    a.FAULTDMG339,
//    a.FAULTDMG340,
//    a.FAULTDMG341,
//    a.FAULTDMG401,
//    a.FAULTDMG402,
//    a.FAULTDMG403,
//    a.FAULTDMG404,
//    a.FAULTDMG405,
//    a.FAULTDMG406,
//    a.FAULTDMG407,
//    a.FAULTDMG408,
//    a.FAULTDMG409,
//    a.FAULTDMG410,
//    a.FAULTDMG411,
//    a.FAULTDMG412,
//    a.FAULTDMG413,
//    a.FAULTDMG414,
//    a.FAULTDMG415,
//    a.FAULTDMG416,
//    a.FAULTDMG417,
//    a.FAULTDMG418,
//    a.FAULTDMG419,
//    a.FAULTDMG420,
//    a.FAULTDMG421,
//    a.FAULTDMG422,
//    a.FAULTDMG423,
//    a.FAULTDMG424,
//    a.FAULTDMG425,
//    a.FAULTDMG426,
//    a.FAULTDMG427,
//    a.FAULTDMG428,
//    a.FAULTDMG429,
//    a.FAULTDMG430,
//    a.FAULTDMG431,
//    a.FAULTDMG432,
//    a.FAULTDMG501,
//    a.FAULTDMG502
