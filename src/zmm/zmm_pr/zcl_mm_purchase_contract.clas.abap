class ZCL_MM_PURCHASE_CONTRACT definition
  public
  create public .

public section.
  INTERFACES if_oo_adt_classrun .
  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_MM_PURCHASE_CONTRACT IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.
    DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).
*    response->set_status( i_reason = 'SUSCESSFULL'  i_code = 2 ).
    DATA plant TYPE string.
    DATA contract TYPE string.

 plant = value #( req[ name = 'plant' ]-value optional ) .
 contract = value #( req[ name = 'contract' ]-value optional ) .

 DATA(pdf1) = zmm_purchase_contract_print=>read_posts( plant = plant contract = contract ) .

   response->set_text( pdf1 ).


  endmethod.
ENDCLASS.
