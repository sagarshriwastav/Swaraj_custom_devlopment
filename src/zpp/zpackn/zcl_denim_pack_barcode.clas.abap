CLASS zcl_denim_pack_barcode DEFINITION
 PUBLIC
  FINAL
  CREATE PUBLIC .

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
                   PLANT TYPE CHAR4
                   rollno type string

        RETURNING VALUE(result12) TYPE string
        RAISING   cx_static_check .

  PROTECTED SECTION.
  PRIVATE SECTION.


    CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
    CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
    CONSTANTS  lv2_url    TYPE string VALUE 'https://btp-yvzjjpaz.authentication.eu10.hana.ondemand.com/oauth/token' .
    CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
    CONSTANTS lc_template_name TYPE string VALUE 'BarcodePP/BarcodePP'.


ENDCLASS.



CLASS ZCL_DENIM_PACK_BARCODE IMPLEMENTATION.


METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).

  ENDMETHOD .


 METHOD if_oo_adt_classrun~main.

*DATA(TEST)  = READ_POSTS( plant = '1200'  date = '23-05-2023' material = 'FFO00090904' rollno = '011000001' foliono = '3829' grade = 'DM' materialDocno = '4900000125')  .

 ENDMETHOD.


  method read_posts .



if rollno is not INITIAL.
select * from  ZPACK_HDR_DEF
 where
       RecBatch = @rollno
       into table @DATA(it) .


endif.

DELETE ADJACENT DUPLICATES FROM it COMPARING all FIELDS.


      data xsml type string .
      data sortnumber type string .
      data rolmul type string .

 DATA(lv_xml) =   |<form1>|.


loop at it into data(wa).

    sortnumber =  |{ wa-MaterialNumber+3 ALPHA = OUT }|.

SELECT SINGLE dyeingshade FROM zpp_sortmaster  WHERE material = @WA-MaterialNumber INTO @DATA(SHadeno).
SELECT SINGLE Zdesc FROM zweav_grad_tab WHERE  grade = @wa-PackGrade INTO @DATA(GRAD) .


rolmul = wa-RollLength * '1.094'   .

   DATA(lv_xml2) =

      |<BARCODE>| &&
      |<Code128BarCode1>{ wa-RecBatch }</Code128BarCode1>| &&
      |<rollno></rollno>| &&
      |<SORTNO1>{ sortnumber }</SORTNO1>| &&
      |<sortno></sortno>| &&
      |<MTR>{ wa-RollLength }</MTR>| &&
      |<YARD>{  rolmul }</YARD>| &&
      |<GRADE>{ GRAD }</GRADE>| &&
      |<ROLLNUMBE1>{ wa-RecBatch }</ROLLNUMBE1>| &&
      |<TPPART>{ wa-NoOfTp }</TPPART>| &&
      |<NETWT>{ wa-NetWeight }</NETWT>| &&
      |<WIDTHININCH>{ wa-FinishWidth }</WIDTHININCH>| &&
      |<SHADENO>{ SHadeno }</SHADENO>| &&
      |</BARCODE>|.


 CONCATENATE xsml lv_xml2 into xsml .

ENDLOOP.

data(lv_xml3) = |</form1>|.

 CONCATENATE lv_xml xsml lv_xml3 into lv_xml .

CALL METHOD ycl_test_adobe=>getpdf(
       EXPORTING
         xmldata  = LV_XML
         template = lc_template_name
       RECEIVING
         result   = result12 ).


 ENDMETHOD.
ENDCLASS.
