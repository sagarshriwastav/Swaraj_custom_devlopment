@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For SortMaster Denim'
define root view entity ZPP_SORTMASTER_CDS as select from zpp_sortmaster  as a 
        left outer join I_ProductDescription as b on ( b.Product = a.material and b.Language = 'E' )
        left outer join ZPC_HEADERMASTER_CDS as c on ( c.Zpunit = a.plant  )
//        left outer join ZPP_MAT_DES_CDS AS D ON ( D.Product = a.material and d.Dyeingsort = a.dyeingsort )
        

{
   key a.material as Material,
   key a.plant as Plant,
   key a.pdno as Pdno,
   a.pdcode,
   a.dyeingsort as Dyeingsort,
   a.mattype as Mattype,
   a.reed as Reed,
   a.dent as Dent,
   a.epi as Epi,
   a.warpcount1 as Warpcount1,
   a.warptype1 as Warptype1,
   a.warptypedesc1,
   a.ratiowarpper1 as Ratiowarpper1,
   a.warpcount2 as Warpcount2,
   a.warptype2 as Warptype2,
   a.warptypedesc2,
   a.ratiowarpper2 as Ratiowarpper2,
   a.warpcount3 as Warpcount3,
   a.warptype3 as Warptype3,
   a.warptypedesc3,
   a.ratiowarpper3 as Ratiowarpper3,
   a.weftcount1 as Weftcount1,
   a.wefttype1 as Wefttype1,
   a.wefttypedesc1,
   a.ratioweftper1 as Ratioweftper1,
   a.weftcount2 as Weftcount2,
   a.wefttype2 as Wefttype2,
   a.wefttypedesc2,
   a.ratioweftper2 as Ratioweftper2,
   a.weftcount3 as Weftcount3,
   a.wefttype3 as Wefttype3,
   a.wefttypedesc3,
   a.ratioweftper3 as Ratioweftper3,
   a.weftcount4 as Weftcount4,
   a.wefttype4 as Wefttype4,
   a.wefttypedesc4,
   a.ratioweftper4 as Ratioweftper4,
   a.pick as Pick,
   a.reedspace as Reedspace,
   a.extraends as Extraends,
   a.totalends as Totalends,
   a.dyeingshade as Dyeingshade,
   a.shadepercen as shadepercen,
   a.shadepercen2,
   a.shadepercen3,
   a.weave as Weave,
   a.design as Design,
   a.processroute as processroute,
   a.remark as Remark1,
   a.shrinkage as Shrinkage,
   a.greiegewidthinch as greiegewidthinch,
   a.stdwidthinch as Stdwidthinch,
   a.stdwidthcms as Stdwidthcms,
   a.stdweight as Stdweight,
   a.weight as Weight,
   case when a.finwd is initial then
   a.stdwidthcms  else a.finwd end  as Finwd,
   a.tareweight as Tareweight,
   a.remark2 as Remark2,
   a.samplingweight as Samplingweight,
   a.washweight as Washweight,
   a.stretch as Stretch,
   a.warpshrinkageperc as warpshrinperce,
   a.weftshrinkageperc as weftshrinperce,
   a.greypotentialwarpperc as greypotentialwarpper,
   a.sort as Sort,
   a.finishtype as Finishtype,
   a.blend as Blend,
   a.loomtype as Loomtype,
   a.compostion as Compostion,
   a.fepi as Fepi,
   a.fppi as Fppi,
   b.ProductDescription,
   a.gsm,
   a.stdwidthinchtolerance,
   a.stdweighttolerance ,
   a.stretchpertolerance,
   a.wapshirnakgeperfrom,
   c.Zpbrand as Department
   
}  
  group by 
   a.material,
   a.plant,
   a.pdno,
   a.pdcode,
   a.dyeingsort,
   a.mattype,
   a.reed,
   a.dent,
   a.epi,
   a.warpcount1,
   a.warptype1,
   a.warptypedesc1,
   a.ratiowarpper1,
   a.warpcount2,
   a.warptype2,
   a.warptypedesc2,
   a.ratiowarpper2,
   a.warpcount3,
   a.warptype3,
   a.warptypedesc3,
   a.ratiowarpper3,
   a.weftcount1,
   a.wefttype1,
   a.wefttypedesc1,
   a.ratioweftper1,
   a.weftcount2,
   a.wefttype2,
   a.wefttypedesc2,
   a.ratioweftper2,
   a.weftcount3,
   a.wefttype3,
   a.wefttypedesc3,
   a.ratioweftper3,
   a.weftcount4,
   a.wefttype4,
   a.wefttypedesc4,
   a.ratioweftper4,
   a.pick,
   a.reedspace,
   a.extraends,
   a.totalends,
   a.dyeingshade,
   a.shadepercen,
   a.shadepercen2,
   a.shadepercen3,
   a.weave,
   a.design,
   a.processroute,
   a.remark,
   a.shrinkage,
   a.greiegewidthinch,
   a.stdwidthinch,
   a.stdwidthcms,
   a.stdweight,
   a.weight,
   a.finwd,
   a.stdwidthcms,
   a.tareweight,
   a.remark2,
   a.samplingweight,
   a.washweight,
   a.stretch,
   a.warpshrinkageperc,
   a.weftshrinkageperc,
   a.greypotentialwarpperc,
   a.sort,
   a.finishtype,
   a.blend,
   a.loomtype,
   a.compostion,
   a.fepi,
   a.fppi,
   b.ProductDescription,
   a.gsm,
   a.stdwidthinchtolerance,
   a.stdweighttolerance ,
   a.stretchpertolerance,
   a.wapshirnakgeperfrom,
   c.Zpbrand
   