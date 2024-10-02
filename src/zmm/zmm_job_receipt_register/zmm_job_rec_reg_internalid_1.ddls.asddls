@AbapCatalog.sqlViewName: 'YINTR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Job Receipt Register Report'
define view ZMM_JOB_REC_REG_INTERNALID_1 as select from ZMM_JOB_REC_REG_CDS_INTERNALID
{
 
   key ClfnObjectInternalID,
   key ClfnObjectID,
   ClfnObjectTable,
   ClassType,
   SY_ID,
   case 
   // when SY_ID  = '100' then '0000000819'  
   //when SY_ID = '150' then  '0000000806'
   when SY_ID = '200' then  '0000000807'
     end as Milname,
   
    case 
    // when SY_ID  = '100' then '0000000818' 
    // when SY_ID  = '150' then '0000000807' 
     when SY_ID  = '200' then '0000000806' 
    end as Lotnumber,
   
      case 
      //when SY_ID  = '100' then '0000000814'   
     // when SY_ID  = '150' then '0000000808' 
     when SY_ID  = '200' then '0000000808' 
     end as NoOFbags,
   
      case 
      // when SY_ID  = '100' then '0000000815'   
      // when SY_ID  = '150' then  '0000000809'
      when SY_ID  = '200' then '0000000809' 
       end as Noofcone,
      
       case 
       // when SY_ID  = '100' then '0000000845'   
      // when SY_ID  = '150' then     '0000000845' 
      when SY_ID  = '200' then '0000000810' 
      end as SupplierCsp,
      
       case 
       // when SY_ID  = '100' then '0000000850'   
      // when SY_ID  = '150' then '0000000850' 
      when SY_ID  = '200' then '0000000811' 
      end as SupplierCount,
      
      
       case 
       // when SY_ID  = '100' then '0000000851'   
       // when SY_ID  = '150' then  '0000000851' 
      when SY_ID  = '200' then '0000000812' 
      end as Suppliercvper,
      
      case 
      // when SY_ID  = '100' then '0000000852'   
      // when SY_ID  = '150' then  '0000000852' 
      when SY_ID  = '200' then '0000000813' 
      end as SupplierCountCvPer
      
   
}  where SY_ID is not null 
