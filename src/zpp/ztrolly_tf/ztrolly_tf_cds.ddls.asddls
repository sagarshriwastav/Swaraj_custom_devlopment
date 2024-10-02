@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS For Trolly Transfer Screen'
define root view entity ZTROLLY_TF_CDS as select from I_MaterialStock_2 as a 
        inner join I_ProductDescription as b on ( b.Product = a.Material and b.Language = 'E' )
      
{
   key a.Plant, 
   key a.Material,
   key a.StorageLocation,      
       b.ProductDescription,
       a.Batch,
       a.MatlWrhsStkQtyInMatlBaseUnit,
       a.MaterialBaseUnit,
       a.SDDocument,
       a.SDDocumentItem,
       substring(a.Batch,1 ,4) as SetNo
       
}  where a.MatlWrhsStkQtyInMatlBaseUnit > 0 
