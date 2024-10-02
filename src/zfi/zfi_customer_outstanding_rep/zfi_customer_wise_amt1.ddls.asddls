@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Customer Outstanding  Report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZFI_CUSTOMER_WISE_AMT1 with parameters 
                p_comp : abap.char( 4 ) ,
                p_posting:abap.dats,
                p_posting1:abap.dats,
                RAMT:abap.int4,
                RAMT1:abap.int4, 
                RAMT2:abap.int4,
                RAMT3:abap.int4
 as select from ZFI_CUSTOMER_OUTSTANDING_CDS2( p_comp : $parameters.p_comp, p_posting : $parameters.p_posting, 
                                      p_posting1 : $parameters.p_posting1 
                                       )
 as a  
{
 key  a.CompanyCode,
 key  a.FiscalYear,
 key  a.Customer,  
      a.CustomerName,
      a.CompanyCodeCurrency,
      a.SalesDocument,
      a.SalesDocumentItem,
      a.TYPE,
      a.ProfitCenter,
   @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
   sum(a.Amount)  as Amount,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
 @Consumption.dynamicLabel: { label : 'DAYS - ( &1 ) - &2' , 
 binding : [ { index : 1 , parameter : 'RAMT' }, 
{ index : 2 , parameter : 'RAMT1' } ] }
  cast( case when dats_days_between( a.DueCalculationBaseDate, $parameters.p_posting1 )  between 0  
   and $parameters.RAMT
   then cast( sum(a.Amount ) as abap.dec( 13, 3 ) )
  else 0 end  as abap.curr( 13, 3 ) )  as  AMT030  ,
  
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast( case when dats_days_between( a.DueCalculationBaseDate, $parameters.p_posting1 )  > $parameters.RAMT 
  and dats_days_between( a.DueCalculationBaseDate, $parameters.p_posting1 ) <= $parameters.RAMT1 
 // and a.DebitCreditCode = 'S'  
   then cast( sum(a.Amount) as abap.dec( 13, 3 ) )
  else 0 end  as abap.curr( 13, 3 ) )  as  AMT060  ,
  
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(  case when dats_days_between( a.DueCalculationBaseDate, $parameters.p_posting1 )  > $parameters.RAMT1 
  and dats_days_between( a.DueCalculationBaseDate, $parameters.p_posting1 ) <= $parameters.RAMT2 
   then cast( sum(a.Amount) as abap.dec( 13, 3 ) )
  else 0 end  as abap.curr( 13, 3 ) )  as  AMT090  ,
  
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(  case when dats_days_between( a.DueCalculationBaseDate, $parameters.p_posting1 )  > $parameters.RAMT2 
  and dats_days_between( a.DueCalculationBaseDate, $parameters.p_posting1 ) <= $parameters.RAMT3 
   then cast( sum(a.Amount) as abap.dec( 13, 3 ) )
  else 0 end  as abap.curr( 13, 3 ) )  as  AMT120  ,
  
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast( case when dats_days_between( a.DueCalculationBaseDate, $parameters.p_posting1 )  > $parameters.RAMT3
  then cast( sum(a.Amount) as abap.dec( 13, 3 ) )
  else 0 end as abap.curr( 13, 3 ) )  as  AMT121 
 


}      
 group by a.CompanyCode,
          a.FiscalYear,
       //   a.Amount,          
          a.Customer,
          a.CustomerName,
          a.DueCalculationBaseDate,
          a.CompanyCodeCurrency,
          a.SalesDocument,
          a.SalesDocumentItem,
          a.TYPE,
          a.ProfitCenter
