CLASS zcl_http_checkprint DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_HTTP_CHECKPRINT IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.

    DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).
data(cookies)  = request->get_cookies(  ) .
*data(cache)  = request->get_cookies(  ) .

    DATA(checknumber)  = VALUE #( req[ name = 'checkfrom' ]-value OPTIONAL ) .
    DATA(checknumber2)  = VALUE #( req[ name = 'checkto' ]-value OPTIONAL ) .
    DATA(housebank)    = VALUE #( req[ name = 'housebank' ]-value OPTIONAL ) .
    DATA(accountpayee) = VALUE #( req[ name = 'accountpayee' ]-value OPTIONAL ) .
    DATA(self) = VALUE #( req[ name = 'self' ]-value OPTIONAL ) .
    DATA(RTGS) = VALUE #( req[ name = 'rtgs' ]-value OPTIONAL ).
    DATA(chekbackside) = VALUE #( req[ name = 'chekbackside' ]-value OPTIONAL ).


*IRNGENRATE = value #( req[ name = 'irn' ]-value optional ) .
*Eway_generate = value #( req[ name = 'eway' ]-value optional ) .
*Form_generate = value #( req[ name = 'form' ]-value optional ) .
*Transpoter_name = value #( req[ name = 'transporter' ]-value optional ) .
*DISTANCE = value #( req[ name = 'distance' ]-value optional ) .
*Eway_Cancellation = value #( req[ name = 'caneway' ]-value optional ) .






    DATA(pdf1)   = yclass_cheque_print=>read_posts( variable  = checknumber variable2 = checknumber2  housebank = housebank accountpayee = accountpayee
                  rtgs = RTGS chekbackside = chekbackside self = self )  .
    response->set_text( pdf1 ).






  ENDMETHOD.
ENDCLASS.
