 CLASS zpp_mastercard_print_class DEFINITION
 PUBLIC
  FINAL
  CREATE PUBLIC .
**********************CREATED GAJENDRA SINGH SHEKHAWAT********************************************************
  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .


     CLASS-DATA : access_token TYPE string .
    CLASS-DATA : xml_file TYPE string .
    CLASS-DATA : template TYPE string .

    TYPES :
      BEGIN OF struct,
        xdp_template TYPE string,
        xml_data     TYPE string,
        form_type    TYPE string,
        form_locale  TYPE string,
        tagged_pdf   TYPE string,
        embed_font   TYPE string,
      END OF struct."

    CLASS-METHODS :

      create_client
        IMPORTING url           TYPE string
        RETURNING VALUE(result) TYPE REF TO if_web_http_client
        RAISING   cx_static_check ,

      read_posts
        importing
                   mastercardno type string
                   qualitycode  type  string
                   radiobutton  type  string

        RETURNING VALUE(result12) TYPE string
        RAISING   cx_static_check .

  PROTECTED SECTION.
  PRIVATE SECTION.


    CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
    CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
    CONSTANTS  lv2_url    TYPE string VALUE 'https://btp-yvzjjpaz.authentication.eu10.hana.ondemand.com/oauth/token' .
    CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
    CONSTANTS lc_template_name TYPE string VALUE 'MASTESRCARD_PRINT/MASTESRCARD_PRINT'.


ENDCLASS.



CLASS ZPP_MASTERCARD_PRINT_CLASS IMPLEMENTATION.


METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).

  ENDMETHOD .


 METHOD if_oo_adt_classrun~main.


 ENDMETHOD.


  method read_posts .


      data xsml type string .
      data Lv_xml type string .
      data DYINGDESCC type string .


    IF radiobutton = 'Landscap' .
     template = 'MASTERCARD_LANDSCAPE/MASTERCARD_LANDSCAPE' .
    ELSEIF radiobutton = 'Potrait'.
    template   =   'MASTESRCARD_PRINT/MASTESRCARD_PRINT' .
    ENDIF.
IF mastercardno IS NOT INITIAL AND qualitycode IS NOT INITIAL .

    SELECT * FROM ZPC_HEADERMASTER_CDS as a
            INNER JOIN I_ProductDescription as f ON ( f~Product = a~Zpqlycode AND f~Language = 'E' )
            WHERE a~Zpno = @mastercardno AND a~Zpqlycode = @qualitycode
                             INTO TABLE @DATA(IT) .

 ELSEIF  qualitycode IS NOT INITIAL .

    SELECT * FROM ZPC_HEADERMASTER_CDS as a
            INNER JOIN I_ProductDescription as f ON ( f~Product = a~Zpqlycode AND f~Language = 'E' )
            WHERE a~Zpno = @mastercardno AND a~Zpqlycode = @qualitycode
                             INTO TABLE @IT .

 ENDIF.
    READ TABLE IT INTO DATA(WA_IT) INDEX 1.

    SELECT SINGLE dyeindesc FROM ZPP_DYEING_SHADE_TMG WHERE Dyeingshade = @wa_it-a-Zpdytype INTO @DAta(dyeinds) .
     DATA DENTLE TYPE  P DECIMALS 0 .
       DENTLE  = WA_IT-A-Zdent .


       IF dyeinds = '' .
       DYINGDESCC  = wa_it-a-Zpdytype .
       ELSE .
       DYINGDESCC = dyeinds .
       ENDIF.

