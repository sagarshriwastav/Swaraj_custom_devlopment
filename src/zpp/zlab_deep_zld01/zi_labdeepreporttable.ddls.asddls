@EndUserText.label: 'LAB DEEP REPORT TABLE'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZI_LabDeepReportTable
  as select from ZLABDEEPTABLE
  association to parent ZI_LabDeepReportTable_S as _LabDeepReportTabAll on $projection.SingletonID = _LabDeepReportTabAll.SingletonID
{
  key REQUIMENT_NO as RequimentNo,
  DATES as Dates,
  SALES_ORDER as SalesOrder,
  CONSTRUCTION as Construction,
  CUSTOMER_NAMES as CustomerNames,
  BUYER as Buyer,
  END_USE as EndUse,
  TEST_STD as TestStd,
  COST_REF as CostRef,
  EXECUTIVE_NAME as ExecutiveName,
  PREPARED_BY as PreparedBy,
  LIGHT_SOURCE_PRIMARY as LightSourcePrimary,
  LIGHT_SOURCE_SECONDARY as LightSourceSecondary,
  OTHERS as Others,
  MECHANICAL_FINISH as MechanicalFinish,
  CHEMICAL_FINISH as ChemicalFinish,
  REMARK as Remark,
  SHADE_NAMES as ShadeNames,
  @Consumption.hidden: true
  1 as SingletonID,
  _LabDeepReportTabAll
  
}
