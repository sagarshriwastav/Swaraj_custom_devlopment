class ZCL_DNM_SET_NO_HTTP definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_DNM_SET_NO_HTTP IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.


   DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).
*    response->set_status( i_reason = 'SUSCESSFULL'  i_code = 2 ).


*DATA(REPOS)  = request->get_text(  ).
    DATA nrrangenr TYPE CHAR2.
    DATA nrrangenr2 TYPE char8.
    DATA YEAR    TYPE NUMC4.
        YEAR = SY-DATUM+0(4).
        nrrangenr2 = req[ 2 ]-NAME.

     nrrangenr = req[ 2 ]-value.
     IF nrrangenr2+0(1)  =  's'  .

    DATA: nr_number     TYPE cl_numberrange_runtime=>nr_number.
    TRY.
        CALL METHOD cl_numberrange_runtime=>number_get
          EXPORTING
            nr_range_nr = nrrangenr "'01'
            object      = 'ZSET_NO'
             toyear     =  YEAR
*            quantity    = 0000000001
          IMPORTING
            number      = nr_number.


      CATCH cx_nr_object_not_found.
      CATCH cx_number_ranges.
    ENDTRY.
    SHIFT nr_number LEFT DELETING LEADING '0'.
    DATA: lv_nr TYPE yde_numc10.
    lv_nr = |{ nr_number ALPHA = OUT }|.
*  * lv_nr = NR_NUMBER.
    response->set_text( |{ lv_nr }| ).

    ENDIF.


  endmethod.
ENDCLASS.
