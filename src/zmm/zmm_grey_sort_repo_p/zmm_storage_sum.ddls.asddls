@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SUM LOCATION'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_STORAGE_SUM as select from I_StockQuantityCurrentValue_2  ( P_DisplayCurrency : 'INR' ) as A
{
    A.Product,
    A.Batch,
    A.StorageLocation,
    A.MaterialBaseUnit,
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    A.MatlWrhsStkQtyInMatlBaseUnit,
     @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
   sum(case when A.StorageLocation like 'FG01' then (A.MatlWrhsStkQtyInMatlBaseUnit)  end  )  as AT_GREY_GODOWAN,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
   sum(case when A.StorageLocation like 'VJOB' then (A.MatlWrhsStkQtyInMatlBaseUnit)  end  )  as AT_JOB_WORK,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
   sum(case when A.StorageLocation like 'FN01' then (A.MatlWrhsStkQtyInMatlBaseUnit)  end  )  as FINISH_GODOWAN,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
   sum(case when A.StorageLocation like 'INS1' then (A.MatlWrhsStkQtyInMatlBaseUnit)  end  )  as AT_INSPECTION
} 
  where   A.MatlWrhsStkQtyInMatlBaseUnit > 0
 group by A.Product,
          A.StorageLocation,
         A.MaterialBaseUnit ,
       A.MatlWrhsStkQtyInMatlBaseUnit,
         A.Batch
