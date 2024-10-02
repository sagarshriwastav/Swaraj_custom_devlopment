class ZCL_PACK_311_BAPI definition
  public
  create public .

public section.
* CLASS-DATA:
*      FAAI TYPE RESPONSE FOR

CLASS-DATA: BEGIN OF TY1 ,
       MSGV1 TYPE STRING ,
       MSGV2 TYPE STRING ,
       MSGV3 TYPE STRING ,
       MSGV4 TYPE STRING ,

       END OF TY1 .

   INTERFACES if_oo_adt_classrun .
  interfaces IF_HTTP_SERVICE_EXTENSION .

  CLASS-METHODS
      get_mat
        IMPORTING VALUE(mat)      TYPE i_product-Product
        RETURNING VALUE(material) TYPE char18.
protected section.
private section.
ENDCLASS.



CLASS ZCL_PACK_311_BAPI IMPLEMENTATION.


  METHOD get_mat.
    DATA matnr TYPE char18.

    matnr = |{ mat ALPHA = IN }|.
    material = matnr.
  ENDMETHOD.


  METHOD if_http_service_extension~handle_request.

    DATA(req) = request->get_form_fields(  ).

    DATA(body)  = request->get_text(  )  .

    data znum type char2 .
    DATA zpackn TYPE    zpackn_json .
    DATA result TYPE string .

    xco_cp_json=>data->from_string( body )->write_to( REF #( zpackn ) ).

******************************NUMBER RANGE START****************************************

  ZNUM = zpackn-inspectiomcno .
  DATA(ZNUM3)  =  ZCLASS_GDMVT=>num_range( num = znum  nobject = 'ZBATCH_NR' ).

******************************NUMBER RANGE END****************************************
******************************Folio Number CHEACK START*******************************
SELECT SINGLE folio_number from zpackhdr WHERE folio_number = @zpackn-foliono AND cancelflag <> 'X' INTO @DATA(checak).
IF checak is NOT INITIAL .

  result = 'ERROR Folio Number is Already Exist'.
  response->set_text( |{ result }| ).
else .
******************************Folio Number CHEACK START*******************************

  loop at zpackn-atablearr2  assigning FIELD-SYMBOL(<WAT>).
  IF <WAT>-soitem EQ '0'.
<WAT>-soitem = ''.
<WAT>-ind = ''.
<WAT>-insstocktype = '' .
<WAT>-recbatch =  ZNUM3 .
else.
<WAT>-soitem = |{ <WAT>-soitem ALPHA = IN }| .
<WAT>-ind = 'E'.
<WAT>-insstocktype = 'E' .
<WAT>-recbatch =  ZNUM3 .
ENDIF.
endloop.

        MODIFY ENTITIES OF i_materialdocumenttp
                    ENTITY materialdocument
                    CREATE FROM VALUE #( ( %cid                          = 'My%CID_1'
                                           goodsmovementcode             = '04'
                                           postingdate                   =  zpackn-date  " sy-datum
                                           documentdate                  =   sy-datum
                                           %control-goodsmovementcode                    = cl_abap_behv=>flag_changed
                                           %control-postingdate                          = cl_abap_behv=>flag_changed
                                           %control-documentdate                         = cl_abap_behv=>flag_changed
                                       ) )

*FF001
*FF001A  1.  FN01  2 . FG01

                    ENTITY materialdocument
                    CREATE BY \_materialdocumentitem
                    FROM VALUE #( (
                                    %cid_ref = 'My%CID_1'
                                    %target = VALUE #( FOR any IN zpackn-atablearr2 INDEX INTO i  ( %cid                           = |My%CID_{ i }_001|
                                                         plant                          = zpackn-plant
                                                         material                       =  get_mat( mat = zpackn-material )
                                                         goodsmovementtype              = '311'
                                                         storagelocation                = zpackn-storloc
                                                         quantityinentryunit            =  any-length
                                                         entryunit                      = 'M'
                                                         batch                          = any-batch
                                                         issuingorreceivingplant        = zpackn-plant
                                                         issuingorreceivingstorageloc   = zpackn-recivloc
                                                         issgorrcvgbatch                = any-recbatch
                                                         issgorrcvgspclstockind         = ANY-ind
                                                         inventoryspecialstocktype      = any-insstocktype
                                                         specialstockidfgsalesorder     = |{ any-salesorder ALPHA = IN }|
                                                         specialstockidfgsalesorderitem  = any-soitem
                                                         materialdocumentitemtext       = 'Denim Packing'
                                                         %control-plant                 = cl_abap_behv=>flag_changed
                                                         %control-material              = cl_abap_behv=>flag_changed
                                                         %control-goodsmovementtype    = cl_abap_behv=>flag_changed
                                                         %control-storagelocation       = cl_abap_behv=>flag_changed
                                                         %control-quantityinentryunit  = cl_abap_behv=>flag_changed
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

 IF commit_failed-materialdocument IS NOT INITIAL .

 LOOP AT  commit_reported-materialdocumentitem ASSIGNING FIELD-SYMBOL(<data>).

  DATA(msz) =  <data>-%msg  .

  DATA(mszty) = sy-msgty .
  DATA(msz_1)  = | { sy-msgv1 } { sy-msgv2 }  { sy-msgv3 } { sy-msgv4 } Message Type- { sy-msgty } Message No { sy-msgno }  |  .

  ENDLOOP .

