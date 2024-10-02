@AbapCatalog.sqlViewName: 'YWARPAVGBPM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Warping Entry Avgbpm'
define view ZPP_WARPING_AVGBPM as select from ZPP_WARPING_REP1
{
    key ZfsetNo,
        avgbpmm,
        beamin1creel ,
        supplierconweight ,
        Zcount,
        Material
} 

group by 
       ZfsetNo,
        avgbpmm,
        beamin1creel ,
        supplierconweight ,
        Zcount,
        Material
