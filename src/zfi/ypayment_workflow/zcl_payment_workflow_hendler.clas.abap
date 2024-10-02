class ZCL_PAYMENT_WORKFLOW_HENDLER definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_PAYMENT_WORKFLOW_HENDLER IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

  DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).
    DATA nrrangenr TYPE char2.

    DATA: nr_number     TYPE cl_numberrange_runtime=>nr_number.
    TRY.
        CALL METHOD cl_numberrange_runtime=>number_get
          EXPORTING
            nr_range_nr =  '01'
            object      = 'YTOKEN_NO'
            quantity    = 0000000001
          IMPORTING
            number      = nr_number.

      CATCH cx_nr_object_not_found.
      CATCH cx_number_ranges.
    ENDTRY.
    SHIFT nr_number LEFT DELETING LEADING '0'.
    DATA: lv_nr TYPE yde_numc10.
    lv_nr = |{ nr_number ALPHA = IN }|.
    response->set_text( |{ lv_nr }| ).


  endmethod.
ENDCLASS.