IF WA_IT-a-Zpunit = '2100' OR WA_IT-a-Zpunit = '2200'  .

   DATA(PLANTADD)   =   'MODWAY SUITING PRIVATE LTD.' .
   ELSE .

    PLANTADD  =  'SWARAJ SUITING LTD.' .

   ENDIF.

    lv_xml =

         |<form1>| &&
         |<PAGE1>| &&
         |<Subform1>| &&
         |<LOOMTYPE>{ WA_IT-a-Ploom }</LOOMTYPE>| &&
         |<warpno>{ SY-datum+0(4) }-{ SY-datum+4(2) }-{ SY-datum+6(2) }</warpno>| &&
         |<PlantAddress>{ PLANTADD }</PlantAddress>| &&
         |</Subform1>| &&
         |<Subform2>| &&
         |<Subform3>| &&
         |<Mastercardno>{ WA_IT-a-Zpno }</Mastercardno>| &&
         |<REEDDENT>{ |{ WA_IT-A-Zpreed1 ALPHA = OUT }| }/{ DENTLE }</REEDDENT>| &&
         |<PICKS>{ WA_IT-A-Zppicks }</PICKS>| &&
         |<REEDSPACE>{  WA_IT-A-Zpreedspace }</REEDSPACE>| &&
         |<GREYWT>{ wa_IT-A-ztowtpermtr }</GREYWT>| &&
         |<EPI>{ WA_IT-A-Zpepi }</EPI>| &&
         |</Subform3>| &&
         |<Subform4>| &&
         |<quality>{ WA_IT-F-ProductDescription }</quality>| &&
         |<CUSTOMER>{ WA_IT-A-supplier }</CUSTOMER>| &&
         |<PARTYREF></PARTYREF>| &&
         |<Dyeingsort>{ WA_IT-A-DyeSort }</Dyeingsort>| &&
         |<DyeingShade>{ DYINGDESCC }</DyeingShade>| &&
         |<PieceLength>{ wa_it-a-Plength }</PieceLength>| &&
         |</Subform4>| &&
         |<Subform5>| &&
         |<WarpWtperMtr>{ wa_it-a-zwawtpermtr }</WarpWtperMtr>| &&
         |<WeftPermtr>{ wa_it-a-zwewtpermtr }</WeftPermtr>| &&
         |<PDNO>{ wa_it-a-pdnumber }</PDNO>| &&
         |<BODYENDS>{ WA_IT-A-Bodyends }</BODYENDS>| &&
         |<SLEVEDGEENDS>{ WA_IT-a-selvedgeends }</SLEVEDGEENDS>| &&
         |<TOTALENDS>{ WA_IT-a-Zptotends }</TOTALENDS>| &&
         |<SETCODENO></SETCODENO>| &&
         |</Subform5>| &&
         |</Subform2>| &&
         |<Subform6>| &&
         |<WEAVINGINSTRUCTION>{ WA_IT-a-weavingreamrk }</WEAVINGINSTRUCTION>| &&
         |</Subform6>| &&
         |<TEXT/>| &&
         |<SubTABLE>| &&
         |<Table1>| &&
         |<HeaderRow/>| .


     SELECT  * FROM zpc_warppattern_cds  WHERE Zpno = @wa_it-a-Zpno INTO table @data(tab1) .

     SORT tab1 BY Zpno Zpmsno Pattern .
     DATA TOTENDS TYPE P DECIMALS 3 .
     DATA TOTWpmtr TYPE P DECIMALS 3 .
     DATA N TYPE I .
     DATA C TYPE C LENGTH 1 .

     DATA ZERO TYPE c LENGTH 10 .
     data zero1 type c LENGTH 10.
     data zero2 type c LENGTH 10.

     DATA end TYPE c LENGTH 10 .
     data end1 type c LENGTH 10.
     data end2 type c LENGTH 10.


 DELETE tab1 WHERE P1 = '' AND  P2 = '' AND  P3 = '' AND  P4 = '' AND  P5 = '' AND  P6 = '' AND  P7 = '' AND  P8 = '' AND  P9 = '' AND
                  P10 = '' AND  P11 = '' AND  P12 = '' AND  P13 = '' AND  P14 = '' AND  P15 = '' AND  P16 = '' AND P17 = '' AND  P18 = '' AND
                  P19 = '' AND  P20 = '' AND  P21 = '' AND  P22 = '' AND  P23 = '' AND  P24 = '' .


  DATA(WARPtab1)  = tab1[].
  DATA(WEFTTAB)   = tab1[] .
  DATA(I_WARPREP)  = tab1[] .

