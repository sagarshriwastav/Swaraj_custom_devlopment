class ZCL_MM_YFACTORY_BEAM_PRINT_HTT definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_MM_YFACTORY_BEAM_PRINT_HTT IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.
  DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).

    DATA(CUSTOMER) = VALUE #( req[ name = 'customer' ]-value OPTIONAL ) .
    DATA(datefrom) = VALUE #( req[ name = 'postingfrom' ]-value OPTIONAL ) .
    DATA(dateto) = VALUE #( req[ name = 'postingto' ]-value OPTIONAL ) .
    DATA(PLANT) = VALUE #( req[ name = 'plant' ]-value OPTIONAL ) .



    data(pdf2) = zcl_mm_yfactory_beam_print=>read_posts( CUSTOMER = CUSTOMER datefrom = datefrom dateto = dateto PLANT = PLANT ) .


      response->set_text( pdf2 ).

  endmethod.
ENDCLASS.
