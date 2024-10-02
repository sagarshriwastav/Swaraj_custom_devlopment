@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ROLL_NO_CDS_YEAR'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_ROLL_NO_CDS_YEAR as select from ZMM_ROLL_NO_CDS
{
    key rollno,
    party,
    Last4Date,
    MONTH4
} where   Last4Date <> '2023' and MONTH4 > '03'
