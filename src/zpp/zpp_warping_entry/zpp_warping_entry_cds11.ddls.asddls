@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  Warping Entry Module Pool'
define root view entity ZPP_WARPING_ENTRY_CDS11 as select from zwarping_entry

{
    key zfset_no as ZfsetNo,
    key zmc_no as ZmcNo,
    key material as Material,
    zlength as Zlength,    
    ends as Ends,
    beamno as Beamno,
    beamlenght as Beamlenght,
    @Semantics.quantity.unitOfMeasure : 'zunit'
    grooswt as Grooswt,
     @Semantics.quantity.unitOfMeasure : 'zunit'
    tarewt as Tarewt,
     @Semantics.quantity.unitOfMeasure : 'zunit'
    netwt as Netwt,
    rpm as Rpm,
    warper as Warper,
    zcount as Zcount,
    zunit,
    breaks, 
    breaksmtr,
    zdate
}
