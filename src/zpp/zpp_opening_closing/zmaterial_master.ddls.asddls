@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material Master CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMATERIAL_MASTER
  with parameters
    p_fromdate : abap.dats,
    p_todate   : abap.dats
  as select from    I_MaterialDocumentItem_2 as A
    left outer join I_Product                as B on(
      B.Product = A.Material
    )

  //   movment type           use


{
  key A.Material,
  key A.Plant,
      A.Batch,
      ''                                                                                           as GoodsMovementType,
      B.BaseUnit                                                                                   as MaterialBaseUnit,
      ''                                                                                           as OrderID,
      ''                                                                                           as PurchaseOrder,
      ''                                                                                           as DebitCreditCode,
      ''                                                                                           as PostingDate,
      ''                                                                                           as StorageLocation,
      A.CompanyCodeCurrency,
      A.CompanyCodeCurrency                                                                        as Orginalcurr,
      //     a.TotalGoodsMvtAmtInCCCrcy ,

      //     case when A.CompanyCodeCurrency is not initial
      //         then cast( 'INR'  as abap.cuky( 5 )  ) end as CompanyCodeCurrency ,

      //     case when A.MaterialBaseUnit is not initial
      //         then cast( 'TO'  as abap.unit( 3 )  ) end as MaterialBaseUnit ,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case when A.GoodsMovementType = '561'  then sum( A.QuantityInBaseUnit )
      when A.GoodsMovementType = '562'  then sum((  A.QuantityInBaseUnit ) * -1 )
      //     case when A.GoodsMovementType = '561' or A.GoodsMovementType = '562' then sum( A.QuantityInBaseUnit )
      end                                                                                          as Receiptqty,

      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case when A.GoodsMovementType = '561'  then sum( A.TotalGoodsMvtAmtInCCCrcy )
      when A.GoodsMovementType = '562'  then sum( ( A.TotalGoodsMvtAmtInCCCrcy ) * -1 )
      end                                                                                          as Receiptamt561,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case when ( A.OrderID is not initial and ( A.GoodsMovementType = '101'  ) ) then sum( A.QuantityInBaseUnit )
      when ( A.OrderID is not initial and ( A.GoodsMovementType = '102'  ) ) then sum( A.QuantityInBaseUnit ) * -1
                                                                                               end as production101,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case when ( A.PurchaseOrder is not initial and ( A.GoodsMovementType = '101'  ) ) then sum( A.QuantityInBaseUnit )
      when ( A.PurchaseOrder is not initial and ( A.GoodsMovementType = '102'  ) ) then sum( A.QuantityInBaseUnit ) * -1
      end                                                                                          as purchase101,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when ( A.OrderID is not initial and ( A.GoodsMovementType = '101' ) ) then sum( A.TotalGoodsMvtAmtInCCCrcy )
      when ( A.OrderID is not initial and ( A.GoodsMovementType = '102' ) ) then sum( A.TotalGoodsMvtAmtInCCCrcy ) * -1
      end                                                                                          as productionAmt101,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when ( A.PurchaseOrder is not initial and ( A.GoodsMovementType = '101' ) ) then sum( A.TotalGoodsMvtAmtInCCCrcy )
      when ( A.PurchaseOrder is not initial and ( A.GoodsMovementType = '102' ) ) then sum( A.TotalGoodsMvtAmtInCCCrcy ) * -1
      end                                                                                          as purchaseAmt101,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case
      when ( A.DebitCreditCode = 'S' and ( A.GoodsMovementType = '301' ) ) then sum( A.QuantityInBaseUnit )
      when ( A.DebitCreditCode = 'S' and ( A.GoodsMovementType = '302' ) ) then sum( A.QuantityInBaseUnit ) * -1
      end                                                                                          as receipt301,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case
      when ( A.DebitCreditCode = 'H' and ( A.GoodsMovementType = '301' ) ) then sum( A.QuantityInBaseUnit )
      when ( A.DebitCreditCode = 'H' and ( A.GoodsMovementType = '302' ) ) then sum( A.QuantityInBaseUnit ) * -1
      end                                                                                          as issue301,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when ( A.DebitCreditCode = 'S' and ( A.GoodsMovementType = '301' ) ) then sum( A.TotalGoodsMvtAmtInCCCrcy )
      when ( A.DebitCreditCode = 'S' and ( A.GoodsMovementType = '302' ) ) then sum( A.TotalGoodsMvtAmtInCCCrcy ) * -1
      end                                                                                          as receiptAmt301,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when ( A.DebitCreditCode = 'H' and ( A.GoodsMovementType = '301' ) ) then sum( A.TotalGoodsMvtAmtInCCCrcy )
      when ( A.DebitCreditCode = 'H' and ( A.GoodsMovementType = '302' ) ) then sum( A.TotalGoodsMvtAmtInCCCrcy ) * -1
      end                                                                                          as issueAmt301,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case
      when ( A.DebitCreditCode = 'H' and ( A.GoodsMovementType = '309' ) ) then sum( A.QuantityInBaseUnit )
      when ( A.DebitCreditCode = 'H' and ( A.GoodsMovementType = '310' ) ) then sum( A.QuantityInBaseUnit ) * -1
      end                                                                                          as receipt309,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case
      when ( A.DebitCreditCode = 'S' and ( A.GoodsMovementType = '309' ) ) then sum( A.QuantityInBaseUnit )
      when ( A.DebitCreditCode = 'S' and ( A.GoodsMovementType = '310' ) ) then sum( A.QuantityInBaseUnit ) * -1
      end                                                                                          as issue309,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when ( A.DebitCreditCode = 'H' and ( A.GoodsMovementType = '309' ) ) then sum( A.TotalGoodsMvtAmtInCCCrcy )
      when ( A.DebitCreditCode = 'H' and ( A.GoodsMovementType = '310' ) ) then sum( A.TotalGoodsMvtAmtInCCCrcy ) * -1
      end                                                                                          as receiptAmt309,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when ( A.DebitCreditCode = 'S' and ( A.GoodsMovementType = '309' ) ) then sum( A.TotalGoodsMvtAmtInCCCrcy )
      when ( A.DebitCreditCode = 'S' and ( A.GoodsMovementType = '310' ) ) then sum( A.TotalGoodsMvtAmtInCCCrcy ) * -1
      end                                                                                          as issueAmt309,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case
      when ( A.GoodsMovementType = '653' )  then sum( A.QuantityInBaseUnit )
      when ( A.GoodsMovementType = '654' )  then sum( A.QuantityInBaseUnit ) * -1
      end                                                                                          as salereturn653,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when ( A.GoodsMovementType = '653' )  then sum( A.TotalGoodsMvtAmtInCCCrcy )
      when ( A.GoodsMovementType = '654' )  then sum( A.TotalGoodsMvtAmtInCCCrcy ) * -1
      end                                                                                          as salereturnAmt653,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case
      when ( A.GoodsMovementType = '641') then sum( A.QuantityInBaseUnit )
      when ( A.GoodsMovementType = '642') then sum( A.QuantityInBaseUnit ) * -1
      end                                                                                          as issue641,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when ( A.GoodsMovementType = '641' ) then sum( A.TotalGoodsMvtAmtInCCCrcy )
      when ( A.GoodsMovementType = '642' ) then sum( A.TotalGoodsMvtAmtInCCCrcy ) * -1
      end                                                                                          as issueAmt641,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case
      when ( A.StorageLocation is initial and ( A.GoodsMovementType = '641' ) ) then sum( A.QuantityInBaseUnit )
      when ( A.StorageLocation is initial and ( A.GoodsMovementType = '642' ) ) then sum( A.QuantityInBaseUnit ) * -1
      end                                                                                          as Intransit641,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when ( A.StorageLocation is initial and ( A.GoodsMovementType = '641' ) ) then sum( A.TotalGoodsMvtAmtInCCCrcy )
      when ( A.StorageLocation is initial and ( A.GoodsMovementType = '642' ) ) then sum( A.TotalGoodsMvtAmtInCCCrcy ) * -1
      end                                                                                          as IntransitAmt641,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case
      when ( A.GoodsMovementType = '241' ) then sum( A.QuantityInBaseUnit )
      when ( A.GoodsMovementType = '242' ) then sum( A.QuantityInBaseUnit ) * -1
      end                                                                                          as issue241,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when ( A.GoodsMovementType = '241' ) then sum( A.TotalGoodsMvtAmtInCCCrcy )
      when ( A.GoodsMovementType = '242' ) then sum( A.TotalGoodsMvtAmtInCCCrcy ) * -1
      end                                                                                          as issueAmt241,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case
      when ( A.GoodsMovementType = '201' ) then sum( A.QuantityInBaseUnit )
      when ( A.GoodsMovementType = '202' ) then sum( A.QuantityInBaseUnit ) * -1
      end                                                                                          as issue201,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when ( A.GoodsMovementType = '201' ) then sum( A.TotalGoodsMvtAmtInCCCrcy )
      when ( A.GoodsMovementType = '202' ) then sum( A.TotalGoodsMvtAmtInCCCrcy ) * -1
      end                                                                                          as issueAmt201,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case
      when ( A.GoodsMovementType = '261' ) then sum( A.QuantityInBaseUnit )
      when ( A.GoodsMovementType = '262' ) then sum( A.QuantityInBaseUnit ) * -1
      end                                                                                          as issue261,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when ( A.GoodsMovementType = '261' ) then sum( A.TotalGoodsMvtAmtInCCCrcy )
      when ( A.GoodsMovementType = '262' ) then sum( A.TotalGoodsMvtAmtInCCCrcy ) * -1
      end                                                                                          as issueAmt261,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case
      when ( A.GoodsMovementType = '601' ) then sum( A.QuantityInBaseUnit )
      when ( A.GoodsMovementType = '602' ) then sum( A.QuantityInBaseUnit ) * -1
      end                                                                                          as issue601,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when ( A.GoodsMovementType = '601' ) then sum( A.TotalGoodsMvtAmtInCCCrcy )
      when ( A.GoodsMovementType = '602' ) then sum( A.TotalGoodsMvtAmtInCCCrcy ) * -1
      end                                                                                          as issueAmt601,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case
      when ( A.GoodsMovementType = '161' ) then sum( A.QuantityInBaseUnit )
      when ( A.GoodsMovementType = '162' ) then sum( A.QuantityInBaseUnit ) * -1
      end                                                                                          as issue161,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when ( A.GoodsMovementType = '161' ) then sum( A.TotalGoodsMvtAmtInCCCrcy )
      when ( A.GoodsMovementType = '162' ) then sum( A.TotalGoodsMvtAmtInCCCrcy ) * -1
      end                                                                                          as issueAmt161,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case
      when ( A.GoodsMovementType = '221' ) then sum( A.QuantityInBaseUnit )
      when ( A.GoodsMovementType = '222' ) then sum( A.QuantityInBaseUnit ) * -1
      end                                                                                          as Projectissue221,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when ( A.GoodsMovementType = '221' ) then sum( A.TotalGoodsMvtAmtInCCCrcy )
      when ( A.GoodsMovementType = '222' ) then sum( A.TotalGoodsMvtAmtInCCCrcy ) * -1
      end                                                                                          as ProjectissueAmt221 ,
      

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case
      when ( A.GoodsMovementType = '561' or A.GoodsMovementType = '101' or A.GoodsMovementType = '301' or ( A.GoodsMovementType = '309' and A.DebitCreditCode = 'H' ) or A.GoodsMovementType = '653' ) then sum( A.QuantityInBaseUnit )
      when ( A.GoodsMovementType = '562' or A.GoodsMovementType = '102'or A.GoodsMovementType = '302' or  ( A.GoodsMovementType = '310' and A.DebitCreditCode = 'H' ) or A.GoodsMovementType = '654') then sum( A.QuantityInBaseUnit ) * -1
       
      end                                                                                          as totgoodsreciptqty  ,   //ADDED BY Abhishek 24.01.2024

     @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when ( A.GoodsMovementType = '561' or A.GoodsMovementType = '101' or A.GoodsMovementType = '301' or ( A.GoodsMovementType = '309' and A.DebitCreditCode = 'H' ) or A.GoodsMovementType = '653') then sum( A.TotalGoodsMvtAmtInCCCrcy )
      when ( A.GoodsMovementType = '562' or A.GoodsMovementType = '102' or A.GoodsMovementType = '302' or ( A.GoodsMovementType = '310' and A.DebitCreditCode = 'H' )or A.GoodsMovementType = '654' ) then sum( A.TotalGoodsMvtAmtInCCCrcy ) * -1
      end                                                                                          as totgoodsreciptamount,   // added by Abhishek 24.01.2024 
      
      
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case
      when ( A.GoodsMovementType = '161' or A.GoodsMovementType = '201' or A.GoodsMovementType = '221' or A.GoodsMovementType = '241' or A.GoodsMovementType = '261' or A.GoodsMovementType = '301'  or ( A.GoodsMovementType = '309'  and A.DebitCreditCode = 'S' ) or  A.GoodsMovementType = '601' or A.GoodsMovementType = '641'  ) then sum( A.QuantityInBaseUnit )
      when ( A.GoodsMovementType = '162' or A.GoodsMovementType = '202' or A.GoodsMovementType = '222'  or A.GoodsMovementType = '242' or A.GoodsMovementType = '262' or A.GoodsMovementType = '302' or ( A.GoodsMovementType = '310'  and A.DebitCreditCode = 'S' ) or A.GoodsMovementType = '602' or A.GoodsMovementType = '642') then sum( A.QuantityInBaseUnit ) * -1
       
      end                                                                                          as totgoodsissueqty  ,   //ADDED BY Abhishek 24.01.2024

     @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      case
      when (A.GoodsMovementType = '161' or A.GoodsMovementType = '201' or A.GoodsMovementType = '221' or A.GoodsMovementType = '241'  or A.GoodsMovementType = '261' or A.GoodsMovementType = '301'  or ( A.GoodsMovementType = '309'  and A.DebitCreditCode = 'S' ) or  A.GoodsMovementType = '601' or A.GoodsMovementType = '641' ) then sum( A.TotalGoodsMvtAmtInCCCrcy )
      when ( A.GoodsMovementType = '162' or A.GoodsMovementType = '202' or A.GoodsMovementType = '222' or A.GoodsMovementType = '242' or  A.GoodsMovementType = '262' or  A.GoodsMovementType = '302' or (A.GoodsMovementType = '310'  and A.DebitCreditCode = 'S' ) or A.GoodsMovementType = '602' or A.GoodsMovementType = '642' ) then sum( A.TotalGoodsMvtAmtInCCCrcy ) * -1
      end                                                                                          as totgoodissueamount   // added by Abhishek 24.01.2024 
      

}
where
      A.PostingDate              >= $parameters.p_fromdate
  and A.PostingDate              <= $parameters.p_todate
  and A.ReversedMaterialDocument is initial
  and A.GoodsMovementIsCancelled is initial
  and A.Material                 is not initial

group by
  A.Material,
  A.Plant,
  A.Batch,
  A.GoodsMovementType,
  A.QuantityInBaseUnit,
  A.OrderID,
  A.PurchaseOrder,
  A.DebitCreditCode,
  A.PostingDate,
  A.StorageLocation,
  A.CompanyCodeCurrency,
  B.BaseUnit
