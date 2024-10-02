CLASS zpp_alphabet_tab_update_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  INTERFACES IF_OO_ADT_CLASSRUN .
 CLASS-METHODS UPLOADDATA .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZPP_ALPHABET_TAB_UPDATE_CLASS IMPLEMENTATION.


METHOD if_oo_adt_classrun~main .
  ME->uploaddata(  ) .
  ENDMETHOD.


 METHOD UPLOADDATA .

 DELETE FROM zpp_alphabet_ta1 .
  DATA : LTTABLE TYPE TABLE OF zpp_alphabet_ta1.
         LTTABLE = VALUE #(
                     ( sno = '1'  alphabet = 'A'  alphabet1 = 'A'  alphabet2 = 'B' )
                     ( sno = '2'  alphabet = 'B' alphabet1 = 'C'  alphabet2 = 'D'  )
                     ( sno = '3'  alphabet = 'C'  alphabet1 = 'E'  alphabet2 = 'F' )
                     ( sno = '4'  alphabet = 'D'  alphabet1 = 'G'  alphabet2 = 'H' )
                     ( sno = '5'  alphabet = 'E' alphabet1 = 'I'  alphabet2 = 'J' )
                     ( sno = '6'  alphabet = 'F' alphabet1 = 'K'  alphabet2 = 'L' )
                     ( sno = '7'  alphabet = 'G' alphabet1 = 'M' alphabet2 = 'N' )
                     ( sno = '8'  alphabet = 'H' alphabet1 = 'O' alphabet2 = 'P' )
                     ( sno = '9'  alphabet = 'I' alphabet1 = 'Q' alphabet2 = 'R' )
                     ( sno = '10'  alphabet = 'J' alphabet1 = 'S' alphabet2 = 'T' )
                     ( sno = '11'  alphabet = 'K' alphabet1 = 'U' alphabet2 = 'V' )
                     ( sno = '12'  alphabet = 'L' alphabet1 = 'W' alphabet2 = 'X' )
                     ( sno = '13'  alphabet = 'M' alphabet1 = 'Y' alphabet2 = 'Z' )
                     ( sno = '14'  alphabet = 'N' )
                     ( sno = '15'  alphabet = 'O' )
                     ( sno = '16'  alphabet = 'P' )
                     ( sno = '17'  alphabet = 'Q' )
                     ( sno = '18'  alphabet = 'R' )
                     ( sno = '19'  alphabet = 'S' )
                     ( sno = '20'  alphabet = 'T' )
                     ( sno = '21'  alphabet = 'U' )
                     ( sno = '22'  alphabet = 'V' )
                     ( sno = '23'  alphabet = 'W' )
                     ( sno = '24'  alphabet = 'X' )
                     ( sno = '25'  alphabet = 'Y' )
                     ( sno = '26'  alphabet = 'Z' )
                     ( sno = '27'  alphabet = 'AA' )
                     ( sno = '28'  alphabet = 'AB' )
                     ( sno = '29'  alphabet = 'AC' )
                     ( sno = '30'  alphabet = 'AD' )
                     ( sno = '31'  alphabet = 'AE' )
                     ( sno = '32'  alphabet = 'AF' )
                     ( sno = '33'  alphabet = 'AG' )
                     ( sno = '34'  alphabet = 'AH' )
                     ( sno = '35'  alphabet = 'AI' )
                     ( sno = '36'  alphabet = 'AJ' )
                     ( sno = '37'  alphabet = 'AK' )
                     ( sno = '38'  alphabet = 'AL' )
                     ( sno = '39'  alphabet = 'AM' )
                     ( sno = '40'  alphabet = 'AN' )
                     ( sno = '41'  alphabet = 'AO' )
                     ( sno = '42'  alphabet = 'AP' )
                     ( sno = '43'  alphabet = 'AQ' )
                     ( sno = '44'  alphabet = 'AR' )
                     ( sno = '45'  alphabet = 'AS' )
                     ( sno = '46'  alphabet = 'AT' )
                     ( sno = '47'  alphabet = 'AU' )
                     ( sno = '48'  alphabet = 'AV' )
                     ( sno = '49'  alphabet = 'AW' )
                     ( sno = '50'  alphabet = 'AX' )
                     ( sno = '51'  alphabet = 'AY' )
                     ( sno = '52'  alphabet = 'AZ' )


                          ).
         MODIFY zpp_alphabet_ta1 FROM TABLE @LTTABLE .
         COMMIT WORK AND WAIT .
ENDMETHOD.
ENDCLASS.
