@AbapCatalog.sqlViewName: 'YSDDOMEC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Domestic Packing List Print'
define view ZSD_DOMESTIC_PRINT as select from I_DeliveryDocument as a 
left outer join I_DeliveryDocumentItem as b on ( b.DeliveryDocument = a.DeliveryDocument )
{
    key a.DeliveryDocument 
 
 } 
    where b.DistributionChannel = '01'
   group by  
         a.DeliveryDocument 
