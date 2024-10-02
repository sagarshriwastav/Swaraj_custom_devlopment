class ZCL_CL_SD_PERFORMA_HANDLER_CLA definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_CL_SD_PERFORMA_HANDLER_CLA IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

  DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).

    DATA JSON TYPE STRING .
DATA plant type string.
DATA performadocument type string.

plant = value #( req[ name = 'plant' ]-value optional ) .
PERFORMADOCUMENT =  value #( req[ name = 'salesdocument' ]-value optional ) .


data(pdf2) = zsd_performa_invoice_adobe=>read_posts( plant = plant performadocument = performadocument ) .


 response->set_text( pdf2  ).



  endmethod.
ENDCLASS.
