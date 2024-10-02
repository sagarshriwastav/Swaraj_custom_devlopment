class ZCL_PP_GREY_REN_HTTP definition
  public
  create public .

public section.
********************CREATED GAJENDRA SINGH SHEKHAWAT*************************************************************
  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_PP_GREY_REN_HTTP IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

        DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).

    DATA(body)  = request->get_text(  )  .
    DATA productionorder TYPE N LENGTH 12 .

    DATA respo  TYPE zgrey_grn_structure .

    xco_cp_json=>data->from_string( body )->write_to( REF #( respo ) ).

        READ TABLE respo-tabledata into data(T1) INDEX 1.

    productionorder  =    |{ t1-prodorder ALPHA = IN }|.

**** Validation *****
  DATA totalqty TYPE string .
  data result type string .
  DATA Json TYPE string.
  DATA CONQTY  TYPE I_MATERIALdocumentitem_2-QuantityInEntryUnit.
  DATA NETWTSAVE  TYPE I_MATERIALdocumentitem_2-QuantityInEntryUnit.


*********************************************Cheack For Production Order Release And Deleted*************************

    SELECT SINGLE a~OrderIsReleased , a~OrderIsTechnicallyCompleted ,b~IsMarkedForDeletion FROM I_MFGORDERWITHSTATUS as a
    LEFT OUTER JOIN I_ManufacturingOrder as b ON ( b~ManufacturingOrder = a~ManufacturingOrder ) WHERE a~ManufacturingOrder = @productionorder  INTO @DATA(CHEAKORD) .

    IF ( CHEAKORD-OrderIsReleased IS  INITIAL  OR CHEAKORD-IsMarkedForDeletion IS NOT INITIAL ) AND CHEAKORD-OrderIsTechnicallyCompleted IS INITIAL  .

    IF CHEAKORD-OrderIsReleased IS  INITIAL .

    DATA lv TYPE string .
    LV  = 'Error Order Is Not Released. Please Release The Order fIRST. '.
   response->set_text(  lv   ).

   ELSEIF  CHEAKORD-IsMarkedForDeletion IS NOT INITIAL .

     LV  = 'Error Order Is  Deleted. Please Cheack The Order fIRST. '.
   response->set_text(  lv   ).

   ENDIF.
*********************************************Cheack For Production Order Release And Deleted************************
else .

*********************************************Cheack For Batch Already Posted****************************************
DATA WTMTR TYPE P DECIMALS 3 .
Loop AT respo-tabledata into data(wa_respo).

  CONQTY = CONQTY + wa_respo-netwt .
  WTMTR = wa_respo-wtmtr * 1000 .

 SELECT SINGLE ztowtpermtr FROM zpc_headermaster WHERE zpqlycode = @wa_respo-material AND zpunit = @respo-plant INTO @DATA(ztowtpermtr) .

  IF ztowtpermtr <=  WTMTR + 35 AND ztowtpermtr >= WTMTR - 35 .

  ELSE .
  IF SY-uname <> 'CB9980000086' .
  json  = |'Error' && { WA_RESPO-material } && { 'Please Maintain Correct Quality Weight' } |.
  response->set_text( json  ).
  EXIT.
  ENDIF.
  ENDIF.

 SELECT sum( case when DebitCreditCode = 'S' THEN QuantityInBaseUnit ELSE QuantityInBaseUnit * -1 END )
 AS qty
 FROM I_MATERIALdocumentitem_2
      WHERE BATCH = @WA_RESPO-recbatch AND Plant = @respo-plant AND Material = @wa_respo-material AND GoodsMovementType IN ( '101','102' )

      INTO @DATA(qty).
if  qty > 0.
json  = |'Error' && { WA_RESPO-recbatch } && { 'Batch Already POSTED' } |.
           response->set_text( json  ).
 EXIT.
ENDIF.
*clear:  wa_respo.
ENDLOOP.
**********************************************Cheack For Batch Already Posted***********************************************

*********************************************Validation For Yarn Consumption Net Wet****************************************
* IF json IS  INITIAL  .
* SELECT sum(  QuantityInBaseUnit ) AS qty
* FROM I_MATERIALdocumentitem_2 WHERE OrderID = @productionorder AND Plant = @respo-plant AND GoodsMovementType IN ( '261' ) AND GoodsMovementIsCancelled = ''
* AND Material LIKE 'Y%' INTO @DATA(qty261).
*
*  SELECT sum(  netwt ) AS qty FROM ZJOB_GREY_NETWT_DISPATCH_CDS
*  WHERE Prodorder = @productionorder AND Plant = @respo-plant
*      INTO @DATA(SAVENETWT).
* NETWTSAVE = qty261 - SAVENETWT .
*IF CONQTY >  NETWTSAVE .
*
*json  = |'Error' && { 'Net Weight Should not exceed Yarn Consumption' } |.
*response->set_text( json  ).
*ENDIF.
*
*ENDIF.

**********************************************Validation For Yarn Consumption Net Wet************************************
 IF json IS  INITIAL  .

*********************************************101 Start******************************************************************
IF productionorder is NOT INITIAL.
      MODIFY ENTITIES OF i_materialdocumenttp
                ENTITY materialdocument
                CREATE FROM VALUE #( ( %cid                          = 'My%CID_1'
                                       goodsmovementcode             = '02'
                                       postingdate                   = respo-date
                                       documentdate                  = sy-datum
                                       %control-goodsmovementcode                    = cl_abap_behv=>flag_changed
                                       %control-postingdate                          = cl_abap_behv=>flag_changed
                                       %control-documentdate                         = cl_abap_behv=>flag_changed
                                   ) )

                ENTITY materialdocument
                CREATE BY \_materialdocumentitem
                FROM VALUE #(   (
                                %cid_ref = 'My%CID_1'
                                %target = VALUE #( FOR any IN respo-tabledata INDEX INTO i ( %cid                           = |My%CID_{ i }_001|
                                                     plant                          = respo-plant
                                                     material                       = any-material               "'YGI1Z14N02009040'
                                                     goodsmovementtype              = '101'
                                                     storagelocation                = any-sloc  "'YG01'
                                                     batch                          = any-recbatch
                                                     quantityinentryunit            =  any-quantity
                                                     entryunit                      = 'M'
                                                     manufacturingorder             = |{ ANY-prodorder ALPHA = IN }|
                                                     goodsmovementrefdoctype        = 'F'
                                                     iscompletelydelivered          = ' '
                                                     materialdocumentitemtext       = any-batch
                                                     %control-plant                 = cl_abap_behv=>flag_changed
                                                     %control-material              = cl_abap_behv=>flag_changed
                                                     %control-goodsmovementtype    = cl_abap_behv=>flag_changed
                                                     %control-storagelocation       = cl_abap_behv=>flag_changed
                                                     %control-quantityinentryunit  = cl_abap_behv=>flag_changed
                                                     %control-entryunit             = cl_abap_behv=>flag_changed
                                                 )     )


                            ) )
                MAPPED   DATA(ls_create_mapped)
                FAILED   DATA(ls_create_failed)
                REPORTED DATA(ls_create_reported).




    COMMIT ENTITIES BEGIN
     RESPONSE OF i_materialdocumenttp
     FAILED DATA(commit_failed)
     REPORTED DATA(commit_reported).

   IF commit_failed IS NOT INITIAL .

     LOOP AT  commit_reported-materialdocumentitem ASSIGNING FIELD-SYMBOL(<data>).

          DATA(msz) =  <data>-%msg  .

          DATA(mszty) = sy-msgty .
          DATA(msz_1)  = | { sy-msgv1 } { sy-msgv2 }  { sy-msgv3 } { sy-msgv4 } Message Type- { sy-msgid } Message No { sy-msgno }  |  .

        ENDLOOP .
