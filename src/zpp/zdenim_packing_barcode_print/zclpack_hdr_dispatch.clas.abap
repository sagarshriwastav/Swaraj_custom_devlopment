CLASS zclpack_hdr_dispatch DEFINITION
 PUBLIC
  FINAL
  CREATE PUBLIC .

********************CREATED GAJENDRA SINGH SHEKHAWAT*************************************************************

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .




     CLASS-DATA : access_token TYPE string .
    CLASS-DATA : xml_file TYPE string .
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
                   plant type string
                   date  type  string
                   date1  type  string
                   material type matnr
                   material1 type matnr
                   rollno type string
                   rollno1 type string
                   foliono TYPE string
                   foliono1 TYPE string
                   grade TYPE string
                   grade1 TYPE string
                   materialdocno TYPE string
                   materialdocno1 TYPE string
                   partysort1 TYPE string
                   dispatch TYPE string

        RETURNING VALUE(result12) TYPE string
        RAISING   cx_static_check .

  PROTECTED SECTION.
  PRIVATE SECTION.


    CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
    CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
    CONSTANTS  lv2_url    TYPE string VALUE 'https://btp-yvzjjpaz.authentication.eu10.hana.ondemand.com/oauth/token' .
    CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
**    CONSTANTS lc_template_name TYPE string VALUE 'BarcodePP/BarcodePP'.
    CONSTANTS lc_template_name TYPE string VALUE 'DispatchBarcodeSticker/DispatchBarcodeSticker'.


ENDCLASS.



CLASS ZCLPACK_HDR_DISPATCH IMPLEMENTATION.


METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).

  ENDMETHOD .


 METHOD if_oo_adt_classrun~main.

*DATA(TEST)  = READ_POSTS( plant = '1200'  date = '23-05-2023' material = 'FFO00090904' rollno = '011000001' foliono = '3829' grade = 'DM' materialDocno = '4900000125')  .

 ENDMETHOD.


  method read_posts .

    DATA date2 TYPE string.
    DATA gv1 TYPE string .
    DATA gv2 TYPE string .
    DATA gv3 TYPE string .

if date2  is not INITIAL.

    gv3 = date+6(4)  .
    gv2 = date+3(2)  .
    gv1 = date+0(2)  .

    CONCATENATE gv3 gv2 gv1 INTO date2.

    DATA date3 TYPE string.
    DATA gv4 TYPE string .
    DATA gv5 TYPE string .
    DATA gv6 TYPE string .

    gv6 = date1+6(4)  .
    gv5 = date1+3(2)  .
    gv4 = date1+0(2)  .

    CONCATENATE gv6 gv5 gv4 INTO date3.

*(to_date(DATE2'DD/MM/YYYY') 'YYYY') ||  '-' ||  Get_Date_Part(to_date(DATE2 'DD/MM/YYYY') 'MM')  || '-' ||  Get_Date_Part(to_date(DATE2'DD/MM/YYYY') 'DD').

*
*data    : s_date TYPE RANGE OF zpackhdr-document_date.
*DATA : W_SEL TYPE s_date.
*data    : s_date1 TYPE TABLE of RSDSSELOPT  .


*          if date2 is NOT INITIAL.
*          w_sel-sign = 'I'.
*          W_SEL-OPTION = 'EQ'.
*          W_SEL-LOW = date2.
*          APPEND W_SEL TO DATE2.
*          endif.

*

   select * from  ZPACK_HDR_DEF
   where plant = @plant and
**       PostingDate GE @date2 and PostingDate LE @date3 and
       ( PostingDate BETWEEN  @date2 and @date3  ) and
**       ( MaterialNumber GE @material AND MaterialNumber LE @material1 ) and
       ( MaterialNumber BETWEEN @material AND  @material1 ) and
**       ( RecBatch GE @rollno and RecBatch LE @rollno1 ) and
       ( RecBatch BETWEEN @rollno and @rollno1 ) and
**       ( FolioNumber GE @foliono and FolioNumber LE @foliono1 ) and
       ( FolioNumber BETWEEN @foliono and @foliono1 ) and
**       ( PackGrade GE @grade and PackGrade LE @grade1 ) and
       ( PackGrade BETWEEN @grade and @grade1 ) and
**       ( mat_doc GE @materialdocno and  mat_doc LE @materialdocno1 )
       ( MatDoc BETWEEN @materialdocno and @materialdocno1 )
       into table @data(it) .

