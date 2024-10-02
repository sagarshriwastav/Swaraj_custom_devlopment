CLASS zsd_shp_delivery_check_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_badi_interface .
    INTERFACES if_le_shp_delivery_fin_check .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZSD_SHP_DELIVERY_CHECK_CLASS IMPLEMENTATION.


  METHOD if_le_shp_delivery_fin_check~delivery_final_check.

     DATA pick1 TYPE i .
     DATA pickCange TYPE I .
     DATA pickCange1 TYPE C LENGTH 5.

      LOOP AT delivery_document_items_in INTO DATA(ls_delivery_item) WHERE ( deliverydocumentitemcategory = 'CB99' OR deliverydocumentitemcategory = 'CB98' ).
  IF ls_delivery_item-material+0(3) <> 'FGJ' .

      SELECT  SINGLE pick FROM zjob_grey_netwt_dispatch_cds WHERE Material =  @ls_delivery_item-material AND Recbatch = @ls_delivery_item-batch INTO @DATA(pick) .

         pick1 = pick .
         IF pickCange = '0' .
         pickCange1 = '' .
         ELSE.
         pickCange1 = pickCange.
         ENDIF.
   IF pickCange1 <> '' .
        IF pickCange1 <> pick1 .

          message-messagetype = 'E'. " saving of the delivery document will be prevented
          message-messagetext = |Error: For { ls_delivery_item-material } & Batch: { ls_delivery_item-batch } Change Pick : {  pick  }  Please enter correct Batch Pick.|.
          EXIT.
     ENDIF.
     ENDIF.
     SELECT  SINGLE pick FROM zjob_grey_netwt_dispatch_cds WHERE Material =  @ls_delivery_item-material AND Recbatch = @ls_delivery_item-batch INTO @pickCange .
*     clear

     ELSEif ls_delivery_item-material+0(4) = 'FGJL' OR ls_delivery_item-material+0(5) = 'FGJLM' .

    SELECT  SINGLE pick FROM zjob_grey_netwt_dispatch_cds WHERE Material =  @ls_delivery_item-material AND Recbatch = @ls_delivery_item-batch INTO @pick .

         pick1 = pick .
         IF pickCange = '0' .
         pickCange1 = '' .
         ELSE.
         pickCange1 = pickCange.
         ENDIF.
   IF pickCange1 <> '' .
        IF pickCange1 <> pick1 .

          message-messagetype = 'E'. " saving of the delivery document will be prevented
          message-messagetext = |Error: For { ls_delivery_item-material } & Batch: { ls_delivery_item-batch } Change Pick : {  pick  }  Please enter correct Batch Pick.|.
          EXIT.
     ENDIF.
     ENDIF.
     SELECT  SINGLE pick FROM zjob_grey_netwt_dispatch_cds WHERE Material =  @ls_delivery_item-material AND Recbatch = @ls_delivery_item-batch INTO @pickCange .
*

     endif.

     ENDLOOP.

  ENDMETHOD.
ENDCLASS.
