@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZFIPAYMENT PROGRAMs Projection View'
define root view entity ZFIPAYMENT 
provider contract transactional_query
  as projection on ZFIPAYMENT_PROGRAM

{
 key  Accountingdocument,
  key  Finyear,
      key Companycode,
       Tokennum,
       Clearingjournalentry,
       Accgroup,
       Reffdate, 
       Reffdoc,
       Glbalance,
       Notdueamonnt,
       Pandingamount,
       Glbalanceafteradv,
       Gstinput,
       Transactioncurrency,
       Postingdate,
       Supplier,
       Suppliername,
       Paymentterms,
       Netduedate,
       Additionalcurrency1,
       Assignmentreference,
       Request,
       Approve,
       Hold,
       Remark,
       Partialpayment   
  
}
