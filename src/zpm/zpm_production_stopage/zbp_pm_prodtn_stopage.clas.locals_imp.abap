CLASS lhc_zpm_prodtn_stopage DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zpm_prodtn_stopage RESULT result.

      METHODS ZPRODSAVR FOR DETERMINE ON SAVE
      IMPORTING keys FOR zpm_prodtn_stopage~zprodsavr .

ENDCLASS.

CLASS lhc_zpm_prodtn_stopage IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

   METHOD ZPRODSAVR.
  ENDMETHOD.

ENDCLASS.
