CLASS lhc_ygateitm_cds DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR ygateitm_cds RESULT result.

ENDCLASS.

CLASS lhc_ygateitm_cds IMPLEMENTATION.

  METHOD get_global_authorizations.
  if 1 = 2 .
  ENDIF.
  ENDMETHOD.

ENDCLASS.
