CLASS zdenim_packing_report DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES:
      if_oo_adt_classrun.
    CLASS-METHODS: fault.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZDENIM_PACKING_REPORT IMPLEMENTATION.


  METHOD fault.

*   SELECT * FROM ZPACKHDR_DDM AS A
*
*        LEFT OUTER JOIN ZDNMFAULT_DDN AS B ON  ( B~Charg = A~Batch ) INTO TABLE @DATA(VALUE).
    SELECT COUNT( count1 )
     FROM ydenim_packing WHERE matnr = 'FFO00090904'
     AND werks = '1200'
     AND charg = 'AN1'
     INTO @DATA(lv_fault).
    WAIT UP TO 1 SECONDS.
  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.
    me->fault( ).
  ENDMETHOD.
ENDCLASS.
