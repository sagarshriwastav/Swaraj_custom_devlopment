class ZCL_MM_FABRICWISE_PERCATANGE_H definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_MM_FABRICWISE_PERCATANGE_H IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

    DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).



      DATA(body)  = request->get_text(  )  .
     DATA respo TYPE  zmm_yfactory_beam_str1 .
     DATA wa_ga TYPE zfabric_wastage.
     DATA TABRESULT TYPE string..

     xco_cp_json=>data->from_string( body )->write_to( REF #( respo ) ).

   loop at respo-atablearr1 INTO DATA(wa) .
    wa_ga-material  = wa-material.
    wa_ga-wastegpersantage = wa-watagepercentage.
    wa_ga-materialdescription = wa-materialdesc.
    MODIFY zfabric_wastage FROM  @wa_ga .
   endloop.

        IF sy-subrc IS INITIAL.
          TABRESULT =  ' Data Saved!! ' .
        ELSE.
          TABRESULT = 'Error in saving data!!' .
        ENDIF.

      COMMIT WORK AND WAIT.

   response->set_text( TABRESULT  ).

  endmethod.
ENDCLASS.
