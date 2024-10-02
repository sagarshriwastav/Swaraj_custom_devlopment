@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS For Trolly Transfer Screen For OptName'
define root view entity ZPP_OPTNAME_CDS1 as select from zpp_optname

{
     key sno as Sno,
     key operatorid as Operatorid,
     operatorname as Operatorname,
     type as Type,
     inactive as Inactive
}
