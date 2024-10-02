@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ROLL_NO_CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType: {
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_ROLL_NO_CDS as 
  select from zsubcon_item as A
// left outer join I_JournalEntry as C on C.PostingDate = A.date1
{
  key A.rollno,
      A.party,
      left(A.date1, 4) as Last4Date , 
     substring(A.date1,5,2) as MONTH4  
      // Getting the last 4 characters of date1
//      case when C.FiscalYear is null then '2023' else C.FiscalYear end as FISCALYEAR
}
