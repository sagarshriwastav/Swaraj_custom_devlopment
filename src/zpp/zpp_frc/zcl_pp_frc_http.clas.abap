class ZCL_PP_FRC_HTTP definition
  public
  create public .
********************CREATED GAJENDRA SINGH SHEKHAWAT*************************************************************
public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.


TYPES:BEGIN OF TY_HEAD,
      MAT   TYPE C LENGTH 10,
      PLANT TYPE C LENGTH 4,
      LOC TYPE C LENGTH 4,
      BATCH TYPE C LENGTH 10,
      N     TYPE I,
      BALE_QTY TYPE P LENGTH 13 DECIMALS 2,
      NO_BALE TYPE I,
  END OF TY_HEAD.
DATA: WA_HEAD TYPE  TY_HEAD,
      IT_HEAD TYPE TABLE OF TY_HEAD.

   TYPES:BEGIN OF TY_HEAD411,

          mat         TYPE C LENGTH 40,
         issuingbatch TYPE C LENGTH 20,
         qty          TYPE  P  LENGTH 13 DECIMALS 3,
         uom          TYPE C LENGTH 3,
         salesoder    TYPE C LENGTH 12,
         soitem       TYPE N LENGTH 6,
         ind          TYPE C LENGTH 1,
    END OF TY_HEAD411.
   DATA: WA_HEAD411 TYPE  TY_HEAD411,
         IT_HEAD411 TYPE TABLE OF TY_HEAD411.

    DATA: WA_HEAD309 TYPE  TY_HEAD411,
         IT_HEAD309 TYPE TABLE OF TY_HEAD411.





private section.
ENDCLASS.



