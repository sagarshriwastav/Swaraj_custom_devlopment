class ZCL_WARPING_ENTRY_HTTP definition
  public
  create public .
********************CREATED GAJENDRA SINGH SHEKHAWAT*************************************************************
public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.

   DATA: filedata TYPE string.

ENDCLASS.



CLASS ZCL_WARPING_ENTRY_HTTP IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

            data zwarping_entry type zwarping_entry .

      DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).







        DATA variable TYPE char8.
        DATA variable1 TYPE CHAR10.

        variable = req[ 3 ]-NAME.
        variable1 = req[ 3 ]-value.

    DATA(body)  = request->get_text(  )  .

    DATA respo  TYPE zwarping_entry_structure .

     xco_cp_json=>data->from_string( body )->write_to( REF #( respo ) ).
     READ TABLE respo-tabledata INTO DATA(WA_SET) INDEX 1.

     IF variable1 = 'Create' .
          LOOP AT   respo-tabledata ASSIGNING FIELD-SYMBOL(<FS2>)  .


          zwarping_entry-totends = respo-totalend.
          zwarping_entry-beamlenght = <FS2>-beamlength.
          zwarping_entry-beamno = <FS2>-beamno.
          zwarping_entry-ends = <FS2>-ends.
          zwarping_entry-grooswt = <FS2>-grosswt.
          zwarping_entry-material = <FS2>-dyeingsort.
          zwarping_entry-netwt = <FS2>-netwt.
          zwarping_entry-rpm = <FS2>-rpm.
          zwarping_entry-tarewt = <FS2>-tarewt.
          zwarping_entry-warper = <FS2>-warper.
          zwarping_entry-zfset_no = <FS2>-setno.
          zwarping_entry-zlength = <FS2>-setlength.
          zwarping_entry-zmc_no = <FS2>-warpingmcno.
          zwarping_entry-breaks = <FS2>-breaks.
          zwarping_entry-breaksmtr = <FS2>-breakmilion.
          zwarping_entry-zcount = respo-yarnc.
          zwarping_entry-zdate   = respo-postingdate.
          zwarping_entry-avgbpmm = respo-avgbpmm .
          zwarping_entry-beamin1creel = respo-beamin1creel .
          zwarping_entry-supplierconweight = respo-supplierconweight .

               modify  zwarping_entry from @zwarping_entry  .

      COMMIT WORK AND WAIT.

     ENDLOOP .
            IF sy-subrc IS INITIAL.
          DATA(TABRESULT) =  ' Data Saved!! ' .
        ELSE.
          TABRESULT = 'Error in saving data!!' .
        ENDIF.


      ELSEIF   variable1 = 'Change' .

     DELETE FROM zwarping_entry WHERE Zfset_no = @WA_SET-setno.
     COMMIT WORK AND WAIT.
      IF sy-subrc IS INITIAL.
                LOOP AT   respo-tabledata ASSIGNING FIELD-SYMBOL(<FS>)  .


          zwarping_entry-totends = respo-totalend.
          zwarping_entry-beamlenght = <FS>-beamlength.
          zwarping_entry-beamno = <FS>-beamno.
          zwarping_entry-ends = <FS>-ends.
          zwarping_entry-grooswt = <FS>-grosswt.
          zwarping_entry-material = <FS>-dyeingsort.
          zwarping_entry-netwt = <FS>-netwt.
          zwarping_entry-rpm = <FS>-rpm.
          zwarping_entry-tarewt = <FS>-tarewt.
          zwarping_entry-warper = <FS>-warper.
          zwarping_entry-zfset_no = <FS>-setno.
          zwarping_entry-zlength = <FS>-setlength.
          zwarping_entry-zmc_no = <FS>-warpingmcno.
          zwarping_entry-breaks = <FS>-breaks.
          zwarping_entry-breaksmtr = <FS>-breakmilion.
          zwarping_entry-zcount = respo-yarnc.
          zwarping_entry-zdate   = respo-postingdate.
          zwarping_entry-avgbpmm = respo-avgbpmm.
          zwarping_entry-beamin1creel = respo-beamin1creel .
          zwarping_entry-supplierconweight = respo-supplierconweight .


               modify  zwarping_entry from @zwarping_entry  .

      COMMIT WORK AND WAIT.
        ENDLOOP.
        ENDIF.
         IF sy-subrc IS INITIAL.
          TABRESULT =  ' Data Change Saved!! ' .
        ELSE.
          TABRESULT = 'Error in saving data!!' .
        ENDIF.


      ENDIF.

  DATA JSON TYPE STRING.
         CONCATENATE  TABRESULT 'Table Zwarping Entry' INTO json SEPARATED BY ' '.

      response->set_text( json ).


  endmethod.
ENDCLASS.
