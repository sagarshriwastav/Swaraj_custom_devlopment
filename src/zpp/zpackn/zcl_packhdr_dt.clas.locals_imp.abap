CLASS LHC_ZPACKHDR_DPACK DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR ZPACKHDR_Dpack
        RESULT result,
      Sono FOR DETERMINE ON MODIFY
            IMPORTING keys FOR ZPACKHDR_Dpack~Sono.
ENDCLASS.

CLASS LHC_ZPACKHDR_DPACK IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.

  ENDMETHOD.

  METHOD Sono.
* DATA IT_PACKHDR TYPE TABLE OF zcopy_structure .
*
*read ENTITIES OF ZPACKHDR_DDM IN LOCAL MODE
*entity ZPACKHDR_Dpack  FIELDS ( Batch Counter MaterialNumber Plant DocumentDate PostingDate RecBatch RecevingLocation StorageLocation )
*WITH CORRESPONDING #( keys )
*    RESULT DATA(lt_project).
*
*MOVE-CORRESPONDING lt_project TO IT_PACKHDR .
*
*
*data(Grn_no)   = zcl_goodsmovement_311=>material_document12(  it_packhdr = IT_PACKHDR )  .
*
*modify ENTITIES OF ZPACKHDR_DDM  IN LOCAL MODE
* ENTITY ZPACKHDR_Dpack  UPDATE fields ( matDocument  )
* WITH VALUE #(  FOR lw_proj IN lt_project INDEX INTO i (
*                  %key = lw_proj-%key
*
*                  matDocument = '123453'
**                  znr_test=>use_nr( )
*              ) )
*
* REPORTED DATA(lt_reported).
*
*

  ENDMETHOD.


ENDCLASS.
