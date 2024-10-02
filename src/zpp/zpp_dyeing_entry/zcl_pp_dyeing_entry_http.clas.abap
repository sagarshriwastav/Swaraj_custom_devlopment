class ZCL_PP_DYEING_ENTRY_HTTP definition
  public
  create public .
********************CREATED GAJENDRA SINGH SHEKHAWAT*************************************************************
public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_PP_DYEING_ENTRY_HTTP IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.


    DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).

    DATA(body)  = request->get_text(  )  .

     DATA productionorder TYPE znumc12 .

        DATA respo  TYPE zpp_dyeing_structure .

    xco_cp_json=>data->from_string( body )->write_to( REF #( respo ) ).


            READ TABLE respo-tabledata into data(T1) INDEX 1.

            DATA WZPPGREY TYPE zpp_dyeing1 .


    productionorder  =    |{ respo-order ALPHA = IN }|.

**** Validation *****
DATA totalqty TYPE string .
data result type string .
  DATA Json TYPE string.

Loop AT respo-tabledata into data(wa_respo).

 SELECT sum( case when DebitCreditCode = 'S' THEN QuantityInBaseUnit ELSE QuantityInBaseUnit * -1 END )
 AS qty
 FROM I_MATERIALdocumentitem_2
      WHERE BATCH = @WA_RESPO-beamnumber AND GoodsMovementType IN ( '101','102' )
      INTO @DATA(qty).
if  qty > 0.
json  = |{ WA_RESPO-beamnumber } && { 'Beam Already Posted' } |.
           response->set_text( json  ).
 EXIT.
ENDIF.
*clear:  wa_respo.
ENDLOOP.

***********************************************gajendrasing************************************
*Loop AT respo-tabledata into data(set_no).
*SELECT SINGLE * FROM zpp_dyeing1  WHERE setno  = @set_no-beamnumber into @data(set) .

*if set is INITIAL .
* json  = |{ 'ERROR' } { set-setno } { 'WARPING Entry is Pending ' }  |.
*             response->set_text( json  ).
*      ENDIF.
*      ENDLOOP.

*************************************end***************************************************************


 IF json IS  INITIAL  .


**** Validation *****
******101*****
IF productionorder is NOT INITIAL.
      MODIFY ENTITIES OF i_materialdocumenttp
                ENTITY materialdocument
                CREATE FROM VALUE #( ( %cid                          = 'My%CID_1'
                                       goodsmovementcode             = '02'
                                       postingdate                   = respo-postdate
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
                                                     material                       = respo-material               "'YGI1Z14N02009040'
                                                     goodsmovementtype              = '101'
                                                     storagelocation                = respo-sloc  "'YG01'
                                                     batch                          = ANY-beamnumber
                                                     quantityinentryunit            =  any-length
                                                     entryunit                      = 'M'
                                                     manufacturingorder             = |{ respo-order ALPHA = IN }|
                                                     goodsmovementrefdoctype        = 'F'
                                                     iscompletelydelivered          = ' '
                                                     materialdocumentitemtext       = any-weight
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
IF commit_failed-materialdocumentitem IS INITIAL .

CLEAR mszty .
ENDIF .

ELSE .

   LOOP AT ls_create_mapped-materialdocument ASSIGNING FIELD-SYMBOL(<keys_header>).

   IF MSZTY = 'E' .
EXIT .
ENDIF .

      CONVERT KEY OF i_materialdocumenttp
      FROM <keys_header>-%pid
      TO <keys_header>-%key .
    ENDLOOP.


    LOOP AT ls_create_mapped-materialdocumentitem ASSIGNING FIELD-SYMBOL(<keys_item>).

    IF MSZTY = 'E' .
EXIT .
ENDIF .
*
      CONVERT KEY OF i_materialdocumentitemtp
      FROM <keys_item>-%pid
      TO <keys_item>-%key.
    ENDLOOP.


ENDIF.
    COMMIT ENTITIES END.

IF  MSZTY = 'E' OR msz_1 <> ' '.

result = |Error { MSZ_1 } |.

ELSE .

DATA(GRN)  = <keys_header>-MaterialDocument .
* data result type string .
data result1 type string .

result = <keys_header>-MaterialDocument .
result1 = <keys_header>-MaterialDocumentYear.


ENDIF .

DATA TABRESULT TYPE STRING.

DATA N TYPE INT4.

ENDIF.
*********261*******
*
loop at  respo-tabledata1  assigning FIELD-SYMBOL(<WAT>).
IF <WAT>-soitem EQ '0'.
<WAT>-soitem = ''.
<WAT>-ind = ''.
else.
<WAT>-soitem = |{ <WAT>-soitem ALPHA = IN }| .
<WAT>-ind = 'E'.
ENDIF.
endloop.

DATA : WA_TAB TYPE ZPP_DYEING_ENTRY_STRUCTURE1.

LOOP AT respo-tabledata INTO DATA(WA_TAB1).
WA_TAB-material = 'BEAMPIPE0001' .
WA_TAB-plant = '1200'.
WA_TAB-sloc  = 'DY01'.
WA_TAB-reqqty = '1' .
*WA_TAB-unit   =   'PC'.
*loop at respo-tabledata1  assigning FIELD-SYMBOL(<WAT1>).
*
*WA_TAB-salesorder = <WAT1>-salesorder.
*IF <WAT1>-soitem EQ '0'.
*WA_TAB-soitem = ''.
*WA_TAB-ind = ''.
*else.
*WA_TAB-soitem = |{ <WAT>-soitem ALPHA = IN }| .
*WA_TAB-ind = 'E'.
*ENDIF.
*endloop.
WA_TAB-batch = wa_tab1-pipenumber.
APPEND WA_TAB TO respo-tabledata1 .
ENDLOOP.


 IF result IS NOT INITIAL AND result1 IS NOT INITIAL .

      MODIFY ENTITIES OF i_materialdocumenttp
                ENTITY materialdocument
                CREATE FROM VALUE #( ( %cid                          = 'My%CID_1'
                                       goodsmovementcode             = '03'
                                       postingdate                   = respo-postdate
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
                                                     plant                          = any1-plant
                                                     material                       = any1-material               "'YGI1Z14N02009040'
                                                     goodsmovementtype              = '261'
                                                     storagelocation                =  any1-sloc  "'YG01'
                                                     batch                          =  any1-batch
                                                     quantityinentryunit            = any1-reqqty

                                                     entryunit                      =  any1-unit
                                                     manufacturingorder             =  |{ respo-order ALPHA = IN }|
                                                     goodsmovementrefdoctype        = ' '
                                                    SpecialStockIdfgSalesOrder                     = |{ ANY1-salesorder ALPHA = IN }|

                                                     SpecialStockIdfgSalesOrderItem                 =  ANY1-soitem
**                                                     iscompletelydelivered          = ''
**                                                     materialdocumentitemtext       = ''
                                                      InventorySpecialStockType       =     any1-ind
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

     IF commit_failed2-materialdocumentitem IS NOT INITIAL .

     LOOP AT  commit_reported2-materialdocumentitem ASSIGNING FIELD-SYMBOL(<data261>).

          DATA(msz261) =  <data261>-%msg  .

          DATA(mszty261) = sy-msgty .
          DATA(msz_1261)  = | { sy-msgv1 } { sy-msgv2 }  { sy-msgv3 } { sy-msgv4 } Message Type- { sy-msgid } Message No { sy-msgno }  |  .

        ENDLOOP .

IF commit_failed2-materialdocumentitem IS INITIAL .

CLEAR mszty261 .
ENDIF .

ELSE .


   LOOP AT ls_create_mapped2-materialdocument ASSIGNING FIELD-SYMBOL(<keys_header1>).

    IF MSZTY261 = 'E' .
EXIT .
ENDIF .

      CONVERT KEY OF i_materialdocumenttp
      FROM <keys_header1>-%pid
      TO <keys_header1>-%key .
    ENDLOOP.


    LOOP AT ls_create_mapped2-materialdocumentitem ASSIGNING FIELD-SYMBOL(<keys_item1>).

 IF MSZTY261 = 'E' .
EXIT .
ENDIF .
*

      CONVERT KEY OF i_materialdocumentitemtp
      FROM <keys_item1>-%pid
      TO <keys_item1>-%key.
    ENDLOOP.

ENDIF.

     COMMIT ENTITIES END.

     IF  MSZTY261 = 'E' .

DATA(result2) = |Error { MSZ_1 } |.

ELSE .
  GRN  = <keys_header1>-MaterialDocument .

result2 = <keys_header1>-MaterialDocument .
DATA(result21) = <keys_header1>-MaterialDocumentYear.


ENDIF.
ENDIF.

******261 End*****

**************************TABLE DATA SAVED START*****************8

IF result IS NOT INITIAL AND result1 IS NOT INITIAL .

LOOP AT respo-tabledata ASSIGNING FIELD-SYMBOL(<FS>) .
**N = N + 1 .
WZPPGREY-plant = RESPO-plant  .
WZPPGREY-setno = RESPO-setno.
WZPPGREY-zorder = respo-order.
WZPPGREY-hremark1 = respo-remark1.
WZPPGREY-hremark2 = respo-remark2.
WZPPGREY-material = respo-material.
WZPPGREY-beamno = <FS>-beamnumber.
WZPPGREY-pipenumber = <FS>-pipenumber.
WZPPGREY-length = <FS>-length.
WZPPGREY-netweight = <FS>-netweight.
WZPPGREY-tareweight = <FS>-tareweight.
WZPPGREY-grossweight = <FS>-grossweight.
WZPPGREY-shade = <FS>-shade.
WZPPGREY-optname = <FS>-operatorname.
WZPPGREY-shift  = <FS>-shift.
WZPPGREY-greyshort = <FS>-greysort.
WZPPGREY-remark  = <FS>-remark.
WZPPGREY-totends = respo-totends.
WZPPGREY-materialdocument = result.
WZPPGREY-materialdocumentyear = result1.
WZPPGREY-materialdocument261  =  result2.
WZPPGREY-materialdocumentyear261 = result21.
WZPPGREY-unsizedwt        =     <FS>-unsizedwt.
WZPPGREY-sizedwt       =  <FS>-sizedper .
WZPPGREY-avgweight     =   <FS>-avgwt.

 MODIFY zpp_dyeing1 FROM @WZPPGREY  .
*
*
ENDLOOP .
      COMMIT WORK AND WAIT.
  IF sy-subrc IS INITIAL.
          TABRESULT =  ' Data Saved!! ' .
        ELSE.
          TABRESULT = 'Error in saving data!!' .
        ENDIF.

ENDIF.

***********************TABLE DATA SAVED END **********************

    DATA lv TYPE string .
*    DATA Json TYPE string.
  IF  MSZTY = 'E' .

     json =  result .
     ELSE .

      CONCATENATE 'Matterial Document' result '/' result2 'Post Sucessfully And Table' TABRESULT  INTO json SEPARATED BY ' '.

  ENDIF.

           response->set_text( json  ).

ENDIF.


  endmethod.
ENDCLASS.
