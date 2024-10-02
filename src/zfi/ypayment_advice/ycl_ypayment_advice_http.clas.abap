CLASS ycl_ypayment_advice_http DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS YCL_YPAYMENT_ADVICE_HTTP IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.
    DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).

    DATA(fromdate) = VALUE #( req[ name = 'fromdate' ]-value OPTIONAL ) .
   DATA(checkbox) = VALUE #( req[ name = 'checkbox' ]-value OPTIONAL ) .
    DATA(todate) = VALUE #( req[ name = 'todate' ]-value OPTIONAL ) .
    DATA(vendor) = VALUE #( req[ name = 'vendor' ]-value OPTIONAL ) .
    DATA(document) = VALUE #( req[ name = 'document' ]-value OPTIONAL ) .
    DATA(comcode) = VALUE #( req[ name = 'comcode' ]-value OPTIONAL ) .
    DATA(remark) = VALUE #( req[ name = 'remark' ]-value OPTIONAL ) .
    DATA(clearingdocument) = VALUE #( req[ name = 'clearingdocument' ]-value OPTIONAL ) .

*    todate = |{ todate+0(4) }{ todate+6(2) }{ todate+4(2) }|   .
*    fromdate = |{ fromdate+0(4) }{ fromdate+6(2) }{ fromdate+4(2) }|   .
   IF clearingdocument IS NOT INITIAL .

    DATA(pdf2) = zgs_payment_advice=>read_posts( fromdate = fromdate  todate = todate vendor = vendor document = document comcode = comcode clearingdocument  = clearingdocument remark = remark ) .


    ELSE .

     pdf2 = ypayment_advice=>read_posts( fromdate = fromdate  todate = todate vendor = vendor document = document
                                           comcode = comcode clearingdocument  = clearingdocument remark = remark ) .
    ENDIF.
     response->set_text( pdf2  ).

  ENDMETHOD.
ENDCLASS.
