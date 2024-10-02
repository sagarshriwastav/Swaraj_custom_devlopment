@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Draft CDS view'
define root view entity ydraft_bl_cds
  as select from ydraft_bl 
{
  key docno    as Docno,
  key doctype  as Doctype,
  key litem    as Litem,
      material as Material,
      mdesp    as Mdesp,
      lot      as Lot,
      fromto   as Fromto,
      taxid    as Taxid, 
      details  as Details,
    deliveryno as Deliveryno,
   containerno as Containerno
}
