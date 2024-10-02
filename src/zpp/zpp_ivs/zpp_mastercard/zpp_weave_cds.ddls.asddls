@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Weave Code & Des'
define root view entity ZPP_WEAVE_CDS as select from zweave
{
    key weavecode as Weavecode,
        weavedes as Weavedes
 
}