DELETE I_WARPREP WHERE REP IS INITIAL .
SORT I_WARPREP BY REP DESCENDING .

******************  WARPPATTERNTABLE START*******************************

LOOP AT I_WARPREP INTO DATA(W_MULREP) WHERE ( REP = 'R1' OR  REP = 'M1' ) AND Pattern = '1'.

      W_MULREP-Maktx = W_MULREP-Rep .

  APPEND W_MULREP TO WARPtab1 .
  CLEAR : W_MULREP.
ENDLOOP.

LOOP AT I_WARPREP INTO DATA(W_MULREP2) WHERE (  REP = 'R2' OR  REP = 'M2' ) AND Pattern = '1'.

      W_MULREP2-Maktx = W_MULREP2-Rep .

  APPEND W_MULREP2 TO WARPtab1 .
  CLEAR : W_MULREP2.
ENDLOOP.


 LOOP AT WARPtab1 INTO data(wa_tab1) WHERE Pattern = '1' AND  Maktx <> ''  .


       if wa_tab1-Maktx <> 'M1' AND wa_tab1-Maktx <> 'R1' AND wa_tab1-Maktx <> 'M2' AND wa_tab1-Maktx <> 'R2' .

         N = N + 1.
         IF N = 1 .  C = 'A' .       ELSEIF N = 2 .  C = 'B' .
         ELSEIF  N = 3 .  C = 'C' .  ELSEIF N = 4 .  C = 'D' .
         ELSEIF   N = 5 .  C = 'E' . ELSEIF   N = 6 .  C = 'F' .
         ELSEIF   N = 7 .  C = 'G' . ELSEIF   N = 8 .  C = 'H'  .
         ELSEIF   N = 9 .  C = 'I' . ELSEIF   N = 10 .  C = 'J' .
         ELSEIF   N = 11 .  C = 'K' . ELSEIF   N = 12 .  C = 'L' .
         .
         ENDIF.
         ENDIF.

         ZERO = wa_tab1-Wpmtr .
        ZERO1   =   |{ ZERO ALPHA = OUT }| .
         if zero1 = 0.
         zero2 = ' ' .
         ELSE .
           zero2 = zero1 .
         ENDIF.

         end = wa_tab1-Ends .
        end1   =   |{ end ALPHA = OUT }| .

         if end1 = 0.
         end2 = ' ' .
         ELSE .
           end2 = end1 .
         ENDIF.

       TOTENDS = TOTENDS + wa_tab1-Ends .
       TOTWpmtr = TOTWpmtr +  wa_tab1-Wpmtr.

     lv_xml = lv_xml &&

            |<Row1>| &&
            |<SR>{ C }</SR>| &&
            |<YARNDESC>{ wa_tab1-Maktx }</YARNDESC>| &&
            |<WEIGHT>{ zero2 }</WEIGHT>| &&
            |<BOX1>{ wa_tab1-p1 }</BOX1>| &&
            |<BOX2>{ wa_tab1-p2 }</BOX2>| &&
            |<BOX3>{ wa_tab1-p3 }</BOX3>| &&
            |<BOX4>{ wa_tab1-p4 }</BOX4>| &&
            |<BOX5>{ wa_tab1-p5 }</BOX5>| &&
            |<BOX6>{ wa_tab1-p6 }</BOX6>| &&
            |<BOX7>{ wa_tab1-p7 }</BOX7>| &&
            |<BOX8>{ wa_tab1-p8 }</BOX8>| &&
            |<BOX9>{ wa_tab1-p9 }</BOX9>| &&
            |<BOX10>{ wa_tab1-p10 }</BOX10>| &&
            |<BOX11>{ wa_tab1-p11 }</BOX11>| &&
            |<BOX12>{ wa_tab1-p12 }</BOX12>| &&
            |<BOX13>{ wa_tab1-p13 }</BOX13>| &&
            |<BOX14>{ wa_tab1-p14 }</BOX14>| &&
            |<BOX15>{ wa_tab1-p15 }</BOX15>| &&
            |<BOX16>{ wa_tab1-p16 }</BOX16>| &&
            |<BOX17>{ wa_tab1-p17 }</BOX17>| &&
            |<BOX18>{ wa_tab1-p18 }</BOX18>| &&
            |<BOX19>{ wa_tab1-p19 }</BOX19>| &&
            |<box20ends>{ end2 }</box20ends>| &&

            |</Row1>| .


       clear : c,zero,zero1,zero2,end,end1,end2.



   ENDLOOP .

     lv_xml = lv_xml &&

            |<Row2>| &&
            |<WEIGHTTOTAL>{ TOTWpmtr }</WEIGHTTOTAL>| &&
            |<endstotal1>{ TOTENDS }</endstotal1>| &&
            |</Row2>| &&
            |</Table1>| &&
            |</SubTABLE>| &&
            |<TEXT2/>| &&
            |<subTABLE2>| &&
            |<Table2>| &&
            |<HeaderRow/>| .


