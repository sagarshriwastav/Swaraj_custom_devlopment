CLASS zmir7_mail_class  DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
    CLASS-METHODS
      read_data
*        IMPORTING variable        TYPE string
        RETURNING VALUE(result12) TYPE string
        RAISING   cx_static_check .
    CLASS-DATA: lx_bcs_mail TYPE REF TO cx_bcs_mail.



  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZMIR7_MAIL_CLASS IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    TRY.
        DATA(return_data) = read_data(  ) .
    ENDTRY.
  ENDMETHOD.


  METHOD read_data.

    DATA gv4 TYPE datab_kk .
    DATA gv1(2) TYPE C .
    DATA gv2(2) TYPE C .
    DATA gv3 TYPE string .

    DATA dt4 TYPE string .
    DATA dt1(2) TYPE C .
    DATA dt2(2) TYPE C .
    DATA dt3 TYPE string .

    DATA fiscle TYPE zchar4.
    DATA fiscle1(4) TYPE n.
    fiscle1 = sy-datum+0(4).

    gv3 = sy-datum+0(4)  . "YEAR
    gv2 = sy-datum+4(2)  . "MONTH
    gv1 = sy-datum+6(2)  . "DAY

    GV1 = GV1 - 04.
    GV1 = |{ GV1 ALPHA = IN }|.
    CONCATENATE GV3 GV2 GV1 INTO GV4.


  SELECT * FROM I_PurchaseOrderHistoryAPI01 WHERE PostingDate = @GV4
   AND ( PurchasingHistoryCategory <> 'T' AND PurchasingHistoryCategory <> 'Q')  INTO TABLE @DATA(IT).

 IF IT IS NOT INITIAL.

  DELETE ADJACENT DUPLICATES FROM IT COMPARING ReferenceDocument POSTINGDATE.

    TYPES : BEGIN OF it_solisti1 ,
              line TYPE c LENGTH 255,
            END OF it_solisti1.

    DATA : i_objtx  TYPE STANDARD TABLE OF it_solisti1,
           i_objtxt TYPE it_solisti1.

    CLEAR : i_objtx,i_objtxt .
    i_objtxt-line = '<HTML> <BODY>'.
    APPEND i_objtxt TO i_objtx.
    CLEAR : i_objtxt.

    CONCATENATE '<p style="font-family:Calibri;font-size:15;">' 'Dear Sir,' INTO i_objtxt-line.
    APPEND i_objtxt TO i_objtx.
    CLEAR : i_objtxt.


            i_objtxt-line = '<HTML> <BODY>'.
            APPEND i_objtxt TO i_objtx.
            CLEAR : i_objtxt.

            i_objtxt-line = '<p><b>Here are the documents waiting for MIR7, since last four days:</b></p>'.
            APPEND i_objtxt-line TO i_objtx.
            CLEAR : i_objtxt .


            i_objtxt-line = '<table width=”30%” style="font-family:calibri;font-size:15;MARGIN:10px;"'.   " bordercolor="blue"'.
            APPEND i_objtxt TO i_objtx.
            CLEAR : i_objtxt.

            i_objtxt-line = 'cellspacing="0" cellpadding="1" width="100%" '.
            APPEND i_objtxt TO i_objtx.
            CLEAR : i_objtxt.

            i_objtxt-line = 'border="1"><tbody><tr>'.
            APPEND i_objtxt TO i_objtx.
            CLEAR : i_objtxt.


            i_objtxt-line = '<th bgcolor="#a3d4ba" width="20%"> Documents </th>'.
            APPEND i_objtxt TO i_objtx.
            CLEAR : i_objtxt.


            i_objtxt-line = '<th bgcolor="#a3d4ba" width="20%"> Document Date </th>'.
            APPEND i_objtxt TO i_objtx.
            CLEAR : i_objtxt.


  LOOP AT IT INTO DATA(WA).

    dt3 = wa-PostingDate+0(4)  . "YEAR
    dt2 = wa-PostingDate+4(2)  . "MONTH
    dt1 = wa-PostingDate+6(2)  . "DAY

    dt1 = |{ dt1 ALPHA = IN }|.
    CONCATENATE dt1 '/' dt2 '/' dt3 INTO dt4.


          i_objtxt-line = '<tr align = "center">'.
          APPEND i_objtxt TO i_objtx.
          CLEAR : i_objtxt.

          CONCATENATE '<td><b>' wa-ReferenceDocument  '</b></td>' INTO i_objtxt-line SEPARATED BY space.
          APPEND i_objtxt TO i_objtx.
          CLEAR : i_objtxt.

          i_objtxt-line = |<td>| && |{ dt4 }| && |</td>|.
          APPEND i_objtxt TO i_objtx.
          CLEAR : i_objtxt.

          i_objtxt-line = '<tr align = "center">'.
          APPEND i_objtxt TO i_objtx.
          CLEAR : i_objtxt.


 endloop.

             i_objtxt-line = '</table width=”30%” style="font-family:calibri;font-size:15;MARGIN:10px;"'.   " bordercolor="blue"'.
            APPEND i_objtxt TO i_objtx.
            CLEAR : i_objtxt.

      DELETE i_objtx WHERE table_line IS INITIAL .
