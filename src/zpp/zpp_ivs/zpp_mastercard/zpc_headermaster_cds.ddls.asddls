//@AbapCatalog.viewEnhancementCategory: [#NONE]
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'HEADERMASTER CARD'
//@Metadata.ignorePropagatedAnnotations: true
//@ObjectModel.usageType:{
//    serviceQuality: #X,
//    sizeCategory: #S,
//    dataClass: #MIXED
//}
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '##GENERATED zgate_repoj'

define root view entity ZPC_HEADERMASTER_CDS 
   as select from zpc_headermaster
{
    key zpno as Zpno,
    zpdate as Zpdate,
    zpdevno as Zpdevno,
    zpunit as Zpunit,
    ploom as Ploom,
    zpqlycode as Zpqlycode,
    zpreed1 as Zpreed1,
    zppicks as Zppicks,
    zpreedspace as Zpreedspace,
    zpbrand as Zpbrand,
    zptotends as Zptotends,
    extraends ,
    zpbeamlgh1 as Zpbeamlgh1,
    zpbeamlgh2 as Zpbeamlgh2,
    zpepi as Zpepi,
    zpdytype as Zpdytype,
    zpweavetype as Zpweavetype,
    zpfinwdth as Zpfinwdth,
    zppriority as Zppriority,
    zpptyname as Zpptyname,
    zpwtpermtr as Zpwtpermtr,
    zwawtpermtr as zwawtpermtr,
    zwewtpermtr  as zwewtpermtr,
    ztowtpermtr as  ztowtpermtr,
    remark  as remark,
    zpshldbewt as Zpshldbewt,
    zpstatus as Zpstatus,
    zpremarks as Zpremarks,
    zpusername as Zpusername,
    zptime as Zptime,
    dpr as Dpr,
    epr as Epr,
    epd as Epd,
    ppr as Ppr,
    stends as Stends,
    stdents as Stdents,
    bodyends as Bodyends,
    warptends as Warptends,
    wefttends as Wefttends,
    stepr as Stepr,
    swpmtr as Swpmtr,
    wstepr as Wstepr,
    wswpmtr as Wswpmtr,
    totmono as Totmono,
    selvedgewpmtr as Selvedgewpmtr,
    stends1 as Stends1,
    crimp as Crimp,
    zunit as Zunit,
    @Semantics.quantity.unitOfMeasure : 'ZUNIT'
    zanlyswt as Zanlyswt,
    zselvtyp as Zselvtyp,
    zmonotyp as Zmonotyp,
    pdvlp as Pdvlp,
    psnm as Psnm,
    propac as Propac,
    plength as Plength,
    siqlty as Siqlty,
    changed_on as ChangedOn,
    changed_by as ChangedBy,
    zvbeln as ZVbeln,
    zposnr as ZPosnr,
    zdent as Zdent,
    blend as Blend,
    release_mcard as ReleaseMcard,
    release_date as ReleaseDate,
    release_by as ReleaseBy,
    sales_width as SalesWidth,
    old_qlty as OldQlty,
    zsub_weave as ZsubWeave,
    dyesort as DyeSort,
    pdnumber as pdnumber,
    supplier,
    pvends,
    fabricends,
    weavingreamrk,
    selvedgeends,
     @Semantics.user.createdBy: true
      created_by                as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at                as CreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      last_changed_by           as LastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      last_changed_at           as LastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      local_last_changed_at     as LocalLastChangedAt
}