*******************  WARPPATTERNTABLE END*******************************

     DATA TOTENDS1 TYPE P DECIMALS 3 .
     DATA TOTWpmtr1 TYPE P DECIMALS 3 .
     DATA N1 TYPE I .
     DATA C1 TYPE C LENGTH 1 .

*******************  WEFTPATTERNTABLE START*******************************


LOOP AT I_WARPREP INTO DATA(W_WEFTREP) WHERE ( REP = 'R1' OR  REP = 'M1' ) AND Pattern = '2'.

      W_WEFTREP-Maktx = W_WEFTREP-Rep .

  APPEND W_WEFTREP TO WEFTTAB .
  CLEAR : W_WEFTREP.
ENDLOOP.

LOOP AT I_WARPREP INTO DATA(W_WEFTREP2) WHERE (  REP = 'R2' OR  REP = 'M2' ) AND Pattern = '2'.

      W_WEFTREP2-Maktx = W_WEFTREP2-Rep .

  APPEND W_WEFTREP2 TO WEFTTAB .
  CLEAR : W_WEFTREP2.
ENDLOOP.


  LOOP AT WEFTTAB INTO data(wa_tab2) WHERE Pattern = '2' AND Maktx <> '' .

    if wa_tab2-Maktx <> 'M1' AND wa_tab2-Maktx <> 'R1' AND wa_tab2-Maktx <> 'M2' AND wa_tab2-Maktx <> 'R2' .

     N1 = N1 + 1.
     IF N1 = 1 .  C1 = 'A' .
     ELSEIF N1 = 2 .  C1 = 'B' . ELSEIF  N1 = 3 .  C1 = 'C' .
     ELSEIF N1 = 4 .  C1 = 'D' . ELSEIF   N1 = 5 .  C1 = 'E' .
     ELSEIF N1 = 6 .  C1 = 'F' . ELSEIF N1 =  7 .  C1 = 'G' .
     ELSEIF N1 = 8 .  C1 = 'H' . ELSEIF N1 = 9 .  C1 = 'I' .
     ELSEIF N1 = 10 .  C1 = 'J' . ELSEIF N1 = 11 .  C1 = 'K' .
     ELSEIF N1 = 12 .  C1 = 'L' . ELSEIF N1 = 12 .  C1 = 'M' .
     ENDIF.

     ENDIF.

     ZERO = wa_tab2-Wpmtr .
        ZERO1   =   |{ ZERO ALPHA = OUT }| .

         if zero1 = 0.
         zero2 = ' ' .
         ELSE .
           zero2 = zero1 .
         ENDIF.

         end = wa_tab2-Ends .
        end1   =   |{ end ALPHA = OUT }| .

         if end1 = 0.
         end2 = ' ' .
         ELSE .
           end2 = end1 .
         ENDIF.


       TOTENDS1 = TOTENDS1 + wa_tab2-Ends .
       TOTWpmtr1 = TOTWpmtr1 +  wa_tab2-Wpmtr.

         lv_xml = lv_xml &&

            |<Row1>| &&
            |<SR1>{ C1 }</SR1>| &&
            |<YARNDESC1>{ wa_tab2-Maktx }</YARNDESC1>| &&
            |<WEIGHT1>{ zero2 }</WEIGHT1>| &&
            |<BOX1>{ wa_tab2-p1 }</BOX1>| &&
            |<BOX2>{ wa_tab2-p2 }</BOX2>| &&
            |<BOX3>{ wa_tab2-p3 }</BOX3>| &&
            |<BOX4>{ wa_tab2-p4 }</BOX4>| &&
            |<BOX5>{ wa_tab2-p5 }</BOX5>| &&
            |<BOX6>{ wa_tab2-p6 }</BOX6>| &&
            |<BOX7>{ wa_tab2-p7 }</BOX7>| &&
            |<BOX8>{ wa_tab2-p8 }</BOX8>| &&
            |<BOX9>{ wa_tab2-p9 }</BOX9>| &&
            |<BOX10>{ wa_tab2-p10 }</BOX10>| &&
            |<BOX11>{ wa_tab2-p11 }</BOX11>| &&
            |<BOX12>{ wa_tab2-p12 }</BOX12>| &&
            |<BOX13>{ wa_tab2-p13 }</BOX13>| &&
            |<BOX14>{ wa_tab2-p14 }</BOX14>| &&
            |<BOX15>{ wa_tab2-p15 }</BOX15>| &&
            |<BOX16>{ wa_tab2-p16 }</BOX16>| &&
            |<BOX17>{ wa_tab2-p17 }</BOX17>| &&
            |<BOX18>{ wa_tab2-p18 }</BOX18>| &&
            |<BOX19>{ wa_tab2-p19 }</BOX19>| &&
            |<BOX20ends2>{ end2 }</BOX20ends2>| &&


            |</Row1>| .

             clear : c1,zero,zero1,zero2,end,end1,end2.


   ENDLOOP  .


        lv_xml = lv_xml &&

            |<Row2>| &&
            |<WTTOTAL>{ TOTWpmtr1 }</WTTOTAL>| &&
            |<ENDSTOTAL2>{ TOTENDS1 }</ENDSTOTAL2>| &&
            |</Row2>| &&
            |</Table2>| &&
            |</subTABLE2>| &&
            |<SubTABLE3>| &&
            |<Table3>| &&
            |<HeaderRow/>| .

