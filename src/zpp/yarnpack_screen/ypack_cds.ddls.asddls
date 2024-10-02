//@AbapCatalog.sqlViewName: 'YPACK1'
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
//@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ypack_cds'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.ignorePropagatedAnnotations: true

@AbapCatalog.extensibility: {
  extensible: true,
  elementSuffix: 'YPK',
  allowNewDatasources: false,
  dataSources: ['Persistence'],
  quota: {
    maximumFields: 250,
    maximumBytes: 2500
  }
}
define view entity ypack_cds as select from ypack as Persistence  {
key werks as Werks,
key shift as Shift,
key pdat as Pdat,
key batch as Batch,
key porder as Porder,
key packno as Packno,
key mblnr as Mblnr,
key zbatch as Zbatch,
key zlot_no as ZlotNo,
container as Container,
workcenter as Workcenter,
salesorderit as Salesorderit,
packingtype as Packingtype,
net_wt as NetWt,
grosswt as Grosswt,
grade as Grade,
noofpkg as Noofpkg,
worker as Worker,
remark as Remark,
date1 as Date1,
material as Material,
materialdesc as Materialdesc,
customer as Customer,
coneno as Coneno,
storageloca as Storageloca,
conetip as Conetip,
conacity as Conacity,
coneweight as Coneweight,
lotnumber as Lotnumber,
packedby as Packedby,
orderqty as Orderqty,
deliveredqty as Deliveredqty,
openqty as Openqty,
millnumber as Millnumber,
costcenter as Costcenter,
radiobutton as Radiobutton
}