CLASS ZCL_PP_FRC_HTTP IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

    DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).

    DATA(body)  = request->get_text(  )  .
    DATA productionorder TYPE znumc12 .

    DATA respo  TYPE zpp_frc_str .


    xco_cp_json=>data->from_string( body )->write_to( REF #( respo ) ).

    READ TABLE respo-atablearr1 INTO DATA(WA) INDEX 1.

************************************NUMBRE RANGE START *****************************************************

    DATA nrrangenr TYPE CHAR2.
    DATA nrrangenr2 TYPE char8.
    DATA YEAR    TYPE NUMC4.
        YEAR = SY-DATUM+0(4).
        nrrangenr2 = req[ 2 ]-value.

     nrrangenr = req[ 3 ]-value.

************************************NUMBRE RANGE Good Cut *****************************************************

IF nrrangenr2 = 'Good Cut' .

    DATA: nr_number     TYPE cl_numberrange_runtime=>nr_number.
    TRY.
        CALL METHOD cl_numberrange_runtime=>number_get
          EXPORTING
            nr_range_nr = nrrangenr "'01'
            object      = 'ZFRC_NUM'
             toyear     =  YEAR
            quantity    = 000000001
          IMPORTING
            number      = nr_number.


      CATCH cx_nr_object_not_found.
      CATCH cx_number_ranges.
    ENDTRY.
    SHIFT nr_number LEFT DELETING LEADING '0'.
    DATA: lv_nr TYPE C LENGTH 9.
    lv_nr = |{ nr_number ALPHA = OUT }|.
*  * lv_nr = NR_NUMBER.


   DATA  NUMBRER TYPE C LENGTH 10 .
     IF nrrangenr2+0(1)  =  'G' .
     IF respo-gctype = 'CL' .
     CONCATENATE 'GC' lv_nr INTO NUMBRER.
     ELSEIF respo-gctype = 'PL' .
     CONCATENATE 'GP' lv_nr INTO NUMBRER.
      ELSEIF respo-gctype = 'POLY KNIT' .
     CONCATENATE 'GK' lv_nr INTO NUMBRER.
     ENDIF.
    ENDIF.

************************************NUMBRE RANGE END Good Cut *****************************************************
    ELSE.

************************************NUMBRE RANGE START FRC ********************************************************

    DO respo-noofbale   TIMES .

 TRY.
        CALL METHOD cl_numberrange_runtime=>number_get
          EXPORTING
            nr_range_nr = nrrangenr "'01'
            object      = 'ZFRC_NUM'
             toyear     =  YEAR
            quantity    = 000000001
          IMPORTING
            number      = nr_number.


      CATCH cx_nr_object_not_found.
      CATCH cx_number_ranges.
    ENDTRY.
    SHIFT nr_number LEFT DELETING LEADING '0'.
    DATA: lv_nr2 TYPE C LENGTH 9.
    lv_nr2 = |{ nr_number ALPHA = OUT }|.

   IF lv_nr2 IS NOT INITIAL.

      SHIFT lv_nr2 LEFT DELETING LEADING '0'.
      CONDENSE lv_nr2 NO-GAPS.

     DATA  NUMBRER1 TYPE C LENGTH 10 .
     IF nrrangenr2+0(1)  =  'F' .
     CONCATENATE 'F' lv_nr2 INTO NUMBRER1.

     ELSEIF nrrangenr2+0(1)  =  'R' .
     CONCATENATE 'R' lv_nr2 INTO NUMBRER1.

     ELSEIF nrrangenr2+0(1)  =  'C' .
     CONCATENATE 'C' lv_nr2 INTO NUMBRER1.

     ELSEIF nrrangenr2+0(1)  =  'K' .
     CONCATENATE 'K' lv_nr2 INTO NUMBRER1.

     ENDIF.

      WA_HEAD-BATCH = NUMBRER1.
*      SHIFT lv_nr2 LEFT DELETING LEADING '0'.
*      CONDENSE lv_nr2 NO-GAPS.
*      lv_nr2 = lv_nr2 + 1.
*      SHIFT lv_nr2 LEFT DELETING LEADING '0'.
*      CONDENSE lv_nr2 NO-GAPS.
    ENDIF.
    APPEND WA_HEAD TO IT_HEAD .
ENDDO .
   CLEAR:lv_nr2.
   ENDIF.


************************************NUMBRE RANGE END FRC ************************************************

************************************NUMBRE RANGE END ******************************************************

***************************************411E START *********************************************************
   DATA MAT TYPE C LENGTH 1.
   DATA MATERIAL(18) TYPE C .

LOOP AT respo-atablearr1 INTO DATA(WAT411).

  IF WAT411-salesoder IS NOT INITIAL .
  MAT    = WAT411-mat+0(1).
  SELECT SINGLE * FROM zpp_alphabet_ta1 WHERE alphabet = @MAT INTO @DATA(WA_MAT) .

  IF SY-subrc = '0' .
  IF WA_MAT <> ''.
  wa_head411-mat = WAT411-mat .
  ENDIF.

  ELSEIF WA_MAT = '' .
  MATERIAL   =  WAT411-mat .
  wa_head411-mat = |{ MATERIAL ALPHA = IN }| .
  wa_head411-mat   =  wa_head411-mat+22(18) .
  ENDIF.
*    wa_head411-mat = wat411-mat.
    wa_head411-issuingbatch = wat411-issuingbatch.
    wa_head411-qty  = wat411-qty .
    wa_head411-salesoder = wat411-salesoder .
    wa_head411-soitem = wat411-soitem .
    wa_head411-uom = wat411-uom .

      APPEND WA_HEAD411 TO IT_HEAD411 .
 ENDIF.
ENDLOOP.
  CLEAR : WA_HEAD411 .


IF  nrrangenr2 = 'Good Cut' .

***************************************411E START  Good Cut ***********************************************
IF IT_HEAD411 IS NOT INITIAL .

 MODIFY ENTITIES OF i_materialdocumenttp
             ENTITY MaterialDocument
             CREATE FROM VALUE #( ( %cid                          = 'My%CID_1'
                                    goodsmovementcode             = '04'
                                    postingdate                   = respo-postingdate
                                    documentdate                  =   sy-datum
                                    %control-goodsmovementcode                    = cl_abap_behv=>flag_changed
                                    %control-postingdate                          = cl_abap_behv=>flag_changed
                                    %control-documentdate                         = cl_abap_behv=>flag_changed
                                ) )


             ENTITY MaterialDocument
             CREATE BY \_MaterialDocumentItem
             FROM VALUE #( (
                             %cid_ref = 'My%CID_1'
                             %target = VALUE #( FOR any IN IT_HEAD411 index INTO i  ( %cid    = |My%CID_{ i }_001|
                                                  plant                          = respo-plant
                                                  material                       = any-mat
                                                  GoodsMovementType              = '411'
                                                  inventoryspecialstocktype        = 'E'
                                                  storagelocation                = respo-storagelocation
                                                  QuantityInEntryUnit            =  any-qty
                                                  entryunit                      = 'M'
                                                  Batch                          = any-issuingbatch
                                                  IssuingOrReceivingPlant        = respo-plant
                                                  IssuingOrReceivingStorageLoc   = respo-recstoloc
                                                  IssgOrRcvgBatch                = NUMBRER
                                                  IssgOrRcvgMaterial             = respo-recevingmaterial
                                                  IssgOrRcvgSpclStockInd         = ''
                                                  specialstockidfgsalesorder     =  |{ any-salesoder ALPHA = IN }|
                                                    specialstockidfgsalesorderitem  = |{ any-soitem ALPHA = IN }|