*******************  WEFTPATTERNTABLE END *******************************


*******************  SELVEFGE START *******************************
   SELECT  * FROM ZPC_SELVEDGE_CDS  WHERE Zpno = @wa_it-a-zpno INTO table @data(tab3) .

   SORT  tab3 BY Zpno Zpmsno .
   DATA TOTDENT2 TYPE P DECIMALS 3 .
   DATA TOTENDS2 TYPE P DECIMALS 3 .
   DATA TOTTOENDS2 TYPE P DECIMALS 3 .
   DATA TOTWeight TYPE P DECIMALS 3 .
   DATA N2 TYPE I .
   DATA C2 TYPE C LENGTH 1 .

  LOOP AT tab3 INTO DATA(WA_TAB3) .


    N2 = N2 + 1.
    IF N2 = 1 .  C2 = 'A' .  ELSEIF N2 = 2 .  C2 = 'B' .
    ELSEIF  N2 = 3 .  C2 = 'C' .  ELSEIF N2 = 4 .  C2 = 'D' .
    ELSEIF   N2 = 5 .  C2 = 'E' .
  ENDIF.


        TOTDENT2 = TOTDENT2 + wa_tab3-Dent .
        TOTENDS2 = TOTENDS2 +  wa_tab3-Ends.
        TOTTOENDS2 = TOTTOENDS2 +  wa_tab3-Totalends.
        TOTWeight = TOTWeight +  WA_TAB3-Wpmtr.

            lv_xml = lv_xml &&


            |<Row1>| &&
            |<SR>{ C2 }</SR>| &&
            |<YARNDEC>{ WA_TAB3-Maktx }</YARNDEC>| &&
            |<count>{ WA_TAB3-Rescnt }</count>| &&
            |<Weave>{ WA_TAB3-Shaft }</Weave>| &&
            |<Dent>{ WA_TAB3-Dent }</Dent>| &&
            |<Ends>{ WA_TAB3-Ends }</Ends>| &&
            |<Multiplier>{ |{ WA_TAB3-Mul ALPHA = OUT }| }</Multiplier>| &&
            |<Repeat>{ WA_TAB3-Repeats }</Repeat>| &&
            |<TENDS>{ WA_TAB3-Totalends }</TENDS>| &&
            |<Weight>{ WA_TAB3-Wpmtr }</Weight>| &&
            |</Row1>| .

  ENDLOOP.
            lv_xml = lv_xml &&


            |<Row2>| &&
            |<TOTALDENT>{ TOTDENT2 }</TOTALDENT>| &&
            |<Ends>{ TOTENDS2 }</Ends>| &&
            |<TOTALTENDS>{ TOTTOENDS2 }</TOTALTENDS>| &&
            |<WeightSEL>{ TOTWeight }</WeightSEL>| &&
            |</Row2>| &&
            |</Table3>| &&
            |</SubTABLE3>| &&
            |<DRAFTWEAVE>| &&
            |<WEAVESUB>| &&
            |<WeaveDRAFTPEG>{ WA_IT-a-Zpweavetype }</WeaveDRAFTPEG>| &&
            |</WEAVESUB>| &&
            |</DRAFTWEAVE>| &&
            |<Subtable5>| &&
            |<DRAFTTABSUB>| &&
            |<Table5>| &&
            |<HeaderRow/>| .

