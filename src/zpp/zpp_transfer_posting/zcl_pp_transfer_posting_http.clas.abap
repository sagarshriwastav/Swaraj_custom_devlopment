CLASS zcl_pp_transfer_posting_http DEFINITION
  PUBLIC
  CREATE PUBLIC .
********************CREATED GAJENDRA SINGH SHEKHAWAT*************************************************************
  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_PP_TRANSFER_POSTING_HTTP IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.



    DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).


    DATA(body)  = request->get_text(  )  .

    DATA sddocument TYPE znumc12 .
    DATA sddocumentitem TYPE n LENGTH 6 .

    DATA respo  TYPE zpp_transfer_posting_str .



    xco_cp_json=>data->from_string( body )->write_to( REF #( respo ) ).


    READ TABLE respo-atablearr1 INTO DATA(t1) INDEX 1.
    DATA  totalqty1 TYPE  string.
    DATA result TYPE string .
    DATA result1 TYPE string .

   DATA MAT TYPE C LENGTH 1.
   DATA MATERIAL(18) TYPE C .
   DATA CONMATERIAL(18) TYPE C .

  LOOP AT respo-atablearr1 ASSIGNING FIELD-SYMBOL(<GS>) .
  MAT    = <GS>-mat+0(1).
  SELECT SINGLE * FROM zpp_alphabet_ta1 WHERE alphabet = @MAT INTO @DATA(WA_MAT) .

  IF SY-subrc = '0' .

  IF WA_MAT <> ''.
  <GS>-mat = <GS>-mat .
  ENDIF.

  ELSEIF WA_MAT = '' .
  MATERIAL   =  <GS>-mat .
  <GS>-mat = |{ MATERIAL ALPHA = IN }| .
  <GS>-mat   =  <GS>-mat+22(18) .
  ENDIF.

  ENDLOOP.

    IF  respo-radiobuton = 'Sloc To Sloc' .

      LOOP AT  respo-atablearr1  ASSIGNING FIELD-SYMBOL(<wat>).
        IF <wat>-soitem EQ '0'.
          <wat>-soitem = ''.
          <wat>-ind = ''.
        ELSE.
          <wat>-soitem = |{ <wat>-soitem ALPHA = IN }| .
          <wat>-ind = 'E'.
        ENDIF.
      ENDLOOP.

      MODIFY ENTITIES OF i_materialdocumenttp
                ENTITY materialdocument
                CREATE FROM VALUE #( ( %cid                          = 'My%CID_1'
                                       goodsmovementcode             = '04'
                                       postingdate                   =  sy-datum
                                       documentdate                  =   sy-datum
                                       %control-goodsmovementcode                    = cl_abap_behv=>flag_changed
                                       %control-postingdate                          = cl_abap_behv=>flag_changed
                                       %control-documentdate                         = cl_abap_behv=>flag_changed
                                   ) )

*FF001
*FF001A  1.  FN01  2 . FG01
                ENTITY materialdocument
                CREATE BY \_materialdocumentitem
                FROM VALUE #( (
                                %cid_ref = 'My%CID_1'
                                %target = VALUE #( FOR any IN respo-atablearr1 INDEX INTO i  ( %cid                           = |My%CID_{ i }_001|
                                                     plant                          =   any-plant
                                                     material                       =    any-mat
                                                     goodsmovementtype              = '311'
                                                     inventoryspecialstocktype      = any-ind
                                                     storagelocation                =    any-stloc
                                                     quantityinentryunit            =   any-stockqty
                                                     entryunit                      = 'M'
                                                     batch                          =    any-batch
                                                     issuingorreceivingplant        =  any-plant
                                                     issuingorreceivingstorageloc   =  any-recloc
                                                     issgorrcvgbatch                =  any-batch
                                                     specialstockidfgsalesorder     =  |{ any-salesoder ALPHA = IN }|
                                                     specialstockidfgsalesorderitem  = |{ any-soitem ALPHA = IN }|
                                                     issgorrcvgspclstockind         = ''
                                                     materialdocumentitemtext       =    ''
                                                     %control-plant                 = cl_abap_behv=>flag_changed
                                                     %control-material              = cl_abap_behv=>flag_changed
                                                     %control-goodsmovementtype     = cl_abap_behv=>flag_changed
                                                     %control-storagelocation       = cl_abap_behv=>flag_changed
                                                     %control-quantityinentryunit   = cl_abap_behv=>flag_changed
                                                     %control-entryunit             = cl_abap_behv=>flag_changed
                                                 ) )


                            ) )
                MAPPED   DATA(ls_create_mapped)
                FAILED   DATA(ls_create_failed)
                REPORTED DATA(ls_create_reported).

      COMMIT ENTITIES BEGIN
       RESPONSE OF i_materialdocumenttp
       FAILED DATA(commit_failed)
       REPORTED DATA(commit_reported).