*                                                  ManufacturingOrder             = '000001000057'
*                                                  GoodsMovementRefDocType        = 'F'
*                                                  IsCompletelyDelivered          = ' '
                                                  iscompletelydelivered          = ' '
                                                  MaterialDocumentItemText       =    'Good Cut'
                                                  %control-plant                 = cl_abap_behv=>flag_changed
                                                  %control-material              = cl_abap_behv=>flag_changed
                                                  %control-GoodsMovementType     = cl_abap_behv=>flag_changed
                                                  %control-storagelocation       = cl_abap_behv=>flag_changed
                                                  %control-QuantityInEntryUnit   = cl_abap_behv=>flag_changed
                                                  %control-entryunit             = cl_abap_behv=>flag_changed
                                              ) )


                         ) )
             MAPPED   DATA(ls_create_mapped411)
             FAILED   DATA(ls_create_failed411)
             REPORTED DATA(ls_create_reported411).

  COMMIT ENTITIES BEGIN
   RESPONSE OF i_materialdocumenttp
   FAILED DATA(commit_failed411)
   REPORTED DATA(commit_reported411).

IF commit_failed411-materialdocument IS NOT INITIAL .

     LOOP AT  commit_reported411-materialdocumentitem ASSIGNING FIELD-SYMBOL(<data411>).

          DATA(msz411) =  <data411>-%msg  .

          DATA(mszty411) = sy-msgty .
          DATA(msz_1411)  = | { sy-msgv1 } { sy-msgv2 }  { sy-msgv3 } { sy-msgv4 } Message Type- { sy-msgid } Message No { sy-msgno }  |  .

        ENDLOOP .

IF commit_failed411-materialdocument IS INITIAL .

CLEAR mszty411 .
ENDIF .

ELSE .


     LOOP AT ls_create_mapped411-materialdocument ASSIGNING FIELD-SYMBOL(<keys_header411>).

     IF MSZTY411 = 'E' .
EXIT .
ENDIF .

      CONVERT KEY OF i_materialdocumenttp
      FROM <keys_header411>-%pid
      TO <keys_header411>-%key .
    ENDLOOP.


    LOOP AT ls_create_mapped411-materialdocumentitem ASSIGNING FIELD-SYMBOL(<keys_item411>).

    IF MSZTY411 = 'E' .
EXIT .
ENDIF .
*
      CONVERT KEY OF i_materialdocumentitemtp
      FROM <keys_item411>-%pid
      TO <keys_item411>-%key.
    ENDLOOP.

    ENDIF.

COMMIT ENTITIES END .
data result41 type string .
data result411 type string .

      IF  MSZTY411 = 'E' .

result41 = |Error { MSZ_1411 } |.

ELSE .

DATA(GRN411)  = <keys_header411>-MaterialDocument .


result41 = <keys_header411>-MaterialDocument .
result411 = <keys_header411>-MaterialDocumentYear.
ENDIF.
***************************************411E END Good Cut ***********************************************
ENDIF.
   DATA MAT309 TYPE C LENGTH 1.
   DATA MATERIAL309(18) TYPE C .

LOOP AT respo-atablearr1 INTO DATA(WAT309).

    IF WAT309-salesoder IS INITIAL .

  MAT    = wat309-mat+0(1).
  SELECT SINGLE * FROM zpp_alphabet_ta1 WHERE alphabet = @MAT INTO @DATA(WA_MAT309) .

  IF SY-subrc = '0' .

  IF WA_MAT309 <> ''.
  wa_head309-mat = WAT309-mat .
  ENDIF.

  ELSEIF WA_MAT309 = '' .
  MATERIAL   =  WAT309-mat .
  wa_head309-mat = |{ MATERIAL ALPHA = IN }| .
  wa_head309-mat   =  wa_head309-mat+22(18) .
  ENDIF.

*    wa_head309-mat = wat309-mat.
    wa_head309-issuingbatch = wat309-issuingbatch.
    wa_head309-qty  = wat309-qty .
    wa_head309-salesoder = wat309-salesoder .
    wa_head309-soitem = wat309-soitem .
    wa_head309-uom = wat309-uom .

      APPEND WA_HEAD309 TO IT_HEAD309 .
 ENDIF.
