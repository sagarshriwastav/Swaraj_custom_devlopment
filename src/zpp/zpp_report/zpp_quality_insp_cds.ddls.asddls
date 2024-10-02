@AbapCatalog.sqlViewName: 'YQMFININSP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Finish Quality Inspection'
define view ZPP_QUALITY_INSP_CDS as select from zpp_quality_insp as a 
left outer join ZQM_FINAL_QUALITY_REP as b on (b.matdoc_no = a.matdoc_no and b.matdoc_year = a.matdoc_year)
         left outer join I_MaterialDocumentItem_2 as GS on (GS.Batch = a.batch and GS.Material = a.material 
                                                           and GS.StorageLocation = a.sloc and GS.Plant = a.plant 
                                                           and GS.GoodsMovementType = '101' and GS.GoodsMovementIsCancelled = '' ) 
         left outer join I_MaterialDocumentHeader_2 as GSS on ( GSS.MaterialDocument = GS.MaterialDocument 
                                                                and GSS.MaterialDocumentYear = GS.MaterialDocumentYear )  
         left outer join I_MaterialDocumentHeader_2 as GS_GSS on ( GS_GSS.MaterialDocument = a.matdoc_no 
                                                                and GS_GSS.MaterialDocumentYear = a.matdoc_year )  
         left outer join zpp_finishing as GS1  on (  GS.MaterialDocument = GS1.materialdocument101 and GS.MaterialDocumentYear = GS1.materialdocumentyear101 
                                             and GS.Material = GS1.material101 and GS.Batch = GS1.finishrollno             )                                                                                                                
                                                                
{
      key a.srno as Srno,
      key a.plant as Plant,
      key a.material as Material,
      key a.batch as Batch,
      key a.matdoc_no as MatdocNo,
      key a.matdoc_year as MatdocYear,
      key a.qatestno,
      a.refbatch,
      a.postingdate as Postingdate,
      a.sloc as Sloc,
      a.recsloc as Recsloc,
      a.salesorder as Salesorder,
      a.zparameter as Zparameter,
      a.remark as Remark,
      a.zresult as Zresult,
      a.setno as Setno,
      a.loomnumber as Loomnumber,
      a.trollyno as Trollyno,
      a.greigemtr as Greigemtr,
      a.finishmtr as Finishmtr,
      a.dyeingsort as Dyeingsort,
      a.finishrefinish as Finishrefinish,
      a.processroute as Processroute,
      a.partyname as Partyname,
      a.customername as Customername,
      a.operatorname as Operatorname,
      a.stretchstd as Stretchstd,
      a.stretchperc as Stretchperc,
      a.munit as Munit,
      a.perunit as Perunit,
      b.matdoc_no,
      b.matdoc_year,
      b.HeadResult,
      b.FINISHEPI,
      b.FINISHPPI,
      b.FINISHGSM,
      b.FINISHOzYD,
      b.WASHGSM,
      b.SKEWBEFOREA,
      b.SKEWBEFOREB,
      b.SKEWLEVISAC,
      b.SKEWLEVISBD,
      b.SKEWMOVEMENT,
      b.SKEWMOVEMENTLEVIS,
      b.FINISHWIDTHINCH,
      b.FINISHWIDTHCM,
      b.WidthUseableInInch,
      b.WidthUseableInCms,
      b.WASHWIDTHINCH,
      b.WASHWIDTHCM,
      b.RESIDULEWARPSHRINKAGE,
      b.RESIDULEWEFTSHRINKAGE,
      b.BOWING,
      b.REMARK as ItemRemark,
      b.ZRESULT as ItemZresult,
      b.BOWINGPERCENT,
      b.Growth,
      b.GrowthPercent,
      b.TearWarpkgF,
      b.TearWeftkgF,
      b.TensileWarpGram,
      b.TensileWeftGram,
      b.PhValue,
      b.CrockingWET,
      b.CrockingDRY,
      b.Stretch,
      b.StretchPer, 
      GSS.CreationTime as FinshingTime,
      GSS.PostingDate as FinshingDate,
      GS_GSS.CreationTime as QAtime,
      GS_GSS.PostingDate  as QaDate,
      GS1.greywidth

}
