CLASS lhc_zdnm_alias DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zdnm_alias RESULT result.

    METHODS zdeter_m FOR DETERMINE ON SAVE
      IMPORTING keys FOR zdnm_alias~zdeter_m.

ENDCLASS.

CLASS lhc_zdnm_alias IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD zdeter_m.
  ENDMETHOD.

ENDCLASS.