ENDLOOP.
  CLEAR : WA_HEAD309 .

IF IT_HEAD309 IS NOT INITIAL .

***************************************309 START Good Cut ***********************************************

 MODIFY ENTITIES OF i_materialdocumenttp
             ENTITY MaterialDocument
             CREATE FROM VALUE #( ( %cid                          = 'My%CID_1'
                                    goodsmovementcode             = '04'
                                    postingdate                   = respo-postingdate
                                    documentdate                  =   sy-datum
                                    %control-goodsmovementcode                    = cl_abap_behv=>flag_changed
                                    %control-postingdate                          = cl_abap_behv=>flag_changed
                                    %control-documentdate                         = cl_abap_behv=>flag_changed
                                ) )


             ENTITY MaterialDocument
             CREATE BY \_MaterialDocumentItem
             FROM VALUE #( (
                             %cid_ref = 'My%CID_1'
                             %target = VALUE #( FOR any309 IN IT_HEAD309 index INTO i  ( %cid    = |My%CID_{ i }_001|
                                                  plant                          = respo-plant
                                                  material                       = any309-mat
                                                  GoodsMovementType              = '309'
                                                  inventoryspecialstocktype        = ''
                                                  storagelocation                = respo-storagelocation
                                                  QuantityInEntryUnit            =  any309-qty
                                                  entryunit                      = 'M'
                                                  Batch                          = any309-issuingbatch
                                                  IssuingOrReceivingPlant        = respo-plant
                                                  IssuingOrReceivingStorageLoc   = respo-recstoloc
                                                  IssgOrRcvgBatch                = NUMBRER
                                                  IssgOrRcvgMaterial             = respo-recevingmaterial
                                                  IssgOrRcvgSpclStockInd         = ''
                                                  iscompletelydelivered          = ' '
                                                  MaterialDocumentItemText       =    'Good Cut'
                                                  %control-plant                 = cl_abap_behv=>flag_changed
                                                  %control-material              = cl_abap_behv=>flag_changed
                                                  %control-GoodsMovementType     = cl_abap_behv=>flag_changed
                                                  %control-storagelocation       = cl_abap_behv=>flag_changed
                                                  %control-QuantityInEntryUnit   = cl_abap_behv=>flag_changed
                                                  %control-entryunit             = cl_abap_behv=>flag_changed
                                              ) )


                         ) )
             MAPPED   DATA(ls_create_mapped309)
             FAILED   DATA(ls_create_failed309)
             REPORTED DATA(ls_create_reported309).

  COMMIT ENTITIES BEGIN
   RESPONSE OF i_materialdocumenttp
   FAILED DATA(commit_failed309)
   REPORTED DATA(commit_reported309).

  IF commit_failed309-materialdocument IS NOT INITIAL .

     LOOP AT  commit_reported309-materialdocumentitem ASSIGNING FIELD-SYMBOL(<data309>).

          DATA(msz309) =  <data309>-%msg  .

          DATA(mszty309) = sy-msgty .
          DATA(msz_1309)  = | { sy-msgv1 } { sy-msgv2 }  { sy-msgv3 } { sy-msgv4 } Message Type- { sy-msgid } Message No { sy-msgno }  |  .

        ENDLOOP .

IF commit_failed309-materialdocument IS INITIAL .

CLEAR mszty309 .
ENDIF .

ELSE .


     LOOP AT ls_create_mapped309-materialdocument ASSIGNING FIELD-SYMBOL(<keys_header309>).

     IF MSZTY309 = 'E' .
EXIT .
ENDIF .

      CONVERT KEY OF i_materialdocumenttp
      FROM <keys_header309>-%pid
      TO <keys_header309>-%key .
    ENDLOOP.


    LOOP AT ls_create_mapped309-materialdocumentitem ASSIGNING FIELD-SYMBOL(<keys_item309>).

    IF MSZTY309 = 'E' .
EXIT .
ENDIF .
*
      CONVERT KEY OF i_materialdocumentitemtp
      FROM <keys_item309>-%pid
      TO <keys_item309>-%key.
    ENDLOOP.

    ENDIF.

  COMMIT ENTITIES END .
  data result39 type string .
data result309 type string .

      IF  MSZTY309 = 'E' .

result39 = |Error { MSZ_1309 } |.

ELSE .

DATA(GRN309)  = <keys_header309>-MaterialDocument .


result39 = <keys_header309>-MaterialDocument .
result309 = <keys_header309>-MaterialDocumentYear.

