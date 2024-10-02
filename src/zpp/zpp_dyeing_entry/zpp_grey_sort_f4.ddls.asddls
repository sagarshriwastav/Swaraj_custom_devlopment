@AbapCatalog.sqlViewName: 'YGREYSORT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For F4 Dyeing Entry Grey Sort'
define view ZPP_GREY_SORT_F4 as select from zpp_sortmaster

    {
      key dyeingsort,
          material
          
          
}    where  dyeingsort <> ''
 group by  
          dyeingsort,
          material
