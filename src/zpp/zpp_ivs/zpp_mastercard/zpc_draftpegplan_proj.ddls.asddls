@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Draftpegpllan Proj Cds For Master Card Screen'
define root view entity ZPC_DRAFTPEGPLAN_PROJ 
  provider contract transactional_query
  as projection on  ZPC_DRAFTPEGPLAN_CDS
{
    key Zpno as Zpno,
    key Pmgroup as Pmgroup,
    key Ptype as Ptype,
    key Zpmsno as Zpmsno,
    Pmdesc as Pmdesc,
    Mul as Mul,
    Repeats as Repeats,
 //   Mark as Mark,
 //   Repeats1 as Repeats1,
 //  Mul1 as Mul1,
    Remark as Remark
}
