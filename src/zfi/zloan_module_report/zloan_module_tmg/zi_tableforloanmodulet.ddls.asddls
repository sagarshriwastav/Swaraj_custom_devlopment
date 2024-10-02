@EndUserText.label: 'Table For Loan Module Tmg'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZI_TableForLoanModuleT
  as select from ZLOAN_MODULE_TAB
  association to parent ZI_TableForLoanModuleT_S as _TableForLoanModuAll on $projection.SingletonID = _TableForLoanModuAll.SingletonID
{
  key COMPANYCODE as Companycode,
  key GLCODE as Glcode,
  LOANNOID as Loannoid,
  SENTIONDATE as Sentiondate,
  TOTALLOANAMOUNT as Totalloanamount,
  MORATORIUMPERIOD as Moratoriumperiod,
  NUMBEROFINSTALMENTS as Numberofinstalments,
  INTERESTRATE as Interestrate,
  REPAYMENTFREQUENCY as Repaymentfrequency,
  INSTALLMENTAMOUNT as Installmentamount,
  @Consumption.hidden: true
  1 as SingletonID,
  _TableForLoanModuAll
  
}
