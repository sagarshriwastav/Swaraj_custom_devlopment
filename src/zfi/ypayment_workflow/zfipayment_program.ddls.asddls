@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'FIPAYMENT PROGRAM'
define root view entity ZFIPAYMENT_PROGRAM
  as select from zpayment_program
 
{
  key   accountingdocument     as Accountingdocument,
  key   finyear                as Finyear,
  key   companycode            as Companycode,
        tokennum               as Tokennum,
        accgroup               as Accgroup,
        clearingjournalentry   as Clearingjournalentry,
        transactioncurrency    as Transactioncurrency,
        postingdate            as Postingdate,
        supplier               as Supplier,
        suppliername           as Suppliername,
        paymentterms           as Paymentterms,
        netduedate             as Netduedate,
        reffdate               as Reffdate,
        reffdoc                as Reffdoc,
        additionalcurrency1    as Additionalcurrency1,
        assignmentreference    as Assignmentreference,
        glbalance              as Glbalance,
        notdueamonnt           as Notdueamonnt,
        pandingamount          as Pandingamount,
        glbalanceafteradv      as Glbalanceafteradv,
        gstinput               as Gstinput,
        partialpayment         as Partialpayment,
        request                as Request,
        approve                as Approve,
        hold                   as Hold,
        remark                 as Remark,
        journalentrydate       as Journalentrydate,
        duedays                as Duedays,
        specialjournalindictor as Specialjournalindictor,
        amount                 as Amount,
        reftext                as Reftext,
        tdsamt                 as Tdsamt,
        profitcenter           as Profitcenter,
        request1               as Request1,
        zero30amt              as Zero30amt,
        thirty60amt            as Thirty60amt,
        sixty90amt             as Sixty90amt,
        above90                as Above90,
        partialpayment2        as Partialpayment2,
        journalentrytype       as JournalEntryType,
        invoicereference  as Invoicereference ,
          approvalchecking as Approvalchecking 


}
