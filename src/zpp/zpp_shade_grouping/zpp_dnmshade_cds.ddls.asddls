@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Denim Shade CDS'
define root view entity ZPP_DNMSHADE_CDS as select from zpp_dnmshade
{
    key plant as Plant,
    key material as Material,
    key rollno as Rollno,
    key follono as Follono,
    shgrp as Shgrp,
    materialdesc as Materialdesc,
    unshade,
    dmreason,
    devationtype,
    creationdate,
    creationtime
    
}
