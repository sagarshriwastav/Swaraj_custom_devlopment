@AbapCatalog.sqlViewName: 'YPARTYWISFIN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Party Wise Fault Dmange Mtr'
define view ZPP_PARTY_WISE_DMG_FIN 
 with parameters  
    p_fromdate : abap.dats,
    p_todate   : abap.dats
as select from ZPP_PARTY_WISE_DMG_CDS3( p_fromdate : $parameters.p_fromdate , p_todate : $parameters.p_todate )
{
    key Party,
    SortNo,
    Setno,
    Zunit,
    ZunitPercent,
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
    TotalQuantity
} 

  
