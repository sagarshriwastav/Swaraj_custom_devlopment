@AbapCatalog.sqlViewName: 'YARNPRINTNETWT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Yarn Facory Beam Print'
define view Yarn_Factory_Beam_Desp_WT_CDS 
   with parameters  
          @Environment.systemField: #SYSTEM_DATE    
                p_posting:abap.dats,
             @Environment.systemField: #SYSTEM_DATE
                p_posting1:abap.dats
as select from  I_MaterialDocumentItem_2 as a 
  inner join ymseg4 as b on (b.MaterialDocument = a.MaterialDocument 
                             and b.MaterialDocumentItem = a.MaterialDocumentItem
                             and b.MaterialDocumentYear = a.MaterialDocumentYear )
   left outer join ZJOB_GREY_NETWT_DISPATCH_CDS as c on ( c.Material = a.Material and c.Recbatch = a.Batch )
{
       key a.MaterialDocument,
       key a.Material,
       key a.MaterialDocumentYear,
        sum( c.Netwt ) as Netwt
} where a.GoodsMovementType = '601' 
  and  a.PostingDate between $parameters.p_posting and $parameters.p_posting1 
group by 

     a.MaterialDocument,
     a.Material,
     a.MaterialDocumentYear
