class ZCL_FI_LEDGER_PRINT_HTTP definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_FI_LEDGER_PRINT_HTTP IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

    DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).

    DATA(companycode) = VALUE #( req[ name = 'companycode' ]-value OPTIONAL ) .
    DATA(datefrom) = VALUE #( req[ name = 'datefrom' ]-value OPTIONAL ) .
    DATA(dateto) = VALUE #( req[ name = 'dateto' ]-value OPTIONAL ) .
    DATA(glcodefrom) = VALUE #( req[ name = 'glcodefrom' ]-value OPTIONAL ) .



    data(pdf2) = zfi_ledger_print_class=>read_posts( companycode = companycode datefrom = datefrom dateto = dateto glcodefrom = glcodefrom ) .


      response->set_text( pdf2 ).

  endmethod.
ENDCLASS.