IF msz_1 = '' .

 LOOP AT  commit_reported-materialdocument ASSIGNING FIELD-SYMBOL(<Hddata>).

          msz =  <Hddata>-%msg  .

          mszty = sy-msgty .
          msz_1 = commit_reported-materialdocument[ 1 ]-%msg->if_message~get_text( ).
        ENDLOOP .
ENDIF.
IF commit_failed-materialdocument IS INITIAL .

CLEAR mszty .
ENDIF .

ELSE .


   LOOP AT ls_create_mapped-materialdocument ASSIGNING FIELD-SYMBOL(<keys_header>).

     IF MSZTY = 'E' OR MSZTY = 'W' .
EXIT .
ENDIF .


      CONVERT KEY OF i_materialdocumenttp
      FROM <keys_header>-%pid
      TO <keys_header>-%key .
    ENDLOOP.


    LOOP AT ls_create_mapped-materialdocumentitem ASSIGNING FIELD-SYMBOL(<keys_item>).

      IF MSZTY = 'E' OR MSZTY = 'W'.
EXIT .
ENDIF .

*
      CONVERT KEY OF i_materialdocumentitemtp
      FROM <keys_item>-%pid
      TO <keys_item>-%key.
    ENDLOOP.

ENDIF.
    COMMIT ENTITIES END.

     IF  MSZTY = 'E' OR MSZTY = 'W' OR msz_1 <> ''.