ENDIF.
    ENDIF.
***************************************309 END Good Cut ***********************************************

***************************************Table Save Start Good Cut **************************************
DATA WZPPGREY TYPE zpp_frc_tab .

   IF ( result41 IS NOT INITIAL AND  result411 IS NOT INITIAL ) OR ( result39 IS NOT INITIAL AND  result309 IS NOT INITIAL ).

   WZPPGREY-plant   = respo-plant.
   WZPPGREY-recbatch = numbrer.
*   WZPPGREY-materialdocument201 =
*   WZPPGREY-materialdocumentyear201
*   WZPPGREY-materialdocument202
*   WZPPGREY-materialdocumentyear202
   WZPPGREY-materialdocument309 = result39.
   WZPPGREY-materialdocumentyear309 = result309.
   WZPPGREY-materialdocument411  = result41 .
   WZPPGREY-materialdocumentyear411 = result411.
   WZPPGREY-costcenter   = respo-costcenter .
   WZPPGREY-gcgrosswt   =  respo-grossweight .
   WZPPGREY-gctype   = respo-gctype .
   WZPPGREY-gfrctype  = nrrangenr2 .
   WZPPGREY-noofbale  = respo-noofbale.
   WZPPGREY-postingdate  = respo-postingdate .
   WZPPGREY-recevingmaterial  = respo-recevingmaterial .
   WZPPGREY-recstoloc    = respo-recstoloc .
   WZPPGREY-storagelocation  = respo-storagelocation .
   WZPPGREY-totalmtr  = respo-totmeter .
   WZPPGREY-totalwt  = respo-grossweight .
   WZPPGREY-uom   = 'M' .
   WZPPGREY-baleqty =  respo-baleqty .
   WZPPGREY-totalwt =  respo-totweight .

  MODIFY zpp_frc_tab FROM @WZPPGREY .

ENDIF.

***************************************Table Save end Good Cut **************************************


    DATA lv TYPE string .
    DATA Json411 TYPE string.

  IF  MSZTY411 = 'E' .

Json411 = |ERROR { MSZ_1411 } |.

ELSE .

      CONCATENATE 'Matterial Document' result41 '/' result39 ' Poast '   INTO json411 SEPARATED BY ' '.

 ENDIF.

   response->set_text( json411  ).
*************************************** END Good Cut ********************************************************************


    ELSEIF  nrrangenr2 <> 'Good Cut'.

IF IT_HEAD411 IS NOT INITIAL .
***************************************411E START Fents Regs Chindi *********************************************************



    MODIFY ENTITIES OF i_materialdocumenttp
             ENTITY MaterialDocument
             CREATE FROM VALUE #( ( %cid                          = 'My%CID_1'
                                    goodsmovementcode             = '04'
                                    postingdate                   =   respo-postingdate
                                    documentdate                  =   sy-datum
                                    %control-goodsmovementcode                    = cl_abap_behv=>flag_changed
                                    %control-postingdate                          = cl_abap_behv=>flag_changed
                                    %control-documentdate                         = cl_abap_behv=>flag_changed
                                ) )

*FF001
*FF001A  1.  FN01  2 . FG01
             ENTITY MaterialDocument
             CREATE BY \_MaterialDocumentItem
             FROM VALUE #( (
                             %cid_ref = 'My%CID_1'
                             %target = VALUE #( FOR any1 IN IT_HEAD411 index INTO i  ( %cid                           = |My%CID_{ i }_001|
                                                  plant                          = respo-plant
                                                  material                       = any1-mat
                                                  GoodsMovementType              = '411'
                                                  inventoryspecialstocktype        = 'E'
                                                  storagelocation                = respo-storagelocation
                                                  QuantityInEntryUnit            =  any1-qty
                                                  entryunit                      = ''
                                                  Batch                          = any1-issuingbatch
                                                  IssuingOrReceivingPlant        = respo-plant
                                                  IssuingOrReceivingStorageLoc   = respo-storagelocation
                                                  IssgOrRcvgBatch                = any1-issuingbatch
                                                  IssgOrRcvgMaterial             = any1-mat
                                                 issgorrcvgspclstockind          = 'B'
                                                  specialstockidfgsalesorder     =  |{ any1-salesoder ALPHA = IN }|
                                                  specialstockidfgsalesorderitem  = |{ any1-soitem ALPHA = IN }|
