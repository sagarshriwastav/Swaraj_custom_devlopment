@AbapCatalog.sqlViewName: 'YDYEN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  Dyeing Entry Shade To Short'
define view ZPP_DYEING_SHADE_CDS as select from zpp_sortmaster

    {
      key dyeingsort,
          dyeingshade
          
}   group by  
          dyeingsort,
          dyeingshade
