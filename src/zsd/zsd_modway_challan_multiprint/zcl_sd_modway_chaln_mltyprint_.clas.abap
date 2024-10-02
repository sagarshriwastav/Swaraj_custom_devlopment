class ZCL_SD_MODWAY_CHALN_MLTYPRINT_ definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_SD_MODWAY_CHALN_MLTYPRINT_ IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

   DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).


DATA JSON TYPE STRING .
DATA plant type string.
DATA delverynoFrom type string.
DATA delverynoto type string.
DATA Pick type string.





plant =  value #( req[ name = 'plant' ]-value optional ) .
delverynoFrom =  value #( req[ name = 'delverynofrom' ]-value optional ) .
delverynoto =  value #( req[ name = 'delverynoto' ]-value optional ) .
pick =  value #( req[ name = 'pick' ]-value optional ) .




JSON =  value #( req[ name = 'json' ]-value optional ) .


data(pdf2) = zsd_modway_challan_multiprint=>read_posts( plant = plant delverynoFrom = delverynoFrom delverynoTo = delverynoTo Pick = Pick ) .

response->set_text( pdf2  ).

  endmethod.
ENDCLASS.
