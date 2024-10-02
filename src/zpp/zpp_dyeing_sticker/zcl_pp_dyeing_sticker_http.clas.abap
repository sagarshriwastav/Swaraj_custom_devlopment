class ZCL_PP_DYEING_STICKER_HTTP definition
public
create public .
public section.

INTERFACES if_oo_adt_classrun .
interfaces IF_HTTP_SERVICE_EXTENSION .

protected section.
private section.

ENDCLASS.



CLASS ZCL_PP_DYEING_STICKER_HTTP IMPLEMENTATION.


 method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.
   DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).
*    response->set_status( i_reason = 'SUSCESSFULL'  i_code = 2 ).

 data plant type string.
 data material type matnr.
 data dyedfrom TYPE string.
 data dyedto TYPE string.


plant = value #( req[ name = 'plant' ]-value optional ) .
material = value #( req[ name = 'material' ]-value optional ) .
dyedfrom = value #( req[ name = 'dyedfrom' ]-value optional ) .
dyedto = value #( req[ name = 'dyedto' ]-value optional ) .


*
DATA(pdf1) = zpp_dyeing_sticker_class=>read_posts( plant = plant

                                          material = material

                                          dyedfrom = dyedfrom
                                          dyedto = dyedto
                                          ).
                                          response->set_text( pdf1 ).
  endmethod.


 METHOD if_oo_adt_classrun~main.


  ENDMETHOD.
ENDCLASS.
