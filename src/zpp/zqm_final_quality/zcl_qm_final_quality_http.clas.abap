class ZCL_QM_FINAL_QUALITY_HTTP definition
  public
  create public .
********************CREATED GAJENDRA SINGH SHEKHAWAT*************************************************************
public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_QM_FINAL_QUALITY_HTTP IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.


              data zpp_quality_insp type zpp_quality_insp .

      DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).

          DATA NAME TYPE C LENGTH 20.
            NAME = req[ 2 ]-value.
          DATA(body)  = request->get_text(  )  .



   IF NAME =  'Create'   .

       DATA respo  TYPE zpp_final_quality .

         xco_cp_json=>data->from_string( body )->write_to( REF #( respo ) ).

     DATA sddocument TYPE znumc12 .
    DATA sddocumentITEM TYPE N LENGTH 6 .

        READ TABLE respo-atablearr1 into data(T1) INDEX 1.
      sddocument = t1-salesorder.

data  totalqty1 type  string.
data result type string .
data result1 type string .
DATA MAT TYPE C LENGTH 1.
DATA MATERIAL(18) TYPE C .
DATA CONMATERIAL(18) TYPE C .
*DATA BATCH7 TYPE C LENGTH 7.
*DATA CHECKDATE TYPE C LENGTH 8.
*DATA CHECKDATEERROR TYPE STRING .









loop at  respo-atablearr1  assigning FIELD-SYMBOL(<WAT>).








MAT    = <WAT>-material+0(1).
  SELECT SINGLE * FROM zpp_alphabet_ta1 WHERE alphabet = @MAT INTO @DATA(WA_MAT) .
  IF SY-subrc = '0' .

  IF WA_MAT <> ''.

  <WAT>-material = <WAT>-material .

  ENDIF.
  ELSEIF WA_MAT = '' .
  MATERIAL   =  <WAT>-material .
  <WAT>-material = |{ MATERIAL ALPHA = IN }| .
  <WAT>-material   =  <WAT>-material+22(18) .

  ENDIF.


IF <WAT>-soitem EQ '0'.
<WAT>-soitem = ''.
<WAT>-ind = ''.
else.
<WAT>-soitem = |{ <WAT>-soitem ALPHA = IN }| .
<WAT>-ind = 'E'.
<WAT>-type =  'E'.
ENDIF.
endloop.

*BATCH7 = <WAT>-setno+0(7) .
*
*
*
*SELECT SINGLE * FROM I_MaterialDocumentItem_2 WHERE Batch = @BATCH7 INTO @DATA(WA_BATCH) .
*CHECKDATE =  SY-datum - wa_batch-PostingDate .
*
*IF CHECKDATE > 7 .
*SELECT SINGLE setnumber FROM zpp_approval_tab WHERE setnumber = @BATCH7 INTO  @DATA(WA_APPROVAL) .
*
*
*IF CHECKDATE > 7 AND WA_APPROVAL IS INITIAL .
*CHECKDATEERROR = 'The Greige Receipt date is currently 7 days overdue, so kindly approve this Set Number from Management' .
*response->set_text( CHECKDATEERROR ) .
**result = |ERROR TIME FINISH { CHECKDATE } |.
*
*EXIT .
*ENDIF.
*ENDIF.





      MODIFY ENTITIES OF i_materialdocumenttp
                ENTITY materialdocument
                CREATE FROM VALUE #( ( %cid                          = 'My%CID_1'
                                       goodsmovementcode             = '04'
                                       postingdate                   = sy-datum
                                       documentdate                  = sy-datum
                                       %control-goodsmovementcode                    = cl_abap_behv=>flag_changed
                                       %control-postingdate                          = cl_abap_behv=>flag_changed
                                       %control-documentdate                         = cl_abap_behv=>flag_changed
                                   ) )

                ENTITY materialdocument
                CREATE BY \_materialdocumentitem
                FROM VALUE #(   (
                                %cid_ref = 'My%CID_1'

                                %target = VALUE #( FOR any1 IN respo-atablearr1 INDEX INTO i ( %cid                           = |My%CID_{ i }_001|
