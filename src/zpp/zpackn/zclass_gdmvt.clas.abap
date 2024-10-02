CLASS zclass_gdmvt DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .


  PUBLIC SECTION.
 CLASS-DATA  it_zpack type TABLE OF  zpackhdr_d .


   INTERFACES if_oo_adt_classrun .
class-METHODS  : material_document12
   IMPORTING it_packhdr type zpackhdr_d
   EXPORTING invoice       TYPE string
   RETURNING VALUE(result) TYPE string ,
 bapi_261

        RETURNING VALUE(result1) TYPE string,

 bapi_cancel

        RETURNING VALUE(result1) TYPE string ,
   num_range
        IMPORTING num type char2
                  nobject type string
        RETURNING VALUE(result1) TYPE string

                  .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCLASS_GDMVT IMPLEMENTATION.


  METHOD BAPI_261.
  DATA(PLANT)  = '1200' .

      MODIFY ENTITIES OF i_materialdocumenttp
                ENTITY materialdocument
                CREATE FROM VALUE #( ( %cid                          = 'My%CID_2'
                                       goodsmovementcode             = '03'
                                       postingdate                   = sy-datum
                                       documentdate                  = sy-datum
                                       %control-goodsmovementcode                    = cl_abap_behv=>flag_changed
                                       %control-postingdate                          = cl_abap_behv=>flag_changed
                                       %control-documentdate                         = cl_abap_behv=>flag_changed
                                   ) )

                ENTITY materialdocument
                CREATE BY \_materialdocumentitem
                FROM VALUE #(   (
                                %cid_ref = 'My%CID_2'
                                %target = VALUE #(  ( %cid                           =  'My%CID_1_001'
                                                     plant                          = '1200'  ""any1-plant
                                                     material                       = 'SD000003'  ""any1-material               "'YGI1Z14N02009040'
                                                     goodsmovementtype              =  '261'
                                                     storagelocation                =  'ST01' ""any1-sloc  "'YG01'
                                                     batch                          =  '0000000010'  ""any1-batch
                                                     quantityinentryunit            =  '1' ""any1-Quantity
                                                     entryunit                      =  'KG' ""any1-uom
                                                     manufacturingorder             =  '000001000011'
                                                     goodsmovementrefdoctype        =  ' '
                                                     SalesOrder =  ' '
                                                     SalesOrderItem =  ' '
                                                     SpecialStockIdfgSalesOrder =  ' '
                                                     SpecialStockIdfgSalesOrderItem  =  ' '
**                                                     iscompletelydelivered          = ''
**                                                     materialdocumentitemtext       = ''
                                                     %control-plant                 = cl_abap_behv=>flag_changed
                                                     %control-material              = cl_abap_behv=>flag_changed
                                                     %control-goodsmovementtype    = cl_abap_behv=>flag_changed
                                                     %control-storagelocation       = cl_abap_behv=>flag_changed
                                                     %control-quantityinentryunit  = cl_abap_behv=>flag_changed
                                                     %control-entryunit             = cl_abap_behv=>flag_changed
                                                 )     )


                            ) )
               MAPPED   DATA(ls_create_mapped2)
                FAILED   DATA(ls_create_failed2)
                REPORTED DATA(ls_create_reported2).




    COMMIT ENTITIES BEGIN
     RESPONSE OF i_materialdocumenttp
     FAILED DATA(commit_failed2)
     REPORTED DATA(commit_reported2).



LOOP AT ls_create_mapped2-materialdocument ASSIGNING FIELD-SYMBOL(<keys_header1>).

  CONVERT KEY OF i_materialdocumentTp
  FROM <keys_header1>-%pid
  TO <keys_header1>-%key .
ENDLOOP.


LOOP AT ls_create_mapped2-materialdocumentitem ASSIGNING FIELD-SYMBOL(<keys_item1>).
*
  CONVERT KEY OF i_materialdocumentitemtp
  FROM <keys_item1>-%pid
  TO <keys_item1>-%key.
ENDLOOP.


COMMIT ENTITIES END.

  ENDMETHOD.


  METHOD BAPI_CANCEL.


*Declare derived type for authorization request
DATA: request_ga TYPE STRUCTURE FOR PERMISSIONS REQUEST  i_materialdocumenttp\\MaterialDocument .

*Activate check for create operation
request_ga-%delete = if_abap_behv=>mk-on.

*Perform authorization request
GET PERMISSIONS ONLY GLOBAL AUTHORIZATION ENTITY  i_materialdocumenttp\\MaterialDocument
  REQUEST request_ga
RESULT DATA(result)
FAILED DATA(failed)
REPORTED DATA(reported).






DATA: lt_cancel_header TYPE TABLE FOR ACTION IMPORT i_materialdocumenttp\\MaterialDocument~Cancel.

