
class ZCL_RESERVATIONSLIP definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_RESERVATIONSLIP IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

 DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).


data(reservation) = value #( req[ name = 'matdoc' ]-value optional ) .



data(pdf1)  = zreservationslip=>read_posts(  matdoc = reservation  year = ' '  )   .





response->set_text( pdf1   ) .







  endmethod.
ENDCLASS.
