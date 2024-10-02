class ZCL_PNO_HTT definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_PNO_HTT IMPLEMENTATION.


method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.
 DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).





DATA nrrangenr TYPE char2.

nrrangenr = value #( req[ name = 'numc' ]-value optional ) .

*nrrangenr = ' ' .

  DATA: nr_number     TYPE cl_numberrange_runtime=>nr_number.
  DATA: nr_Object     TYPE cl_numberrange_runtime=>nr_object .





    TRY.
        CALL METHOD cl_numberrange_runtime=>number_get
          EXPORTING
            nr_range_nr =  nrrangenr
            object      = 'ZPNO'
*            'ZBATCH_NR'
            quantity    = 0000000001
          IMPORTING
            number      = nr_number.

      CATCH cx_nr_object_not_found.
      CATCH cx_number_ranges.
    ENDTRY.
    SHIFT nr_number LEFT DELETING LEADING '0'.
    DATA: lv_nr TYPE znumc_10 .
    lv_nr = |{ nr_number ALPHA = IN }|.

data nrng_num  type string .

 nrng_num  = lv_nr .
response->set_text( nrng_num  ).





endmethod.
ENDCLASS.
