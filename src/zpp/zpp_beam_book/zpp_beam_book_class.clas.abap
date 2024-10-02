CLASS zpp_beam_book_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  INTERFACES if_rap_query_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZPP_BEAM_BOOK_CLASS IMPLEMENTATION.


METHOD if_rap_query_provider~select.

     DATA: lt_response TYPE TABLE OF ZPP_BEAM_BOOK_CDS .
     DATA: wa1         TYPE ZPP_BEAM_BOOK_CDS.
     DATA:lt_current_output TYPE TABLE OF ZPP_BEAM_BOOK_CDS .




    DATA(lv_top)           = io_request->get_paging( )->get_page_size( ).
    DATA(lv_skip)          = io_request->get_paging( )->get_offset( ).
    DATA(lt_clause)        = io_request->get_filter( )->get_as_sql_string( ).
    DATA(lt_fields)        = io_request->get_requested_elements( ).
    DATA(lt_sort)          = io_request->get_sort_elements( ).


    TRY.
        DATA(lt_filter_cond) = io_request->get_filter( )->get_as_ranges( ).
      CATCH cx_rap_query_filter_no_range INTO DATA(lx_no_sel_option).
    ENDTRY.

    DATA(lr_material)  =  VALUE #( lt_filter_cond[ name   =  'MATERIAL'  ]-range OPTIONAL ).
    DATA(lr_plant)  =  VALUE #( lt_filter_cond[ name   = 'PLANT' ]-range OPTIONAL ).
    DATA(lr_date)  =  VALUE #( lt_filter_cond[ name   = 'FROM_DATE' ]-range OPTIONAL ).
    DATA(lr_Beamnumber)  =  VALUE #( lt_filter_cond[ name   = 'BEAM' ]-range OPTIONAL ).



    DATA Balance_Mtr TYPE P DECIMALS 3.
    DATA Shrinkage   TYPE P DECIMALS 3.

     SELECT
             a~plant ,
             a~Batch                   as Beam,
             a~prodorder               as Order_no,
             a~POSTINGDATE             as folding_date,
             a~RECBATCH                as Piece_no ,
             a~MATERIAL                as material,
             a~materialdec             as Description ,
             a~pick                    as Pick,
             a~quantity                as G_mtr,
             a~netwt                   as Weight ,
             a~wtmtr                   as Wt_Mtr,
             b~deliverydocument        as Challan_No,
             c~ActualGoodsMovementDate as Challan_Date,
             a~loomno                  as Loom_No,
             d~UnloadingPointName      as Beam_Length,
             d~MfgOrderPlannedTotalQty,
             @Balance_Mtr              as Balance_Mtr,
             @Shrinkage                as Shrinkage,
             e~ztowtpermtr             as QualityWt,
             e~Zpreed1                 as Reed,
             e~Zppicks                 as MasterPick,
             e~Zpreedspace             as Rs,
             f~yy1_setno_ord           as SetNo,
             a~UOM                     as materialbaseunit
     FROM  ZJOB_GREY_NETWT_DISPATCH_CDS       as a
     LEFT OUTER JOIN i_deliverydocumentitem   as b ON (  a~recbatch = b~batch AND b~material = a~material  )
     LEFT OUTER JOIN i_deliverydocument       as c ON ( c~deliverydocument = b~deliverydocument )
     LEFT OUTER JOIN I_ManufacturingOrderItem as d ON ( d~ManufacturingOrder = a~Prodorder )
     LEFT OUTER JOIN I_ManufacturingOrder     AS f ON ( f~ManufacturingOrder = d~ManufacturingOrder )
     LEFT OUTER JOIN zpc_headermaster_cds     as e ON ( E~Zpqlycode = A~Material and e~Zpunit = a~Plant )