ELSE .
IF commit_failed-materialdocument IS INITIAL .

CLEAR mszty .
ENDIF .

LOOP AT ls_create_mapped-materialdocument ASSIGNING FIELD-SYMBOL(<keys_header>).
IF mszty = 'E' .
  EXIT .
 ENDIF .

          CONVERT KEY OF i_materialdocumenttp
          FROM <keys_header>-%pid
          TO <keys_header>-%key .
        ENDLOOP.


        LOOP AT ls_create_mapped-materialdocumentitem ASSIGNING FIELD-SYMBOL(<keys_item>).
*
  IF mszty = 'E' .
  EXIT .
  ENDIF .

   CONVERT KEY OF i_materialdocumentitemtp
          FROM <keys_item>-%pid
          TO <keys_item>-%key.
        ENDLOOP.
ENDIF.
        COMMIT ENTITIES END.

        IF  mszty = 'E' .

          result = |ERROR { msz_1 } |.

        ELSE .
          DATA(grn)  = <keys_header>-materialdocument .

          result = <keys_header>-materialdocument .
          DATA(result21) = <keys_header>-MaterialDocumentYear.
          DATA(ResultItem)  = <keys_item>-MaterialDocumentItem.

        ENDIF .



    DATA zpack_item TYPE zpackhdr_d.

  IF result IS NOT INITIAL AND result21 IS NOT INITIAL .

    LOOP AT zpackn-atablearr2 ASSIGNING FIELD-SYMBOL(<fs1>)  .

      zpack_item-actozs    =  zpackn-actozs .
      zpack_item-batch       =  <fs1>-batch .
      zpack_item-cancelflag    =  ''.
      zpack_item-document_date   =  SY-datum .
      zpack_item-sendinglength   =   <fs1>-length .
      zpack_item-flag_quantity_total   =  zpackn-totqty.
      zpack_item-finish_width   =  zpackn-finishwidth .
      zpack_item-folio_number   =  zpackn-foliono .
      zpack_item-gross_weight   =  zpackn-grossweight.
      zpack_item-inspection_mc_no   =  zpackn-inspectiomcno.
      zpack_item-loomno   =  <fs1>-loomno .
      zpack_item-material_number   =  get_mat( mat = zpackn-material ).
      zpack_item-mat_doc   =       result .
      zpack_item-mat_docitem   =    ResultItem .
      zpack_item-mat_docyear   =   result21.
      zpack_item-net_weight   =  zpackn-netweight.
      zpack_item-no_of_tp   =  zpackn-tp .
      zpack_item-operator_name   =  zpackn-opername.
      zpack_item-pack_grade   =  zpackn-packgrade.
      zpack_item-party   =  <fs1>-partyname.
      zpack_item-plant   =  zpackn-plant.
      zpack_item-posting_date   =  zpackn-date.
      zpack_item-receving_location   =  zpackn-recivloc.
      zpack_item-rec_batch   =    ZNUM3.
      zpack_item-remark1   =  zpackn-remark1 .
      zpack_item-remark2   =  zpackn-remark2.
      zpack_item-re_grading   =  zpackn-regrading.
      zpack_item-roll_length   =  zpackn-rolllength.
      zpack_item-sales_order   = | { <fs1>-salesorder ALPHA = IN } |.
      zpack_item-setno   =  <fs1>-setno.
      zpack_item-shift   =  zpackn-shift.
      zpack_item-so_item   =  <fs1>-soitem.
      zpack_item-stdnetwt   =  zpackn-stdnetwt.
      zpack_item-stdozs   =  zpackn-stdozs.
      zpack_item-stdwidth   =  zpackn-stdwidth .
      zpack_item-cutablewidth = zpackn-cutablewidth .
      zpack_item-storage_location   =  zpackn-storloc.
      zpack_item-totalpoint   =  zpackn-flagqty.
      zpack_item-tpremk   =  zpackn-tpremk.
      zpack_item-trollyno   =  <fs1>-trollyno.
      zpack_item-unit_field   =  'KG' .
      zpack_item-unitmtr      = 'M' .
      zpack_item-unitinch    =   'IN' .
      zpack_item-point4   =   zpackn-point4 .

      MODIFY zpackhdr_d FROM @zpack_item .
      CLEAR zpack_item .
    ENDLOOP .


    DATA zpack1 TYPE zpackhdr .
    READ TABLE zpackn-atablearr2 ASSIGNING FIELD-SYMBOL(<fs2>) INDEX 1 .
    IF sy-subrc = 0 .
      zpack1-actozs    =  zpackn-actozs .
      zpack1-batch       =  <fs2>-batch .
      zpack1-cancelflag    =  ''.
      zpack1-document_date   =  SY-datum.
      zpack1-flag_quantity_total   =  zpackn-totqty.
      zpack1-finish_width   =  zpackn-finishwidth .
      zpack1-folio_number   =  zpackn-foliono .
      zpack1-gross_weight   =  zpackn-grossweight.
      zpack1-inspection_mc_no   =  zpackn-inspectiomcno.
      zpack1-loomno   =  <fs2>-loomno .
      zpack1-material_number   =  get_mat( mat = zpackn-material ).
      zpack1-mat_doc   =       result .
      zpack1-mat_docitem   =    ResultItem .
      zpack1-mat_docyear   =   result21.
      zpack1-net_weight   =  zpackn-netweight.
      zpack1-no_of_tp   =  zpackn-tp .
      zpack1-operator_name   =  zpackn-opername.
      zpack1-pack_grade   =  zpackn-packgrade.
      zpack1-party   =  <fs2>-partyname.
      zpack1-plant   =  zpackn-plant.
      zpack1-posting_date   =  zpackn-date.
      zpack1-receving_location   =  zpackn-recivloc.
      zpack1-rec_batch   =    ZNUM3.
      zpack1-remark1   =  zpackn-remark1 .
      zpack1-remark2   =  zpackn-remark2.
      zpack1-re_grading   =  zpackn-regrading.
      zpack1-roll_length   =  zpackn-rolllength.
      zpack1-sales_order   =  |{ <fs2>-salesorder ALPHA = IN } |.
      zpack1-setno   =  <fs2>-setno.
      zpack1-shift   =  zpackn-shift.
      zpack1-so_item   =  <fs2>-soitem.
      zpack1-stdnetwt   =  zpackn-stdnetwt.
      zpack1-stdozs   =  zpackn-stdozs.
      zpack1-stdwidth   =  zpackn-stdwidth .
      ZPACK1-cutablewidth = zpackn-cutablewidth .
      zpack1-storage_location   =  zpackn-storloc.
      zpack1-totalpoint   =  zpackn-flagqty.
      zpack1-tpremk   =  zpackn-tpremk.
      zpack1-trollyno   =  <fs2>-trollyno.
      zpack1-unit_field   =  'KG' .
      zpack1-unitmtr      = 'M' .
      zpack1-unitinch    =   'IN' .
      zpack1-point4 =   zpackn-point4 .

      MODIFY zpackhdr FROM @zpack1 .

    ENDIF .

    DATA WA_DNMFAULT TYPE zdnmfault .