lt_cancel_header = VALUE #( ( %key-MaterialDocument = '4900000153' %key-MaterialDocumentYear = '2023' ) ).
MODIFY ENTITY i_materialdocumenttp\\MaterialDocument
 EXECUTE Cancel FROM lt_cancel_header
RESULT DATA(result3)
MAPPED DATA(mapped3)
FAILED DATA(failed3)
REPORTED DATA(reported3).


COMMIT ENTITIES.

  ENDMETHOD.


METHOD if_oo_adt_classrun~main.


  data(return) =  bapi_cancel(  ) .

 out->write( return  ) .

ENDMETHOD.


method material_document12 .



 MODIFY ENTITIES OF i_materialdocumenttp
             ENTITY MaterialDocument
             CREATE FROM VALUE #( ( %cid                          = 'My%CID_1'
                                    goodsmovementcode             = '04'
                                    postingdate                   = '20230518'
                                    documentdate                  = '20230518'
                                    %control-goodsmovementcode                    = cl_abap_behv=>flag_changed
                                    %control-postingdate                          = cl_abap_behv=>flag_changed
                                    %control-documentdate                         = cl_abap_behv=>flag_changed
                                ) )

*FF001
*FF001A  1.  FN01  2 . FG01

             ENTITY MaterialDocument
             CREATE BY \_MaterialDocumentItem
             FROM VALUE #( (
                             %cid_ref = 'My%CID_1'
                             %target = VALUE #( ( %cid                           = 'My%CID_1_001'
                                                  plant                          = '1200'
                                                  material                       = 'FFO00090904'
                                                  GoodsMovementType              = '311'
                                                  storagelocation                = 'FN01'
                                                  QuantityInEntryUnit            =  1
                                                  entryunit                      = 'M'
                                                  Batch                          = 'FF001'
                                                  IssuingOrReceivingPlant        = '1200'
                                                  IssuingOrReceivingStorageLoc   = 'FG01'
                                                  IssgOrRcvgBatch                = 'FF001A'
                                                  IssgOrRcvgSpclStockInd         = ''
*                                                  ManufacturingOrder             = '000001000057'
*                                                  GoodsMovementRefDocType        = 'F'
*                                                  IsCompletelyDelivered          = ' '
                                                  MaterialDocumentItemText       = 'Testing'
                                                  %control-plant                 = cl_abap_behv=>flag_changed
                                                  %control-material              = cl_abap_behv=>flag_changed
                                                  %control-GoodsMovementType    = cl_abap_behv=>flag_changed
                                                  %control-storagelocation       = cl_abap_behv=>flag_changed
                                                  %control-QuantityInEntryUnit  = cl_abap_behv=>flag_changed
                                                  %control-entryunit             = cl_abap_behv=>flag_changed
                                              ) )


                         ) )
             MAPPED   DATA(ls_create_mapped)
             FAILED   DATA(ls_create_failed)
             REPORTED DATA(ls_create_reported).

  COMMIT ENTITIES BEGIN
   RESPONSE OF i_materialdocumenttp
   FAILED DATA(commit_failed)
   REPORTED DATA(commit_reported).

*
LOOP AT ls_create_mapped-materialdocument ASSIGNING FIELD-SYMBOL(<keys_header>).

  CONVERT KEY OF i_materialdocumentTp
  FROM <keys_header>-%pid
  TO <keys_header>-%key .
ENDLOOP.


LOOP AT ls_create_mapped-materialdocumentitem ASSIGNING FIELD-SYMBOL(<keys_item>).
*
  CONVERT KEY OF i_materialdocumentitemtp
  FROM <keys_item>-%pid
  TO <keys_item>-%key.
ENDLOOP.

COMMIT ENTITIES END.



endmethod .


  METHOD NUM_RANGE.

data(object1)  = nobject  .
DATA nrrangenr TYPE char2.

nrrangenr = num  .

  DATA: nr_number     TYPE cl_numberrange_runtime=>nr_number.
  DATA: nr_Object     TYPE cl_numberrange_runtime=>nr_object .

nr_Object  = nobject .

    TRY.
        CALL METHOD cl_numberrange_runtime=>number_get
          EXPORTING
            nr_range_nr = num
            object      = nr_Object
*            'ZBATCH_NR'
            quantity    = 0000000001
          IMPORTING
            number      = nr_number.

      CATCH cx_nr_object_not_found.
      CATCH cx_number_ranges.
    ENDTRY.
    SHIFT nr_number LEFT DELETING LEADING '0'.
   DATA: lv_nr TYPE znum9 .
    lv_nr = |{ nr_number ALPHA = IN }|.


result1 = lv_nr .


  ENDMETHOD.
ENDCLASS.
