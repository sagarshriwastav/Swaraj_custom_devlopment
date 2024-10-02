@AbapCatalog.sqlViewName: 'YARNCON'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Yarn Consumption Report'
define view ZMM_YARN_CONSUMPTION_CDS  
                with parameters 
            @Environment.systemField: #SYSTEM_DATE    
                p_posting:abap.dats,
             @Environment.systemField: #SYSTEM_DATE
                p_posting1:abap.dats
                as select from I_MaterialDocumentItem_2 as a 
inner join ymseg4 as CAN on ( CAN.MaterialDocument = a.MaterialDocument and CAN.MaterialDocumentItem = a.MaterialDocumentItem
                                     and CAN.MaterialDocumentYear = a.MaterialDocumentYear )
 left outer join I_ProductDescription as B on (  B.Product = a.Material and B.Language = 'E')
 left outer join  I_Product as c on ( c.Product = a.Material )
 
{
    
    key a.Material,  
    key a.Batch,
    key a.Plant,
        a.Customer,
        a.MaterialBaseUnit,
        case when a.DebitCreditCode = 'S' and a.GoodsMovementType = '501' then sum( a.QuantityInBaseUnit ) end as YARNRECEIVED,
        case when a.DebitCreditCode = 'H' and a.GoodsMovementType = '502' then sum( a.QuantityInBaseUnit ) end as YARNRETURN,
        B.ProductDescription
    
}   where c.IndustryStandardName = 'E' and ( a.GoodsMovementType = '501' or  a.GoodsMovementType = '502' )
         and a.PostingDate > $parameters.p_posting  and a.PostingDate <= $parameters.p_posting1
    group by 
      a.Material,
      a.Batch,
      a.Plant,
      a.Customer,
      a.MaterialBaseUnit,
      a.DebitCreditCode,
      a.GoodsMovementType,
      B.ProductDescription
