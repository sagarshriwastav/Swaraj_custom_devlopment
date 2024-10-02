class ZCL_PP_LOOMCARD_PRINT_HTTP definition
  public
  create public .

public section.
   INTERFACES if_oo_adt_classrun .
  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_PP_LOOMCARD_PRINT_HTTP IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

     DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).

     data beamno type string.
     data orderno  type C LENGTH 12.
     data orderno1  type C LENGTH 12.
     DATA radiobutton TYPE STRING .


beamno = value #( req[ name = 'beamno' ]-value optional ) .
orderno = value #( req[ name = 'orderno' ]-value optional ) .
radiobutton = value #( req[ name = 'radiobutton' ]-value optional ) .

orderno1   =  |{ orderno ALPHA = IN }| .


*
DATA(pdf1) = zpp_loomcard_print_class=>read_posts( beamno = beamno
                                          orderno = orderno1
                                          radiobutton  = radiobutton
                                          ).

   response->set_text( pdf1 ).
  endmethod.


 METHOD if_oo_adt_classrun~main.


  endmethod.
ENDCLASS.
