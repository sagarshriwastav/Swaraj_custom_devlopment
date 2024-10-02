@AbapCatalog.sqlViewName: 'YROLLLENDTH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZDEPARTMENT_ROLL_CDS'
define view ZDEPARTMENT_ROLL_CDS as select from ZPACK_HEAD_REP_CDS
{
    key PackGrade ,
        PostingDate,
    sum( RollLength ) as ROLLSUM
    
}
group by
PackGrade,
PostingDate
