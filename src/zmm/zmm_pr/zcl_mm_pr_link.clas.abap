class ZCL_MM_PR_LINK definition

  public
  create public .
  public section.
INTERFACES if_oo_adt_classrun .
interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_MM_PR_LINK IMPLEMENTATION.


 method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.
   DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).
*    response->set_status( i_reason = 'SUSCESSFULL'  i_code = 2 ).

DATA matdoc TYPE string.
DATA year TYPE string.


matdoc = value #( req[ name = 'martdoc' ]-value optional ) .
year = value #( req[ name = 'year' ]-value optional ) .

DATA(pdf1) = zmm_pr=>read_posts( martdoc = matdoc year = year ).
   response->set_text( pdf1 ).
  endmethod.


 METHOD if_oo_adt_classrun~main.
*DATA(pdf1) = zmm_pr=>read_posts( martdoc = ' ' year = year ).

  ENDMETHOD.
ENDCLASS.