LOOP AT zpackn-atablearr3 ASSIGNING FIELD-SYMBOL(<fs3>)  .


WA_DNMFAULT-posting_date     =    zpackn-date .
WA_DNMFAULT-rec_batch     =    ZNUM3 .
WA_DNMFAULT-erdat     =   zpackn-date .
WA_DNMFAULT-ftype       = <fs3>-ftype .
WA_DNMFAULT-material_number       =  get_mat( mat = zpackn-material ) .
WA_DNMFAULT-mat_docyear    =   result21 .
WA_DNMFAULT-mat_doc       =  result .
WA_DNMFAULT-meter       = <fs3>-meter.
WA_DNMFAULT-point       =  <fs3>-point.
WA_DNMFAULT-tometer     =  <fs3>-tometer .
WA_DNMFAULT-unit_field  = 'M' .
WA_DNMFAULT-plant      =   zpackn-plant .
WA_DNMFAULT-zparty     =  <fs3>-partyname.
WA_DNMFAULT-batch      =  <fs3>-batch.

  MODIFY zdnmfault FROM @WA_DNMFAULT  .
*  CLEAR : WA_DNMFAULT .
ENDLOOP.
  DATA : ZPLANT TYPE CHAR4 .
         ZPLANT = zpackn-plant .

DATA(pdf1) =  zcl_denim_pack_barcode=>read_posts(  PLANT = ZPLANT rollno = ZNUM3
                                           ).


ENDIF.
       IF  mszty = 'E' .

       response->set_text( result ).

       ELSEIF pdf1 IS NOT INITIAL  .

       response->set_text( pdf1 ) .

       ELSE .
       response->set_text( |{ znum3 }  New Batch  Material document { result }| ) .

       ENDIF.



 ENDIF.

ENDMETHOD.
ENDCLASS.
