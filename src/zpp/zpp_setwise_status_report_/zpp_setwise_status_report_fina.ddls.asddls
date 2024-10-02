@AbapCatalog.sqlViewName: 'YSETFINAL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_SETWISE_STATUS_REPORT_FINA'
define view ZPP_SETWISE_STATUS_REPORT_FINA as select from ZPP_SETWISE_STATUS_REPORT_CDS as a
              left outer join ZPP_SETWISE_DYEING_CDS as b on ( b.Setno = a.SetNo )
              left outer join ZPP_SETWISE_WEAVING_CDS as c on ( c.setno = a.SetNo )
              left outer join ZPP_SETWISE_FINISHING_CDS as d on ( d.Set_code = a.SetNo )
              left outer join ZPP_SETWISE_GREADING_CDS as e on ( e.Setno = a.SetNo )
{
    key a.SetNo as WarpSetNo,
        a.PostingDate as WarpDate,
        a.Beamno as WarpBeam,
        a.Totends as Totalends,
        a.Ends as WarpEnds,
        a.Length as WarpLength,
        a.zunit ,
        a.SortNo as WarpSortNo,
        @Semantics.quantity.unitOfMeasure: 'zunit'
        a.Grooswt as WarpGrooswt,
        @Semantics.quantity.unitOfMeasure: 'zunit'
        a.Tarewt as WarpTarewt,
        @Semantics.quantity.unitOfMeasure: 'zunit'
        a.Netwt as WarpNetwt,
        a.Breaks as WarpBreaks,
        a.Warper ,
        
        b.SortNo as  DyeSort,
        b.PostingDate as DyeDate,
        b.Beamno as DyeBeam,
        b.luom,
        @Semantics.quantity.unitOfMeasure : 'luom'
        b.Length as DyeLength,
        b.Remark as DyeRemark,
        b.Greyshort as DyeGreyshort,
        b.wuom,
        @Semantics.quantity.unitOfMeasure : 'Wuom'
        b.Netweight as DyeNetweight,    
        @Semantics.quantity.unitOfMeasure : 'Wuom'
        b.Tareweight as DyeTareweight,
        @Semantics.quantity.unitOfMeasure : 'Wuom'
        b.Grossweight as DyeGrossweight,
        
        c.Batch as WvngBeamNo,
        c.Postingdate as WvngDate,
        c.GreySort as WvngGreySort,
        c.Partyname as WvngPartyname,
        c.Partybeam as WvngPartybeam,
        c.Uom,
        @Semantics.quantity.unitOfMeasure : 'uom'
        c.Quantity as WeavingLength,
        
        d.BeamNo as FinishBeamno,
        d.Postingdate as FinishDate,
        d.Material101 as FinishMaterial101,
        d.Material261 as FinishMaterial261,
        d.Zunit as FinishZunit,
        @Semantics.quantity.unitOfMeasure : 'zunit'
        d.Greymtr as FinishGreymtr,
        @Semantics.quantity.unitOfMeasure : 'zunit'
        d.Finishmtr as Finishmtr,
        d.Shrinkageperc as FinishShrinkageperc,
        @Semantics.quantity.unitOfMeasure : 'zunit'
        d.Actualmtr as FinishActualmtr,
        
        e.Sortno as GredSortno,
        e.PostingDate,
        e.PackGrade as GredPackGrade,
        e.RollLength as GreyRollLength,
        e.Dyeingsort as GredDyeingsort
        
        
        
        
        
        
}
