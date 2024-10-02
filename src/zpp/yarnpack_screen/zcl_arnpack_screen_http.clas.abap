CLASS zcl_arnpack_screen_http DEFINITION
  PUBLIC
  CREATE PUBLIC .
********************CREATED GAJENDRA SINGH SHEKHAWAT*************************************************************
  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ARNPACK_SCREEN_HTTP IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.

    DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).

    DATA(body)  = request->get_text(  )  .
    DATA productionorder TYPE N LENGTH 12 .

    DATA respo  TYPE zyarnpack_req .


    xco_cp_json=>data->from_string( body )->write_to( REF #( respo ) ).



    productionorder  =    |{ respo-order ALPHA = IN }|.

**** Validation *****
DATA totalqty TYPE string .
data result type string .
  DATA Json TYPE string.

   SELECT SINGLE OrderIsReleased , OrderIsDeleted FROM I_MFGORDERWITHSTATUS  WHERE ManufacturingOrder = @productionorder INTO @DATA(CHEAKORD) .

    IF CHEAKORD-OrderIsReleased IS  INITIAL OR CHEAKORD-OrderIsDeleted IS NOT INITIAL    .

    IF CHEAKORD-OrderIsReleased IS  INITIAL .

    DATA lv TYPE string .
    LV  = 'Error Order Is Not Released. Please Release The Order fIRST. '.
   response->set_text(  lv   ).

   ELSEIF  CHEAKORD-OrderIsDeleted IS NOT INITIAL .

     LV  = 'Error Order Is  Deleted. Please Cheack The Order fIRST. '.
   response->set_text(  lv   ).

   ENDIF.

else .

Loop AT respo-tabledata into data(wa_respo).

totalqty = totalqty + wa_respo-netwt.
clear:  wa_respo.
ENDLOOP.

If totalqty > respo-openqty.

DATA VAL1 TYPE string.
Json = 'Error Please Cheack OpenQty'.

else .




**** Validation *****
******101*****
IF productionorder is NOT INITIAL.
      MODIFY ENTITIES OF i_materialdocumenttp
                ENTITY materialdocument
                CREATE FROM VALUE #( ( %cid                          = 'My%CID_1'
                                       goodsmovementcode             = '02'
                                       postingdate                   =  respo-postingdate
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
                                                     storagelocation                = respo-storageloca  "'YG01'
                                                     batch                          = any-pack
                                                     quantityinentryunit            = any-netwt
                                                     entryunit                      = 'KG'
                                                     manufacturingorder             = productionorder
                                                     goodsmovementrefdoctype        = 'F'
                                                     iscompletelydelivered          = ' '
                                                     materialdocumentitemtext       = respo-lotnumber
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

    IF commit_failed-materialdocument IS NOT INITIAL .

     LOOP AT  commit_reported-materialdocumentitem ASSIGNING FIELD-SYMBOL(<data>).

          DATA(msz) =  <data>-%msg  .

          DATA(mszty) = sy-msgty .
          DATA(msz_1)  = | { sy-msgv1 } { sy-msgv2 }  { sy-msgv3 } { sy-msgv4 } Message Type- { sy-msgid } Message No { sy-msgno }  |  .

        ENDLOOP .

IF commit_failed-materialdocument IS INITIAL .

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

data result1 type string .

   IF  MSZTY = 'E' .

result = |Error { MSZ_1 } |.

ELSE .

DATA(GRN)  = <keys_header>-MaterialDocument .
* data result type string .

result = <keys_header>-MaterialDocument .
result1 = <keys_header>-MaterialDocumentYear.

ENDIF.

DATA TABRESULT TYPE STRING.

DATA WZPACKN TYPE ZPACKN .
DATA N TYPE INT4.

 IF result IS NOT INITIAL AND result1 IS NOT INITIAL .

LOOP AT respo-tabledata ASSIGNING FIELD-SYMBOL(<FS>) .
N = N + 1 .
WZPACKN-plant1 = RESPO-plant  .
WZPACKN-shift =  ' ' .
WZPACKN-documentdate  = SY-DATUM .
WZPACKN-batch  = <FS>-pack .
WZPACKN-bag_number  = N .
WZPACKN-lot_number = respo-lotnumber .
  WZPACKN-packing_type  = RESPO-packingtype .
  WZPACKN-netwt       = RESPO-net_wt      .
  WZPACKN-grosswt      = RESPO-grosswt     .
  WZPACKN-material     = RESPO-material    .
  WZPACKN-noofcones       = RESPO-coneno      .
  WZPACKN-conetip      = RESPO-conetip     .
  WZPACKN-cone_weight   = RESPO-coneweight  .

 MODIFY ZPACKN FROM @WZPACKN  .
        IF sy-subrc IS INITIAL.
          TABRESULT =  ' Data Saved!! ' .
        ELSE.
          TABRESULT = 'Error in saving data!!' .
        ENDIF.

      COMMIT WORK AND WAIT.

ENDLOOP .

ENDIF.

*****Packing Table Save End******
ENDIF.
*********261*******

loop at  respo-tabledata1  assigning FIELD-SYMBOL(<WAT>).
 IF <WAT>-soitem EQ '0'.
 <WAT>-soitem = ''.
 <WAT>-ind = ''.
 else.
<WAT>-soitem = |{ <WAT>-soitem ALPHA = IN }| .
<WAT>-ind = 'E'.
ENDIF.
endloop.
 IF result IS NOT INITIAL AND result1 IS NOT INITIAL .

      MODIFY ENTITIES OF i_materialdocumenttp
                ENTITY materialdocument
                CREATE FROM VALUE #( ( %cid                          = 'My%CID_1'
                                       goodsmovementcode             = '03'
                                       postingdate                   =   respo-postingdate
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
                                                     quantityinentryunit            =  any1-Quantity
                                                     entryunit                      =   ''   "any1-uom
                                                     manufacturingorder             =  productionorder
                                                     goodsmovementrefdoctype        = ' '
                                                     SalesOrder                     = ' '
                                                     SalesOrderItem =  ' '
                                                    SpecialStockIdfgSalesOrder =    |{ ANY1-salesorder ALPHA = IN }|
                                                    SpecialStockIdfgSalesOrderItem     =  ANY1-soitem
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

        IF commit_failed2-materialdocument IS NOT INITIAL .

     LOOP AT  commit_reported2-materialdocumentitem ASSIGNING FIELD-SYMBOL(<data2>).

          DATA(msz2) =  <data2>-%msg  .

          DATA(mszty2) = sy-msgty .
          DATA(msz_12)  = | { sy-msgv1 } { sy-msgv2 }  { sy-msgv3 } { sy-msgv4 } Message Type- { sy-msgid } Message No { sy-msgno }  |  .

        ENDLOOP .

IF commit_failed2-materialdocument IS INITIAL .

CLEAR mszty2 .
ENDIF .

ELSE .


   LOOP AT ls_create_mapped2-materialdocument ASSIGNING FIELD-SYMBOL(<keys_header2>).

 IF MSZTY2 = 'E' .
EXIT .
ENDIF .

      CONVERT KEY OF i_materialdocumenttp
      FROM <keys_header2>-%pid
      TO <keys_header2>-%key .
    ENDLOOP.


    LOOP AT ls_create_mapped2-materialdocumentitem ASSIGNING FIELD-SYMBOL(<keys_item2>).

  IF MSZTY2 = 'E' .
EXIT .
ENDIF .
*
      CONVERT KEY OF i_materialdocumentitemtp
      FROM <keys_item2>-%pid
      TO <keys_item2>-%key.
    ENDLOOP.

ENDIF.
    COMMIT ENTITIES END.

data result261 type string .

   IF  MSZTY2 = 'E' .

result261 = |Error { MSZ_1 } |.

ELSE .

DATA(GRN2)  = <keys_header2>-MaterialDocument .
* data result type string .

result261 = <keys_header2>-MaterialDocument .
DATA(result1261) = <keys_header2>-MaterialDocumentYear.

ENDIF.

ENDIF.
******261 End*****



*******************

  IF   MSZTY = 'E' .
     json    =  result .
     ELSE .

      CONCATENATE ' Matterial Document ' '101 = ' '(' result ')' ' / ' ' 261 = ' '(' result261 ')' ' Post Sucessfully And Table' TABRESULT  INTO json SEPARATED BY ' ' .

*     ELSEIF   MSZTY <> 'E' AND  MSZTY2 = 'E'.
*
*      CONCATENATE 'Matterial Document ' result '/' result261  ' Post Sucessfully And Table' TABRESULT  INTO json .
*
*      ELSEIF  MSZTY <> 'E' AND  MSZTY2 <> 'E'.

ENDIF.
      ENDIF.

**    IF <keys_item> IS ASSIGNED .
**      lv   = |Material Document'  '{ <keys_item>-materialdocument }'  'Posted'|  .
**      response->set_text(  lv   ).

**    ELSE . .

           response->set_text( json  ).

*      response->set_text( '####failed'  ).

    ENDIF.








  ENDMETHOD.
ENDCLASS.
