CLASS lhc_zfreghtcharges_pr1 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zfreghtcharges_pr1 RESULT result.

ENDCLASS.

CLASS lhc_zfreghtcharges_pr1 IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

ENDCLASS.
