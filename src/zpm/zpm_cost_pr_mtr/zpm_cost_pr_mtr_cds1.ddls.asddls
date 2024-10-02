@AbapCatalog.sqlViewName: 'YPMCOSTMTR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Cost Pr Mtr Report'
define view ZPM_COST_PR_MTR_CDS1 as select from I_MaterialDocumentItem_2 as a 
                          inner join ymseg4   as B on ( B.MaterialDocument = a.MaterialDocument 
                                                  and B.MaterialDocumentItem = a.MaterialDocumentItem 
                                                  and B.MaterialDocumentYear = a.MaterialDocumentYear )
                 
{
  
   key a.Plant,
   key a.PostingDate,
       a.MaterialBaseUnit as MaterialBaseUnit1,
      sum( a.QuantityInEntryUnit  ) as OrderQTY
}    
where a.Material like 'FFO%' and a.OrderID <> ''
       group by 
       
        a.Plant,
        a.PostingDate,
        a.MaterialBaseUnit
