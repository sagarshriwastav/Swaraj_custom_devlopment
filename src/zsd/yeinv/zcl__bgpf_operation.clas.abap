CLASS zcl__bgpf_operation DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_bgmc_op_single.
    INTERFACES if_oo_adt_classrun .

    METHODS constructor
      IMPORTING VALUE(iv_data) TYPE string OPTIONAL.

  PRIVATE SECTION.
    DATA mv_data TYPE string  .

    METHODS modify
      RAISING cx_bgmc_operation.

    METHODS save.

ENDCLASS.



CLASS ZCL__BGPF_OPERATION IMPLEMENTATION.


  METHOD constructor.
    mv_data = iv_data.
  ENDMETHOD.


  METHOD if_bgmc_op_single~execute.
    modify( ).

*        cl_abap_tx=>save( ).

    save( ).
  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.

save(  )  .


  ENDMETHOD.


  METHOD modify.
    WAIT UP TO 10 SECONDS.
    IF mv_data IS INITIAL.
*           RAISE EXCEPTION NEW cx_demo_bgpf( textid = cx_demo_bgpf=>initial_input ).
    ENDIF.

    CONDENSE mv_data.
  ENDMETHOD.


  METHOD save.

    " wait up to 10 seconds .
    CONDENSE mv_data.
if  mv_data   is not INITIAL  .


  TRY.
      zsd_pdf_mail=>read_data(  invoice =  mv_data invoice1  = mv_data  )  .
    CATCH cx_static_check.
      "handle exception
  ENDTRY.
*    SELECT SINGLE SchedulingAgreement
*      FROM I_SchedgagrmthdrApi01 WITH PRIVILEGED ACCESS
*      WHERE yy1_saguid_pdh = @mv_data
*        INTO  @DATA(tab1).
*elseif strlen( mv_data  ) Gt 8 .
*
*      SELECT SINGLE SchedulingAgreement FROM
*       I_SchedglineApi01 WITH PRIVILEGED ACCESS
*        WHERE SchedulingAgreement  = @mv_data
*       INTO  @tab1.
*
*  ENDIF.
*
*    IF tab1 IS NOT INITIAL.
*      zcl_po_create=>create_schudle_line_data( schedulelineagreement = tab1 ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