result = |Error { MSZ_1 } |.

ELSE .

DATA(GRN)  = <keys_header>-MaterialDocument .
* data result type string .
data result1 type string .

result = <keys_header>-MaterialDocument .
result1 = <keys_header>-MaterialDocumentYear.

ENDIF .

*********************************************101 End******************************************************************


**********************************************261 Start******************************************************************
loop at  respo-tabledata1  assigning FIELD-SYMBOL(<WAT>).
 IF <WAT>-soitem EQ '0'.
 <WAT>-soitem = ''.
 <WAT>-ind = ''.
 else.
<WAT>-soitem = |{ <WAT>-soitem ALPHA = IN }| .
<WAT>-ind = 'E'.
ENDIF.
endloop.

IF result IS NOT INITIAL AND  result1 IS NOT INITIAL .

DATA WZPPGREY TYPE zpp_grey_grn_tab .
DATA N TYPE INT4.
DATA TABRESULT TYPE STRING.

LOOP AT respo-tabledata ASSIGNING FIELD-SYMBOL(<FS>) .
*N = N + 1 .
WZPPGREY-plant = RESPO-plant  .
WZPPGREY-Batch = <FS>-Batch .
WZPPGREY-RecBatch = <FS>-RecBatch .
WZPPGREY-materialdocument101  =   result .
WZPPGREY-materialdocumentyear101 =  result1 .
WZPPGREY-postingdate  = respo-date.
WZPPGREY-optcode   = respo-operatorcode .
WZPPGREY-shift    = respo-shift .
WZPPGREY-srno     =  <FS>-sno .
WZPPGREY-Loomno = <FS>-Loomno .
WZPPGREY-Material = <FS>-Material .
WZPPGREY-rollno =  <FS>-rollno .
WZPPGREY-Partybeam = <FS>-Partybeam .
WZPPGREY-Quantity = <FS>-Quantity .
WZPPGREY-NetWt = <FS>-NetWt .
WZPPGREY-stdwt = <FS>-stdwt .
WZPPGREY-wtmtr = <FS>-wtmtr .
WZPPGREY-ProdOrder =  |{ <FS>-ProdOrder ALPHA = IN }| .
WZPPGREY-Sloc = <FS>-Sloc .
WZPPGREY-shadeno = <FS>-shadeno .
WZPPGREY-Remark = <FS>-Remark .
WZPPGREY-Uom = 'M' .
WZPPGREY-ukg  =  'KG' .
WZPPGREY-salesord =  |{ <FS>-salorder ALPHA = IN }| .
WZPPGREY-salesorderitem  =  <FS>-soitem .
WZPPGREY-partyname   = <fs>-partyname.
WZPPGREY-pick =  <fs>-pick .
WZPPGREY-setno = <fs>-setno .
WZPPGREY-grosswt   = <FS>-grosswt.
WZPPGREY-ironpipe  = <FS>-ironpipe.
WZPPGREY-selvedge = <FS>-selvedge .

 MODIFY zpp_grey_grn_tab FROM @WZPPGREY  .