*******************  SELVEFGE ENS *************************************************

***********************************DRAFT AND PEG PLAN TABLE START******************

  DATA  DRAFTpmdesc TYPE C LENGTH 40.
  DATA DRAFTmul TYPE N LENGTH 5 .
  DATA DFRATrepeats TYPE C LENGTH 2.
  DATA PEGpmdesc TYPE C LENGTH 40.
  DATA PEGmul TYPE N LENGTH 5 .
  DATA PEGrepeats TYPE C LENGTH 2.

  SELECT  A~* ,
   @DRAFTpmdesc   AS DRAFTpmdesc,
   @DRAFTmul as DRAFTmul,
   @DFRATrepeats as DFRATrepeats,
   @PEGpmdesc   AS PEGpmdesc,
   @PEGmul as PEGmul,
   @PEGrepeats as PEGrepeats
   FROM ZPC_DRAFTPEGPLAN_CDS  as a WHERE Zpno = @wa_it-a-Zpno INTO table @data(tab4) .

   SORT  tab4 BY A-Zpno A-Zpmsno A-pmgroup.
   DATA NDRAFT TYPE C LENGTH 3 .
   DATA NReapeats TYPE C LENGTH 3 .
   DATA NReapeats1 TYPE C LENGTH 3 .
   DATA MULTLIY  TYPE C LENGTH 3 .
   DATA MULTLI1  TYPE C LENGTH 3 .
   DATA V_TABIX TYPE SY-tabix .

   DATA(IT1)  = tab4[].
   DATA(IT2)   = tab4[] .

   DELETE IT1 WHERE A-Pmgroup = 1 .
   SORT IT1 BY A-Zpno ASCENDING A-zpmsno ASCENDING.
   DELETE tab4 WHERE A-Pmgroup = 2 .
   SORT tab4 BY A-Zpno ASCENDING A-zpmsno ASCENDING.

*   FREE : IT1.
*    DESCRIBE TABLE  tab4 OCCURS DATA(NO) .
 DATA(NO1IT1)   = LINES( IT1 ).
 DATA(NOtab4)   = LINES( tab4 ).

IF NOtab4 LT NO1IT1 .
       NOtab4 = NO1IT1 - NOtab4 .
  DO NOtab4 TIMES .
  APPEND INITIAL LINE TO  tab4 .
  ENDDO.
ENDIF.


