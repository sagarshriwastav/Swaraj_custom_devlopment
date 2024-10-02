@AbapCatalog.sqlViewName: 'YROLLSUM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZDEPARTMENT_ROLL_SUM_CDS'
define view ZDEPARTMENT_ROLL_SUM_CDS as select from ZDEPARTMENT_ROLL_CDS
{
    
    PostingDate,
    sum(ROLLSUM) as ROLLSUM
    
} group by PostingDate
