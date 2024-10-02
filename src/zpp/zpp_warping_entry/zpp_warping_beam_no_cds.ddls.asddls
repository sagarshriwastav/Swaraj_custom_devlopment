@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  Warping Entry Beam No F4'
define root view entity ZPP_WARPING_BEAM_NO_CDS as select from zwarp_beam_tmg as a
//       inner join ZPP_WARPING_BEAM_CDS1 as b on ( b.beamno = a.beamno )

{
    
    key a.plant as Plant,
    key a.beamno as Beamno,
        a.beamwt as Beamwt,
        a.remark as Remark
       
}  // where b.Batch = ''
 