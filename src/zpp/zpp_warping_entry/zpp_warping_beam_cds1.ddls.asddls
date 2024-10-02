@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  Warping Entry Beam No F4'
define root view entity ZPP_WARPING_BEAM_CDS1 as select from I_MaterialStock_2 as a 
        inner join zwarping_entry as b on ( b.zfset_no = a.Batch )
{
    key a.Plant,
    key a.Batch,
        b.beamno
    
}  
 where a.Material like 'BW%' 
 