*    select  * from ZPACK_HDR_DEF
* where plant = @plant and PostingDate in @s_date INto @data(lt_zpack).
*
*******************************************************************************************************

select * from  ZPACK_HDR_DEF
 where plant = @plant and
       PostingDate BETWEEN  @date2 and @date3  into table @it .

endif.

if material is not INITIAL.
select * from  ZPACK_HDR_DEF
 where plant = @plant and
       MaterialNumber BETWEEN @material AND  @material1
       into table @it .
endif.

if foliono is not INITIAL.
select * from  ZPACK_HDR_DEF
 where plant = @plant and
       FolioNumber BETWEEN @foliono and @foliono1
        into table @it .

endif.

if rollno is not INITIAL.
select * from  ZPACK_HDR_DEF
 where plant = @plant and
       RecBatch BETWEEN @rollno and @rollno1
       into table @it .

endif.

if grade is not INITIAL.
select * from  ZPACK_HDR_DEF
 where plant = @plant and
       FolioNumber BETWEEN @foliono and @foliono1
       into table @it .

endif.

if materialdocno is not INITIAL.
select * from  ZPACK_HDR_DEF
 where plant = @plant and
       MatDoc BETWEEN @materialdocno and @materialdocno1
       into table @it .

endif.

DELETE ADJACENT DUPLICATES FROM it COMPARING all FIELDS.


      data xsml type string .
      data sortnumber type string .
      data roundoff1 type P DECIMALS 2 .
      data roundoff2 type int2 .
      data roundoff5 type int2 .
      data roundoff6 type int2 .
      data roundoff3 type P DECIMALS 2 .
      data roundoff4 type P DECIMALS 2 .
      data DPTTOT type P DECIMALS 2 .
      data DPTTOT2 type P DECIMALS 2 .
      data DPTTOT3 type P DECIMALS 2 .

      data rolmul type P DECIMALS 2 .

 DATA(lv_xml) =   |<form1>|.


loop at it into data(wa).

* SELECT SINGLE SUM( roll_length ) as ZRoolLenth  FROM zpackhdr_d  WHERE rec_batch = @wa-RecBatch INTO @DATA(ZRoolLenth).
SELECT SINGLE dyeingshade FROM zpp_sortmaster  WHERE material = @WA-MaterialNumber INTO @DATA(SHadeno).
SELECT SINGLE Zdesc FROM zweav_grad_tab WHERE  grade = @wa-PackGrade INTO @DATA(GRAD) .

 SELECT SINGLE C~MaterialByCustomer  FROM ZPP_MATERIALDOCUMENTITEM as a
  LEFT OUTER JOIN I_MaterialDocumentItem_2 as b ON ( b~MaterialDocument = a~Materialdocumentno AND b~MaterialDocumentYear = a~Materialdocumentyear
                                                    AND b~DebitCreditCode = 'H' AND b~Material = a~Material AND b~Batch = a~Batch )
  LEFT OUTER  JOIN  I_SalesDocumentItem  as c ON ( C~SalesDocument = b~SalesOrder AND c~SalesDocumentItem = b~SalesOrderItem )
  WHERE a~Batch = @WA-RecBatch AND a~Material = @WA-MaterialNumber  INTO  @DATA(materrr).

IF  PLANT = '1210' .

  SELECT SINGLE C~MaterialByCustomer  FROM ZPP_MATERIALDOCUMENTITEM as a
  LEFT OUTER JOIN I_MaterialDocumentItem_2 as b ON ( b~MaterialDocument = a~Materialdocumentno  AND b~MaterialDocumentYear = a~Materialdocumentyear
                                                            AND b~Material = a~Material AND b~Batch = a~Batch AND b~SalesOrder IS NOT INITIAL )
  LEFT OUTER  JOIN  I_SalesDocumentItem  as c ON ( C~SalesDocument = b~SalesOrder AND c~SalesDocumentItem = b~SalesOrderItem )
  WHERE a~Batch = @WA-RecBatch AND a~Material = @WA-MaterialNumber AND a~Plant = '1210' INTO  @materrr.

 ENDIF.

 if materrr IS INITIAL.

SELECT SINGLE MaterialByCustomer  FROM I_SalesDocumentItem  WHERE SalesDocument =  @wa-SalesOrder  AND SalesDocumentItem =  @wa-SoItem INTO @materrr .


 ENDIF.

   if partysort1 is not INITIAL or dispatch is not INITIAl .

     sortnumber = materrr .

   ELSE .

   sortnumber =  |{ wa-MaterialNumber+3 ALPHA = OUT }|.
