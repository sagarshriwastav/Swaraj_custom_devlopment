@AbapCatalog.sqlViewName: 'YPPMATFG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  MasterCard Mat Des FG F4'
define view ZPP_MAT_DES_FG1 as select from I_Product as a 
             inner join ZPC_HEADERMASTER_CDS as c on ( c.Zpqlycode = a.Product )
{
    key a.Product ,
        c.Zpno,
        substring(a.Product,1,1) as TYPE


}   
