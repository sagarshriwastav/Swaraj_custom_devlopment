CLASS zpp_loomcard_print_class DEFINITION
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
                   beamno type string
                   orderno  type  CHAR12
                  radiobutton  type  string

        RETURNING VALUE(result12) TYPE string
        RAISING   cx_static_check .

  PROTECTED SECTION.
  PRIVATE SECTION.


    CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
    CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
    CONSTANTS  lv2_url    TYPE string VALUE 'https://btp-yvzjjpaz.authentication.eu10.hana.ondemand.com/oauth/token' .
    CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
*    CONSTANTS lc_template_name TYPE string VALUE 'LoomCard_Print_PP/LoomCard_Print_PP'.


ENDCLASS.



CLASS ZPP_LOOMCARD_PRINT_CLASS IMPLEMENTATION.


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
     template = 'LoomCardLANDSCAP/LoomCardLANDSCAP' .
    ELSEIF radiobutton = 'Potrait'.
    template   =   'LoomCard_Print_PP/LoomCard_Print_PP' .
    ENDIF.

IF beamno IS NOT INITIAL AND orderno IS NOT INITIAL .

    SELECT * FROM I_ManufacturingOrderItem as a
            INNER JOIN I_ProductDescription as f ON ( f~Product = a~Product AND f~Language = 'E' )
           INNER JOIN I_ManufacturingOrder as b ON ( b~ManufacturingOrder = a~ManufacturingOrder )
           LEFT JOIN I_SalesDocument as c ON ( c~SalesDocument = a~SalesOrder )
           LEFT JOIN I_Customer as d ON ( d~Customer = c~SoldToParty )
           LEFT OUTER JOIN ZPC_HEADERMASTER_CDS as e ON ( e~Zpno = b~YY1_MasterNumber_ORD )
           LEFT OUTER JOIN I_SalesDocumentItem as g ON ( g~OriginSDDocument = A~SalesOrder AND g~OriginSDDocumentItem = a~SalesOrderItem
                                                         AND g~SDDocumentCategory = 'C' )
            WHERE a~Batch = @beamno AND a~ManufacturingOrder = @orderno
                             INTO TABLE @DATA(IT) .

 ELSEIF  beamno IS NOT INITIAL .

 SELECT * FROM I_ManufacturingOrderItem as a
         INNER JOIN I_ProductDescription as f ON ( f~Product = a~Product AND f~Language = 'E' )
           INNER JOIN I_ManufacturingOrder as b ON ( b~ManufacturingOrder = a~ManufacturingOrder )
           LEFT JOIN I_SalesDocument as c ON ( c~SalesDocument = a~SalesOrder )
           LEFT JOIN I_Customer as d ON ( d~Customer = c~SoldToParty )
           LEFT OUTER JOIN ZPC_HEADERMASTER_CDS as e ON ( e~Zpno = b~YY1_MasterNumber_ORD )
           LEFT OUTER JOIN I_SalesDocumentItem as g ON ( g~OriginSDDocument = A~SalesOrder AND g~OriginSDDocumentItem = a~SalesOrderItem
                                             AND g~SDDocumentCategory = 'C'  )
            WHERE a~Batch = @beamno
                             INTO TABLE @IT .

 ENDIF.
    READ TABLE IT INTO DATA(WA_IT) INDEX 1.

     SELECT SINGLE dyeindesc FROM ZPP_DYEING_SHADE_TMG WHERE Dyeingshade = @wa_it-e-Zpdytype INTO @DAta(dyeinds) .
     DATA DENTLE TYPE  P DECIMALS 0 .
       DENTLE  = WA_IT-E-Zdent .

       IF dyeinds = '' .
       DYINGDESCC  = wa_it-e-Zpdytype .
       ELSE .
       DYINGDESCC = dyeinds .
       ENDIF.


   IF WA_IT-a-PlanningPlant = '2100' OR WA_IT-a-PlanningPlant = '2200'  .

   DATA(PLANTADD)   =   'MODWAY SUITING PRIVATE LTD.' .
   ELSE .

    PLANTADD  =  'SWARAJ SUITING LTD.' .

   ENDIF.

   IF WA_IT-a-PlanningPlant = '1300' .

   DATA(PICK)  =  WA_IT-b-YY1_Pick_ORD - 2 .

   ELSE .

   PICK  =  WA_IT-b-YY1_Pick_ORD .

   ENDIF.

    lv_xml =

         |<form1>| &&
         |<PAGE1>| &&
         |<Subform1>| &&
         |<LOOMTYPE>{ WA_IT-e-Ploom }</LOOMTYPE>| &&
         |<LOOMNo>{ WA_IT-B-YY1_LoomNumber_ORD }</LOOMNo>| &&
         |<warpno>{ SY-datum+0(4) }-{ SY-datum+4(2) }-{ SY-datum+6(2) }</warpno>| &&
         |<PlantAddres>{ PLANTADD }</PlantAddres>| &&
         |</Subform1>| &&
         |<Subform2>| &&
         |<Subform3>| &&
         |<Mastercardno>{ WA_IT-B-YY1_MasterNumber_ORD }</Mastercardno>| &&
         |<saleorder>{ |{ WA_IT-A-SalesOrder ALPHA = OUT }| }/{ |{ WA_IT-a-SalesOrderItem ALPHA = OUT }| }</saleorder>| &&
         |<REEDDENT>{ |{ WA_IT-e-Zpreed1 ALPHA = OUT }| }/{ DENTLE }</REEDDENT>| &&
         |<PICKS>{ PICK }</PICKS>| &&
         |<REEDSPACE>{  WA_IT-E-Zpreedspace }</REEDSPACE>| &&
         |<GREYWT>{ wa_IT-e-ztowtpermtr }</GREYWT>| &&
         |<EPI>{ WA_IT-e-Zpepi }</EPI>| &&
         |<Flengeno>{ WA_IT-B-YY1_PartyBeam_ORD }</Flengeno>| &&
         |</Subform3>| &&
         |<Subform4>| &&
         |<quality>{ WA_IT-F-ProductDescription }</quality>| &&
         |<CUSTOMER>{ WA_IT-d-CustomerName }</CUSTOMER>| &&
         |<PARTYREF></PARTYREF>| &&
         |<Dyeingsort>{ WA_IT-e-DyeSort }</Dyeingsort>| &&
         |<DyeingShade>{ DYINGDESCC }</DyeingShade>| &&
         |<FINISHWIDTH>{ WA_IT-E-Plength }</FINISHWIDTH>| &&
         |<PONO>{ |{ WA_IT-A-ManufacturingOrder ALPHA = OUT }| }</PONO>| &&
         |</Subform4>| &&
         |<Subform5>| &&
         |<BEAMNO>{ beamno }</BEAMNO>| &&
         |<POLENGTH>{ WA_IT-A-MfgOrderItemPlannedTotalQty }</POLENGTH>| &&
         |<WARPINGLENGTH>{ WA_IT-A-MfgOrderItemPlannedTotalQty }</WARPINGLENGTH>| &&
         |<BODYENDS>{ WA_IT-E-Bodyends }</BODYENDS>| &&
         |<SLEVEDGEENDS>{ WA_IT-E-selvedgeends }</SLEVEDGEENDS>| &&
         |<TOTALENDS>{ WA_IT-E-Zptotends }</TOTALENDS>| &&
         |<SETCODENO>{ WA_IT-B-YY1_SetNo_ORD }</SETCODENO>| &&
         |</Subform5>| &&
         |</Subform2>| &&
         |<Subform6>| &&
         |<selvege>{ WA_IT-g-MaterialByCustomer }</selvege>| &&
         |<WEAVINGINSTRUCTION>{ WA_IT-e-weavingreamrk }</WEAVINGINSTRUCTION>| &&
         |</Subform6>| &&
         |<TEXT/>| &&
         |<SubTABLE>| &&
         |<Table1>| &&
         |<HeaderRow/>| .


     SELECT  * FROM zpc_warppattern_cds  WHERE Zpno = @wa_it-b-YY1_MasterNumber_ORD INTO table @data(tab1) .

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
*******************  WARPPATTERNTABLE START*******************************
 DATA(I_WARPREP222)  = WARPtab1[] .
 FREE:WARPtab1[].

 LOOP AT I_WARPREP222 ASSIGNING FIELD-SYMBOL(<wa_tab1>) WHERE Pattern = '1' AND  Maktx <> ''  .

    APPEND <wa_tab1> TO WARPtab1 .
   if <wa_tab1>-Maktx <> 'M1' AND <wa_tab1>-Maktx <> 'R1' AND <wa_tab1>-Maktx <> 'M2' AND <wa_tab1>-Maktx <> 'R2' .
   APPEND INITIAL LINE TO WARPtab1.
   ENDIF.

 ENDLOOP.

 LOOP AT WARPtab1 INTO data(wa_tab1)  .

     if wa_tab1-Maktx <> 'M1' AND wa_tab1-Maktx <> 'R1' AND wa_tab1-Maktx <> 'M2' AND wa_tab1-Maktx <> 'R2'  AND wa_tab1-Maktx <> ' '.

          N = N + 1.
         IF N = 1 .  C = 'A' .       ELSEIF N = 2 .  C = 'B' .
         ELSEIF  N = 3 .  C = 'C' .  ELSEIF N = 4 .  C = 'D' .
         ELSEIF   N = 5 .  C = 'E' .
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
            |<ENDS>{ end2 }</ENDS>| &&
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
            |<BOX20>{ wa_tab1-p20 }</BOX20>| &&

            |</Row1>| .

           clear : c,zero,zero1,zero2,end,end1,end2.



   ENDLOOP .

     lv_xml = lv_xml &&

            |<Row2>| &&
            |<ENDTOTAL>{ TOTENDS }</ENDTOTAL>| &&
            |<WEIGHTTOTAL>{ TOTWpmtr }</WEIGHTTOTAL>| &&
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

 DATA(WEFT333)  = WEFTTAB[] .
 FREE : WEFTTAB[] .


  LOOP AT WEFT333 ASSIGNING FIELD-SYMBOL(<GS_tab2>) WHERE Pattern = '2' AND Maktx <> '' .

   APPEND <GS_tab2> TO WEFTTAB .
   if <GS_tab2>-Maktx <> 'M1' AND <GS_tab2>-Maktx <> 'R1' AND <GS_tab2>-Maktx <> 'M2' AND <GS_tab2>-Maktx <> 'R2' .
   APPEND INITIAL LINE TO WEFTTAB.
   ENDIF.

 ENDLOOP.