*                                  %target = VALUE #( ( %cid = 'My%CID_1_001'

                                                  plant                          = any1-plant
                                                  material                       = any1-material
                                                  GoodsMovementType              = '311'
                                                  storagelocation                = any1-sloc
                                                  QuantityInEntryUnit            =  any1-stockqty
                                                  entryunit                      = 'M'
                                                  Batch                          = any1-batch
                                                  IssuingOrReceivingPlant        = any1-plant
                                                  IssuingOrReceivingStorageLoc   = any1-recloc
                                                  IssgOrRcvgBatch                = any1-batch
                                                  IssgOrRcvgSpclStockInd         = any1-ind    " 'E'
                                                  InventorySpecialStockType      =  any1-type   " 'E'
                                                  SpecialStockIdfgSalesOrder     =  |{ ANY1-salesorder ALPHA = IN }|
                                                  SpecialStockIdfgSalesOrderItem  =  |{ ANY1-soitem ALPHA = IN }|
*                                                  ManufacturingOrder            = '000001000057'
*                                                  GoodsMovementRefDocType       = 'F'
*                                                  IsCompletelyDelivered         = ' '
                                                  MaterialDocumentItemText       =   ''"  'Trolly Transfer'
                                                  %control-plant                 = cl_abap_behv=>flag_changed
                                                  %control-material              = cl_abap_behv=>flag_changed
                                                  %control-GoodsMovementType     = cl_abap_behv=>flag_changed
                                                  %control-storagelocation       = cl_abap_behv=>flag_changed
                                                  %control-QuantityInEntryUnit   = cl_abap_behv=>flag_changed
                                                  %control-entryunit             = cl_abap_behv=>flag_changed
                                                 )     )


                            ) )
               MAPPED   DATA(ls_create_mapped1)
                FAILED   DATA(ls_create_failed1)
                REPORTED DATA(ls_create_reported1).




    COMMIT ENTITIES BEGIN
     RESPONSE OF i_materialdocumenttp
     FAILED DATA(commit_failed1)
     REPORTED DATA(commit_reported1).

  If commit_failed1-materialdocument is NOT INITIAL.
loop at  commit_reported1-materialdocumentitem ASSIGNING FIELD-SYMBOL(<data2>).


data(msz2) =  <data2>-%MSG  .


data(MSZTY) = SY-msgty .
DATA(MSZ_1)  = | { SY-msgv1 } { SY-msgv2 }  { SY-msgv3 } { SY-msgv4 } Message Type- { SY-msgty } Message No { sy-msgno } { SY-msgid } |  .

ENDLOOP .

IF commit_failed1-materialdocumentitem IS INITIAL .

CLEAR mszty .

ENDIF  .

else.

    LOOP AT ls_create_mapped1-materialdocument ASSIGNING FIELD-SYMBOL(<keys_header1>).
IF MSZTY = 'E' .
EXIT .
ENDIF .


      CONVERT KEY OF i_materialdocumenttp
      FROM <keys_header1>-%pid
      TO <keys_header1>-%key .
    ENDLOOP.


    LOOP AT ls_create_mapped1-materialdocumentitem ASSIGNING FIELD-SYMBOL(<keys_item1>).
    IF MSZTY = 'E' .
EXIT .
ENDIF .

*
      CONVERT KEY OF i_materialdocumentitemtp
      FROM <keys_item1>-%pid
      TO <keys_item1>-%key.
    ENDLOOP.

ENDIF.

     COMMIT ENTITIES END.
*******************************
 DATA Json TYPE string.

  IF MSZTY = 'E' .

result = |ERROR { MSZ_1 } |.

ELSE .

  DATA(GRN1)  = <keys_header1>-MaterialDocument .
 result = <keys_header1>-MaterialDocument .
 result1 = <keys_header1>-MaterialDocumentYear .

ENDIF.

    IF result is not INITIAL AND  result1 is not INITIAL .


    DATA WA TYPE zpp_quality_insp .