ENDLOOP .
  IF sy-subrc IS INITIAL.
          TABRESULT =  ' Data Saved!! ' .
        ELSE.
          TABRESULT = 'Error in saving data!!' .
        ENDIF.


      MODIFY ENTITIES OF i_materialdocumenttp
                ENTITY materialdocument
                CREATE FROM VALUE #( ( %cid                          = 'My%CID_1'
                                       goodsmovementcode             = '03'
                                       postingdate                   = respo-date
                                       documentdate                  = sy-datum
                                       %control-goodsmovementcode                    = cl_abap_behv=>flag_changed
                                       %control-postingdate                          = cl_abap_behv=>flag_changed
                                       %control-documentdate                         = cl_abap_behv=>flag_changed
                                   ) )

                ENTITY materialdocument
                CREATE BY \_materialdocumentitem
                FROM VALUE #(   (
                                %cid_ref = 'My%CID_1'
                                %target = VALUE #( FOR any1 IN respo-tabledata1 INDEX INTO i ( %cid                           = |My%CID_{ i }_001|
                                                     plant                          = respo-plant
                                                     material                       = any1-material               "'YGI1Z14N02009040'
                                                     goodsmovementtype              = '261'
                                                     storagelocation                =  any1-loc  "'YG01'
                                                     batch                          =  any1-batch
                                                     quantityinentryunit            =  any1-quantity
                                                     entryunit                      =  any1-unit
                                                     manufacturingorder             =  |{ ANY1-productionorder ALPHA = IN }|
                                                     goodsmovementrefdoctype        = ' '

                                                     SpecialStockIdfgSalesOrder                     = |{ ANY1-salesorder ALPHA = IN }|

                                                     SpecialStockIdfgSalesOrderItem                 =  ANY1-soitem

**                                                    SpecialStockIdfgSalesOrder      =  'E'
**                                                    SpecialStockIdfgSalesOrderItem  =  'E'
                                                    InventorySpecialStockType       =     any1-ind
**                                                     iscompletelydelivered          = ''
**                                                     materialdocumentitemtext       = ''
                                                     %control-plant                 = cl_abap_behv=>flag_changed
                                                     %control-material              = cl_abap_behv=>flag_changed
                                                     %control-goodsmovementtype    = cl_abap_behv=>flag_changed
                                                     %control-storagelocation       = cl_abap_behv=>flag_changed
                                                     %control-quantityinentryunit  = cl_abap_behv=>flag_changed
                                                     %control-entryunit             = cl_abap_behv=>flag_changed
                                                 )     )


                            ) )
               MAPPED   DATA(ls_create_mapped2)
                FAILED   DATA(ls_create_failed2)
                REPORTED DATA(ls_create_reported2).




    COMMIT ENTITIES BEGIN
     RESPONSE OF i_materialdocumenttp
     FAILED DATA(commit_failed2)
     REPORTED DATA(commit_reported2).

     IF commit_failed2 IS NOT INITIAL .

     LOOP AT  commit_reported2-materialdocumentitem ASSIGNING FIELD-SYMBOL(<data2>).

          DATA(msz2) =  <data2>-%msg  .

          DATA(mszty2) = sy-msgty .
          DATA(msz_12)  = | { sy-msgv1 } { sy-msgv2 }  { sy-msgv3 } { sy-msgv4 } Message Type- { sy-msgid } Message No { sy-msgno }  |  .

        ENDLOOP .

IF msz_12 = '' .

 LOOP AT  commit_reported-materialdocument ASSIGNING FIELD-SYMBOL(<Hddata1>).

          msz2 =  <Hddata>-%msg  .

          mszty2 = sy-msgty .
          MSZ_12 = <Hddata1>-%msg->if_message~get_text( ).
        ENDLOOP .
