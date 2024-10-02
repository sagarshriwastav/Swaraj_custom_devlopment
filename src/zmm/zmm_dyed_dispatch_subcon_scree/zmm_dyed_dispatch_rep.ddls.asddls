@AbapCatalog.sqlViewName: 'YGREYSUBREP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Dyed Beam Dispatch Subcon Report'
define view ZMM_DYED_DISPATCH_REP as select from zmm_dyed_dis_tab
{
    key material as Material,
    key purchaseorder as Purchaseorder,
    key purchaseorderitem as Purchaseorderitem,
    key materialdocument541 as Materialdocument541,
    materialdocumentyear as Materialdocumentyear,
    batch as Batch,
    plant as Plant,
    materialbaseunit as Materialbaseunit,
    storagelocation as Storagelocation,
    matlwrhsstkqtyinmatlbaseunit as Matlwrhsstkqtyinmatlbaseunit,
    productdescription as Productdescription,
    sddocument as Sddocument,
    sddocumentitem as Sddocumentitem,
    greysort as Greysort,
    supplier as Supplier,
    partybeam as Partybeam
}