*****************************HeadarTable Save ********************************

     LOOP AT respo-atablearr1 ASSIGNING FIELD-SYMBOL(<FS>).
     WA-postingdate = SY-datum.
      WA-srno = <FS>-srno.
      WA-plant = <FS>-plant.
      WA-material = <FS>-material .
      WA-batch =  <FS>-batch.
      WA-refbatch =  <FS>-refbatch.
      WA-matdoc_no =  result.
      WA-matdoc_year = result1 .
      WA-sloc =     <FS>-sloc .
      WA-recsloc =  <FS>-recloc.
      WA-salesorder =  <FS>-salesorder.
      WA-setno       =  <FS>-setno .
      WA-loomnumber     =  <FS>-loomno .
      WA-trollyno       =  <FS>-trollyno .
      WA-greigemtr      =  <FS>-greigemtr .
      WA-finishmtr     =  <FS>-finishmtr .
      WA-dyeingsort      =  <FS>-dyeingsort .
      WA-finishrefinish     =  <FS>-ffrf .
      WA-processroute     =  <FS>-processroute .
      WA-partyname      =  <FS>-partyname .
      WA-customername     =  <FS>-customername .
      WA-operatorname     =  <FS>-operatorname .
      WA-stretchstd     =  respo-stpercent .
      WA-stretchperc   =  respo-stpercent .
      WA-munit    =   'M' .
      WA-perunit  =   '%' .
      WA-qatestno = respo-qatestno.


      MODIFY zpp_quality_insp FROM @wa  .
      COMMIT WORK AND WAIT.

    ENDLOOP.

*****************************HeadarTable Save ************************************
*****************************ItemTable Save***************************************

DATA WAItem TYPE zpp_quality_item .
  READ TABLE respo-atablearr1 into data(WA1) INDEX 1.

  LOOP AT respo-atablearr2 ASSIGNING FIELD-SYMBOL(<F2>).
      WAItem-postingdate = SY-datum.
      WAItem-srno = <F2>-srno.
      WAItem-matdoc_no =  result.
      WAItem-matdoc_year = result1 .
      WAItem-zparameter = <F2>-parameter .
      WAItem-refbatch =  WA1-refbatch .
      WAItem-remark = <F2>-remark .
      WAItem-zresult   =  Respo-result.
      WAItem-qatestno = respo-qatestno.

      MODIFY zpp_quality_item FROM @WAItem  .
      COMMIT WORK AND WAIT.

    ENDLOOP.



    ENDIF.

    IF MSZTY = 'E' .

    JSON = result .

  ELSE .

CONCATENATE  ' Material Document '  <keys_header1>-MaterialDocument   ' Post Successfuly '  INTO JSON  SEPARATED BY ' ' .

ENDIF.


ELSEIF   NAME =  'Change'   .


    DATA respo2 TYPE zpp_final_quality_item .

         xco_cp_json=>data->from_string( body )->write_to( REF #( respo2 ) ).


      LOOP AT respo2-atablearr2 ASSIGNING FIELD-SYMBOL(<F22>).
      WAItem-srno = <F22>-srno.
      WAItem-matdoc_no =  respo2-materialdocno.
      WAItem-matdoc_year = respo2-materialdocyear .
      WAItem-zparameter = <F22>-parameter .
      WAItem-refbatch =  respo2-refrencebatch .
      WAItem-remark = <F22>-remark .
      WAItem-zresult   =  respo2-result.
      WAItem-qatestno =   respo2-qatestno.
      WAItem-postingdate = respo2-docdate .

      modify zpp_quality_item FROM @WAItem  .


    ENDLOOP.
    IF sy-subrc IS INITIAL.
          DATA(TABRESULT) =  ' Data Saved!! ' .
        ELSE.
          TABRESULT = 'Error in saving data!!' .
        ENDIF.
     COMMIT WORK AND WAIT.


        JSON = TABRESULT .

ENDIF.
      response->set_text( JSON ) .

  endmethod.
ENDCLASS.
