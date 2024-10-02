CLASS zpp_folding_stickr_class DEFINITION
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
                   BeamNo type string
                   RollNoFrom type STRING
                   RollNoTo type STRING

        RETURNING VALUE(result12) TYPE string
        RAISING   cx_static_check .


  PROTECTED SECTION.
  PRIVATE SECTION.

    CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
    CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
    CONSTANTS  lv2_url    TYPE string VALUE 'https://btp-yvzjjpaz.authentication.eu10.hana.ondemand.com/oauth/token' .
    CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
    CONSTANTS lc_template_name TYPE string VALUE 'FldingSticker_PP/FldingSticker_PP'.

ENDCLASS.



CLASS ZPP_FOLDING_STICKR_CLASS IMPLEMENTATION.


METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).

  ENDMETHOD .


 METHOD if_oo_adt_classrun~main.

*DATA(TEST)  = READ_POSTS( plant = '1200'  date = '23-05-2023' material = 'FFO00090904' rollno = '011000001' foliono = '3829' grade = 'DM' materialDocno = '4900000125')  .

 ENDMETHOD.


  method read_posts .


 DATA RollNoTo1 TYPE STRING .

 RollNoTo1 = RollNoTo .

 IF RollNoFrom IS NOT INITIAL AND RollNoTo1 IS INITIAL .

RollNoTo1 = RollNoFrom .

ENDIF.

 select * from  zpp_grey_grn_tab as a
 INNER JOIN I_ProductDescription as b ON (  B~Product = a~material AND b~Language = 'E' )
 INNER JOIN I_MaterialDocumentItem_2 as C ON (  C~MaterialDocument = a~materialdocument101 AND  C~MaterialDocumentItem = '0001' )
 where A~BATCH = @BeamNo and C~GoodsMovementIsCancelled <> 'X' AND
       recbatch BETWEEN  @RollNoFrom and @RollNoTo1

        into table @DATA(it) .





     data xsml type string .
     DATA(lv_xml) =   |<form1>|.


loop at it into data(wa).

   DATA(lv_xml2) =

       |<BARCODE>| &&
       |<Code128BarCode1>{ wa-a-recbatch }</Code128BarCode1>| &&
       |<PieceNo>{ wa-a-recbatch }</PieceNo>| &&
       |<SORTNO1>{ wa-b-ProductDescription }</SORTNO1>| &&
       |<MTR>{ wa-a-quantity }</MTR>| &&
       |<SetCode>{ wa-a-setno }</SetCode>| &&
       |<NetWt>{ wa-a-netwt }</NetWt>| &&
       |<GrossWt>{ WA-a-grosswt }</GrossWt>| &&
       |<Code128BarCode2>{ wa-a-recbatch }</Code128BarCode2>| &&
       |</BARCODE>|.


 CONCATENATE xsml lv_xml2 into xsml .

ENDLOOP .

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