*                                                  GoodsMovementRefDocType        = 'F'
                                                  IsCompletelyDelivered          = ' '
                                                  MaterialDocumentItemText       =    'FRC'
                                                  %control-plant                 = cl_abap_behv=>flag_changed
                                                  %control-material              = cl_abap_behv=>flag_changed
                                                  %control-GoodsMovementType     = cl_abap_behv=>flag_changed
                                                  %control-storagelocation       = cl_abap_behv=>flag_changed
                                                  %control-QuantityInEntryUnit   = cl_abap_behv=>flag_changed
                                                  %control-entryunit             = cl_abap_behv=>flag_changed
                                              ) )


                         ) )
             MAPPED   ls_create_mapped411
             FAILED  ls_create_failed411
             REPORTED ls_create_reported411.

  COMMIT ENTITIES BEGIN
   RESPONSE OF i_materialdocumenttp
   FAILED commit_failed411
   REPORTED commit_reported411.

 IF commit_failed411-materialdocumentitem IS NOT INITIAL .

     LOOP AT  commit_reported411-materialdocumentitem ASSIGNING FIELD-SYMBOL(<data1>).

          msz411 =  <data1>-%msg  .

          mszty411 = sy-msgty .
         msz_1411  = | { sy-msgv1 } { sy-msgv2 }  { sy-msgv3 } { sy-msgv4 } Message Type- { sy-msgid } Message No { sy-msgno }  |  .

        ENDLOOP .

IF commit_failed411-materialdocumentitem IS INITIAL .

CLEAR mszty411 .
ENDIF .

ELSE .

        LOOP AT ls_create_mapped411-materialdocument ASSIGNING FIELD-SYMBOL(<keys_header411E>).

   IF MSZTY411 = 'E' .
EXIT .
ENDIF .

      CONVERT KEY OF i_materialdocumenttp
      FROM <keys_header411E>-%pid
      TO <keys_header411E>-%key .
    ENDLOOP.


    LOOP AT ls_create_mapped411-materialdocumentitem ASSIGNING FIELD-SYMBOL(<keys_item411E>).
        IF MSZTY411 = 'E' .
EXIT .
ENDIF .
*
      CONVERT KEY OF i_materialdocumentitemtp
      FROM <keys_item411E>-%pid
      TO <keys_item411E>-%key.
    ENDLOOP.
    ENDIF.

    COMMIT ENTITIES END .


  IF  MSZTY411 = 'E' .

result41 = |ERROR { MSZ_1411 } |.

ELSE .


  GRN411  = <keys_header411E>-MaterialDocument .

result41 = <keys_header411E>-MaterialDocument .
result411 = <keys_header411E>-MaterialDocumentYear.

ENDIF.


ENDIF.

***************************************411E END  Fents Regs Chindi *****************************************************

***************************************411E END*************************************************************************

***************************************201 START Fents Regs Chindi *****************************************************



    MODIFY ENTITIES OF i_materialdocumenttp
             ENTITY MaterialDocument
             CREATE FROM VALUE #( ( %cid                          = 'My%CID_1'
                                    goodsmovementcode             = '03'
                                    postingdate                   =   respo-postingdate
                                    documentdate                  =   sy-datum
                                    %control-goodsmovementcode                    = cl_abap_behv=>flag_changed
                                    %control-postingdate                          = cl_abap_behv=>flag_changed
                                    %control-documentdate                         = cl_abap_behv=>flag_changed
                                ) )

*FF001
*FF001A  1.  FN01  2 . FG01
             ENTITY MaterialDocument
             CREATE BY \_MaterialDocumentItem
             FROM VALUE #( (
                             %cid_ref = 'My%CID_1'
                             %target = VALUE #( FOR any2 IN respo-atablearr1 index INTO i  ( %cid                           = |My%CID_{ i }_001|
                                                  plant                          = respo-plant
                                                  material                       = any2-mat
                                                  GoodsMovementType              = '201'
                                                  storagelocation                = respo-storagelocation
                                                  QuantityInEntryUnit            =  any2-qty
                                                  entryunit                      = ''
                                                  Batch                          = any2-issuingbatch
                                                  COSTCENTER                        = respo-costcenter
                                                  IsCompletelyDelivered          = ' '
                                                  MaterialDocumentItemText       =    'FRC'
                                                  %control-plant                 = cl_abap_behv=>flag_changed
                                                  %control-material              = cl_abap_behv=>flag_changed
                                                  %control-GoodsMovementType     = cl_abap_behv=>flag_changed
                                                  %control-storagelocation       = cl_abap_behv=>flag_changed
                                                  %control-QuantityInEntryUnit   = cl_abap_behv=>flag_changed
                                                  %control-entryunit             = cl_abap_behv=>flag_changed
                                              ) )


                         ) )
              MAPPED   DATA(ls_create_mapped201)
             FAILED   DATA(ls_create_failed201)
             REPORTED DATA(ls_create_reported201).

  COMMIT ENTITIES BEGIN
   RESPONSE OF i_materialdocumenttp
   FAILED DATA(commit_failed201)
   REPORTED DATA(commit_reported201).

 IF commit_failed201-materialdocument IS NOT INITIAL .

     LOOP AT  commit_reported201-materialdocumentitem ASSIGNING FIELD-SYMBOL(<data201>).

          DATA(msz201) =  <data201>-%msg  .

          DATA(mszty201) = sy-msgty .
          DATA(msz_1201)  = | { sy-msgv1 } { sy-msgv2 }  { sy-msgv3 } { sy-msgv4 } Message Type- { sy-msgid } Message No { sy-msgno }  |  .

        ENDLOOP .

