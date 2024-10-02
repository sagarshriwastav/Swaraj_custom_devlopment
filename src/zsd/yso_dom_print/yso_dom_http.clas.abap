CLASS yso_dom_http DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS YSO_DOM_HTTP IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.
  DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).

DATA JSON TYPE STRING .
DATA plant type string.
DATA salesorderno type string.
DATA salesorder type N LENGTH 10.

plant = value #( req[ name = 'plant' ]-value optional ) .
salesorderno = value #( req[ name = 'salesorderno' ]-value optional ) .

JSON =  value #( req[ name = 'json' ]-value optional ) .
salesorder = salesorderno .

SELECT SINGLE * FROM I_SalesDocumentItem WITH PRIVILEGED ACCESS WHERE SalesDocument = @salesorder AND Plant = @plant
INTO @data(check).
if check is NOT INITIAL .
data(pdf2) = yso_dom_print_class=>read_posts( plant = plant salesorderno = salesorderno ) .
else .
pdf2 = 'Error Please Check Plant'.
ENDIF.

  endmethod.
ENDCLASS.
