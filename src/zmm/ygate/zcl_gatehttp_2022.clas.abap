class ZCL_GATEHTTP_2022 definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_GATEHTTP_2022 IMPLEMENTATION.


 method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.


   DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).
*    response->set_status( i_reason = 'SUSCESSFULL'  i_code = 2 ).


*DATA(REPOS)  = request->get_text(  ).
    DATA nrrangenr TYPE char2.
    DATA nrrangenr2 TYPE char8.


    nrrangenr2 = req[ 2 ]-NAME.

     nrrangenr = req[ 2 ]-value.
     IF nrrangenr2+0(1)  =  'n'  .

    DATA: nr_number     TYPE cl_numberrange_runtime=>nr_number.
    TRY.
        CALL METHOD cl_numberrange_runtime=>number_get
          EXPORTING
            nr_range_nr = nrrangenr "'01'
            object      = 'YGATNMBRNG'
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
elseif nrrangenr2+0(1)  =  'f'  .


*
 data(GAtepass) = req[ 2 ]-value.

 DATA(pdf1) = yprint_for_adobe=>read_posts( variable = GAtepass ).
*
   response->set_text( pdf1 ).




endif .

  endmethod.
ENDCLASS.
