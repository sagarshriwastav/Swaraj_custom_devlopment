@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Token Number Wise Total'
define root view entity Ztokentot
  as select from ZFIPAYMENT_PROGRAM as a
{
  key a.Tokennum,
      a.Companycode,
      a.Accountingdocument,
      a.Finyear,
      a.Accgroup,
      a.Approve,
      sum(a.Pandingamount) as TotPandingamt

}
group by
  a.Tokennum,
  a.Companycode,
  a.Accgroup,
  a.Accountingdocument,
  a.Finyear,
  a.Approve
