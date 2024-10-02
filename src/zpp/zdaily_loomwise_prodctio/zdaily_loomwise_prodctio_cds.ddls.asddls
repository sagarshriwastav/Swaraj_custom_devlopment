@AbapCatalog.sqlViewName: 'YDAILYLOOOMWISE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZDAILY_LOOMWISE_PRODCTIO'
define view ZDAILY_LOOMWISE_PRODCTIO_CDS as select from ZPP_BCO_CDS
{
    key Loomno,
    key Shortno,
        Zdate,
        Sizsetno as SetCodeNo,
        Reedspace,
        Pickonfabric as LoomPick,
        Afst,
        Awst,
        Acshifta as MTR1,
        Aeffper as AEFF,
        Bfst,
        Bwst,
        Acshiftb as MTR2,
        Beffper as BEFF,
        beamgettingdate as Getting,
        knotting,         
        reknotting,       
        getting as getting1
        
}
