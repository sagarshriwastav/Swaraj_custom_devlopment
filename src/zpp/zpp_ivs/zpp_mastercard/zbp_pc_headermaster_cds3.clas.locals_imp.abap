CLASS lhc_zpc_headermaster_alcds DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zpc_headermaster_alcds RESULT result.

    METHODS zdeter_m FOR DETERMINE ON SAVE
      IMPORTING keys FOR zpc_headermaster_alcds~zdeter_m.

ENDCLASS.

CLASS lhc_zpc_headermaster_alcds IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD zdeter_m.
  ENDMETHOD.

ENDCLASS.