**************


      IF commit_failed-materialdocument IS NOT INITIAL .

        LOOP AT  commit_reported-materialdocumentitem ASSIGNING FIELD-SYMBOL(<data>).

          DATA(msz) =  <data>-%msg  .

          DATA(mszty) = sy-msgty .
          DATA(msz_1)  = | { sy-msgv1 } { sy-msgv2 }  { sy-msgv3 } { sy-msgv4 } Message Type- { sy-msgty } Message No { sy-msgno }  |  .

        ENDLOOP .

      ELSE .

        IF commit_failed-materialdocument IS INITIAL .

          CLEAR mszty .
        ENDIF .

        LOOP AT ls_create_mapped-materialdocument ASSIGNING FIELD-SYMBOL(<keys_header>).
          IF mszty = 'E' .
            EXIT .
          ENDIF .

          CONVERT KEY OF i_materialdocumenttp
          FROM <keys_header>-%pid
          TO <keys_header>-%key .
        ENDLOOP.


        LOOP AT ls_create_mapped-materialdocumentitem ASSIGNING FIELD-SYMBOL(<keys_item>).
*
          IF mszty = 'E' .
            EXIT .
          ENDIF .

          CONVERT KEY OF i_materialdocumentitemtp
                 FROM <keys_item>-%pid
                 TO <keys_item>-%key.
        ENDLOOP.
      ENDIF.
      COMMIT ENTITIES END.


      DATA result311 TYPE string .
      DATA result3111 TYPE string .

      IF  mszty = 'E' .

        result311 = |Error { msz_1 } |.

      ELSE .

        DATA(grn411)  = <keys_header>-materialdocument .


        result311 = <keys_header>-materialdocument .
        result3111 = <keys_header>-materialdocumentyear.
      ENDIF.
      DATA   json   TYPE string.

      CONCATENATE  ' Material Document '  result311   ' Post Successfuly '  INTO json SEPARATED BY ' '.


    ELSEIF  respo-radiobuton = 'SO To SO' .


     LOOP AT  respo-atablearr1  ASSIGNING FIELD-SYMBOL(<wat1>).

        IF <wat1>-soitem EQ '0' AND <wat1>-salesoder = '' .
          <wat1>-salesoder  = <wat1>-recso .
          <wat1>-soitem = <wat1>-recsoitem.
          <wat1>-goodmvt = '412'.
          <wat1>-recso  = '' .
          <wat1>-recsoitem = '' .

        ELSE.
          <wat1>-goodmvt = '413'.
        ENDIF.
      ENDLOOP.



      MODIFY ENTITIES OF i_materialdocumenttp
           ENTITY materialdocument
           CREATE FROM VALUE #( ( %cid                          = 'My%CID_1'
                                  goodsmovementcode             = '04'
                                  postingdate                   = sy-datum
                                  documentdate                  =   sy-datum
                                  %control-goodsmovementcode                    = cl_abap_behv=>flag_changed
                                  %control-postingdate                          = cl_abap_behv=>flag_changed
                                  %control-documentdate                         = cl_abap_behv=>flag_changed
                              ) )

