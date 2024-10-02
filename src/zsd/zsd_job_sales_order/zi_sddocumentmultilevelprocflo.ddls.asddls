@AbapCatalog.sqlViewName: 'YSDFLOW'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For SD Document'
define view ZI_SDDocumentMultiLevelProcFlo as select from I_SDDocumentMultiLevelProcFlow
{
    key DocRelationshipUUID,
    PrecedingDocument,
    PrecedingDocumentItem,
    PrecedingDocumentCategory,
    SubsequentDocument,
    SubsequentDocumentItem,
    SubsequentDocumentCategory,
    ProcessFlowLevel,
    CreationDate,
    CreationTime,
    LastChangeDate,
    QuantityInBaseUnit,
    RefQuantityInOrdQtyUnitAsFloat,
    RefQuantityInBaseUnitAsFloat,
    BaseUnit,
    OrderQuantityUnit,
    SDFulfillmentCalculationRule,
    NetAmount,
    StatisticsCurrency,
    TransferOrderInWrhsMgmtIsConfd,
    WarehouseNumber,
    MaterialDocumentYear,
    BillingPlan,
    BillingPlanItem,
    /* Associations */
    _BaseUnit,
    _OrderQuantityUnit,
    _StatisticsCurrency
}
