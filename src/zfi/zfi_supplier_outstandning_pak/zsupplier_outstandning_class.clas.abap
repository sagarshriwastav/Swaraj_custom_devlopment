CLASS zsupplier_outstandning_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
   INTERFACES IF_OO_ADT_CLASSRUN .
 CLASS-METHODS UPLOADDATA .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zsupplier_outstandning_class IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main .
  ME->uploaddata(  ) .
  ENDMETHOD.


 METHOD UPLOADDATA .
  DATA : LTTABLE TYPE TABLE OF zsupplier_tab.
         LTTABLE = VALUE #(
         ( status2 =  'Open Items'          reportname = 'Supplier Outstanding Report' dummy = '1'  )
         ( status2 =  'Cleared Items'       reportname = 'Supplier Outstanding Report' dummy = '2'  )
         ( status2 =  'All Items'           reportname = 'Supplier Outstanding Report' dummy = '3'  )
*
         ).

*  SELECT * FROM yreport_f4_table INTO TABLE @DATA(DEL) .
*         DELETE yreport_f4_table FROM TABLE @DEL .

         MODIFY zsupplier_tab FROM TABLE @LTTABLE .
         COMMIT WORK AND WAIT .

 ENDMETHOD.
ENDCLASS.
