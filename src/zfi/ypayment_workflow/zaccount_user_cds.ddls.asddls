@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Account Group User ID CDS'
define root view entity ZACCOUNT_USER_CDS
 as select from zaccount_userid
{
  key userid        as Userid,
  key accountinggrp as Accountinggrp
}
