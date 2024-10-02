@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product Wise Vendor Outstanding Report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZMM_PRODUCT_OUTSTANDING
with parameters 
                p_comp : abap.char( 4 ) ,
                p_posting:abap.dats,
                p_posting1:abap.dats,
                 RAMT:abap.int4,
                RAMT1:abap.int4, 
                RAMT2:abap.int4,   
                RAMT3:abap.int4
 as select from ZMM_PRODUCT_OUTSTANDING1(p_comp : $parameters.p_comp , 
                         p_posting : $parameters.p_posting, p_posting1 : $parameters.p_posting1 
               )
 as a  
 left outer join ZFI_SUPPLIER_WISE_AMT4( p_comp : $parameters.p_comp, p_posting : $parameters.p_posting, 
                                      p_posting1 : $parameters.p_posting1 , RAMT : $parameters.RAMT ,
                                      RAMT1 : $parameters.RAMT1 ,RAMT2 : $parameters.RAMT2 ,
                                      RAMT3 : $parameters.RAMT3 
                                       ) as b on ( b.CompanyCode = a.CompanyCode and b.Supplier = a.Supplier 
                                                  and b.FiscalYear = a.FiscalYear )
 
 {
 key  a.CompanyCode,
 key  a.FiscalYear,
 key  a.AccountingDocument,
      a.AccountingDocumentType,
      a.Supplier,
      a.Product,
      a.ProfitCenter,
      b.ProfitCenter as SummaryProfitCenter,
      a.PostingDate,
      a.NetDueDate,
      a.CompanyCodeCurrency,
      a.GLAccount,
   //   case a.AccountingDocumentType  
     // when 'KZ' then '18'
     // else
      a.division  as division,
      a.DocumentReferenceID,
      a.AccountingDocumentHeaderText,
      a.SupplierName,
      a.PurchaseOrder,
      a.PurchaseOrderItem,
      a.MaterialGroup,
      a.AccountAssignmentCategory,
      a.PurchaseOrderItemCategory,
      a.ProductDescription,
      a.ProductType,
      a.BaseUnit,
      a.DueCalculationBaseDate,
       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
   a.Amount  as Amount,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
 @Consumption.dynamicLabel: { label : 'DAYS - ( &1 ) - &2' , 
 binding : [ { index : 1 , parameter : 'RAMT' }, 
{ index : 2 , parameter : 'RAMT1' } ] }
  cast( case when dats_days_between( a.DueCalculationBaseDate, $parameters.p_posting1 )  between 0  
   and $parameters.RAMT
   then cast( a.Amount as abap.dec( 13, 3 ) )
  else 0 end  as abap.curr( 13, 3 ) )  as  AMT030  ,
  
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast( case when dats_days_between( a.DueCalculationBaseDate, $parameters.p_posting1 )  > $parameters.RAMT 
  and dats_days_between( a.DueCalculationBaseDate, $parameters.p_posting1 ) <= $parameters.RAMT1 
 // and a.DebitCreditCode = 'S'  
   then cast( a.Amount as abap.dec( 13, 3 ) )
  else 0 end  as abap.curr( 13, 3 ) )  as  AMT060  ,
  
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(  case when dats_days_between( a.DueCalculationBaseDate, $parameters.p_posting1 )  > $parameters.RAMT1 
  and dats_days_between( a.DueCalculationBaseDate, $parameters.p_posting1 ) <= $parameters.RAMT2 
   then cast( a.Amount as abap.dec( 13, 3 ) )
  else 0 end  as abap.curr( 13, 3 ) )  as  AMT090  ,
  
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(  case when dats_days_between( a.DueCalculationBaseDate, $parameters.p_posting1 )  > $parameters.RAMT2 
  and dats_days_between( a.DueCalculationBaseDate, $parameters.p_posting1 ) <= $parameters.RAMT3 
   then cast( a.Amount as abap.dec( 13, 3 ) )
  else 0 end  as abap.curr( 13, 3 ) )  as  AMT120  ,
  
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast( case when dats_days_between( a.DueCalculationBaseDate, $parameters.p_posting1 )  > $parameters.RAMT3
  then cast( a.Amount as abap.dec( 13, 3 ) )
  else 0 end as abap.curr( 13, 3 ) )  as  AMT121 ,
      a.TYPE   ,
      b.TYPE   as SummaryTYP,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  b.Amount   as AmountSup,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  b.AMT030   as AMT030Sus,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  b.AMT060   as AMT060Sus,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  b.AMT090   as AMT090Sus,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  b.AMT120   as AMT120Sus,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  b.AMT121   as   AMT121Sus

}
 
 group by a.CompanyCode,
          a.FiscalYear,
          a.AccountingDocument,
          a.Supplier,
          a.Product,
          a.ProfitCenter,
          b.ProfitCenter,
          a.PostingDate,
          a.DueCalculationBaseDate,
          a.NetDueDate,
          a.CompanyCodeCurrency,
          a.Amount,
          a.GLAccount,
          a.division,
          a.DocumentReferenceID,
          a.AccountingDocumentHeaderText,
          a.SupplierName,
          a.AccountingDocumentType,
          a.PurchaseOrder,
          a.PurchaseOrderItem,
          a.MaterialGroup,
          a.AccountAssignmentCategory,
          a.PurchaseOrderItemCategory,
          a.ProductDescription,
          a.BaseUnit,
          a.ProductType,
          a.TYPE,
          b.TYPE,
          b.Amount,
          b.AMT030,
          b.AMT060,
          b.AMT090,
          b.AMT120,
          b.AMT121
         
