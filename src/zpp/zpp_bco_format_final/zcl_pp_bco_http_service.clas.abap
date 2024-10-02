class ZCL_PP_BCO_HTTP_SERVICE definition
  public
  create public .
********************CREATED GAJENDRA SINGH SHEKHAWAT*************************************************************
public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_PP_BCO_HTTP_SERVICE IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

      DATA(req) = request->get_form_fields(  ).
       response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).

      DATA(body)  = request->get_text(  )  .

     DATA respo TYPE TABLE OF zpp_bco_str .

     xco_cp_json=>data->from_string( body )->write_to( REF #( respo ) ).

   DATA TABLEWA TYPE zpp_bco.
   DATA TABRESULT TYPE STRING.
   DATA ZDATE1 TYPE C LENGTH 8.
   DATA Zbeamfalldate TYPE C LENGTH 8.
   DATA PartyCode TYPE C LENGTH 10.
   DATA beamgettingdate TYPE C LENGTH 8.

 LOOP AT respo INTO  DATA(CHECK) .
    PartyCode   =  |{ CHECK-party ALPHA = IN }| .

  SELECT SINGLE * FROM I_Supplier WHERE Supplier = @PartyCode INTO @DATA(PARTY) .
 IF sy-subrc IS NOT INITIAL.
 IF PARTY-SupplierName = ''   AND check-millweft2 <> 'N/A' .
    TABRESULT  = |{ CHECK-party } && { 'Supplier Not Permeated' } |.
           response->set_text( TABRESULT  ).
 EXIT.
 ENDIF.
 ENDIF.


 SELECT SINGLE * FROM I_Product WHERE Product = @check-dyeingshort INTO @DATA(PRODUCT) .
 IF sy-subrc IS NOT INITIAL.
 IF PRODUCT-Product = ''    AND check-millweft2 <> 'N/A' .
    TABRESULT  = |{ CHECK-dyeingshort } && { 'DyeingShort Not Permeated' } |.
           response->set_text( TABRESULT  ).
 EXIT.
 ENDIF.
 ENDIF.

  SELECT SINGLE * FROM I_ClfnCharcValueDesc WHERE CharcValueDescription = @check-millweft1 AND Language = 'E' AND CharcValueDescription <> '' INTO @DATA(millweft1) .
 IF sy-subrc IS NOT INITIAL.
 IF millweft1-CharcValueDescription = ''  AND check-millweft2 <> 'N/A' .
    TABRESULT  = |{ CHECK-millweft1 } && { 'Millweft1 Not Permeated' } |.
           response->set_text( TABRESULT  ).
 EXIT.
 ENDIF.
 ENDIF.

  SELECT SINGLE * FROM I_ClfnCharcValueDesc WHERE CharcValueDescription = @check-millweft2 AND Language = 'E' AND CharcValueDescription <> ''  INTO @DATA(millweft2) .
 IF sy-subrc IS NOT INITIAL.
 IF millweft2-CharcValueDescription = '' AND check-millweft2 <> 'N/A' .
    TABRESULT  = |{ CHECK-millweft2 } && { 'Millweft2 Not Permeated' } |.

           response->set_text( TABRESULT  ).
 EXIT.
 ENDIF.
 ENDIF.

  SELECT SINGLE * FROM I_ClfnObjectCharcValForKeyDate WHERE CharcValue = @check-lotnoweft1 AND CharcValue <> ''
                    And ClassType = '023' and ClfnObjectTable = 'MCH1' INTO @DATA(lotnoweft1) .
 IF sy-subrc IS NOT INITIAL.
 IF lotnoweft1-CharcValue = ''   AND check-millweft2 <> 'N/A' .
    TABRESULT  = |{ CHECK-lotnoweft1 } && { 'Lotnoweft1 Not Permeated' } |.
           response->set_text( TABRESULT  ).
 EXIT.
 ENDIF.
 ENDIF.

  SELECT SINGLE * FROM I_ClfnObjectCharcValForKeyDate WHERE CharcValue = @check-lotnoweft2 AND CharcValue <> ''
                                         And ClassType = '023' and ClfnObjectTable = 'MCH1'  INTO @DATA(lotnoweft2) .
 IF sy-subrc IS NOT INITIAL.
 IF lotnoweft2-CharcValue = ''   AND check-millweft2 <> 'N/A' .
    TABRESULT  = |{ CHECK-lotnoweft2 } && { 'Lotnoweft2 Not Permeated' } |.
           response->set_text( TABRESULT  ).
 EXIT.
 ENDIF.
 ENDIF.

 SELECT SINGLE * FROM I_Product WHERE Product = @check-weft1count INTO @DATA(WeftCount1) .
 IF sy-subrc IS NOT INITIAL.
 IF WeftCount1-Product = ''   AND check-millweft2 <> 'N/A' .
    TABRESULT  = |{ CHECK-weft1count } && { 'WeftCount1 Not Permeated' } |.
           response->set_text( TABRESULT  ).
 EXIT.
 ENDIF.
 ENDIF.


  SELECT SINGLE * FROM zpp_dyeing1 as a
  INNER JOIN I_MaterialDocumentItem_2 as c ON ( c~MaterialDocument = a~materialdocument
                                               AND c~MaterialDocumentYear = a~materialdocumentyear
                                               AND c~Batch = a~beamno
                                               AND c~Material = a~material )
  INNER JOIN YMSEG4 as b ON ( b~MaterialDocument = c~materialdocument
                             AND b~MaterialDocumentItem = c~materialdocumentitem
                             AND c~MaterialDocumentYear = a~materialdocumentyear
                             ) WHERE beamno = @check-sizbeemno INTO @DATA(sizbeemno) .

 IF sy-subrc = 0 .
 IF sizbeemno-a-length <> CHECK-beamlength  AND check-millweft2 <> 'N/A' .
    TABRESULT  = |{ CHECK-sizbeemno } && { 'Beamlength Not Permeated' } |.
           response->set_text( TABRESULT  ).
 EXIT.
 ENDIF.
 ENDIF.

   SELECT SINGLE * FROM zpp_dyeing1  WHERE beamno = @check-sizbeemno INTO @DATA(sizbeem) .
 IF sy-subrc IS NOT INITIAL.
 IF sizbeem-beamno = ''   AND check-millweft2 <> 'N/A' .
    TABRESULT  = |{ CHECK-sizbeemno } && { 'Sizbeemno Not Permeated' } |.
           response->set_text( TABRESULT  ).
 EXIT.
 ENDIF.
 ENDIF.

  SELECT SINGLE * FROM I_Product WHERE Product = @check-dyeingshort INTO @DATA(WeftCount2) .
 IF sy-subrc IS NOT INITIAL.
 IF WeftCount2-Product = ''  AND check-millweft2 <> 'N/A' .
    TABRESULT  = |{ CHECK-weft2count } && { 'WeftCount2 Not Permeated' } |.
           response->set_text( TABRESULT  ).
 EXIT.
 ENDIF.
 ENDIF.

  SELECT SINGLE * FROM I_Product WHERE Product = @check-shortno INTO @DATA(SHORTNO) .
 IF sy-subrc IS NOT INITIAL.
 IF SHORTNO-Product = '' AND check-millweft2 <> 'N/A' .
    TABRESULT  = |{ CHECK-shortno } && { 'ShortNo Not Permeated' } |.
           response->set_text( TABRESULT  ).
 EXIT.
 ENDIF.
 ENDIF.


 SELECT SINGLE * FROM I_ManufacturingOrderItem WHERE Batch = @CHECK-sizsetno INTO @DATA(SIZENO) .
 IF sy-subrc IS NOT INITIAL.
 IF SIZENO-Material = '' AND check-millweft2 <> 'N/A' .
    TABRESULT  = |{ CHECK-sizsetno } && { 'Sizsetno Not Permeated' } |.
           response->set_text( TABRESULT  ).
 EXIT.
 ENDIF.
 ENDIF.

 SELECT SINGLE * FROM zpc_headermaster WHERE dyesort = @CHECK-dyeingshort INTO @DATA(TOTLENDS) .
 IF sy-subrc IS NOT INITIAL.
 IF TOTLENDS-zptotends <> CHECK-ends AND TOTLENDS-zptotends <> ( CHECK-ends + 5 ) AND TOTLENDS-zptotends <> ( CHECK-ends - 5 )  AND check-millweft2 <> 'N/A' .
    TABRESULT  = |{ CHECK-dyeingshort } && { 'Total Ends Not Match With Master Data ' } |.
           response->set_text( TABRESULT  ).
 EXIT.
 ENDIF.
 ENDIF.

*     DATA beamgettingdate1 TYPE datn .
*     DATA beamfalldate1    TYPE datn .
*
*     REPLACE ALL OCCURRENCES OF '.' IN  CHECK-beamgettingdate WITH '' .
*     CONDENSE CHECK-beamgettingdate .
*     CONCATENATE CHECK-beamgettingdate+4(4) CHECK-beamgettingdate+2(2) CHECK-beamgettingdate+0(2) INTO beamgettingdate.
*     beamgettingdate1 = beamgettingdate.
*
*     REPLACE ALL OCCURRENCES OF '.' IN  CHECK-beamfalldate WITH '' .
*     CONDENSE CHECK-beamfalldate .
*     CONCATENATE CHECK-beamfalldate+4(4) CHECK-beamfalldate+2(2) CHECK-beamfalldate+0(2) INTO Zbeamfalldate.
*     beamfalldate1  =  Zbeamfalldate.
*if CHECK-beamfalldate <> 'N/A' .
* IF beamfalldate1 < beamgettingdate1 .
*
*  TABRESULT  = |{ CHECK-beamfalldate } && { 'Beam Fall Date should be greater then Beam Getting Date' } |.
*           response->set_text( TABRESULT  ).
* EXIT.
* ENDIF.
* clear:  CHECK ,beamfalldate1,beamgettingdate1,Zbeamfalldate,beamgettingdate.
* ENDIF.
 clear:  CHECK .",beamfalldate1,beamgettingdate1,Zbeamfalldate,beamgettingdate.
ENDLOOP.

 IF TABRESULT IS  INITIAL  .


     LOOP AT respo INTO  DATA(WA) .
     REPLACE ALL OCCURRENCES OF '.' IN  WA-zdate WITH '' .
     CONDENSE WA-zdate .
     CONCATENATE WA-zdate+4(4) WA-zdate+2(2) WA-zdate+0(2) INTO ZDATE1.
     TABLEWA-party    = |{ WA-party ALPHA = IN }|.
     TABLEWA-zdate    = ZDATE1 .
     TABLEWA-srno     = WA-srno .
     TABLEWA-dyeingsort = wa-dyeingshort.
     TABLEWA-loomno     = WA-loomno.
     TABLEWA-sizbeemno    = WA-sizbeemno.
     TABLEWA-sizsetno    = WA-sizsetno .
     TABLEWA-sizinsrno   = wa-sizsetsrno.
     TABLEWA-beamissue    = WA-beamissu .
     TABLEWA-shortno    = WA-shortno .
     TABLEWA-ends    = WA-ends.
     TABLEWA-pickonfabric    = WA-pickonfabric.
     TABLEWA-reed    = WA-reed .
     TABLEWA-reedspace         =  WA-reedspace .
     TABLEWA-weft1count     = WA-weft1count .
     TABLEWA-weft2count     = WA-weft2count .
     TABLEWA-millweft1    = WA-millweft1 .
     TABLEWA-lotnoweft1   =  wa-lotnoweft1 .
     TABLEWA-millweft2    = WA-millweft2.
     TABLEWA-lotnoweft2   =  wa-lotnoweft2 .
     REPLACE ALL OCCURRENCES OF '.' IN  WA-beamgettingdate WITH '' .
     CONDENSE WA-beamgettingdate .
     CONCATENATE WA-beamgettingdate+4(4) WA-beamgettingdate+2(2) WA-beamgettingdate+0(2) INTO beamgettingdate.
     TABLEWA-beamgettingdate = beamgettingdate.
     REPLACE ALL OCCURRENCES OF '.' IN  WA-beamfalldate WITH '' .
     CONDENSE WA-beamfalldate .
     CONCATENATE WA-beamfalldate+4(4) WA-beamfalldate+2(2) WA-beamfalldate+0(2) INTO Zbeamfalldate.
     TABLEWA-beamfalldate    = Zbeamfalldate.
     TABLEWA-balancemtr = wa-balencemeter.
     TABLEWA-beamlength    = WA-beamlength .
     TABLEWA-planbeampipe    = WA-planbeampipe .
     TABLEWA-beemdia    = WA-beemdia .
     TABLEWA-afst    = WA-afst .
     TABLEWA-awst    = WA-awst  .
     TABLEWA-aeffper    = WA-aeffper .
     TABLEWA-bfst    = WA-bfst.
     TABLEWA-bwst    = WA-bwst.
     TABLEWA-beffper    = WA-beffper .
     TABLEWA-acshifta    = WA-acshifta.
     TABLEWA-acshiftb    = WA-acshiftb .
     TABLEWA-rpm    = WA-rpm .
     TABLEWA-calshifta    = WA-calshifta.
     TABLEWA-calshiftb    = WA-calshiftb.
     TABLEWA-BeamOnFloorLength  =  WA-BeamOnFloorLength.
     TABLEWA-PartyGreyStock    =  WA-PartyGreyStock.
     TABLEWA-Meter    =  WA-Meter.
     TABLEWA-knotting    =  WA-knotting.
     TABLEWA-reknotting    =  WA-reknotting.
     TABLEWA-getting    =  WA-getting.

      MODIFY zpp_bco FROM @TABLEWA  .
      CLEAR : Zbeamfalldate ,ZDATE1  ,beamgettingdate, TABLEWA.

     ENDLOOP.
      IF sy-subrc IS INITIAL.
          TABRESULT =  ' Data Saved!! ' .
        ELSE.
          TABRESULT = 'Error in saving data!!' .
        ENDIF.

      COMMIT WORK AND WAIT.

  ENDIF.

   response->set_text( TABRESULT  ).

  endmethod.
ENDCLASS.
