@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_MATERIAL_FRC_CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_MATERIAL_FRC_CDS as select from zpp_finishing   as A 
//left outer join zpp_finishing as B on ( B.material101 = A.material_number and B.postingdate = A.posting_date  )

{   key A.material101,
    key A.finishrollno ,
    A.postingdate,
   cast('M' as abap.unit( 3 ) ) as zunit,
      @Semantics.quantity.unitOfMeasure : 'zunit'
     sum(A.greigemtr)  as greigemtr ,
       @Semantics.quantity.unitOfMeasure : 'zunit'
    sum(A.finishmtr )  as finishmtr
   
      
}  

group by A.material101,
        A.postingdate,
        A.finishrollno
  
        
