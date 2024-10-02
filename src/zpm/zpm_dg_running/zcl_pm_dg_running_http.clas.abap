class ZCL_PM_DG_RUNNING_HTTP definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_PM_DG_RUNNING_HTTP IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

   DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).


    DATA(body)  = request->get_text(  )  .

    DATA respo  TYPE zpm_dg_running_str .

    xco_cp_json=>data->from_string( body )->write_to( REF #( respo ) ).

    DATA WA_TAB TYPE zpm_dg_running .
    DATA TABRESULT TYPE STRING.

    LOOP AT respo-atablearr1 INTO DATA(WA) .

      WA_TAB-dgno   =   WA-dgno .
      WA_TAB-dgendtime   = WA-dgendtime .
      WA_TAB-dgstarttime  = WA-dgstarttime .
      WA_TAB-dgtotaltime  = WA-dgtotaltime .
      WA_TAB-disellevalstart  = WA-disellevalstart .
      WA_TAB-disellevelend   = WA-disellevelend .
      WA_TAB-diselrec        = WA-diselrec .
      WA_TAB-totaldiselconsumption  = WA-totaldiselconsumption .
      REPLACE ALL OCCURRENCES OF '-' IN  WA-date WITH '' .
     CONDENSE WA-date .
*     CONCATENATE WA-zdate+4(4) WA-zdate+2(2) WA-zdate+0(2) INTO ZDATE1.
      WA_TAB-zdate      = WA-date .

       MODIFY zpm_dg_running FROM @WA_TAB.

    ENDLOOP.

     IF sy-subrc IS INITIAL.
          TABRESULT =  ' Data Saved!! ' .
        ELSE.
          TABRESULT = 'Error in saving data!!' .
        ENDIF.

      COMMIT WORK AND WAIT.

       response->set_text( TABRESULT  ).

  endmethod.
ENDCLASS.
