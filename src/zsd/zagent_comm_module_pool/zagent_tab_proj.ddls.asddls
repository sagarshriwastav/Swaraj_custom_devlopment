@EndUserText.label: 'AGENT TAB PROJ'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZAGENT_TAB_PROJ as projection on ZAGENT_TAB_cds
{
    key Agentcode,
    key Invoicenumber,
    Agentname,
    Billingdocumentdate,
    Partycode,
    Partyname,
    Netamount,
    Taxes,
    Agentcommpre,
    Mamount,
    Mtotalamunt,
    Incomminginvno,
    Approve,
    Reject,
    Bill_qty,  
    Vandor_inv,
    Return_flag
}
where Vandor_inv is initial
