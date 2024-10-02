@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material Master CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMATERIAL_MASTER1
  with parameters
    p_fromdate : abap.dats,
    p_todate   : abap.dats
  as select from ZMATERIAL_MASTER( p_fromdate: $parameters.p_fromdate , p_todate: $parameters.p_todate ) as A

  //   movment type           use


{
  key A.Material,
  key A.Plant,
  key A.Batch,
      A.MaterialBaseUnit,
      A.CompanyCodeCurrency,
      A.CompanyCodeCurrency      as Orginalcurr,
      //     a.TotalGoodsMvtAmtInCCCrcy ,

      //     case when A.CompanyCodeCurrency is not initial
      //         then cast( 'INR'  as abap.cuky( 5 )  ) end as CompanyCodeCurrency ,

      //     case when A.MaterialBaseUnit is not initial
      //         then cast( 'TO'  as abap.unit( 3 )  ) end as MaterialBaseUnit ,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum( A.Receiptqty )        as Receiptqty,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(  Receiptamt561 )      as Receiptamt561,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum(  production101 )      as production101,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum(  purchase101 )        as purchase101,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(  productionAmt101 )   as productionAmt101,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(  purchaseAmt101 )     as purchaseAmt101,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum(  receipt301 )         as receipt301,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum(  issue301 )           as issue301,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(  receiptAmt301 )      as receiptAmt301,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(  issueAmt301 )        as issueAmt301,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum(  receipt309 )         as receipt309,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum(  issue309 )           as issue309,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(  receiptAmt309 )      as receiptAmt309,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(  issueAmt309 )        as issueAmt309,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum(  salereturn653  )     as salereturn653,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(  salereturnAmt653 )   as salereturnAmt653,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum(  issue641 )           as issue641,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(  issueAmt641 )        as issueAmt641,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum(  Intransit641 )       as Intransit641,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(  IntransitAmt641 )    as IntransitAmt641,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum(  issue241 )           as issue241,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(  issueAmt241 )        as issueAmt241,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum(  issue201 )           as issue201,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(  issueAmt201 )        as issueAmt201,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum(  issue261 )           as issue261,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(  issueAmt261 )        as issueAmt261,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum(  issue601 )           as issue601,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(  issueAmt601 )        as issueAmt601,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum(  issue161 )           as issue161,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(  issueAmt161 )        as issueAmt161,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum(  Projectissue221 )    as Projectissue221,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum(  ProjectissueAmt221 ) as ProjectissueAmt221,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum (totgoodsreciptqty) as totgoodsreciptqty,             // added by abhishek 24.01.2024
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum ( totgoodsreciptamount ) as totgoodsreciptamount,     // added by abhishek 24.01.2024
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum ( totgoodsissueqty ) as totgoodsissueqty,             // added by abhishek 24.01.2024
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      sum ( totgoodissueamount ) as totgoodissueamount           // added by abhishek 24.01.2024
 }

group by
  A.Material,
  A.Plant,
  A.Batch,
  A.CompanyCodeCurrency,
  A.MaterialBaseUnit
