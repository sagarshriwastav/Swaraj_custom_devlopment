@AbapCatalog.sqlViewName: 'YF4DYES'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS For Dye Chemical F4 Recipe No'
define view ZDYEC_RECIPE_NO_F4 as select from  ZDYEC_SET_COMPONENT 

{ 
   key OrderID,
       SortField,
       recipe  as dyeingsort
       
       }  where SortField <> ''
         group by OrderID,
                  SortField,
                  recipe