DATA WA_IT1 LIKE LINE OF IT1.

    LOOP AT tab4 ASSIGNING FIELD-SYMBOL(<FS>) .
    V_TABIX    = SY-tabix .
   READ TABLE IT1 INTO DATA(WA_DRAFT) INDEX SY-TABIX.
   IF SY-subrc = 0.
    WA_IT1-draftpmdesc  = <FS>-A-Pmdesc .
    WA_IT1-draftmul      = <FS>-A-Mul .
    WA_IT1-dfratrepeats  = <FS>-A-Repeats .

    WA_IT1-PEGpmdesc  = WA_DRAFT-A-Pmdesc .
    WA_IT1-PEGmul      = WA_DRAFT-A-Mul .
    WA_IT1-PEGrepeats  = WA_DRAFT-A-Repeats .

    ENDIF.
    MODIFY tab4 FROM  WA_IT1 INDEX V_TABIX.
   CLEAR : WA_IT1,WA_DRAFT,V_TABIX.
    ENDLOOP.

 FREE IT1[].
  IT1[] = tab4[] .
   DATA MULTI  TYPE C LENGTH 3 .
   DATA MULTI1  TYPE C LENGTH 3 .

LOOP AT IT1 INTO DATA(DERFIT1) .

   MULTLIY  = |{ DERFIT1-draftmul ALPHA = OUT }| .
     IF   MULTLIY = '0' .
      MULTLI1 =  '' .
      ELSE .
      MULTLI1 = MULTLIY .
      ENDIF.

         MULTI  = |{ DERFIT1-pegmul ALPHA = OUT }| .
     IF   MULTI = '0' .
      MULTI1 =  '' .
      ELSE .
      MULTI1 = MULTI .
      ENDIF.
          lv_xml = lv_xml &&

                  |<Row1>| &&
                  |<DRAFT>{ DERFIT1-draftpmdesc }</DRAFT>| &&
                  |<REAPEATS>{ DERFIT1-dfratrepeats }</REAPEATS>| &&
                  |<MULTIPLIER>{ MULTLI1 }</MULTIPLIER>| &&
                  |<PEG>{ DERFIT1-pegpmdesc }</PEG>| &&
                  |<REAPEATSPEG>{ DERFIT1-pegrepeats }</REAPEATSPEG>| &&
                  |<MULTIPLIERPEG>{ MULTI1 }</MULTIPLIERPEG>| &&
                  |</Row1>| .

ENDLOOP.
***********************************DRAFT AND PEG PLAN TABLE END************************

***********************************DRAFT Total Dents AND Ends START********************
DATA text TYPE string.
DATA DRAFTMULTI  TYPE C LENGTH 3 .
 DATA DRAFTMULTI1  TYPE C LENGTH 3 .
 DATA DRAFTRepeats  TYPE C LENGTH 3 .
 DATA(PegIT2)    =  IT2[].
DELETE IT2 WHERE A-Pmgroup <> 1  .

LOOP AT IT2 INTO DATA(WA_TAB4) .
   REPLACE ALL OCCURRENCES OF '-' IN WA_TAB4-A-Pmdesc WITH 'A'.
   TEXT = WA_TAB4-A-Pmdesc.
   FIND ALL OCCURRENCES OF PCRE  'A' IN text IGNORING CASE
   RESULTS DATA(result_tab).

LOOP AT result_tab INTO DATA(result_WA).
    NReapeats = NReapeats + 1.
ENDLOOP.

   IF WA_TAB4-a-Repeats = '['.
    DRAFTRepeats  =  WA_TAB4-a-Repeats.
    DRAFTMULTI  = |{ WA_TAB4-a-Mul ALPHA = OUT }| .
     IF   DRAFTMULTI = '0' .
      DRAFTMULTI1 =  '1' .
      ELSE .
      DRAFTMULTI1 = DRAFTMULTI .
      ENDIF.

   ELSEIF WA_TAB4-a-Repeats = '[]'.
    DRAFTRepeats  =  WA_TAB4-a-Repeats.
    DRAFTMULTI  = |{ WA_TAB4-a-Mul ALPHA = OUT }| .
     IF   DRAFTMULTI = '0' .
      DRAFTMULTI1 =  '1' .
      ELSE .
      DRAFTMULTI1 = DRAFTMULTI .
      ENDIF.

   ENDIF.

   IF DRAFTRepeats = '[' OR DRAFTRepeats = '[]'  .
    NDRAFT = NDRAFT + 1 * DRAFTMULTI1.
   NReapeats1 = NReapeats1 + ( NReapeats + 1 ) * DRAFTMULTI1 .
