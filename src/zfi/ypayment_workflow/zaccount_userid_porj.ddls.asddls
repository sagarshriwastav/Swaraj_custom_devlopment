@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Account Group User ID Projection View'
define root view entity zaccount_userid_porj
  provider contract transactional_query
  as projection on ZACCOUNT_USER_CDS

{
  key Userid,
  key Accountinggrp

}

