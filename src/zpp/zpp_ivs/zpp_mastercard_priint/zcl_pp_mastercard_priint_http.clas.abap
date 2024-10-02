class ZCL_PP_MASTERCARD_PRIINT_HTTP definition
  public
  create public .

public section.
   INTERFACES if_oo_adt_classrun .
  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_PP_MASTERCARD_PRIINT_HTTP IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

     DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).

     data mastercardno type string.
     data qualitycode  type string.
     data radiobutton  type string.


mastercardno = value #( req[ name = 'mastercardno' ]-value optional ) .
qualitycode = value #( req[ name = 'qualitycode' ]-value optional ) .
radiobutton = value #( req[ name = 'radiobutton' ]-value optional ) .


*
DATA(pdf1) = zpp_mastercard_print_class=>read_posts( mastercardno = mastercardno
                                               qualitycode = qualitycode
                                               radiobutton  = radiobutton
                                          ).

   response->set_text( pdf1 ).
  endmethod.


 METHOD if_oo_adt_classrun~main.


  endmethod.
ENDCLASS.
