@AbapCatalog.sqlViewName: 'YCHEMICALFINAL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_CHEMICAL_TEST_FINAL_CDS'
define view ZPP_CHEMICAL_TEST_FINAL_CDS as select from ZPP_CHEMICAL_TEST_REPORT_CDS as a 
             left outer join ZPP_CHEMICAL_TEST_PARAMTR_CDS as b on ( a.partybillnumber = b.Partybillnumber )
{
    key a.purchaseorder,
        a.purchaseorderdate,
        a.supplier,
        a.suppliername,
        a.material,
        a.matdesc,
        a.HSNCode,
        a.GateEntryNo,
        a.vehiclenumber,
        a.partybillnumber,
        a.partybilldate,
        a.materialdocumentyear,
        a.postingdate,
        a.plant,
        a.stpragelocation,
        a.MillName,
        a.lotno,
        a.batch,
        a.testing,
        a.prquantity,
        a.orderquantity,
        a.quantitybaseunit,
        a.NoOfBags,
        a.testingdate,
        b.MOISTURE,
        b.PURITY,
        b.SOLIDCONTENT,
        b.SELFPh,
        b.DRAVETEST,
        b.DENSITY,
        b.RF,
        b.VISCOSITY,
        b.ODURE,
        b.COLOR
      
}
