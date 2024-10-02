@AbapCatalog.sqlViewName: 'YFFSTOCK3'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Finish Fabric Stock Report'
define view ZPP_FF_STOCK_CDS3 as select from I_MfgOrderConfirmation as a 
         inner join I_MaterialDocumentItem_2 as b on ( b.MaterialDocument = a.MaterialDocument 
                                                  and b.MaterialDocumentYear = a.MaterialDocumentYear )
       inner join ymseg4 as c on  ( c.MaterialDocument = b.MaterialDocument 
                                                  and c.MaterialDocumentYear = b.MaterialDocumentYear 
                                                  and c.MaterialDocumentItem = b.MaterialDocumentItem )                                          
  
{
    key a.MaterialDocument,
        a.YY1_TrollyNumber_CFM,
        b.Batch
    
} where  a.YY1_TrollyNumber_CFM is not initial and b.Material like 'FF%'
   group by 
        a.MaterialDocument,
        a.YY1_TrollyNumber_CFM, 
        b.Batch 
