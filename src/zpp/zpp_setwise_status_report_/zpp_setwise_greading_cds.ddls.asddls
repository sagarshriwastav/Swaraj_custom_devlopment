@AbapCatalog.sqlViewName: 'YSETGREAD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_SETWISE_GREADING_CDS'
define view ZPP_SETWISE_GREADING_CDS as select from ZPACK_HEAD_REP_CDS
{
    key MaterialNumber as Sortno,
        PostingDate,
        Setno,
        PackGrade,
        RollLength,
        Dyeingsort
}
