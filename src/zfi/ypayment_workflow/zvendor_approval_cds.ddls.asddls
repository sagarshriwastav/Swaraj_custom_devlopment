@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS FOR VENDOR APROVAL'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZVENDOR_APPROVAL_CDS as select from yvendor_approve
{
    key accountingdocument as Accountingdocument,
    key companycode as Companycode,
    key fiscalyear   as  Fiscalyear ,
    journalentrydate as Journalentrydate,
    journalentrytype as Journalentrytype,
    duedays as Duedays,
    specialjournalindictor as Specialjournalindictor,
    amount as Amount,
    reftext as Reftext,
    invoicereference as Invoicereference,
    paymentterms as Paymentterms,
    request as Request,
        overduedays  as overduedays ,
    approvalchecking as Approvalchecking ,
     supplier         as Supplier,
     suppliername   as Suppliername
    
}






