
CLASS zclass_measuring DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .


  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
    TYPES:
      BEGIN OF ty_md,
        BEGIN OF structure,
          key         TYPE STRUCTURE FOR KEY OF i_measurementdocumenttp_2,
          read_import TYPE STRUCTURE FOR READ IMPORT i_measurementdocumenttp_2,
        END OF structure,
      END OF ty_md,
      tt_ypmeasuring TYPE  ypmeasuring.
    TYPES:
ty_reported_early TYPE RESPONSE FOR REPORTED EARLY i_measurementdocumenttp_2 .
    TYPES:
      ty_reported_late  TYPE RESPONSE FOR REPORTED LATE  i_measurementdocumenttp_2 .

    CLASS-METHODS  material_document12

      IMPORTING it_measuring  TYPE tt_ypmeasuring
      EXPORTING invoice       TYPE string
      RETURNING VALUE(result) TYPE string.
    CLASS-METHODS concatenate_message
      IMPORTING
        !is_reported_early TYPE ty_reported_early OPTIONAL
        !is_reported_late  TYPE ty_reported_late OPTIONAL
      CHANGING
        !cv_message        TYPE string .
    CLASS-METHODS concatenate_reported_message
      IMPORTING
        !it_reported TYPE ANY TABLE
      CHANGING
        !cv_message  TYPE string .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCLASS_MEASURING IMPLEMENTATION.


  METHOD concatenate_message.

    concatenate_reported_message(
      EXPORTING
        it_reported = is_reported_early-measurementdocument
      CHANGING
        cv_message  = cv_message ).

    concatenate_reported_message(
      EXPORTING
        it_reported = is_reported_late-measurementdocument
      CHANGING
        cv_message  = cv_message ).
  ENDMETHOD.


  METHOD concatenate_reported_message.
    FIELD-SYMBOLS:
      <lo_message> TYPE REF TO if_abap_behv_message.
    DATA : lv_severity TYPE string,
           lv_text     TYPE string.

  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.






  ENDMETHOD.


  METHOD material_document12 .
    DATA mv_measurementdocument TYPE ty_md-structure-read_import-%key-measurementdocument VALUE 'Text'.

    data number type znumc6 .
*************************************************************************************************************
******************************************         **********************************************************
*************************************************************************************************************
*************************************************************************************************************

    LOOP AT it_measuring-atableitem ASSIGNING FIELD-SYMBOL(<fs>)   .
    if <fs>-measpoint is not INITIAL .

      DATA(date)  = |{ <fs>-date+6(4) }{ <fs>-date+3(2) }{ <fs>-date+0(2) }| .
      DATA(time)  = |{ <fs>-time+0(2) }{ <fs>-date+3(2) }{ <fs>-date+6(2) }| .
      data unit  type string  .
      unit  = <fs>-unit .
TRANSLATE unit TO UPPER CASE .
CONDENSE unit .

      MODIFY ENTITIES OF i_measurementdocumenttp_2
            ENTITY measurementdocument
             CREATE
               FIELDS ( measuringpoint
*                        measurementreading
                        measurementreadingentryuom
*                        MeasurementCounterReading
*                        MsmtCounterReadingDifference
                        MeasurementReading
                       msmtrdngdate

                       msmtrdngtime  )
                WITH VALUE #( ( %cid     = 'My%CID_1'
                                %data    = VALUE #( measuringpoint = <fs>-measpoint
*                                                    measurementreading = <fs>-countrdg
*                                                     MsmtCounterReadingDifference = <fs>-measrdg
                                                     MeasurementReading = <fs>-measrdg
                                                    measurementreadingentryuom = unit
                                                    msmtrdngdate  = date
                                                    msmtrdngtime  = time
*                                                MsmtRdngDate  = date




*                                                                                                 measurementdocumenttext = '11'
*                                                  measurementdocumenthaslongtext = abap_true

                                                     ) ) )
             CREATE BY \_measurementdocumentlongtext
                FROM VALUE #( ( %cid_ref   = 'My%CID_1'
                                %target    = VALUE #( ( %cid = 'My%CID_2'
                                                        measurementdocumentlongtext = 'Long text' ) ) ) )
            MAPPED   DATA(ls_mapped)
            FAILED   DATA(ls_failed)
            REPORTED DATA(ls_reported_modify).

      COMMIT ENTITIES BEGIN
        RESPONSE OF i_measurementdocumenttp_2
        FAILED   DATA(ls_save_failed)
        REPORTED DATA(ls_save_reported).
      LOOP AT ls_mapped-measurementdocument ASSIGNING FIELD-SYMBOL(<mapped_early>).
        CONVERT KEY OF i_measurementdocumenttp_2 FROM <mapped_early>-measurementdocument TO DATA(ls_md_final_key).
      ENDLOOP.
      COMMIT ENTITIES END.

      READ ENTITIES OF i_measurementdocumenttp_2
         ENTITY measurementdocument
         ALL FIELDS WITH
           VALUE #( ( measurementdocument = ls_md_final_key ) )"mv_measurementdocument ) )
           RESULT DATA(lt_md)
           REPORTED DATA(ls_reported)
           FAILED ls_failed.

      CLEAR ls_failed.
      CLEAR ls_reported.

      MODIFY ENTITIES OF i_measurementdocumenttp_2
        ENTITY measurementdocument
          UPDATE
           FIELDS ( msmtrdngstatus
                    measurementdocumenttext )
           WITH VALUE #( ( %key-measurementdocument =  ls_md_final_key "mv_measurementdocument
                            msmtrdngstatus = '1'
                            measurementdocumenttext = <fs>-text1
                            msmtrdngdate = date ) )
        FAILED   ls_failed
        REPORTED ls_reported.

      concatenate_message( EXPORTING is_reported_early = ls_reported
                           CHANGING  cv_message        = result ).


      COMMIT ENTITIES BEGIN
        RESPONSE OF i_measurementdocumenttp_2
        FAILED   DATA(ls_failed_commit)
        REPORTED DATA(ls_reported_commit).
      COMMIT ENTITIES END.

      concatenate_message( EXPORTING is_reported_late = ls_reported_commit
                           CHANGING  cv_message       = result ).

      CLEAR ls_failed.
      CLEAR ls_reported.

      READ ENTITIES OF i_measurementdocumenttp_2
       ENTITY measurementdocument ALL FIELDS WITH
       VALUE #( ( measurementdocument = ls_md_final_key ) )"mv_measurementdocument ) )
       RESULT DATA(lt_updated_md)
       REPORTED ls_reported
       FAILED ls_failed.

*********************************************
********************************************
*******************************************
number = number + 1 .
clear : date ,time .
endif .


    ENDLOOP .

   result  =   number .

  ENDMETHOD .
ENDCLASS.
