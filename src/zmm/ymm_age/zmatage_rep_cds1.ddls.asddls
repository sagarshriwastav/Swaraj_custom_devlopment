//@AbapCatalog.sqlViewName: 'YMEG'
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Matage Rep'
define root view entity  ZMATAGE_REP_CDS1 
with parameters p_budat:abap.dats,
                RQTY:abap.int4 ,
                RQTY1:abap.int4, 
                RQTY2:abap.int4,
                RQTY3:abap.int4,
                RQTY4:abap.int4
    as select from ZMATAGE_REP_CDS (p_budat : $parameters.p_budat,
                RQTY:$parameters.RQTY ,
                RQTY1:$parameters.RQTY1, 
                RQTY2:$parameters.RQTY2,
                RQTY3:$parameters.RQTY3,
                RQTY4:$parameters.RQTY4 )
{
   
    key plant,
    key material,
    key StorageLocation,
    key MaterialBaseUnit,
    key BATCH,
        CompanyCodeCurrency,
         
   @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'  
     case when QTY > 0
    then ( QTY - TISSQTY )
     else QTY end as QT ,
     
     @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
     case when amt > 0
    then ( amt - TISSamt )
     else amt end as AMT ,
     
     
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit' 
     case when QTY1 > 0
    then ( QTY1 - TISSQTY ) 
     else QTY1 end as QT1,
    
    
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
     case when amt1 > 0
    then ( amt1 - TISSamt )
     else amt1 end as AMT1 ,
     
    
    
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
     case when QTY2 > 0
    then ( QTY2 - TISSQTY ) 
    else QTY2 end as QT2 ,
    
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
     case when amt2 > 0
    then ( amt2 - TISSamt )
     else amt2 end as AMT2 ,
     
    
       @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
   case when QTY3 > 0
   then ( QTY3 - TISSQTY ) 
    else QTY3 end as QT3  ,
    
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
     case when amt3 > 0
    then ( amt3 - TISSamt )
     else amt3 end as AMT3 ,
     
    
    
       @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
     case when QTY4 > 0
    then ( QTY4 - TISSQTY )
    else QTY4 end as QT4  ,
    
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
     case when amt4 > 0
    then ( amt4 - TISSamt )
     else amt4 end as AMT4 ,
     
       @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case when QTY5 > 0
    then ( QTY5 - TISSQTY )
    else QTY5 end as QT5  ,
    
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    case when amt5 > 0
    then ( amt5 - TISSamt )
     else amt5 end as AMT5 
     
  //  TISSQTY
  //  TOTQTY,
 //  ( QTY + QTY1 + QTY2 + QTY3 + QTY4 + QTY5 ) - ( TISSQTY ) as TotQtyRm
    
}