IF commit_failed201-materialdocumentitem  IS INITIAL .

CLEAR mszty201 .
ENDIF .

ELSE .

        LOOP AT ls_create_mapped201-materialdocument ASSIGNING FIELD-SYMBOL(<keys_header201>).


   IF MSZTY201 = 'E' .
EXIT .
ENDIF .

      CONVERT KEY OF i_materialdocumenttp
      FROM <keys_header201>-%pid
      TO <keys_header201>-%key .
    ENDLOOP.


    LOOP AT ls_create_mapped201-materialdocumentitem ASSIGNING FIELD-SYMBOL(<keys_item201>).
  IF MSZTY201 = 'E' .
EXIT .
ENDIF .
      CONVERT KEY OF i_materialdocumentitemtp
      FROM <keys_item201>-%pid
      TO <keys_item201>-%key.
    ENDLOOP.
ENDIF.
  COMMIT ENTITIES END .

 IF  MSZTY201 = 'E' .

DATA(result201) = |Error { MSZ_1201 } |.

ELSE .
  DATA(GRN201)  = <keys_header201>-MaterialDocument .


   result201 = <keys_header201>-MaterialDocument .
DATA(resultY201) = <keys_header201>-MaterialDocumentYear.


ENDIF.

***************************************201 END Fents Regs Chindi *****************************************************

***************************************202 START Fents Regs Chindi *****************************************************




        MODIFY ENTITIES OF i_materialdocumenttp
             ENTITY MaterialDocument
             CREATE FROM VALUE #( ( %cid                          = 'My%CID_1'
                                    goodsmovementcode             = '03'
                                    postingdate                   =   respo-postingdate
                                    documentdate                  =   sy-datum
                                    %control-goodsmovementcode                    = cl_abap_behv=>flag_changed
                                    %control-postingdate                          = cl_abap_behv=>flag_changed
                                    %control-documentdate                         = cl_abap_behv=>flag_changed
                                ) )

             ENTITY MaterialDocument
             CREATE BY \_MaterialDocumentItem
             FROM VALUE #( (
                             %cid_ref = 'My%CID_1'
                             %target = VALUE #( FOR any202 IN IT_HEAD index INTO i  ( %cid                           = |My%CID_{ i }_001|
                                                  plant                          = respo-plant
                                                  material                       = respo-recevingmaterial
                                                  GoodsMovementType              = '202'
*                                                  inventoryspecialstocktype        = 'E'
                                                  storagelocation                = respo-recstoloc
                                                  QuantityInEntryUnit            =  respo-baleqty
                                                  entryunit                      = 'KG'
                                                  Batch                          =  Any202-batch
                                                 issgorrcvgspclstockind          = 'B'
                                                  COSTCENTER                        = respo-costcenter
*                                                  GoodsMovementRefDocType        = 'F'
                                                  IsCompletelyDelivered          = ' '
                                                  MaterialDocumentItemText       =    'FRC'
                                                  %control-plant                 = cl_abap_behv=>flag_changed
                                                  %control-material              = cl_abap_behv=>flag_changed
                                                  %control-GoodsMovementType     = cl_abap_behv=>flag_changed
                                                  %control-storagelocation       = cl_abap_behv=>flag_changed
                                                  %control-QuantityInEntryUnit   = cl_abap_behv=>flag_changed
                                                  %control-entryunit             = cl_abap_behv=>flag_changed
                                              ) )


                         ) )

          MAPPED   DATA(ls_create_mapped202)
             FAILED   DATA(ls_create_failed202)
             REPORTED DATA(ls_create_reported202).

  COMMIT ENTITIES BEGIN
   RESPONSE OF i_materialdocumenttp
   FAILED DATA(commit_failed202)
   REPORTED DATA(commit_reported202).