ENDIF.
IF commit_failed2-materialdocument IS INITIAL .

CLEAR mszty2 .
ENDIF .

ELSE .


   LOOP AT ls_create_mapped2-materialdocument ASSIGNING FIELD-SYMBOL(<keys_header1>).

     IF MSZTY2 = 'E' OR MSZTY = 'W'.
EXIT .
ENDIF .


      CONVERT KEY OF i_materialdocumenttp
      FROM <keys_header1>-%pid
      TO <keys_header1>-%key .
    ENDLOOP.


    LOOP AT ls_create_mapped2-materialdocumentitem ASSIGNING FIELD-SYMBOL(<keys_item1>).

      IF MSZTY2 = 'E' OR MSZTY = 'W'.
EXIT .
ENDIF .

*
      CONVERT KEY OF i_materialdocumentitemtp
      FROM <keys_item1>-%pid
      TO <keys_item1>-%key.
    ENDLOOP.

    ENDIF.

     COMMIT ENTITIES END.

 IF  MSZTY2 = 'E' OR MSZTY = 'W' OR MSZ_12 <> ''.

DATA(result2) = |Error { MSZ_12 } |.

ELSE .

  GRN  = <keys_header1>-MaterialDocument .

result2 = <keys_header1>-MaterialDocument .
DATA(result21) = <keys_header1>-MaterialDocumentYear.

ENDIF.


ENDIF.
ENDIF.
*********************************************261 End******************************************************************
****************************261 DOCUMENT NOT GENERATED(101 REVERSE)**************************************************
IF result IS NOT INITIAL AND result1 IS NOT INITIAL AND ( result21 IS INITIAL OR result21 = '0000' ).

 LOOP AT respo-tabledata ASSIGNING FIELD-SYMBOL(<GSS1>) .

              UPDATE zpp_grey_grn_tab SET error261  = @result2  WHERE
              plant = @RESPO-plant AND  material = @<GSS1>-material AND recbatch = @<GSS1>-recbatch AND
              batch = @<GSS1>-batch AND materialdocument101 = @result AND materialdocumentyear101 = @result1.

ENDLOOP .

 CONCATENATE 'GS261' result '/' result1 INTO json SEPARATED BY ' '.

ENDIF.

****************************261 DOCUMENT NOT GENERATED(101 REVERSE)**************************************************

**********************************************Table Saved Start*******************************************************


DATA WZPPGREY1 TYPE zpp_grey_grn_tab .
DATA N1 TYPE INT4.



IF json is   INITIAL AND result IS NOT INITIAL AND result1 IS NOT INITIAL
AND result2 IS NOT INITIAL AND result21 IS NOT INITIAL .

LOOP AT respo-tabledata ASSIGNING FIELD-SYMBOL(<FS1>) .
*N = N + 1 .

              UPDATE zpp_grey_grn_tab SET materialdocument261 = @result2 , materialdocumentyear261 = @result21 WHERE
              plant = @RESPO-plant AND  material = @<FS1>-material AND materialdocument101 = @result AND
               materialdocumentyear101 = @result1 AND batch = @<FS>-batch AND recbatch = @<FS1>-recbatch .

      COMMIT WORK AND WAIT.
ENDLOOP .
   IF sy-subrc IS  INITIAL.
          TABRESULT =  ' Data Saved!! ' .
        ELSE.
          TABRESULT = 'Error in saving data!!' .
        ENDIF.
**********************************************Table Saved End **********************************************************

     IF  MSZTY = 'E' OR MSZTY = 'W' .

     json =  result .

     ELSE .

      CONCATENATE 'Matterial Document 101/261' result '/' result2 'Post Sucessfully And Table' TABRESULT  INTO json SEPARATED BY ' '.

ENDIF.
ENDIF.
    IF  MSZTY = 'E' OR MSZTY = 'W' .

    json =  result .
    ELSE.
    response->set_text( json  ).
    ENDIF.


ENDIF.
ENDIF.


  endmethod.
ENDCLASS.