LOOP AT WEFTTAB INTO data(wa_tab2)  .
     if wa_tab2-Maktx <> 'M1' AND wa_tab2-Maktx <> 'R1' AND wa_tab2-Maktx <> 'M2' AND wa_tab2-Maktx <> 'R2' AND wa_tab2-Maktx <> ' ' .
     N1 = N1 + 1.
     IF N1 = 1 .  C1 = 'A' .
     ELSEIF N1 = 2 .  C1 = 'B' . ELSEIF  N1 = 3 .  C1 = 'C' .
     ELSEIF N1 = 4 .  C1 = 'D' . ELSEIF   N1 = 5 .  C1 = 'E' .
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
            |<ENDS1>{ End2 }</ENDS1>| &&
            |<WEIGHT1>{ ZERO2 }</WEIGHT1>| &&
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
            |<BOX20>{ wa_tab2-p20 }</BOX20>| &&

            |</Row1>| .

            clear : c1,zero,zero1,zero2,end,end1,end2.

   ENDLOOP  .


        lv_xml = lv_xml &&

            |<Row2>| &&
            |<ENDSTOTAL>{ TOTENDS1 }</ENDSTOTAL>| &&
            |<WTTOTAL>{ TOTWpmtr1 }</WTTOTAL>| &&
            |</Row2>| &&
            |</Table2>| &&
            |</subTABLE2>| &&
            |<SubTABLE3>| &&
            |<Table3>| &&
            |<HeaderRow/>| .
