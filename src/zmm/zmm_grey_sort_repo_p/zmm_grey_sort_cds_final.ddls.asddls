@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GREY SORT DETIAL FINAL'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_GREY_SORT_CDS_FINAL as select from ZMM_GREY_SORT_CDS as A

{  
         @UI.lineItem      : [{position: 10}]
         @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 10}]
         @EndUserText.label:     'Grey Sort'
//         @Consumption.valueHelpDefinition: [    f4 code
//        { entity:  { name:    'I_Customer_VH',
//                     element: 'Customer' }
//        }] 
      
  key    A.greysort,


      @UI.lineItem      : [{position: 20}]
    //     @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 20}]
         @EndUserText.label:     'Pd Sort'
  key    A.PD_SORT,
  
    @UI.lineItem      : [{position: 30}]
    //     @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 30}]
         @EndUserText.label:     'Dyeing Sort'
  key    A.dyeingsort,
//  
   @UI.lineItem      : [{position: 40}]
    //     @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 40}]
         @EndUserText.label:     'TOTAL LENDS'
         @Aggregation.default: #SUM
  key    A.totalends,
  
   @UI.lineItem      : [{position: 50}]
    //     @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 50}]
         @EndUserText.label:     'REED SPACE'
  key    A.reedspace,
  
  
   @UI.lineItem      : [{position: 60}]
    //     @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 60}]
         @EndUserText.label:     'unit'
    //        @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
  key    A.OrderQuantityUnit  as OrderQuantityUnit,
  
   @UI.lineItem      : [{position: 70}]
    //     @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 70}]
         @EndUserText.label:     'Order'
         @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
          @Aggregation.default: #SUM
  key    sum(A.OrderQuantity) as OrderQuantity,
//  
    @UI.lineItem      : [{position: 80}]
    //     @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 80}]
         @EndUserText.label:     'Dispatch'
         @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
          @Aggregation.default: #SUM
  key    sum(A.Delivery_Quantity) as  Delivery_Quantity,
//  
     @UI.lineItem      : [{position: 90}]
    //     @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 90}]
         @EndUserText.label:     'pending'
         @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
          @Aggregation.default: #SUM
  key    sum(A.Pending_Order_Qty) as Pending_Order_Qty,
////  
      
//  
   @UI.lineItem      : [{position: 100}]
    //     @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 100}]
         @EndUserText.label:     'Fresh'
            @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
  key    sum(A.fresh) as fresh,
  
//  
        @UI.lineItem      : [{position: 110}]
    //     @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 110}]
         @EndUserText.label:     'SW'
            @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
  key    sum(A.SW) as SW ,
  
        @UI.lineItem      : [{position: 120}]
    //     @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 120}]
         @EndUserText.label:     'DG'
            @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
  key    sum(A.DG) as DG,
  
//  
   @UI.lineItem      : [{position: 130}]
    //     @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 130}]
         @EndUserText.label:     'Total Running Loom'
            @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
  key    A.TOTAL_RUNNING_LOOM,
  
  @UI.lineItem      : [{position: 140}]
    //     @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 140}]
         @EndUserText.label:     'Balace Mtr On Loom'
            @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
  key    A.BALANCE_MTR_ON_LOOM,
//  
    @UI.lineItem      : [{position: 150}]
    //     @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 150}]
         @EndUserText.label:     'Total Beam'
//            @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
  key    A.batch_tot,
  
//  
   @UI.lineItem      : [{position: 160}]
    //     @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 160}]
         @EndUserText.label:     'Beam Mtr'
            @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
  key    A.BEAM_MTR,
  
  @UI.lineItem      : [{position: 170}]
    //     @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 170}]
         @EndUserText.label:     'At Grey Godowan'
            @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
  key    A.AT_GREY_GODOWAN,
  
  @UI.lineItem      : [{position: 180}]
    //     @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 180}]
         @EndUserText.label:     'AT JOB WORK'
            @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
  key    A.AT_JOB_WORK,
  
  @UI.lineItem      : [{position: 190}]
    //     @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 190}]
         @EndUserText.label:     'FINISH GODOWAN'
           @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
  key    A.FINISH_GODOWAN,
  
  @UI.lineItem      : [{position: 200}]
    //     @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 200}]
         @EndUserText.label:     'AT INSPECTION'
            @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
  key    A.AT_INSPECTION,
  
     @UI.lineItem      : [{position: 210}]
    //     @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 210}]
         @EndUserText.label:     'Required Finish'
            @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
  key    A.required,
  
    @UI.lineItem      : [{position: 220}]
    //     @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 220}]
         @EndUserText.label:     'ESTIMATED FINISH GREY IN PROCESS'
            @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
  key    A.ESTIMATED_FIN_GREY_IN_PRO,
  
  @UI.lineItem      : [{position: 230}]
////    //     @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 230}]
         @EndUserText.label:     'ESTIMATED DAYS'
         @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
  key    A.estimated_days ,
//  
  
 cast( A.required as abap.dec( 13, 2 ) ) -  cast( A.ESTIMATED_FIN_GREY_IN_PRO as abap.dec( 13, 2 ) )  as REQUIRED_PLANNING
  
  
  
  
  
  
//   
   
     
}  group by 
      A.greysort,
      A.PD_SORT,
      A.dyeingsort,
      A.totalends,
      A.reedspace,
//      A.OrderQuantity,
      A.OrderQuantityUnit,
      A.TOTAL_RUNNING_LOOM,
      A.batch_tot,
      A.batch_tot,
      A.BEAM_MTR,
      A.AT_GREY_GODOWAN,
      A.AT_JOB_WORK,
      A.AT_INSPECTION,
      A.FINISH_GODOWAN,
      A.required,
      A.BALANCE_MTR_ON_LOOM,
      A.ESTIMATED_FIN_GREY_IN_PRO,
       A.estimated_days
      

    
