@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Auto BOM Through Master Card'

define root view  entity ZAUTO_BOM_V2 as select from zpc_warppattern_cds as a
inner join ZPC_HEADERMASTER_CDS as b on (b.Zpno = a.Zpno)


{
  key a.Zpno,
  b.DyeSort,
  b.Zpqlycode,
  a.Pattern,
  a.Grp,
  a.Zpmtype,
  a.Zpmyqlty,
  a.Wpmtr
    
}  where a.Zpmyqlty != ' '
 