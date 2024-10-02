CLASS yjob_http_handler_class DEFINITION
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS YJOB_HTTP_HANDLER_CLASS IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.
  DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).


DATA JSON TYPE STRING .
DATA plant type string.
DATA delverynoFrom type string.
DATA delverynoto type string.
DATA Pick type string.
DATA lrnumber type string.





plant =  value #( req[ name = 'plant' ]-value optional ) .
delverynoFrom =  value #( req[ name = 'delverynofrom' ]-value optional ) .
delverynoto =  value #( req[ name = 'delverynoto' ]-value optional ) .
pick =  value #( req[ name = 'pick' ]-value optional ) .
lrnumber =  value #( req[ name = 'lrnumber' ]-value optional ) .




JSON =  value #( req[ name = 'json' ]-value optional ) .

 IF plant = '2100' OR plant = '2200' .

data(pdf2) = yjob_modway_packing_list=>read_posts( plant = plant delverynoFrom = delverynoFrom pick = pick  ) .

ELSE.
  pdf2 = yjob_form_class=>read_posts( plant = plant delverynoFrom = delverynoFrom  delverynoto = delverynoto lrnumber = lrnumber ) .
ENDIF.
response->set_text( pdf2  ).

  endmethod.
ENDCLASS.
