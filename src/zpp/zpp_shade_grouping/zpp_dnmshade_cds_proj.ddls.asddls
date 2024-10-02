@EndUserText.label: 'Denim Shade CDS Projection'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZPP_DNMSHADE_CDS_PROJ as projection on ZPP_DNMSHADE_CDS
{
    key Plant,
    key Material,
    key Rollno,
    key Follono,
    Shgrp,
    Materialdesc
  
}
