@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPREGEN_EXIM'
define root view entity ZPREGEN_EXI
  as select from zpregen_exim
{
  key docno                as Docno,
  key doctype              as Doctype,
      doc_date             as DocDate,
      refreance_no         as RefreanceNo,
      refreance_date       as RefreanceDate,
      peformano            as Peformano,
      peformadate          as Peformadate,
      deliveryno           as Deliveryno,
      deliverydate         as Deliverydate,
      transporter_name     as TransporterName,
      lrno                 as Lrno,
      lr_date             as LrDate,
      truck_no             as TruckNo,
      blno                 as Blno, 
      bldate               as Bldate, 
      containerno          as Containerno,
      containersize        as Containersize,
      rfid_no              as RfidNo,
      lineseal             as Lineseal,
      vesselno             as Vesselno,
      precarrier           as Precarrier,
      portofdischarge      as Portofdischarge,
      portofloading        as Portofloading,
      epcgno               as Epcgno,
      epcgdate             as Epcgdate,
      remarks              as Remarks,
      remarks1             as Remarks1,
      remarks2             as Remarks2,
      payment_terms        as PaymentTerms,
      deliveryterms        as Deliveryterms,
      incotermslocation    as Incotermslocation,
      shipmentmark         as Shipmentmark,
      shipmentdate         as Shipmentdate,
      weightofcontainer    as Weightofcontainer,
      exportname1          as Exportname1,
      street1              as Street1,
      street2              as Street2,
      street3              as Street3,
      city                 as City,
      country              as Country,
      exporteriecno        as Exporteriecno,
      authorisedsigntory   as Authorisedsigntory,
      designation          as Designation,
      authorisedsigntoryno as Authorisedsigntoryno,
      nameofcustomsbroker  as Nameofcustomsbroker,
      maxperwt             as Maxperwt,
      contareweight        as Contareweight,
      weighslip            as Weighslip,
      shipmenttype         as shipmenttype,
      marksndnumber        as Marksndnumber,
      descgoods            as Descgoods,
      salesdocumentdate    as Salesdocumentdate,
      descgoodsother       as Descgoodsother,
      detailsbylc          as Detailsbylc,
      otherdetails         as Otherdetails,
      billofexchange       as Billofexchange,
      nonnegotiable        as Nonegotiable 

}