*******************  WEFTPATTERNTABLE END *******************************


*******************  SELVEFGE START *******************************
   SELECT  * FROM ZPC_SELVEDGE_CDS  WHERE Zpno = @wa_it-b-YY1_MasterNumber_ORD INTO table @data(tab3) .

   SORT  tab3 BY Zpno Zpmsno .
   DATA TOTDENT2 TYPE P DECIMALS 3 .
   DATA TOTENDS2 TYPE P DECIMALS 3 .
   DATA TOTTOENDS2 TYPE P DECIMALS 3 .
   DATA TOTWeight TYPE P DECIMALS 3 .
   DATA N2 TYPE I .
   DATA C2 TYPE C LENGTH 1 .



   DATA(SELVTAB) = tab3[] .
   FREE : tab3[] .


  LOOP AT SELVTAB ASSIGNING FIELD-SYMBOL(<GS_tab3>) . "WHERE Pattern = '2' AND Maktx <> '' .

   APPEND <GS_tab3> TO tab3 .

   APPEND INITIAL LINE TO tab3.


 ENDLOOP.




  LOOP AT tab3 INTO DATA(WA_TAB3) .

  IF WA_TAB3-Maktx <> '' .

    N2 = N2 + 1.




    IF N2 = 1 .  C2 = 'A' .  ELSEIF N2 = 2 .  C2 = 'B' .
    ELSEIF  N2 = 3 .  C2 = 'C' .  ELSEIF N2 = 4 .  C2 = 'D' .
    ELSEIF   N2 = 5 .  C2 = 'E' .
  ENDIF.

