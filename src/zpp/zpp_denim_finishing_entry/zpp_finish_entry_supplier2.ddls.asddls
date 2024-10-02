@AbapCatalog.sqlViewName: 'YSUPPLIERFINSIH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Finishing Entry Supplier'
define view ZPP_FINISH_ENTRY_SUPPLIER2 as select from ZPP_FINISH_ENTRY_Supplier as a
left outer join ZPP_DENIM_FINISH_ENTRY_REP as b on ( b.Material261 = a.Material 
                                                and b.Finishrollno = a.Batch 
                                                and ( b.Partyname  = a.SupplierName or b.supplier = a.Supplier )
                                      )
{  
    key a.Material,
    key a.Batch,
    substring(a.Supplier,4,7) as Supplier,
    a.SupplierName,
    b.Materialdocument101 
}     where ( b.Materialdocument101 = '' or  b.Materialdocument101 is null or  b.Materialdocument101 is initial )
   group by  
   
    a.Material,
    a.Batch,
    a.Supplier,
    a.SupplierName,
    b.Materialdocument101
