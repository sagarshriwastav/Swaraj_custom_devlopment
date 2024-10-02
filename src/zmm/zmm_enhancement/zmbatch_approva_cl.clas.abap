CLASS zmbatch_approva_cl DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    interfaces if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZMBATCH_APPROVA_CL IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA WA TYPE zmbatch_approva .
    WA-batch = '1234567890'.
    WA-supplier = '1234567890'.
    WA-approved = 'YES'.
    MODIFY zmbatch_approva FROM @WA .

  ENDMETHOD.
ENDCLASS.
