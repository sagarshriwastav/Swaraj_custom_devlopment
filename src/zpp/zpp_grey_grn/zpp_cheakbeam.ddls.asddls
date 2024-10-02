@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Grey Grn Check Beam'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_CHEAKBEAM as select from zpp_grey_grn_tab
{
     key prodorder ,
         recbatch  as CheckPiece
}    
   where recbatch <> ''
    group by  
         prodorder ,
         recbatch
