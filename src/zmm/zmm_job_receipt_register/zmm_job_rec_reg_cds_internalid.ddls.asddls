@AbapCatalog.sqlViewName: 'YINTERNALID'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Job Receipt Register Report'
define view ZMM_JOB_REC_REG_CDS_INTERNALID as select from 
           I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  )
{
   key $session.user as CLIENT,
   key ClfnObjectInternalID,
   key ClfnObjectID,
       ClfnObjectTable,
       ClassType,
       case 
       //when CharcInternalID  = '0000000819'  then  '100'
       //when CharcInternalID =    '0000000806' then '150'
       when CharcInternalID =    '0000000807' then '200'
        end as SY_ID
       
   
}
   
