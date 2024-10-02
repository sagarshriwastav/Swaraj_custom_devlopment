@AbapCatalog.sqlViewName: 'YPPDYEING'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Dyeing Sticker'
define view ZPP_DYEING_STICKER as select from ZPP_DYEINGR_CDS
{
    key Material
       
}  
  group by 
        Material