IF commit_failed202-materialdocument IS NOT INITIAL .

     LOOP AT  commit_reported202-materialdocumentitem ASSIGNING FIELD-SYMBOL(<data202>).

          DATA(msz202) =  <data202>-%msg  .

          DATA(mszty202) = sy-msgty .
          DATA(msz_1202)  = | { sy-msgv1 } { sy-msgv2 }  { sy-msgv3 } { sy-msgv4 } Message Type- { sy-msgid } Message No { sy-msgno }  |  .

        ENDLOOP .

IF commit_failed202-materialdocument IS INITIAL .

CLEAR mszty202 .
ENDIF .

ELSE .
        LOOP AT ls_create_mapped202-materialdocument ASSIGNING FIELD-SYMBOL(<keys_header202>).
         IF MSZTY202 = 'E' .
EXIT .
ENDIF .

      CONVERT KEY OF i_materialdocumenttp
      FROM <keys_header202>-%pid
      TO <keys_header202>-%key .
    ENDLOOP.


    LOOP AT ls_create_mapped202-materialdocumentitem ASSIGNING FIELD-SYMBOL(<keys_item202>).

 IF MSZTY202 = 'E' .
EXIT .
ENDIF .
      CONVERT KEY OF i_materialdocumentitemtp
      FROM <keys_item202>-%pid
      TO <keys_item202>-%key.
    ENDLOOP.
ENDIF.
   COMMIT ENTITIES END .


    IF  MSZTY202 = 'E' .

DATA(result202) = |Error { MSZ_1202 } |.

ELSE .

  DATA(GRN202)  = <keys_header202>-MaterialDocument .


 result202 = <keys_header202>-MaterialDocument .
DATA(resultY202) = <keys_header202>-MaterialDocumentYear.

 ENDIF.
***************************************202 END Fents Regs Chindi *****************************************************

***************************************Table Save Start Fents Regs Chindi *********************************************
IF result202 IS NOT INITIAL AND resultY202 IS NOT INITIAL.

    LOOP AT IT_HEAD INTO DATA(WATFRC).
   WZPPGREY-plant   = respo-plant.
   WZPPGREY-recbatch = WATFRC-batch.
   WZPPGREY-materialdocument201 = result201 .
   WZPPGREY-materialdocumentyear201 = resultY201 .
   WZPPGREY-materialdocument202  =  result202.
   WZPPGREY-materialdocumentyear202 = resultY202 .
   WZPPGREY-materialdocument309 = result39.
   WZPPGREY-materialdocumentyear309 = result309.
   WZPPGREY-materialdocument411  = result41 .
   WZPPGREY-materialdocumentyear411 = result411.
   WZPPGREY-costcenter   = respo-costcenter .
   WZPPGREY-gcgrosswt   =  respo-grossweight .
   WZPPGREY-gctype   = respo-gctype .
   WZPPGREY-gfrctype  = nrrangenr2 .
   WZPPGREY-noofbale  = respo-noofbale.
   WZPPGREY-postingdate  = respo-postingdate .
   WZPPGREY-recevingmaterial  = respo-recevingmaterial .
   WZPPGREY-recstoloc    = respo-recstoloc .
   WZPPGREY-storagelocation  = respo-storagelocation .
   WZPPGREY-totalmtr  = respo-totmeter .
   WZPPGREY-totalwt  = respo-grossweight .
   WZPPGREY-uom   = 'KG' .
   WZPPGREY-baleqty =  respo-baleqty .
   WZPPGREY-totalwt =  respo-totweight .
  MODIFY zpp_frc_tab FROM @WZPPGREY .

  CLEAR : WZPPGREY , WATFRC.

ENDLOOP.
ENDIF.
***************************************Table Save End Fents Regs Chindi *********************************************

    DATA Json200 TYPE string.

 IF  MSZTY411 = 'E' .
       json200 =    result41 .

      ELSE .

         CONCATENATE 'Matterial Document' result41 '/'  result201 '/' result202   INTO json200 SEPARATED BY ' '.
ENDIF.
*        'Post Sucessfully And Table' TABRESULT

           response->set_text( json200  ).


    ENDIF.




  endmethod.
ENDCLASS.
