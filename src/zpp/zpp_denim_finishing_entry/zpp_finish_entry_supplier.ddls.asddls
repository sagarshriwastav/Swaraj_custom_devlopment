@AbapCatalog.sqlViewName: 'YSUPPLIER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Denim Finish Entry'
define view ZPP_FINISH_ENTRY_Supplier as select from I_MaterialDocumentItem_2 as a 
               left outer join I_Supplier as b on ( b.Supplier = a.Supplier )
{   
    key a.Material,
    key a.Batch ,
        a.Supplier,
        b.SupplierName
         
}   where a.GoodsMovementType = '101' and a.Material like  'FG%'  
     group by  
        a.Material,
        a.Batch ,
        a.Supplier,
        b.SupplierName
