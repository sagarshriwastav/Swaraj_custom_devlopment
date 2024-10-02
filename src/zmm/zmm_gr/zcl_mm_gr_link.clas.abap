class ZCL_MM_GR_LINK definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_MM_GR_LINK IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.
   DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).
*    response->set_status( i_reason = 'SUSCESSFULL'  i_code = 2 ).

    DATA matdoc TYPE string.
    DATA year TYPE string.

matdoc = value #( req[ name = 'matdoc' ]-value optional ) .
year = value #( req[ name = 'year' ]-value optional ) .


 DATA(pdf1) = zmm_gr_print1=>read_posts( matdoc = matdoc year = year )  .
*
   response->set_text( pdf1 ).



  endmethod.
ENDCLASS.