*FF001
*FF001A  1.  FN01  2 . FG01
           ENTITY materialdocument
           CREATE BY \_materialdocumentitem
           FROM VALUE #( (
                           %cid_ref = 'My%CID_1'
                           %target = VALUE #( FOR any IN respo-atablearr1 INDEX INTO i  ( %cid                           = |My%CID_{ i }_001|
                                                plant                          =    any-plant
                                                material                       =   any-mat
                                                goodsmovementtype              =  any-goodmvt " '413'
                                                inventoryspecialstocktype      = 'E'
                                                storagelocation                =   any-stloc
                                                quantityinentryunit            =   any-stockqty
                                                entryunit                      = 'M'
                                                batch                          =   any-batch
                                                issuingorreceivingplant        =   any-plant
                                                issuingorreceivingstorageloc   =   any-stloc
                                                issgorrcvgbatch                =   any-batch
                                                issgorrcvgspclstockind         =   'E'
                                                salesorder                     =  |{ any-recso ALPHA = IN }|   " '0070000004'
                                                salesorderitem                 =  |{ any-recsoitem ALPHA = IN }| " '000010'
                                                specialstockidfgsalesorder     =  |{ any-salesoder ALPHA = IN  }|    "'0070000096'
                                                specialstockidfgsalesorderitem =  |{ any-soitem ALPHA = IN }| " '000010'

*                                                  ManufacturingOrder             = '000001000057'
*                                                  GoodsMovementRefDocType        = 'F'
*                                                  IsCompletelyDelivered          = ' '
                                                materialdocumentitemtext       =   ''  " 'Trolly Transfer'
                                                   salesorderscheduleline         =   '0'
                                                %control-plant                 = cl_abap_behv=>flag_changed
                                                %control-material              = cl_abap_behv=>flag_changed
                                                %control-goodsmovementtype     = cl_abap_behv=>flag_changed
                                                %control-storagelocation       = cl_abap_behv=>flag_changed
                                                %control-quantityinentryunit   = cl_abap_behv=>flag_changed
                                                %control-entryunit             = cl_abap_behv=>flag_changed
                                            ) )


                       ) )
           MAPPED   DATA(ls_create_mapped413)
           FAILED   DATA(ls_create_failed413)
           REPORTED DATA(ls_create_reported413).

      COMMIT ENTITIES BEGIN
       RESPONSE OF i_materialdocumenttp
       FAILED DATA(commit_failed413)
       REPORTED DATA(commit_reported413).
      LOOP AT commit_reported413-materialdocumentitem INTO DATA(w).
        DATA(a) = w-%msg->if_message~get_longtext(   ).
      ENDLOOP.
      IF ls_create_mapped413-materialdocument IS INITIAL.
        LOOP AT  commit_reported413-materialdocumentitem ASSIGNING FIELD-SYMBOL(<data2>).
* IF  <data2>-%MSG  IS NOT INITIAL .

          DATA(msz2) =  <data2>-%msg  .

*ENDIF.

          mszty = sy-msgty .
          msz_1  = | { sy-msgv1 } { sy-msgv2 }  { sy-msgv3 } { sy-msgv4 } Message Type- { sy-msgty } Message No { sy-msgno } { sy-msgid } |  .

        ENDLOOP .
************************************

      ELSE.

        LOOP AT ls_create_mapped413-materialdocument ASSIGNING FIELD-SYMBOL(<keys_header1>).
          IF mszty = 'E' .
            EXIT .
          ENDIF .


          CONVERT KEY OF i_materialdocumenttp
          FROM <keys_header1>-%pid
          TO <keys_header1>-%key .
        ENDLOOP.


        LOOP AT ls_create_mapped413-materialdocumentitem ASSIGNING FIELD-SYMBOL(<keys_item1>).
          IF mszty = 'E' .
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
      IF  mszty = 'E' .

        result311 = |Error { msz_1 } |.

      ELSE .

        grn411  = <keys_header1>-materialdocument .


        result311 = <keys_header1>-materialdocument .
        result3111 = <keys_header1>-materialdocumentyear.
      ENDIF.

      CONCATENATE  ' Material Document '  result311   ' Post Successfuly '  INTO json SEPARATED BY ' '.

    ENDIF .


    response->set_text( json  ).

  ENDMETHOD.
ENDCLASS.
