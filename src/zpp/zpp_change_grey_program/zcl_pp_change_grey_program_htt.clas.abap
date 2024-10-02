class ZCL_PP_CHANGE_GREY_PROGRAM_HTT definition
  public
  create public .
********************CREATED GAJENDRA SINGH SHEKHAWAT*************************************************************
public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_PP_CHANGE_GREY_PROGRAM_HTT IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

     DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).


    DATA(body)  = request->get_text(  )  .


    DATA respo  TYPE zpp_change_grey_program_str .
    DATA TABRESULT TYPE STRING.

     xco_cp_json=>data->from_string( body )->write_to( REF #( respo ) ).


      LOOP AT   respo-tabledata ASSIGNING FIELD-SYMBOL(<FS>)  .

              UPDATE zpp_grey_grn_tab SET Pick = @<FS>-Pick , NetWt = @<FS>-netwt
              , wtmtr = @<FS>-wtmtr  , ironpipe = @<FS>-ironpipe ,
            grosswt = @<FS>-grosswt , shadeno  = @<FS>-shade ,
             remark = @<FS>-remark WHERE plant = @<FS>-Plant and batch = @<fs>-beamno AND recbatch = @<fs>-rollno
             AND materialdocument101 = @<FS>-materialdocument.
      COMMIT WORK AND WAIT.
     ENDLOOP .
       IF sy-subrc IS INITIAL.
          TABRESULT =  ' Data Saved Successfully !' .
        ELSE.
          TABRESULT = 'Error in saving data!!' .
        ENDIF.
    DATA JSON TYPE STRING.

     JSON =  TABRESULT .

      response->set_text( json ).
  endmethod.
ENDCLASS.