*     left  OUTER JOIN I_MaterialDocumentItem_2 as gg on  (  gg~Material = E~Zpqlycode   )
*     LEFT OUTER JOIN I_MaterialDocumentItem_2 AS GGG ON (  GGG~Material = A~Material AND  GGG~Batch  = A~Batch  )
                                 WHERE a~material IN @lr_material AND a~plant IN @lr_plant AND a~batch IN @lr_beamnumber
       AND a~postingdate IN @lr_date    INTO TABLE @DATA(it).

    DATA shrinkage1 TYPE P DECIMALS 3.
 LOOP AT it ASSIGNING FIELD-SYMBOL(<GS_BEAM>).

 IF <GS_BEAM>-beam_length IS INITIAL OR <GS_BEAM>-beam_length = '' .
 <GS_BEAM>-beam_length  =  <GS_BEAM>-MfgOrderPlannedTotalQty.
 ENDIF.

 ENDLOOP.

    LOOP AT it ASSIGNING FIELD-SYMBOL(<GS>).

    SELECT SINGLE SUM( quantity )  FROM ZJOB_GREY_NETWT_DISPATCH_CDS WHERE Batch = @<GS>-beam INTO @DATA(SUMGREYMTR).

    <GS>-Balance_Mtr = <GS>-Beam_Length - SUMGREYMTR .

    IF <GS>-Balance_Mtr <> 0 AND <GS>-Beam_Length <> 0 .

    shrinkage1  =  ( ( ( <GS>-Beam_Length -  SUMGREYMTR ) / <GS>-Beam_Length ) * 100 ) .
    <GS>-shrinkage  = shrinkage1.

    ENDIF.

    CLEAR:SUMGREYMTR.
    ENDLOOP.

       DATA(it1) = it[].
       DATA(it_FIN) = it[].
       FREE:it_FIN[].
       DATA(it2) = it1[].

   SORT IT2 ASCENDING BY beam material piece_no.
   SORT IT1 ASCENDING BY beam material piece_no.
   DELETE ADJACENT DUPLICATES FROM IT1 COMPARING beam.
   DATA CNT(3) TYPE C.
   DATA G_mtr TYPE menge_d .
   DATA Weight TYPE menge_d .
   DATA WtMtr TYPE menge_d .

  DATA:VA TYPE C LENGTH 100.
  LOOP AT it1 ASSIGNING FIELD-SYMBOL(<ft>).
  LOOP AT iT2 INTO DATA(wt) WHERE beam = <ft>-beam.
  G_mtr = G_mtr + WT-g_mtr.
  Weight = Weight +  WT-Weight.
  WtMtr =   WtMtr +  WT-wt_mtr.
  CNT = CNT + 1.
  APPEND WT TO it_FIN.
  ENDLOOP.
  CLEAR:wt.


  wt-beam = 'SUBTOTAL'.
  wt-beam_length  = '' .
  wt-pick    =  '' .
  wt-rs    =   '' .
  wt-g_mtr = G_mtr.
  wt-weight = Weight.
  wt-wt_mtr  = WtMtr.
  WT-piece_no = CNT.
  APPEND WT TO it_FIN.


  CLEAR:G_mtr,Weight,WtMtr,CNT.
  ENDLOOP.
  FREE IT[].
  IT[] = IT_FIN[].

     DATA BEAMNO TYPE C LENGTH 10 .
     DATA material TYPE C LENGTH 40 .

      LOOP AT IT INTO DATA(wa_item).

      MOVE-CORRESPONDING wa_item TO wa1.

    if wa_item-beam = 'SUBTOTAL'  .
    wa1-Balance_Mtr = '' .
    wa1-Loom_No = '' .
    wa1-Pick = '' .
    wa1-MasterPick = '' .
    wa1-QualityWt =  '' .
    wa1-Reed  =  '' .
    wa1-Rs  =  '' .
    wa1-Shrinkage = '' .
    ENDIF.

      if BEAMNO = wa_item-beam .
        wa1-Beam_Length = ''.
        wa1-Balance_Mtr = ''.
        wa1-Shrinkage  = '' .
        ENDIF.

 if BEAMNO = wa_item-beam  AND material = wa_item-material .
 wa1-QualityWt = ''.
 wa1-Reed = ''.
 wa1-Pick = '' .
 wa1-Rs =  '' .
 ENDIF.

 BEAMNO = wa_item-beam .
 material = wa_item-material .


      APPEND wa1 TO lt_response.
      CLEAR wa1.
    ENDLOOP.




TRY.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*_Paging implementation
  IF lv_top < 0  .
     lv_top = lv_top * -1 .
     ENDIF.
          DATA(lv_start) = lv_skip + 1.
          DATA(lv_end)   = lv_top + lv_skip.
          APPEND LINES OF lt_response FROM lv_start TO lv_end TO lt_current_output.

     io_response->set_total_number_of_records( lines( lt_current_output ) ).
      io_response->set_data( lt_current_output ).

     CATCH cx_root INTO DATA(lv_exception).
        DATA(lv_exception_message) = cl_message_helper=>get_latest_t100_exception( lv_exception )->if_message~get_longtext( ).
    ENDTRY.

ENDMETHOD.
ENDCLASS.
