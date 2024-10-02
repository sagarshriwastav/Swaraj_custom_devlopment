CLASS zdnm_behh DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZDNM_BEHH IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
   data: it_booking type table of zdnm_set.

          it_booking = value #(
      ( client = '350'  unit_field = 'ME' unit_field2 = 'KG' werks = '1200' zlength = '1000' )
      ).

insert zdnm_set from table @it_booking.

select * from zdnm_set into table @it_booking.
out->write( sy-dbcnt ).
out->write( 'Data inserted successfully' ).

  ENDMETHOD.
ENDCLASS.
