@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  Customer Outstanding Report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZFI_AR_REPORT_CDS_FIN 
      with parameters 
                p_comp : abap.char( 4 ) ,
                p_posting1:abap.dats
 as select from ZFI_AR_REPORT_CDS as a    
 left outer join I_BillingDocumentPartner as c on ( c.BillingDocument = a.OriginalReferenceDocument and c.PartnerFunction = 'ZA' ) 
 left outer join I_Supplier  as I on ( I.Supplier = c.Supplier)
 left outer join I_BillingDocument as d on ( d.BillingDocument = a.OriginalReferenceDocument )
// left outer join ZAR_DIVISION_CDS  as e on ( e.BillingDocument = a.OriginalReferenceDocument )
{
 key  a.CompanyCode,
 key  a.FiscalYear,
 key  a.AccountingDocument,
      a.OriginalReferenceDocument,
      a.Customer,
      a.ProfitCenter,
      a.PostingDate,
      a.NetDueDate,
      a.CustomerName,
      c.Supplier,
      I.SupplierName,
      a.CompanyCodeCurrency,
   @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
   sum(a.Amount)  as Amount,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast( case when dats_days_between( a.DueCalculationBaseDate, $parameters.p_posting1 )  between 0  
   and 30
   then cast( a.Amount  as abap.dec( 13, 2 ) )
  else 0 end  as abap.curr( 13, 2 ) )  as  AMT030  ,
  
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast( case when dats_days_between( a.DueCalculationBaseDate, $parameters.p_posting1 )  >= 31 
  and  dats_days_between( a.DueCalculationBaseDate, $parameters.p_posting1 )  <= 45 
 // and a.DebitCreditCode = 'S'  
   then cast( a.Amount as abap.dec( 13, 2 ) )
  else 0 end  as abap.curr( 13, 2 ) )  as  AMT045  ,
  
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(  case when dats_days_between( a.DueCalculationBaseDate, $parameters.p_posting1 )  >= 46
  and   dats_days_between( a.DueCalculationBaseDate, $parameters.p_posting1 ) <= 60 
   then cast( a.Amount as abap.dec( 13, 2 ) )
  else 0 end  as abap.curr( 13, 2 ) )  as  AMT060  ,
  
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(  case when dats_days_between( a.DueCalculationBaseDate, $parameters.p_posting1 )  >= 61 
  and  dats_days_between( a.DueCalculationBaseDate, $parameters.p_posting1 ) <= 90
   then cast( a.Amount as abap.dec( 13, 2 ) )
  else 0 end  as abap.curr( 13, 2 ) )  as  AMT090  ,
  
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast( case when dats_days_between( a.DueCalculationBaseDate, $parameters.p_posting1 )  > 90
  then cast( a.Amount as abap.dec( 13, 2 ) )
  else 0 end as abap.curr( 13, 2 ) )  as  AMT90ABOVE ,
  a.PostingDate as BillingDocumentDate,
  dats_days_between( a.NetDueDate, a.sydatum ) as daysarra,
  dats_days_between( a.PostingDate, a.sydatum ) as totalnumberbill,
  a.sydatum,
  a.DocumentItemText as MatlAccountAssignmentGroup

}      
 group by 
          a.CompanyCode,
          a.FiscalYear,
          a.AccountingDocument,
          a.OriginalReferenceDocument,
          a.DueCalculationBaseDate,
          a.Amount,
          c.Supplier,
          I.SupplierName,
          a.Customer,
          a.ProfitCenter,
          a.PostingDate,
          a.NetDueDate,
          a.CompanyCodeCurrency,
          a.DueCalculationBaseDate,
          a.CustomerName,
          d.BillingDocumentDate,
          a.sydatum ,
          a.DocumentItemText 
         
