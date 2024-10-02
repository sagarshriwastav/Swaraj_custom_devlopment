@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'AGENT TAB'
define root view entity ZAGENT_TAB_cds
  as select from zagent_tab as a 
  left outer join I_JournalEntry as b on ( b.AccountingDocument = a.vandor_inv and b.CompanyCode = a.companycode 
  and b.FiscalYear = a.fiscalyear )

{
  key a.agentcode           as Agentcode,
  key a.invoicenumber       as Invoicenumber,
      a.agentname           as Agentname,
      a.billingdocumentdate as Billingdocumentdate,
      a.partycode           as Partycode,
      a.partyname           as Partyname,
      a.netamount           as Netamount,
      a.taxes               as Taxes,
      a.agentcommpre        as Agentcommpre,
      a.mamount             as Mamount,
      a.mtotalamunt         as Mtotalamunt,
      a.incomminginvno      as Incomminginvno,
    //  case when B.IsReversal = 'X' and b.IsReversed = 'X' then ' ' else 
      a.approve             as Approve,
      a.reject              as Reject,
      a.bill_qty            as Bill_qty,
      a.vandor_inv          as Vandor_inv,
      a.return_flag         as Return_flag

}
