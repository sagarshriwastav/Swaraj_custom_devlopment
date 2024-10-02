CLASS zpp_dyeing_sticker_class DEFINITION
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
                  material type matnr
                   dyedto TYPE string
                   dyedfrom TYPE string

        RETURNING VALUE(result12) TYPE string
        RAISING   cx_static_check .

  PROTECTED SECTION.
  PRIVATE SECTION.


    CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
    CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
    CONSTANTS  lv2_url    TYPE string VALUE 'https://btp-yvzjjpaz.authentication.eu10.hana.ondemand.com/oauth/token' .
    CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
    CONSTANTS lc_template_name TYPE string VALUE 'PP_DYEING_STICKER/PP_DYEING_STICKER'.


ENDCLASS.



CLASS ZPP_DYEING_STICKER_CLASS IMPLEMENTATION.


METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).

  ENDMETHOD .


 METHOD if_oo_adt_classrun~main.

*DATA(TEST)  = READ_POSTS( plant = '1200'  date = '23-05-2023' material = 'FFO00090904' rollno = '011000001' foliono = '3829' grade = 'DM' materialDocno = '4900000125')  .

 ENDMETHOD.


  method read_posts .

if material is not INITIAL AND PLANT is not INITIAL AND dyedto is not INITIAL AND dyedfrom is not INITIAL.
select * from  ZPP_DYEINGR_CDS
 where plant = @plant and
       Material = @material
       AND ( beamno BETWEEN @dyedfrom and @dyedto )
       into table @Data(it) .
endif.


if material is not INITIAL AND PLANT is not INITIAL.
select * from  ZPP_DYEINGR_CDS
 where plant = @plant and
       Material = @material
       into table @it .
endif.

if PLANT is not INITIAL AND dyedto is not INITIAL AND dyedfrom is not INITIAL.

select * from  ZPP_DYEINGR_CDS
 where plant = @plant and
      ( beamno BETWEEN @dyedfrom and @dyedto )
        into table @it .

endif.



DELETE ADJACENT DUPLICATES FROM it COMPARING all FIELDS.


      data xsml type string .
      data sortnumber type string .

 DATA(lv_xml) =   |<form1>|.


loop at it into data(wa).
     SELECT SINGLE PostingDate ,CreationTime  FROM I_MaterialDocumentHeader_2 WHERE MaterialDocument = @WA-Materialdocument
                                                        AND MaterialDocumentYear = @WA-Materialdocumentyear INTO @DATA(DATETIME) .
     SELECT SINGLE YY1_LOOMNUMBER_ORD FROM I_ManufacturingOrder WHERE ManufacturingOrder = @WA-Zorder INTO @DATA(LOOMNO) .
     SELECT SINGLE wefttypedesc1 , wefttypedesc2 ,ratioweftper1 , ratioweftper2 ,weave , totalends
                    FROM zpp_sortmaster WHERE material = @wA-Greyshort INTO @DATA(WEFT) .

   DATA(lv_xml2) =

     |<BARCODE>| &&
      |<Code128BarCode1>{ WA-Beamno }</Code128BarCode1>| &&
      |<ROLLNUMBE1>{ WA-Greyshort }</ROLLNUMBE1>| &&
      |<SORTNO1>{ WA-Beamno }</SORTNO1>| &&
      |<DATEN>{ DATETIME-PostingDate } '-' { DATETIME-CreationTime }</DATEN>| &&
      |<NOOFENDS>{ WEFT-totalends }</NOOFENDS>| &&
      |<MCNO>{ LOOMNO }</MCNO>| &&
      |<LENGTH>{ WA-Length }</LENGTH>| &&
      |<BEAMNO>{ WA-Pipenumber }</BEAMNO>| &&
      |<WEFT1>{ WEFT-wefttypedesc1 }</WEFT1>| &&
      |<SADEGROUP>{ WA-Shade }</SADEGROUP>| &&
      |<WEFT2>{ WEFT-wefttypedesc2 }</WEFT2>| &&
      |<QUALITY>{ WA-Material }</QUALITY>| &&
      |<OPERATOR>{ WA-Optname }</OPERATOR>| &&
      |<WEAVETYPE>{ Weft-weave }</WEAVETYPE>| &&
      |<GROSSWT>{ WA-Grossweight }</GROSSWT>| &&
      |<NETWT>{ WA-Netweight }</NETWT>| &&
      |<WEFT1RPT>{ WEFT-ratioweftper1 }</WEFT1RPT>| &&
      |<WEFT2RPT>{ WEFT-ratioweftper2 }</WEFT2RPT>| &&
      |</BARCODE>| .


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
