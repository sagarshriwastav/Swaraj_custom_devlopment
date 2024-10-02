class ZCL_SD_JOB_SALES_ORDER_PRINT_H definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_SD_JOB_SALES_ORDER_PRINT_H IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

  DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).

DATA JSON TYPE STRING .
DATA plant type string.
DATA salesorderno type string.

salesorderno = value #( req[ name = 'salesorder' ]-value optional ) .



data(pdf2) = zsd_job_sales_ord_print_class=>read_posts(  salesorderno = salesorderno ) .

response->set_text( pdf2  ).

  endmethod.
ENDCLASS.
