@AbapCatalog.sqlViewName: 'ZTABL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MODUELPOOL TABLE CDS'
define root view YTABLECDS as select from zreporttable1
{
    key sno as Sno,
    requiment_no as RequimentNo,
    dates as Dates,
    sales_order as SalesOrder,
    construction as Construction,
    customer_names as CustomerNames,
    buyer as Buyer,
    end_use as EndUse,
    test_std as TestStd,
    cost_ref as CostRef,
    executive_name as ExecutiveName,
    prepared_by as PreparedBy,
    light_source_primary as LightSourcePrimary,
    light_source_secondary as LightSourceSecondary,
    others as Others,
    mechanical_finish as MechanicalFinish,
    chemical_finish as ChemicalFinish,
    remark as Remark,
    shade_names as ShadeNames
}
