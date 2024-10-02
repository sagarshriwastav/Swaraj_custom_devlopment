@AbapCatalog.sqlViewName: 'ZINSPECTION_SUMM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'INSPECTION_SUMMRY_FINAL CDS'
define view ZINSPECTION_SUMMRY_fINAL as select from ZINSPECTION_SUMMRY_CDS


{
   
         @UI.lineItem                : [{ position: 10 }]
//         @UI.selectionField          :  [{ position: 10 }]
         @EndUserText.label          : 'Plant'
           key Plant,
           
         @UI.lineItem                : [{ position: 20 }]
         @UI.selectionField          :  [{ position: 20 }]
         @EndUserText.label          : 'PostingDate'
         key PostingDate,
        
        
         @UI.lineItem                : [{ position: 30 }]
         @UI.selectionField          :  [{ position: 30 }]
         @EndUserText.label          : 'MaterialNumber'
         key MaterialNumber,
   
         @UI.lineItem                : [{ position: 40 }]
         @UI.selectionField          :  [{ position: 40 }]
         @EndUserText.label          : 'Batch'
         key  Batch,
   
    
    
         @UI.lineItem                : [{ position: 50 }]
         @UI.selectionField          :  [{ position: 50 }]
         @EndUserText.label          : 'StorageLocation,'
         key StorageLocation,
         
         @UI.lineItem                : [{ position: 60 }]
         @EndUserText.label          : 'RecevingLocation,'
         key RecevingLocation,
         
         
         @UI.lineItem                : [{ position: 70 }]
         @EndUserText.label          : 'OperatorName,'
         key OperatorName,
         
         @UI.lineItem                : [{ position: 80 }]
         @EndUserText.label          : 'InspectionMcNo,'
         key  InspectionMcNo,
         
         @UI.lineItem                : [{ position: 90 }]
         @EndUserText.label          : 'ReGrading,'
         key ReGrading,
//          
//         @UI.lineItem                : [{ position: 100 }]
//         @EndUserText.label          : 'No Of Tp'
//         NoOfTp,
         @UI.lineItem                : [{ position: 110 }]
         @EndUserText.label          : 'Shift'
         key Shift,
         
         
         @UI.lineItem                : [{ position: 120 }]
         @EndUserText.label          : ' UnitField,'
         key UnitField,
         
         @UI.lineItem                : [{ position: 130 }]
         @EndUserText.label          : 'FinishWidth,'
         key FinishWidth,
         
         @UI.lineItem                : [{ position: 140 }]
         @EndUserText.label          : 'Stdwidth'
         key  Stdwidth,
         
         @UI.lineItem                : [{ position: 150 }]
         @EndUserText.label          : 'cutablewidth '
         key cutablewidth ,
         
         @UI.lineItem                : [{ position: 160 }]
         @EndUserText.label          : 'Stdnetwt'
         key  Stdnetwt,
         
//         @UI.lineItem                : [{ position: 170 }]
//         @EndUserText.label          : 'Totalpoint'
//         Totalpoint,
         
//         @UI.lineItem                : [{ position: 180 }]
//         @EndUserText.label          : 'Point4'
//         Point4,
         
//         @UI.lineItem                : [{ position: 190 }]
//         @EndUserText.label          : 'Remark1'
//         Remark1,
         
         @UI.lineItem                : [{ position: 200 }]
         @EndUserText.label          : 'Stdozs'
         key Stdozs,
          
          
         @UI.lineItem                : [{ position: 210 }]
         @EndUserText.label          : 'Party'
         key Party,
          
//           @UI.lineItem                : [{ position: 220 }]
//         @EndUserText.label          : 'Tpremk'
//          Tpremk,
          
          @UI.lineItem                : [{ position: 230 }]
          @DefaultAggregation: #SUM
          @EndUserText.label          : 'RollLength'
          key RollLength,
          
          @UI.lineItem                : [{ position: 240 }]
          @EndUserText.label          : 'SalesOrder'
          key SalesOrder,
          
          @UI.lineItem                : [{ position: 250 }]
          @EndUserText.label          : 'SoItem'
          key SoItem,
          
          
          
          @UI.lineItem                : [{ position: 260 }]
          @UI.selectionField          :  [{ position: 60 }]
          @EndUserText.label          : 'Setno'
          key  Setno,
          
          
          
          @UI.lineItem                : [{ position: 270 }]
          @EndUserText.label          : 'Beam'
          key Beam,
          
          @UI.lineItem                : [{ position: 280 }]
          @EndUserText.label          : 'Setcode'
          key Setcode,
          
          @UI.lineItem                : [{ position: 290 }]
          @EndUserText.label          : 'Trollyno'
          key Trollyno,
          
          
          @UI.lineItem                : [{ position: 300 }]
          @EndUserText.label          : 'DocumentDate'
          key DocumentDate,
          
          @UI.lineItem                : [{ position: 310 }]
          @EndUserText.label          : 'Cancelflag'
          key Cancelflag,
          
          @UI.lineItem                : [{ position: 320 }]
          @EndUserText.label          : 'Dyeingsort'
          key Dyeingsort,
          
          @UI.lineItem                : [{ position: 330 }]
          @EndUserText.label          : 'lanth'
          key lanth,
          
          @UI.lineItem                : [{ position: 340 }]
          @EndUserText.label          : 'batch8'
          key batch8,
          
          @UI.lineItem                : [{ position: 350 }]
          @EndUserText.label          : 'repack'
          key repack,
          
          @UI.lineItem                : [{ position: 360 }]
          @EndUserText.label          : 'Stock'
          key Stock,
          
       
          @UI.lineItem                : [{ position: 370 }]
          @EndUserText.label          : 'EntryUnit'
          key EntryUnit,
          
          
          
          @UI.lineItem                : [{ position: 380 }]
          @EndUserText.label          : 'qty'
          key qty
          
      
          
          
        
         
}
