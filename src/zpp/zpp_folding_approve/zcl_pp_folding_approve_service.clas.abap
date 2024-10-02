CLASS zcl_pp_folding_approve_service DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_PP_FOLDING_APPROVE_SERVICE IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.

*    DATA tabresult TYPE string .
*   DATA approvdstc TYPE zpp_fold_approve .

    DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).

    DATA(body)  = request->get_text(  )  .


    DATA respo  TYPE zpp_folding_approve_stc .
*        DATA approvdstc TYPE zpp_fold_approve .
*       DATA ZPPFOLDING TYPE    zpp_folding_cds.

    xco_cp_json=>data->from_string( body )->write_to( REF #( respo ) ).

    DATA approvdstc TYPE zpp_fold_approve .


* approvdstc-approve     =   respo-approve .
* MODIFY zpp_fold_approve FROM @approvdstc  .

    IF respo-beam_no IS NOT INITIAL.
       approvdstc-plant = respo-plant.
      approvdstc-sno = respo-beam_no.
*      approvdstc-beam_no = respo-beam_no.
*      approvdstc-approve     =   respo-approve .
      MODIFY zpp_fold_approve  FROM @approvdstc  .
      CLEAR : approvdstc .
    ENDIF.

     DATA tabresult TYPE string .

    IF sy-subrc IS  INITIAL.
      tabresult =  ' Data Saved!! ' .
    ELSE.
      tabresult = 'Error in saving data!!' .
    ENDIF.

      COMMIT WORK AND WAIT.
    response->set_text( tabresult  ).

  ENDMETHOD.
ENDCLASS.
