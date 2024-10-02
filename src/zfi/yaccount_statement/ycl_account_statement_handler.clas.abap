CLASS ycl_account_statement_handler DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS YCL_ACCOUNT_STATEMENT_HANDLER IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.
    DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).


DATA profitcenter TYPE C LENGTH 10 .

    DATA(accounttype) = VALUE #( req[ name = 'accounttype' ]-value OPTIONAL ) .
    DATA(lastdate) = VALUE #( req[ name = 'lastdate' ]-value OPTIONAL ) .
    DATA(currentdate) = VALUE #( req[ name = 'currentdate' ]-value OPTIONAL ) .
    DATA(correspondence) = VALUE #( req[ name = 'correspondence' ]-value OPTIONAL ) .
    DATA(companycode) = VALUE #( req[ name = 'companycode' ]-value OPTIONAL ) .
    DATA(customer) = VALUE #( req[ name = 'customer' ]-value OPTIONAL ) .
    DATA(profitcenter1) = VALUE #( req[ name = 'profitcenter' ]-value OPTIONAL ) .
    DATA(confirmletterbox) = VALUE #( req[ name = 'confirmletterbox' ]-value OPTIONAL ) .

    profitcenter = |{ profitcenter1 ALPHA = IN }| .

 IF  AccountType = 'K' .   """""SUPPLIER""""""""""""""""""""""""""""""""""""""""""

    DATA(pdf2) = yaccount_statement_vendor_cl=>read_posts( companycode = companyCode  correspondence = correspondence
    accounttype = accounttype customer = customer lastdate = lastdate currentdate  = currentdate
    profitcenter = profitcenter confirmletterbox = confirmletterbox  ) .

 ELSEIF AccountType = 'D' . """"""CUSTOMER"""""""""""""""""""""""""""""""""""""""
"   ycl_account_statement_customer
    pdf2 = yaccount_statement_customer_cl=>read_posts( companycode = companyCode  correspondence = correspondence
    accounttype = accounttype customer = customer lastdate = lastdate currentdate  = currentdate
    profitcenter = profitcenter   confirmletterbox = confirmletterbox  ) .

 ENDIF.
    response->set_text( pdf2  ).

  ENDMETHOD.
ENDCLASS.
