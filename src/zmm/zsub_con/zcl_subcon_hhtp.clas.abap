CLASS zcl_subcon_hhtp DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SUBCON_HHTP IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.


    DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).
*    response->set_status( i_reason = 'SUSCESSFULL'  i_code = 2 ).

    DATA type2 TYPE char8.
    DATA(table) = VALUE #( req[ name = 'table' ]-value OPTIONAL ) .


    DATA(body)  = request->get_text(  )  .
    DATA zsubcon TYPE    ztabtt_1 .
    DATA zsubcon1 TYPE zsub_itemt .
    DATA tab1 TYPE char1 .
    DATA tab2 TYPE char1 .
    DATA zsubcon_head TYPE zsubcon_head .
    DATA zsubcon_item TYPE zsubcon_item .



    type2 = req[ 2 ]-value.

***************************************************************SAVE MODE*************************************************
*  IF TYPE2 = 'Save'   .
    IF table = 'table1' .

      xco_cp_json=>data->from_string( body )->write_to( REF #( zsubcon ) ).


      DATA zdate1 TYPE c LENGTH 10 .
      DATA zclosedate TYPE c LENGTH 10 .
      LOOP AT   zsubcon-tabledata ASSIGNING FIELD-SYMBOL(<gs>)  .

        SELECT SINGLE * FROM zsubcon_head WHERE party = @<gs>-supplier AND loom = @<gs>-loom AND date2 = '' INTO @DATA(gs_closedate) .
        IF sy-subrc = 0 .
          IF gs_closedate-dyebeam <> '' .

            IF zsubcon-current_date = '' .
              zclosedate     = '' .
            ELSE.
              CONCATENATE zsubcon-current_date+6(2) '-' zsubcon-current_date+4(2) '-'  zsubcon-current_date+0(4) INTO zdate1.
              zclosedate      = zdate1 .
            ENDIF.

            UPDATE zsubcon_head SET date2 = @zclosedate
            WHERE party = @gs_closedate-party AND dyebeam  = @gs_closedate-dyebeam
            AND loom = @gs_closedate-loom.
            COMMIT WORK AND WAIT.

          ENDIF.
        ENDIF.
        CLEAR : zclosedate ,zdate1 .

      ENDLOOP.

      LOOP AT   zsubcon-tabledata ASSIGNING FIELD-SYMBOL(<fs2>)  .

        zsubcon_head-party      =    <fs2>-supplier  .
        zsubcon_head-partyname  =    <fs2>-suppliername .
        zsubcon_head-dyebeam    = <fs2>-dyebeam .
        zsubcon_head-partybeam  = <fs2>-partybeam .
        zsubcon_head-date1      = zsubcon-current_date  .
        zsubcon_head-loom       = <fs2>-loom.
        zsubcon_head-grsortno   = <fs2>-grsortno .
        zsubcon_head-beampipe   = <fs2>-beampipe .
        zsubcon_head-length     = <fs2>-length .
        zsubcon_head-t_ends     = <fs2>-t_ends .
        zsubcon_head-shade      = <fs2>-shade .
        zsubcon_head-pick       = <fs2>-pick .
        zsubcon_head-reed_spac  = <fs2>-reed_spac .
        zsubcon_head-reed       = <fs2>-reed .
        zsubcon_head-dent       = <fs2>-dent .
         zsubcon_head-startingdate       = <fs2>-startingdate .
*    zsubcon_head-folding_no = <fs2>-folding_no .
        IF <fs2>-date2 = '' .
          zsubcon_head-date2      = '' .
        ELSE.
          CONCATENATE <fs2>-date2+6(2) '-' <fs2>-date2+4(2) '-'  <fs2>-date2+0(4) INTO zdate1.
          zsubcon_head-date2      = zdate1 .
        ENDIF.

        MODIFY  zsubcon_head FROM @zsubcon_head  .
        COMMIT WORK AND WAIT.

      ENDLOOP .
     DATA tabresult TYPE STRING.
      IF sy-subrc IS INITIAL.
       tabresult  =  'Data Saved!! ' .
      ELSE.
        tabresult = 'Error in saving data!!' .
      ENDIF.
    ENDIF .


    IF table = 'table2' .
      DATA SUPPLIER TYPE N LENGTH 10 .
      xco_cp_json=>data->from_string( body )->write_to( REF #( zsubcon1 ) ).

      LOOP AT zsubcon1-tabledata INTO DATA(wa) .

         SUPPLIER = wa-supplier .

         SELECT SINGLE Batch as rollno FROM I_MaterialDocumentItem_2 WITH PRIVILEGED ACCESS  WHERE Batch = @wa-dyebeam
                                                                  AND Supplier = @SUPPLIER
                                                                  AND GoodsMovementType = '541'
                                                                  INTO @DATA(cheack) .
        IF cheack IS INITIAL .
        tabresult = 'Error Please Enter Correct Dyed Beam No' && ' ' && wa-rollno .
        EXIT.
        ELSE.
       CLEAR : cheack.
        SELECT SINGLE rollno FROM  ZMM_ROLL_NO_CDS_YEAR WITH PRIVILEGED ACCESS  WHERE rollno = @wa-rollno
                                                                  AND party = @wa-supplier
                                                                  INTO @cheack .
        IF cheack IS NOT INITIAL .
          tabresult = 'Error Piece Already Received Against this Supplier' && ' ' && wa-rollno .
        EXIT.
        ENDIF .
        CLEAR : CHEACK , wa.
        ENDIF.
      ENDLOOP.

IF tabresult IS INITIAL .
      LOOP AT   zsubcon1-tabledata ASSIGNING FIELD-SYMBOL(<fs1>)  .
        zsubcon_item-party      =  <fs1>-supplier  .
        zsubcon_item-dyebeam    = <fs1>-dyebeam .
        zsubcon_item-partybeam  = <fs1>-partybeam .
        zsubcon_item-date1      = zsubcon1-current_date .
        zsubcon_item-loom       = <fs1>-loom.
        zsubcon_item-grsortno   = <fs1>-grsortno .
        zsubcon_item-beampipe   = <fs1>-beampipe .
        zsubcon_item-length     = <fs1>-mtr .
        zsubcon_item-shift      = <fs1>-shift .
        zsubcon_item-setno      = <fs1>-setno .
        zsubcon_item-pick       = <fs1>-pick .
        zsubcon_item-reed_spac  = <fs1>-reed_space .
        zsubcon_item-rollno   = <fs1>-rollno .
        zsubcon_item-reed       = <fs1>-reed .
        zsubcon_item-dent       = <fs1>-dent .
        zsubcon_item-netwt       = <fs1>-netwt.
        zsubcon_item-shade     = <fs1>-shade .
        zsubcon_item-remarks        = <fs1>-remakrs .
        zsubcon_item-mtr       = <fs1>-mtr.
        zsubcon_item-est_fabrictoreceived       = <fs1>-est_fabrictoreceived.
        zsubcon_item-folding_no       = <fs1>-foldingno.


        MODIFY  zsubcon_item FROM @zsubcon_item  .

        COMMIT WORK AND WAIT.

      ENDLOOP  .

      IF sy-subrc IS INITIAL.
        tabresult =  'Data Saved!! ' .
      ELSE.
        tabresult = 'Error in saving data!!' .
      ENDIF.
ENDIF.
    ENDIF .
***************************************************************SAVE MODE*************************************************
    DATA json TYPE string.
***************************************************************CHANGE MODE***********************************************
*ELSEIF TYPE2 = 'Change' .
    IF type2 = 'Change' .

      IF table = 'table1' .

        xco_cp_json=>data->from_string( body )->write_to( REF #( zsubcon ) ).

        LOOP AT   zsubcon-tabledata ASSIGNING FIELD-SYMBOL(<gs_change>)  .

          UPDATE zsubcon_head SET loom = @<gs_change>-loom , grsortno = @<gs_change>-grsortno
                    WHERE dyebeam = @<gs_change>-dyebeam AND party  = @<gs_change>-supplier .
          COMMIT WORK AND WAIT.
        ENDLOOP .
        IF sy-subrc IS INITIAL.
          tabresult =  ' Data Saved Successfully !' .
        ELSE.
          tabresult = 'Error in saving data!!' .
        ENDIF.

      ENDIF.

    ENDIF.
***************************************************************CHANGE MODE***********************************************
    CONCATENATE  tabresult '' INTO json SEPARATED BY ' '.

    response->set_text( json ).




  ENDMETHOD.
ENDCLASS.
