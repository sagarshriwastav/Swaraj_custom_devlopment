@AbapCatalog.sqlViewName: 'YBOTTOMC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_CONSUME_YARN_CD'
define view ZPP_CONSUME_YARN_C as select from ZPP_CONSUME_YARN_CD
{
    Batch,
    BaseUnit,
    zptotends,
    ConsumeYarn,
    ConsumeYarn1,
    ConsumeYarn2,
    fltp_to_dec( as1 as abap.dec(10,3) ) as dec1_10_0,
    fltp_to_dec( as2 as abap.dec(10,3) ) as dec1_10_01
    
    
} 
