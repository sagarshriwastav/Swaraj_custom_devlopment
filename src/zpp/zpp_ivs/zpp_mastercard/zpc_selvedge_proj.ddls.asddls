@EndUserText.label: 'Selevedge Proj Cds For Master Card Screen'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZPC_SELVEDGE_PROJ  
  provider contract transactional_query
   as projection on ZPC_SELVEDGE_CDS
{
    key Zpno,
    key Zpmsno,
  //  key Zsalign,
    Zpmtype,
    Zpmcountsys,
    Rescnt,
    Zpmyqlty,
    Maktx,
    Shaft,
    Dent,
    Dent1,
    Ends,
    Repeats,
    Mul,
    Totalends,
    Pmdesc,
    Shades,
    Mark,
    Wpmtr,
    Icon,
    Center
}
