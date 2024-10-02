@AbapCatalog.sqlViewName: 'YCHEMICALTEST'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_CHEMICAL_TEST_REPORT_CDS'
define view ZPP_CHEMICAL_TEST_REPORT_CDS as select from zpp_chemical_tab 
{
    key purchaseorder,
        purchaseorderdate,
        suppliercode as supplier,
        suppliername,
        material,
        matdesc,
        hsn as HSNCode,
        gateno as GateEntryNo,
        vehiclenumber,
        partybillnumber,
        partybilldate,
        materialdocumentyear,
        postingdate,
        plant,
        stpragelocation,
        charcvaluedescription as MillName,
        lotno,
        batch,
        testing,
        prquantity,
        orderquantity,
        quantitybaseunit,
        noofbags as NoOfBags,
        testingdate
    
}
