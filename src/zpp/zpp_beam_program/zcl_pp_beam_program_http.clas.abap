class ZCL_PP_BEAM_PROGRAM_HTTP definition
  public
  create public .
********************CREATED GAJENDRA SINGH SHEKHAWAT*************************************************************
public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_PP_BEAM_PROGRAM_HTTP IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

   DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).

    DATA(TYP)  = req[ 2 ]-name.


      DATA(body)  = request->get_text(  )  .

     DATA respo TYPE  zpp_beam_program_str .
     DATA TABLEWA TYPE zpp_beam_pro_tab.
     DATA TABRESULT TYPE STRING.
     DATA TOTALBEAMMTR TYPE P DECIMALS 3.

   xco_cp_json=>data->from_string( body )->write_to( REF #( respo ) ).
************************************************CHANGE**********************************
************************************************CHANGE VALIDATION***********************
   IF TYP = 'change' .

    DATA(GS_TA) = respo-atablearr1[] .
   DELETE ADJACENT DUPLICATES FROM GS_TA COMPARING beamno plant .

   SORT respo-atablearr1 ASCENDING BY beamno .
   SORT GS_TA ASCENDING BY beamno .
   DATA POMTR TYPE P DECIMALS 3.


  LOOP AT  GS_TA  INTO DATA(GS_TA_WA) .
  LOOP AT  respo-atablearr1  INTO DATA(FS) WHERE beamno = GS_TA_WA-beamno AND plant = GS_TA_WA-plant.
  TOTALBEAMMTR = TOTALBEAMMTR + FS-pomtr.
  ENDLOOP.

  POMTR  = TOTALBEAMMTR  .
  IF POMTR <> 0 .
  IF POMTR > GS_TA_WA-beammtr .
  TABRESULT =  | Sort Meter shouldn't greater than Beam Length; Please Check! | && 'BeamNo' &&  '-' && |{ GS_TA_WA-beamno }| &&  '-' && 'Plant' &&  '-' && |{ GS_TA_WA-plant }|.
  EXIT.
  ENDIF.
  ENDIF.
  CLEAR:TOTALBEAMMTR,POMTR,GS_TA_WA.
  ENDLOOP.
************************************************CHANGE VALIDATION***********************
************************************************CHANGE TABLE UPATE**********************
  IF TABRESULT IS INITIAL .

    LOOP AT respo-atablearr1 INTO  DATA(WA) .

    UPDATE zpp_beam_pro_tab SET pomtr = @wa-pomtr WHERE zplant = @wa-plant AND material = @wa-material AND orderno = @wa-orderno
    AND beamno = @wa-beamno .
    COMMIT WORK AND WAIT.

     ENDLOOP .
       IF sy-subrc IS INITIAL.
          TABRESULT =  ' Data Saved Successfully !' .
        ELSE.
          TABRESULT = 'Error in saving data!!' .
        ENDIF.

   ENDIF.
   ENDIF.
************************************************CHANGE TABLE UPATE***********
************************************************CHANGE END*******************
************************************************ADD START********************
                              "  VALIDATION
   IF TYP = 'add' .
   GS_TA = respo-atablearr1[] .
   DELETE ADJACENT DUPLICATES FROM GS_TA COMPARING beamno plant .

   SORT respo-atablearr1 ASCENDING BY beamno .
   SORT GS_TA ASCENDING BY beamno .

   LOOP AT  GS_TA  INTO GS_TA_WA .

   SELECT SINGLE SUM( pomtr ) as pomtr , BEAMMTR FROM zpp_beam_pro_tab WHERE beamno = @GS_TA_WA-beamno
                                   AND zplant = @GS_TA_WA-plant  GROUP BY BEAMMTR INTO @DATA(SAVEPOMTR).

  IF SY-subrc =  0.
  IF     SAVEPOMTR-BEAMMTR <> 0.
  IF SAVEPOMTR-BEAMMTR <> GS_TA_WA-BEAMMTR.
  TABRESULT =  | Beam Length should be same for all Sorts in a Beam | && 'BeamNo' && '-' && |{ GS_TA_WA-beamno }| && 'Plant' && '-'  && |{ GS_TA_WA-plant }|.
  EXIT.
  ENDIF.
  ENDIF.
  ENDIF.

  LOOP AT  respo-atablearr1  INTO FS WHERE beamno = GS_TA_WA-beamno AND plant = GS_TA_WA-plant.
  TOTALBEAMMTR = TOTALBEAMMTR + FS-pomtr.
  if FS-beammtr <> GS_TA_WA-beammtr.
  TABRESULT =  | Beam Length should be same for all Sorts in a Beam | && 'BeamNo' && '-' && |{ GS_TA_WA-beamno }| && '-' && 'Plant' && '-' && |{ GS_TA_WA-plant }|.
  EXIT.
  ENDIF.
  ENDLOOP.

  POMTR  = TOTALBEAMMTR + SAVEPOMTR-pomtr .
  IF POMTR <> 0 .
  IF POMTR > GS_TA_WA-beammtr .
  TABRESULT =  | Sort Meter shouldn't greater than Beam Length; Please Check! | && 'BeamNo' && '-' && |{ GS_TA_WA-beamno }| && '-' && 'Plant' && '-' && |{ GS_TA_WA-plant }|.
  EXIT.
  ENDIF.
  ENDIF.
  CLEAR:TOTALBEAMMTR,POMTR,GS_TA_WA,SAVEPOMTR.
  ENDLOOP.
  "  VALIDATION

************************************************TABLE SAVED***********************

IF TABRESULT IS INITIAL .
      LOOP AT respo-atablearr1 INTO  WA .
      TABLEWA-beamno   =    WA-beamno.
      TABLEWA-material =    WA-material.
      TABLEWA-orderno  =   |{ WA-orderno ALPHA = IN  }|  .
      TABLEWA-zdate    =    WA-date .
      TABLEWA-beammtr  =    WA-beammtr.
      TABLEWA-pomtr    =    WA-pomtr .
      TABLEWA-zunit    =    'M' .
      TABLEWA-zplant   =   WA-plant.

      MODIFY zpp_beam_pro_tab FROM @TABLEWA  .
      CLEAR :  TABLEWA.

     ENDLOOP.
      IF sy-subrc IS INITIAL.
          TABRESULT =  ' Data Saved!! ' .
        ELSE.
          TABRESULT = 'Error in saving data!!' .
        ENDIF.

      COMMIT WORK AND WAIT.
  ENDIF.
  ENDIF.
************************************************TABLE SAVED***********************
************************************************ADD END*******************************
   response->set_text( TABRESULT  ).

  endmethod.
ENDCLASS.