ENDIF.


        TOTDENT2 = TOTDENT2 + wa_tab3-Dent .
        TOTENDS2 = TOTENDS2 +  wa_tab3-Ends.
        TOTTOENDS2 = TOTTOENDS2 +  wa_tab3-Totalends.
        TOTWeight = TOTWeight +  WA_TAB3-Wpmtr.

            lv_xml = lv_xml &&


            |<Row1>| &&
            |<SR>{ C2 }</SR>| &&
            |<YARNDEC>{ WA_TAB3-Maktx }</YARNDEC>| &&
            |<count>{ wa_tab3-Rescnt }</count>| &&
            |<Weave>{ WA_TAB3-Shaft }</Weave>| &&
            |<Dent>{ WA_TAB3-Dent }</Dent>| &&
            |<Ends>{ WA_TAB3-Ends }</Ends>| &&
            |<Multiplier>{ |{ WA_TAB3-Mul ALPHA = OUT }| }</Multiplier>| &&
            |<Repeat>{ wa_tab3-Repeats }</Repeat>| &&
            |<TENDS>{ WA_TAB3-Totalends }</TENDS>| &&
            |<Weight>{ WA_TAB3-Wpmtr }</Weight>| &&
            |</Row1>| .

    clear : C2.
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
            |<WeaveDRAFTPEG>{ WA_IT-E-Zpweavetype }</WeaveDRAFTPEG>| &&
            |</WEAVESUB>| &&
            |</DRAFTWEAVE>| &&
            |<Subtable5>| &&
            |<DRAFTTABSUB>| &&
            |<Table5>| &&
            |<HeaderRow/>| .

*******************  SELVEFGE ENS *******************************



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
   FROM ZPC_DRAFTPEGPLAN_CDS  as a WHERE Zpno = @wa_it-B-YY1_MasterNumber_ORD INTO table @data(tab4) .

   SORT  tab4 BY A-Zpno A-Zpmsno A-pmgroup.
   DATA NDRAFT TYPE C LENGTH 3 .
   DATA NPeg TYPE C LENGTH 3 .
   DATA NReapeats TYPE C LENGTH 3 .
   DATA NReapeats1 TYPE C LENGTH 3 .
   DATA MULTLIY  TYPE C LENGTH 3 .
   DATA MULTLI1  TYPE C LENGTH 3 .
   DATA V_TABIX TYPE SY-tabix .

   DATA(IT1)  = tab4[].
   DATA(IT2)   = tab4[] .
   DELETE IT1 WHERE A-Pmgroup = 1 .
    SORT IT1 BY A-Zpno  ASCENDING A-zpmsno ASCENDING..
   DELETE tab4 WHERE A-Pmgroup = 2 .
    SORT tab4 BY A-Zpno  ASCENDING A-zpmsno ASCENDING.

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

     NPeg  = NPeg + 1.
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

DATA: moff TYPE i,
      mlen TYPE i.
DATA text TYPE string.

*     DATA(IT3)  = tab4[].


LOOP AT IT2 INTO DATA(WA_TAB4)  WHERE a-pmgroup = '1'.

   REPLACE ALL OCCURRENCES OF '-' IN WA_TAB4-A-Pmdesc WITH 'A'.

   TEXT = WA_TAB4-A-Pmdesc.
   FIND ALL OCCURRENCES OF PCRE  'A' IN text IGNORING CASE
   RESULTS DATA(result_tab).

LOOP AT result_tab INTO DATA(result_WA).

    NReapeats = NReapeats + 1.

