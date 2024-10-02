@AbapCatalog.sqlViewName: 'YBCO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Bco Report'
define view ZPP_BCO_CDS as select from zpp_bco   as a 
   left outer join I_Product as b on ( b.Product = a.weft1count )
   left outer join I_Product as C on ( C.Product = a.weft2count )
   left outer join I_Supplier as d on ( d.Supplier = a.party )
{
  key party as Party,
  key zdate as Zdate,
  key shortno as Shortno,
  key ' ' as shift,
  key loomno as Loomno,
  dyeingsort as Dyeingsort,
  sizbeemno as Sizbeemno,
  srno as Srno,
  d.SupplierName,
  sizsetno as Sizsetno,
  sizinsrno as Sizinsrno,
  beamissue as Beamissue,
  ends as Ends,
  pickonfabric as Pickonfabric,
  reed as Reed,
  reedspace as Reedspace,
  weft1count as Weft1count,
  b.ProductOldID as Weft1count1,
  weft2count as Weft2count,
  C.ProductOldID   as  Weftcount2,
  millweft1 as Millweft1,
  lotnoweft1 as Lotnoweft1,
  millweft2 as Millweft2,
  lotnoweft2 as Lotnoweft2,
  beamgettingdate ,
  beamfalldate as Beamfalldate,
  beamlength as Beamlength,
  balancemtr as Balancemtr,
  planbeampipe as Planbeampipe,
  beemdia as Beemdia,
  afst as Afst,
  awst as Awst,
  aeffper as Aeffper,
  bfst as Bfst,
  bwst as Bwst,
  beffper as Beffper,
  acshifta as Acshifta,
  acshiftb as Acshiftb,
  rpm as Rpm,
  calshifta as Calshifta,
  calshiftb as Calshiftb,
  case when beamfalldate is not null then 'YES' else
  'NO' end as BeamFallStatus,
  beamonfloorlength ,
  partygreystock  ,
  meter,
  knotting,         
  reknotting,       
  getting                  
}
