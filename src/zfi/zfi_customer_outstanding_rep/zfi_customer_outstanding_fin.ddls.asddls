@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  Customer Outstanding Report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity  ZFI_CUSTOMER_OUTSTANDING_FIN 
      with parameters 
                p_comp : abap.char( 4 ) ,
                p_posting:abap.dats,
                p_posting1:abap.dats,
                RAMT:abap.int4,
                RAMT1:abap.int4, 
                RAMT2:abap.int4,
                RAMT3:abap.int4
 as select from ZFI_CUSTOMER_OUTSTANDING_CDS2(p_posting : $parameters.p_posting, p_posting1 : $parameters.p_posting1 ,
              p_comp : $parameters.p_comp ) 
 as a    
 left outer join I_BillingDocumentPartner as c on ( c.BillingDocument = a.OriginalReferenceDocument and c.PartnerFunction = 'ZA' ) 
 left outer join I_Supplier  as I on ( I.Supplier = c.Supplier)
 left outer join ZFI_CUSTOMER_WISE_AMT4( p_comp : $parameters.p_comp, p_posting : $parameters.p_posting, 
                                      p_posting1 : $parameters.p_posting1 , RAMT : $parameters.RAMT ,
                                      RAMT1 : $parameters.RAMT1 ,RAMT2 : $parameters.RAMT2 ,
                                      RAMT3 : $parameters.RAMT3 
                                       ) as b on ( b.CompanyCode = a.CompanyCode and b.Customer = a.Customer 
                                                  and b.FiscalYear = a.FiscalYear )
{
 key  a.CompanyCode,
 key  a.FiscalYear,
 key  a.AccountingDocument,
      a.AccountingDocumentType,
      a.Customer,
      a.Product,
      a.ProfitCenter,
      a.PostingDate,
      a.NetDueDate,
      a.GLAccount,
      a.division  as division,
      a.DocumentReferenceID,
      a.DueCalculationBaseDate,
      a.AccountingDocumentHeaderText,
      a.CustomerName,
      c.Supplier,
      I.SupplierName,
      a.SalesDocument,
      a.SalesDocumentItem,
      a.MaterialGroup,
      a.ProductDescription, 
      a.CompanyCodeCurrency,
      b.TYPE   as TypeSmmery,
      b.ProfitCenter as ProfitcenterSummary,
   @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
   sum(a.Amount)  as Amount,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
 @Consumption.dynamicLabel: { label : 'DAYS - ( &1 ) - &2' , 
 binding : [ { index : 1 , parameter : 'RAMT' }, 
{ index : 2 , parameter : 'RAMT1' } ] }
  cast( case when dats_days_between( a.DueCalculationBaseDate, $parameters.p_posting1 )  between 0  
   and $parameters.RAMT
   then cast( a.Amount  as abap.dec( 13, 3 ) )
  else 0 end  as abap.curr( 13, 3 ) )  as  AMT030  ,
  
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast( case when dats_days_between( a.DueCalculationBaseDate, $parameters.p_posting1 )  > $parameters.RAMT 
  and  dats_days_between( a.DueCalculationBaseDate, $parameters.p_posting1 )  <= $parameters.RAMT1 
 // and a.DebitCreditCode = 'S'  
   then cast( a.Amount as abap.dec( 13, 3 ) )
  else 0 end  as abap.curr( 13, 3 ) )  as  AMT060  ,
  
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(  case when dats_days_between( a.DueCalculationBaseDate, $parameters.p_posting1 )  > $parameters.RAMT1 
  and   dats_days_between( a.DueCalculationBaseDate, $parameters.p_posting1 ) <= $parameters.RAMT2 
   then cast( a.Amount as abap.dec( 13, 3 ) )
  else 0 end  as abap.curr( 13, 3 ) )  as  AMT090  ,
  
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(  case when dats_days_between( a.DueCalculationBaseDate, $parameters.p_posting1 )  > $parameters.RAMT2 
  and  dats_days_between( a.DueCalculationBaseDate, $parameters.p_posting1 ) <= $parameters.RAMT3 
   then cast( a.Amount as abap.dec( 13, 3 ) )
  else 0 end  as abap.curr( 13, 3 ) )  as  AMT120  ,
  
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast( case when dats_days_between( a.DueCalculationBaseDate, $parameters.p_posting1 )  > $parameters.RAMT3
  then cast( a.Amount as abap.dec( 13, 3 ) )
  else 0 end as abap.curr( 13, 3 ) )  as  AMT121 ,
 
  a.TYPE,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  b.Amount   as AmountCus,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  b.AMT030   as AMT030Cus,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  b.AMT060   as AMT060Cus,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  b.AMT090   as AMT090Cus,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  b.AMT120   as AMT120Cus,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  b.AMT121   as   AMT121Cus
   

}      
 group by a.CompanyCode,
          a.FiscalYear,
          a.AccountingDocument,
          
          a.DueCalculationBaseDate,
          a.Amount,
          c.Supplier,
          I.SupplierName,
          a.Customer,
          a.Product,
          a.ProfitCenter,
          a.PostingDate,
          a.NetDueDate,
          a.CompanyCodeCurrency,
          a.GLAccount,
          a.division,
          a.DocumentReferenceID,
          a.DueCalculationBaseDate,
          a.AccountingDocumentHeaderText,
          a.CustomerName,
          a.AccountingDocumentType,
          a.SalesDocument,
         a.SalesDocumentItem,
          a.MaterialGroup,
          a.ProductDescription,
          a.TYPE,
          b.TYPE,
          b.ProfitCenter,
          b.Amount,
          b.AMT030,
          b.AMT060,
          b.AMT090,
          b.AMT120,
          b.AMT121
         
