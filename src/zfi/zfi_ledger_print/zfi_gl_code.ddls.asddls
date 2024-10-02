@AbapCatalog.sqlViewName: 'YGLCODE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For GL Code'
define view ZFI_GL_CODE as select from I_GLAccount as a 
   left outer join I_GlAccountTextInCompanycode as b on (b.GLAccount = a.GLAccount and b.Language = 'E' )
{
    key a.GLAccount,
        b.GLAccountName

}  
  group by 
      a.GLAccount,
      b.GLAccountName
