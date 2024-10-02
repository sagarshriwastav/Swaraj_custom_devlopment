@AbapCatalog.sqlViewName: 'YSELVEDGE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Selvedge Program'
define view ZPP_SELVEDGE_CDS as select from I_ManufacturingOrderItem as a 
             inner join I_ProductDescription as b on ( b.Product = a.Material and b.Language = 'E' ) 
 
{ 
   key a.Batch,
   key a.Material,
   key a.ProductionPlant,
       a.ManufacturingOrder,
       b.ProductDescription
}    
  group by  
     a.Batch,
     a.Material,
     a.ProductionPlant,
     a.ManufacturingOrder,
     b.ProductDescription
