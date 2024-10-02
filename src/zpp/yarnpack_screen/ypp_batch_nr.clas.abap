CLASS ypp_batch_nr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
    CLASS-DATA: numc10 TYPE c LENGTH 10.
    CLASS-METHODS:
      create_nr,
      use_nr
        RETURNING VALUE(lv_nr) LIKE numc10.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS YPP_BATCH_NR IMPLEMENTATION.


  METHOD create_nr.
    DATA : lv_norange  TYPE REF TO cl_numberrange_objects,
           lv_interval TYPE REF TO cl_numberrange_intervals,
           lv_runtime  TYPE REF TO cl_numberrange_runtime.

    DATA : nr_attribute  TYPE cl_numberrange_objects=>nr_attribute,
           obj_text      TYPE cl_numberrange_objects=>nr_obj_text,
           lv_returncode TYPE cl_numberrange_objects=>nr_returncode,
           lv_errors     TYPE cl_numberrange_objects=>nr_errors,
           nr_interval   TYPE cl_numberrange_intervals=>nr_interval,
           st_interval   LIKE LINE OF nr_interval,
           nr_number     TYPE cl_numberrange_runtime=>nr_number,
           nr_interval1  TYPE cl_numberrange_runtime=>nr_interval,
           error         TYPE cl_numberrange_intervals=>nr_error,
           error_inf     TYPE cl_numberrange_intervals=>nr_error_inf,
           error_iv      TYPE cl_numberrange_intervals=>nr_error_iv,
           warning       TYPE cl_numberrange_intervals=>nr_warning.

    nr_attribute-buffer = 'X'.
    nr_attribute-object = 'ZPP_BATCH'.
    nr_attribute-domlen = 'ZCHAR10'.
    nr_attribute-percentage = 10.
    nr_attribute-devclass = 'ZHARSHIT'.
    obj_text-langu = 'E'.
    obj_text-object = 'ZPP_BATCH'.
    obj_text-txt = 'PP Batch Number Range'.
    obj_text-txtshort = 'PP Batch NR'.

    st_interval-subobject = ''.
    st_interval-nrrangenr = '01'.
* st_INTERVAL-toyear
    st_interval-fromnumber  = '1000000000'.
    st_interval-tonumber    = '9999999999'.
    st_interval-procind     = 'I'.
    APPEND st_interval TO nr_interval.


    TRY.
        cl_numberrange_objects=>create(
        EXPORTING
            attributes                = nr_attribute
            obj_text                  = obj_text
        IMPORTING
            errors = lv_errors
            returncode = lv_returncode )
           .
      CATCH cx_number_ranges INTO DATA(lx_number_range).
    ENDTRY.


    TRY.

        CALL METHOD cl_numberrange_intervals=>create
          EXPORTING
            interval  = nr_interval
            object    = nr_attribute-object
            subobject = ''
          IMPORTING
            error     = error
            error_inf = error_inf
            error_iv  = error_iv.
      CATCH  cx_nr_object_not_found INTO DATA(lx_no_obj_found).
      CATCH cx_number_ranges INTO DATA(cx_number_ranges).

    ENDTRY.
  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.
*    me->create_nr(  ).
    DATA(nr) = me->use_nr( ).
    out->write( nr ).
  ENDMETHOD.


  METHOD use_nr.
    DATA: nr_number     TYPE cl_numberrange_runtime=>nr_number.
    TRY.
        CALL METHOD cl_numberrange_runtime=>number_get
          EXPORTING
            nr_range_nr = '01'
            object      = 'ZPP_BATCH'
            quantity    = 0000000001
          IMPORTING
            number      = nr_number.

      CATCH cx_nr_object_not_found.
      CATCH cx_number_ranges.
    ENDTRY.
    SHIFT nr_number LEFT DELETING LEADING '0'.
    lv_nr = |{ nr_number ALPHA = IN }|.

  ENDMETHOD.
ENDCLASS.
