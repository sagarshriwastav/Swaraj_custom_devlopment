class ZCL_AR_PRINT_FI_HENDLER_CLASS definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_AR_PRINT_FI_HENDLER_CLASS IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.
    DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).
*    response->set_status( i_reason = 'SUSCESSFULL'  i_code = 2 ).

 DATA profitcenter TYPE C LENGTH 10 .


   DATA(companycode) = VALUE #( req[ name = 'companycode' ]-value OPTIONAL ) .
    DATA(ReportType) = VALUE #( req[ name = 'radiobutton' ]-value OPTIONAL ) .
    DATA(customer) = VALUE #( req[ name = 'customer_agent' ]-value OPTIONAL ) .
    DATA(postingfrom) = VALUE #( req[ name = 'postingfrom' ]-value OPTIONAL ) .
    DATA(postingto) = VALUE #( req[ name = 'postingto' ]-value OPTIONAL ) .
    DATA(profitcenter1) = VALUE #( req[ name = 'profit' ]-value OPTIONAL ) .
    DATA(division) = VALUE #( req[ name = 'division' ]-value OPTIONAL ) .

    profitcenter = |{ profitcenter1 ALPHA = IN }| .

IF ReportType = 'Agent Wise' .

 DATA(pdf2) = zar_print_fi_agent_wise=>read_posts( companycode = companyCode
 customer = customer postingfrom = postingfrom postingto  = postingto  profitcenter = profitcenter ) .


ELSEIF ReportType = 'Customer Wise' .

 pdf2 = ycl_ar_print_fi_adobe=>read_posts( companycode = companyCode
 customer = customer postingfrom = postingfrom postingto  = postingto  profitcenter = profitcenter division = division  ) .

ENDIF.

   response->set_text( pdf2 ).

*ENDIF.
  endmethod.
ENDCLASS.
