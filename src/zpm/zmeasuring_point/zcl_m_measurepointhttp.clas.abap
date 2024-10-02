class ZCL_M_MEASUREPOINTHTTP definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_M_MEASUREPOINTHTTP IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.


  DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).

    DATA(body)  = request->get_text(  )  .

*      response->set_text(  body ).


   DATA respo  TYPE ypmeasuring .
   DATA respo1  TYPE TABLE OF ypmeasuring .


    xco_cp_json=>data->from_string( body )->write_to( REF #( respo-atableitem ) ).

IF SY-SUBRC = 0 .


* RESPO1 = RESPO-atableitem[]  .

DATA(STATUS)  = zclass_measuring=>material_document12( it_measuring = respo  )  .

 response->set_text(  | { STATUS } Records Updated  | ).

ENDIF .


  endmethod.
ENDCLASS.