**   IF dispatch is not INITIAL.
**   endif.
   ENDIF.


  rolmul = wa-RollLength * '1.094'   .

  roundoff1 = wa-RollLength .
  roundoff2 = wa-FinishWidth .
  roundoff3 = wa-NetWeight .
  roundoff4 = wa-GrossWeight .
  roundoff5 = wa-Totalpoint .
  roundoff6 = wa-Point4 .
  DPTTOT =   ( wa-Totalpoint * 36 ) * 100    .
  DPTTOT2 = rolmul * wa-FinishWidth .
  DPTTOT3 = DPTTOT / DPTTOT2 .
   DATA(lv_xml2) =


  |<Subform1>| &&
   |<TEXTSUBFORM/>| &&
   |<IMAGESUBFORM/>| &&
   |<BARCODESUBFORM/>| &&
   |<Code128BarCode1>{ wa-RecBatch }</Code128BarCode1>| &&
   |<ROLLSUBFORM>| &&
     |<ROLLNO>{ wa-RecBatch }</ROLLNO>| &&
   |</ROLLSUBFORM>| &&
   |<SORTSUBFORM>| &&
     |<SORTNO>{ sortnumber }</SORTNO>| &&
   |</SORTSUBFORM>| &&
   |<MTRSUBFORM>| &&
     |<MTR>{ roundoff1 }</MTR>| &&
   |</MTRSUBFORM>| &&
   |<WIDTHSUBFORM>| &&
     |<WIDTH>{ roundoff2 } Inch</WIDTH>| &&
   |</WIDTHSUBFORM>| &&
   |<YARDSUBFORM>| &&
     |<YARD>{ rolmul }</YARD>| &&
   |</YARDSUBFORM>| &&
   |<NETWTSUBFORM>| &&
     |<NETWT>{ roundoff3 } Kg</NETWT>| &&
   |</NETWTSUBFORM>| &&
   |<PIECESUBFORM>| &&
     |<PIECENO>{ WA-NoOfTp }</PIECENO>| &&
   |</PIECESUBFORM>| &&
   |<GRSWTSUBFORM>| &&
     |<GRSWT>{ roundoff4 } Kg</GRSWT>| &&
   |</GRSWTSUBFORM>| &&
   |<SHADESUBFORM>| &&
     |<SHADE>{ shadeno }</SHADE>| &&
   |</SHADESUBFORM>| &&
   |<PTSUBFORM>| &&
     |<PTDEF>{ roundoff6 }</PTDEF>| &&
   |</PTSUBFORM>| &&
   |<GRADESUBFORM>| &&
     |<GRADE>{ grad }</GRADE>| &&
   |</GRADESUBFORM>| &&
   |<TOTDPTSUBFORM>| &&
     |<TOTDPT>{ roundoff5 }</TOTDPT>| &&
   |</TOTDPTSUBFORM>| &&
   |<DPTSUBFORM>| &&
     |<DPT100SQYD>{ DPTTOT3 }</DPT100SQYD>| &&
   |</DPTSUBFORM>| &&
  |</Subform1>| .


 CONCATENATE xsml lv_xml2 into xsml .
 clear : roundoff1 ,roundoff2 ,roundoff3 ,roundoff4 , DPTTOT , DPTTOT2 , DPTTOT3 , rolmul , WA , roundoff5 , roundoff6 .



ENDLOOP .

data(lv_xml3) = |</form1>|.

 CONCATENATE lv_xml xsml lv_xml3 into lv_xml .

   CALL METHOD ycl_test_adobe=>getpdf(
       EXPORTING
         xmldata  = LV_XML
         template = lc_template_name
       RECEIVING
         result   = result12 ).

  DATA  WYPO1 TYPE      YP01 .

  IF result12 NE 'ERROR'  AND  partysort1 is not INITIAL.

 LOOP AT it INTO DATA(GS_WA) .

 WYPO1-materialdoc  = GS_WA-MatDoc  .
 WYPO1-flag     = 'X'  .
 wypo1-rollno  =  GS_WA-RecBatch.
 wypo1-plant   =  GS_WA-Plant .

 MODIFY YP01 FROM  @WYPO1 .

 ENDLOOP.
 COMMIT WORK AND WAIT.

ENDIF .


 ENDMETHOD.
ENDCLASS.
