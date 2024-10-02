@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'sum of batch'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_BCO_CDS_SUM as select from zpp_bco as A

{ key sum( A.loomno ) as loomno,
       A.balancemtr as balancemtr,
       A.shortno as shortno,
       A.sizbeemno,
        count( distinct A.loomno ) as NoofPeaces
    
} group by A.balancemtr,
          A.shortno,
//          A.loomno,
           A.sizbeemno