ENDIF.

  IF WA_TAB4-a-Repeats = ']' OR DRAFTRepeats = '[]' .
 CLEAR: DRAFTMULTI1 ,DRAFTMULTI1,DRAFTRepeats.
  ENDIF.

   IF DRAFTRepeats = ' ' AND WA_TAB4-a-Repeats <> ']' AND WA_TAB4-a-Repeats = ' '.
    NDRAFT = NDRAFT + 1 .
   NReapeats1 = NReapeats1 +  NReapeats + 1 .
ENDIF.

    CLEAR : NReapeats, result_WA .

ENDLOOP.

***********************************DRAFT Total Dents AND Ends END***********************

***********************************PEG Total RepeatPick START***********************
DELETE PegIT2 WHERE A-Pmgroup <> 2 .
DATA PEGMULTI  TYPE C LENGTH 3 .
DATA PEGMULTI1  TYPE C LENGTH 3 .
DATA PEGRepeatsPick  TYPE C LENGTH 3  .
DATA NPeg TYPE C LENGTH 3 .

LOOP AT PegIT2 INTO DATA(WA_PEGIT2) .

   IF WA_PEGIT2-a-Repeats = '['.
    PEGRepeatsPick  =  WA_PEGIT2-a-Repeats.

    PEGMULTI  = |{ WA_PEGIT2-a-Mul ALPHA = OUT }| .

     IF   PEGMULTI = '0' .
      PEGMULTI1 =  '1' .
      ELSE .
      PEGMULTI1 = PEGMULTI .
      ENDIF.

   ELSEIF WA_PEGIT2-a-Repeats = '[]'.

    PEGRepeatsPick  =  WA_PEGIT2-a-Repeats.

    PEGMULTI  = |{ WA_PEGIT2-a-Mul ALPHA = OUT }| .

     IF   PEGMULTI = '0' .
      PEGMULTI1 =  '1' .
      ELSE .
      PEGMULTI1 = PEGMULTI .
      ENDIF.

   ENDIF.
   IF PEGRepeatsPick = '[' OR PEGRepeatsPick = '[]'  .
    NPeg = NPeg + 1 * PEGMULTI1.


ENDIF.
  IF WA_PEGIT2-a-Repeats = ']' OR PEGRepeatsPick = '[]' .

 CLEAR: PEGMULTI1 ,PEGMULTI1,PEGRepeatsPick.
  ENDIF.

   IF PEGRepeatsPick = ' ' AND WA_PEGIT2-a-Repeats <> ']' AND WA_PEGIT2-a-Repeats = ' '.

    NPeg =  NPeg + 1 .

ENDIF.
    CLEAR : NReapeats .

ENDLOOP.




***********************************PEG Total RepeatPick END*************************


           lv_xml = lv_xml &&

*            |</Table5PEG>| &&
*            |</PEGTABSUB>| &&
             |</Table5>| &&
             |</DRAFTTABSUB>| &&
             |</Subtable5>| &&
*            |</Page2>| &&
*            |<PAGE3>| &&
            |<Subform7>| &&
            |<Subform8>| &&
            |<RepeatPick>{ NPeg }</RepeatPick>| &&
            |<DraftEnds>{ NReapeats1 }</DraftEnds>| &&
            |</Subform8>| &&
            |<Subform9>| &&
            |<Dents>{ NDRAFT }</Dents>| &&
            |</Subform9>| &&
            |</Subform7>| &&
            |</PAGE1>| &&
            |</form1>| .

  CALL METHOD ycl_test_adobe=>getpdf(
       EXPORTING
         xmldata  = LV_XML
         template = template
       RECEIVING
         result   = result12 ).

 ENDMETHOD.
ENDCLASS.
