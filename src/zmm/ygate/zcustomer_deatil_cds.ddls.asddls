@AbapCatalog.sqlViewName: 'YGATECUSTOMER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Customer  Detail Gate Entry'
define view ZCUSTOMER_DEATIL_CDS as select from I_Customer
{
    key Customer,
    CustomerAccountGroup,
    CustomerName,
    CustomerFullName,
    StreetName as Addrress,
    IsBusinessPurposeCompleted,
    CreatedByUser
   
} 
 
 group by  
    Customer,
    CustomerAccountGroup,
    CustomerName,
    CustomerFullName,
    StreetName,
    IsBusinessPurposeCompleted,
    CreatedByUser
