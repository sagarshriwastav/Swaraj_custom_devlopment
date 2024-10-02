@AbapCatalog.sqlViewName: 'YGOODS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Goods Transaction Report'
define view ZGOODS_TRANSACTION_CDS as select from I_MaterialDocumentItem_2 as a
           left outer join I_Product as b on ( b.Product = a.Material )
{
    case when a.Material like 'Y%'  then 'YARN' 
      when a.Material like 'FG%'  then 'GREY FABRIC'
      when a.Material like 'FF%' or  a.Material like '776%' then 'FINISH FABRIC'
      when a.Material like 'HUS%' then 'HUSK'
      when a.Material like 'SD%' then 'DYES CHEMICAL'  end as Material,
      a.Plant
}where b.ProductType <> 'ZDYJ' and b.ProductType <> 'ZFIJ' and b.ProductType <> 'ZGFJ'
       and b.ProductType <> 'ZWRJ' and b.ProductType <> 'ZYRJ'
