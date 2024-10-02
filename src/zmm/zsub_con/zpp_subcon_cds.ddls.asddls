@AbapCatalog.sqlViewName: 'YSUBCON'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Subcon Supplier F4'
define view ZPP_SUBCON_CDS as select from I_MaterialDocumentItem_2 as a
     left outer join I_Supplier as c on ( c.Supplier = a.Supplier ) 
{ 
        key a.Supplier,
        c.SupplierName
       
} where a.GoodsMovementType = '541' and a.Material like 'BD%'
      and a.Plant = '1200' and a.StorageLocation != ' '
   group by  
        a.Supplier,
        c.SupplierName
