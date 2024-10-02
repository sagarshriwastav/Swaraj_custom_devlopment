@AbapCatalog.sqlViewName: 'YARNPACK_QUERY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'YPACK_CDS_query'
@Analytics.query: true
define view YPACK_CDS_query as select from ypack_cds {
    key Werks,
    key Shift,
    key Pdat,
    key Batch,
    key Porder,
    key Packno,
    key Mblnr,
    key Zbatch,
    key ZlotNo,
    Container,
    Workcenter,
    Salesorderit,
    Packingtype,
    NetWt,
    Grosswt,
    Grade,
    Noofpkg,
    Worker,
    Remark,
    Date1,
    Material,
    Materialdesc,
    Customer,
    Coneno,
    Storageloca,
    Conetip,
    Conacity,
    Coneweight,
    Lotnumber,
    Packedby,
    Orderqty,
    Deliveredqty,
    Openqty,
    Millnumber,
    Costcenter,
    Radiobutton
}