ENDLOOP.
    NDRAFT = NDRAFT + 1 .

    NReapeats1 = NReapeats1 + NReapeats + 1.
    CLEAR : NReapeats, result_WA .

ENDLOOP.


           lv_xml = lv_xml &&
             |</Table5>| &&
         |</DRAFTTABSUB>| &&
      |</Subtable5>| &&
            |<Subform7>| &&
            |<Subform8>| &&
            |<Dents>{ NDRAFT }</Dents>| &&
            |<DraftEnds>{ NReapeats1 }</DraftEnds>| &&
            |</Subform8>| &&
            |<Subform9>| &&
            |<RepeatPick>{ NPeg }</RepeatPick>| &&
            |</Subform9>| &&
*            |</Subform7>| &&
            |<TABLE4>| &&
            |<Table4>| &&
            |<HeaderRow/>| .

  SELECT  * FROM I_MfgOrderOperationComponent
                  WHERE ManufacturingOrder = @wa_it-b-ManufacturingOrder INTO table @data(tab5) .

  SORT tab5 BY  ReservationItem  .

 LOOP AT tab5 INTO DATA(WA_TAB6) .
     SELECT SINGLE ProductDescription FROM  I_ProductDescription WHERE Product = @WA_TAB6-Material and Language = 'E' INTO @DATA(DEC) .

   IF SY-SYSID = 'XMV'.

     SELECT SINGLE a~ClfnObjectInternalID ,c~CharcValue, H~CharcValueDescription FROM I_BatchDistinct as a
             LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as c on ( c~ClassType = '023' and c~ClfnObjectTable = 'MCH1'
             and c~ClfnObjectInternalID = a~ClfnObjectInternalID and c~CharcInternalID = '0000000819' )
             LEFT OUTER JOIN ZI_ClfnCharcValueDesc_cds as h on ( h~mil = c~CharcValue and h~CharcInternalID = '0000000819' and h~Language = 'E' )
             WHERE ( a~Batch = @WA_TAB6-Batch and a~Material = @WA_TAB6-Material )   into @DATA(mil).

        SELECT SINGLE a~ClfnObjectInternalID , c~CharcValue  FROM I_BatchDistinct as a
                LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as c on ( c~ClassType = '023' and c~ClfnObjectTable = 'MCH1'
                and c~ClfnObjectInternalID = a~ClfnObjectInternalID and c~CharcInternalID = '0000000818' )
                WHERE ( a~Batch = @WA_TAB6-Batch and a~Material = @WA_TAB6-Material )  into @DATA(LOT).
   ELSE.

             SELECT SINGLE a~ClfnObjectInternalID ,c~CharcValue, H~CharcValueDescription FROM I_BatchDistinct as a
             LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as c on ( c~ClassType = '023' and c~ClfnObjectTable = 'MCH1'
             and c~ClfnObjectInternalID = a~ClfnObjectInternalID and c~CharcInternalID = '0000000807' )
             LEFT OUTER JOIN ZI_ClfnCharcValueDesc_cds as h on ( h~mil = c~CharcValue and h~CharcInternalID = '0000000807' and h~Language = 'E' )
             WHERE ( a~Batch = @WA_TAB6-Batch and a~Material = @WA_TAB6-Material )   into @mil.

        SELECT SINGLE a~ClfnObjectInternalID , c~CharcValue  FROM I_BatchDistinct as a
                LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as c on ( c~ClassType = '023' and c~ClfnObjectTable = 'MCH1'
                and c~ClfnObjectInternalID = a~ClfnObjectInternalID and c~CharcInternalID = '0000000806' )
                WHERE ( a~Batch = @WA_TAB6-Batch and a~Material = @WA_TAB6-Material )  into @LOT.

 ENDIF.


            lv_xml = lv_xml &&

            |<Row1>| &&
            |<MATDESC>{ DEC }</MATDESC>| &&
            |<REQQYT>{ WA_TAB6-RequiredQuantity }</REQQYT>| &&
            |<BATCH>{ |{ WA_TAB6-Batch ALPHA = OUT }| }</BATCH>| &&
            |<millname>{ MIL-CharcValueDescription }</millname>| &&
            |<LotNo>{ LOT-CharcValue }</LotNo>| &&
            |</Row1>| .

CLEAR : MIL,LOT.
ENDLOOP.

            lv_xml = lv_xml &&

            |</Table4>| &&
            |</TABLE4>| &&
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