*
*          i_objtxt-line = '<tr align = "center">'.
*          APPEND i_objtxt TO i_objtx.
*          CLEAR : i_objtxt.
*
*
    i_objtxt-line = '</body> </html>'.
    APPEND i_objtxt TO i_objtx.
    CLEAR i_objtxt.

    CONCATENATE '<p style="font-family:Calibri;font-size:16;">' 'Thank You,'  '</p>'     INTO i_objtxt-line .
    APPEND i_objtxt-line TO i_objtx.
    CLEAR : i_objtxt .

    CONCATENATE  '<p style="font-family:Calibri;font-size:16;">'   'SAP '        '</p>'  INTO i_objtxt-line .
    APPEND i_objtxt-line TO i_objtx.
    CLEAR : i_objtxt .


    DATA :
      v_lines_txt TYPE i,
      v_lines_bin TYPE i.
    CLEAR : v_lines_txt , v_lines_bin .

    v_lines_txt = lines( i_objtx ).
    DATA lv TYPE string .
    CLEAR : lv .
    LOOP  AT i_objtx INTO i_objtxt .
      IF lv = ''.
        lv = i_objtxt.
      ELSE.
        CONCATENATE lv i_objtxt INTO lv.
        CONDENSE lv .
      ENDIF.
    ENDLOOP.

*    DATA(config_instance) = cl_bcs_mail_system_config=>create_instance( ).
*    DATA recipient_domains TYPE cl_bcs_mail_system_config=>tyt_recipient_domains.
*    DATA sender_domains TYPE cl_bcs_mail_system_config=>tyt_sender_domains.
*    recipient_domains = VALUE #( ( 'novelveritas.com' ) ).
*    sender_domains = VALUE #( ( '@swarajsuiting.com' ) ).
*    recipient_domains = VALUE #( ( 'gmail.com' ) ).
*    "Add allowed domains
*
*    TRY.
*        config_instance->set_address_check_active( abap_true ).
*        config_instance->add_allowed_recipient_domains( recipient_domains ).
*        config_instance->add_allowed_sender_domains( sender_domains ).
*        config_instance->modify_default_sender_address( iv_default_address = 'noreply@swarajsuiting.com'
*        iv_default_name = 'Default Sender' ).
*      CATCH cx_bcs_mail_config INTO DATA(write_error).
*        "handle exception
*    ENDTRY.


    TRY.
        DATA(lo_mail) = cl_bcs_mail_message=>create_instance( ).
        lo_mail->set_sender( 'noreply@swarajsuiting.com' ).
*        lo_mail->add_recipient( 'vipinrathore2424@gmail.com' ).
        lo_mail->add_recipient( 'tajendrasinghsolanki342@gmail.com' ).
        lo_mail->add_recipient( 'praveenranawat784@gmail.com' ).
        lo_mail->add_recipient( '' ).




        lo_mail->set_subject( 'Documents Pending For MIR7' ).
        lo_mail->set_main( cl_bcs_mail_textpart=>create_instance(
        iv_content      = lv
        iv_content_type = 'text/html'
        ) ).


        lo_mail->send( IMPORTING et_status = DATA(lt_status) ).
      CATCH cx_bcs_mail INTO lx_bcs_mail.
    ENDTRY.

 ENDIF.

  ENDMETHOD.
ENDCLASS.
