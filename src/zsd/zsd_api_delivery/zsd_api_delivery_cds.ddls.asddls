@AbapCatalog.sqlViewName: 'YAPIDEL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Api Delivery'
define view ZSD_API_DELIVERY_CDS as select from I_SalesDocumentItem
{
     
   key SalesDocument,
   key SalesDocumentItem,
       YY1_Cut1_SDI,
       YY1_Grade1_SDI,
       YY1_PDNumber_SDI,
       YY1_Plant_at_item_SDI,  
       YY1_Rolls_SDI,
       YY1_Shade_item_SDI 
}
