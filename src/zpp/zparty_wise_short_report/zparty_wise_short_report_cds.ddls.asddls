@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'party wise short report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPARTY_WISE_SHORT_REPORT_CDS as select from ZPARTY_WISE_SHORT_REP  
    
    {
       key Party,
       PostingDate,
       MaterialNumber, 
       MaterialBaseUnit,
   //   cast( cast( MaterialBaseUnit as abap.unit( 3 ) ) as abap.dec(13,0) ) as MaterialBaseUnit,
     //  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
     cast( FRC as abap.dec(13,0) ) as FRC,     
       sum(fresh) as FRESH,
       sum(SW) as SW,
       sum(other) as OTHER,
       sum(PD) as PD,
       sum(QD) as QD,
       sum(CD) as CD,
       sum(SV) as SV,
       sum(SL) as SL
 
       
       
    } group by Party,
               PostingDate,
               MaterialNumber,
               MaterialBaseUnit,
               FRC
               
              
               
              
