@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BIMWISE SUBCON DISPATCH REPORT'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZBEAMWISE_SUB_DISPAT_CDS as select from zpp_dyeing1 as a  
      left outer join I_MaterialDocumentItem_2 as b on ( b.MaterialDocument = a.materialdocument 
                                                       and b.MaterialDocumentYear = a.materialdocumentyear 
                                                       and b.Material = a.material 
                                                       and b.Batch = a.beamno )
      inner join ymseg4 as C on ( C.MaterialDocument = b.MaterialDocument 
                                     and C.MaterialDocumentItem = b.MaterialDocumentItem
                                     and C.MaterialDocumentYear = b.MaterialDocumentYear)
      left outer join ZBEAMWISE_MINIMUM_DOC_CDS as minbacth on ( minbacth.Batch = a.beamno
                                                                and minbacth.Plant = a.plant )                               
      inner join ZBEAMWISE_SUB_DOC_CDS as D on ( D.MaterialDocument = minbacth.materialdocument 
                                                    and D.MaterialDocumentItem =  minbacth.MaterialDocumentItem
                                                    and D.Plant = minbacth.Plant  )
     left outer join I_BillingDocumentItem as bill on ( bill.ReferenceSDDocument = D.MaterialDocument 
                                      and bill.ReferenceSDDocumentItem = D.ZMaterialDocumentItem )                                               
     left outer join I_Supplier as e on ( e.Supplier = D.Supplier )   
     left outer join I_PurchaseContractHistoryAPI01 as f on ( f.ReleaseOrder = D.PurchaseOrder and f.ReleaseOrderItem = D.PurchaseOrderItem )    
{
    key a.plant as Plant,
    key a.setno as Setno,
    key a.beamno as Beamno,
    key a.material as Material,
    key a.materialdocument as Materialdocument,
    key b.MaterialDocumentItem as Materialdocumentitem,
    key a.materialdocumentyear as Materialdocumentyear,
    a.zorder as Zorder,
    a.hremark1 as Hremark1,
    a.hremark2 as Hremark2,
    a.pipenumber as Pipenumber,
    cast('M' as abap.unit( 3 ) ) as luom,
    cast('KG' as abap.unit( 3 ) ) as wuom,
    @Semantics.quantity.unitOfMeasure : 'luom'
    a.length as Length,
    @Semantics.quantity.unitOfMeasure : 'Wuom'
    a.netweight as Netweight,    
    @Semantics.quantity.unitOfMeasure : 'Wuom'
    a.tareweight as Tareweight,
    @Semantics.quantity.unitOfMeasure : 'Wuom'
    a.grossweight as Grossweight,
    @Semantics.quantity.unitOfMeasure : 'Wuom'
    a.avgweight as Avgweight,
    @Semantics.quantity.unitOfMeasure : 'Wuom'
    a.unsizedwt as Unsizedwt,
    @Semantics.quantity.unitOfMeasure : 'Wuom'
    a.sizedwt as Sizedwt,
    a.shade as Shade,
    a.optname as Optname,
    a.shift as Shift,
    a.greyshort as Greyshort,
    a.remark as Remark,
    a.totends,
    D.PurchaseOrder,
    D.PurchaseOrderItem,
    minbacth.materialdocument as documentno541,
    minbacth.MaterialDocumentItem as documentitemno541,
    e.SupplierName as Supplier,
    bill.BillingDocument,
    D.PostingDate,
    
    b.GoodsMovementType,
  //  f.ConditionRateAmount
    f.PurchaseContract
    
    
} where bill.BillingDocument is not null 


    
