CLASS zcl_goodsmovement_311 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .


  PUBLIC SECTION.




   INTERFACES if_oo_adt_classrun .
class-METHODS  material_document12
IMPORTING it_packhdr type zpack_tabtype
   RETURNING VALUE(result) TYPE string  .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_GOODSMOVEMENT_311 IMPLEMENTATION.


METHOD if_oo_adt_classrun~main.


*  DATA(return_data) = material_document12(  ) .



ENDMETHOD.


method material_document12 .


read table it_packhdr into  data(zpack1) index 1 .



 MODIFY ENTITIES OF i_materialdocumenttp
             ENTITY MaterialDocument
             CREATE FROM VALUE #( ( %cid                          = 'My%CID_1'
                                    goodsmovementcode             = '04'
                                    postingdate                   =  zpack1-postingdate
                                    documentdate                  =  zpack1-postingdate
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
                             %target = VALUE #( FOR any IN it_packhdr index INTO i  ( %cid                           = |My%CID_{ i }_001|
                                                  plant                          = any-plant
                                                  material                       = any-materialnumber
                                                  GoodsMovementType              = '311'
                                                  storagelocation                = any-storagelocation
                                                  QuantityInEntryUnit            = any-rolllength
                                                  entryunit                      = 'M'
                                                  Batch                          = any-batch
                                                  IssuingOrReceivingPlant        = any-plant
                                                  IssuingOrReceivingStorageLoc   = any-recevinglocation
                                                  IssgOrRcvgBatch                = any-recbatch
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

result = <keys_header>-MaterialDocument .

endmethod .
ENDCLASS.
