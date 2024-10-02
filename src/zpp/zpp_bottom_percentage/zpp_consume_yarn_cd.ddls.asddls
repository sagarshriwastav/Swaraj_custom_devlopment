@AbapCatalog.sqlViewName: 'YCONSUMEYARNSUM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_CONSUME_YARN_CDS'
define view ZPP_CONSUME_YARN_CD as select from ZPP_CONSUME_YARN_CDS
{
    Batch,
    BaseUnit,
    zptotends,
    ConsumeYarn,
    ConsumeYarn1,
    ConsumeYarn2,
  case when ConsumeYarn1 <> 0 then ( cast(ConsumeYarn as abap.fltp )
                 / ( cast( ConsumeYarn1  as abap.fltp )) )  else 0 end as as1,
  case when ConsumeYarn1 <> 0 then ( cast(ConsumeYarn2 as abap.fltp )
                 / ( cast( ConsumeYarn1  as abap.fltp )) )   else 0 end  as as2             
                  
  
}
