@AbapCatalog.sqlViewName: 'YMIR7STATUS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Mir7 status report'
define view ZMIR7_STATUS_REPORT_CDS as select from ygateitem1 as a 
           left outer join ygatehead1 as b on ( a.gateno = b.gateno )
           left outer join I_SupplierInvoiceAPI01 as c on ( c.SupplierInvoiceIDByInvcgParty = b.invoice )
                                                           // and substring( c.InvoicingParty,3,4) = a.lifnr )

{
  key a.matnr as material,
      a.gate_qty as Quantity,
      a.lifnr as supplier,
      b.gate_in_date,
      b.gateno,
      b.invoice,
      a.zinvoice,
      case when c.SupplierInvoiceStatus like 'A' then 'PARK'
           when c.SupplierInvoiceStatus like '5' then 'POST'  end as SupplierInvoiceStatus1,
     c.SupplierInvoice as MIR7NO      
      
       
         
}
