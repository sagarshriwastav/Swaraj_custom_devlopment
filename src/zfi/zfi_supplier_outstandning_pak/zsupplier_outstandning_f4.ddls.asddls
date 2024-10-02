@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZSUPPLIER_OUTSTANDNING_F4'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZSUPPLIER_OUTSTANDNING_F4 as select from ZSUPPLIER_OUTSTANDNING_CDS as A

{
     key A.Status
 //    key   A.ITEAM
         
}
group by 
      A.Status
   //   A.ITEAM
      
      
//where A.REPORT = 'CLEARED ITEM'  or     A.REPORT =       'OPEN ITEM'
