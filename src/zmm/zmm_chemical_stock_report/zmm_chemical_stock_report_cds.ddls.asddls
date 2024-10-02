@AbapCatalog.sqlViewName: 'ZCHEMICAL_REPORT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMM_CHEMICAL_STOCK_REPORT_CDS'
define view ZMM_CHEMICAL_STOCK_REPORT_CDS as select from ZMM_CHEMICAL_STOCK2

{
    key Plant,
    key StorageLocation,
    key Material,
    Material_Description,
    Batch,
    Quantity,
    Quantity_Unit,
    Arrived_In_Plant_Date,
    dats_days_between(  Arrived_In_Plant_Date , SYSTUMDATE ) as ageingdays,
    Arrived_In_Plant_Quantity,
    Purchase_Rate_Per_Unit,
    Currency,
    Valuation_As_Per_Purchase_Rate,
    max(Arrived_In_Location_Date) as Arrived_In_Location_Date,
     sum(  QuantityInEntryUnit ) as QuantityInEntryUnit,
    TotalStockInPlant
} 

group by

Plant,
StorageLocation,
Material,
    Material_Description,
    Batch,
    Quantity,
    Quantity_Unit,
    SYSTUMDATE,
    Arrived_In_Plant_Date,
    Arrived_In_Plant_Quantity,
    Purchase_Rate_Per_Unit,
    Currency,
    Valuation_As_Per_Purchase_Rate,
    TotalStockInPlant
