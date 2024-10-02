@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS For Dye Set Component Details'
define root view  entity ZDYEC_SET_COMPOV1 as select from ZDYEC_SET_COMPONENT
{

  key SetNumber,
  key OrderID ,
      recipe  as dyeingsort
   

    
}    where SetNumber <> ' '
   group by  
              SetNumber,
              OrderID,
              recipe

