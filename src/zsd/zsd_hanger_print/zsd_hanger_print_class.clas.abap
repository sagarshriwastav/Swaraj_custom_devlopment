CLASS zsd_hanger_print_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.


  INTERFACES if_oo_adt_classrun .


        CLASS-DATA : access_token TYPE string .
        CLASS-DATA : xml_file TYPE string .
*        CLASS-DATA : template TYPE string .

*    TYPES :BEGIN OF struct,
*        xdp_template TYPE string,
*        xml_data     TYPE string,
*        form_type    TYPE string,
*        form_locale  TYPE string,
*        tagged_pdf   TYPE string,
*        embed_font   TYPE string,
*      END OF struct."

 TYPES: BEGIN OF ty_head,
              style        TYPE zsd_hanger_tab-style,
              yarnspun     TYPE zsd_hanger_tab-yarnspun,
              width        TYPE zsd_hanger_tab-width,
              weight       TYPE zsd_hanger_tab-weight,
              shade        TYPE zsd_hanger_tab-shade,
              weave        TYPE zsd_hanger_tab-weave,
              weftsnkg     TYPE zsd_hanger_tab-weftsnkg,
              finshtype    TYPE zsd_hanger_tab-finshtype,
          END OF ty_head.
    DATA:it_head TYPE TABLE OF ty_head.

       CLASS-METHODS :

      create_client
        IMPORTING url           TYPE string
        RETURNING VALUE(result) TYPE REF TO if_web_http_client
        RAISING   cx_static_check ,

      read_posts
        importing value(table) type string

                  styleno TYPE STRING
*                  yarnspun TYPE STRING
*                  width TYPE STRING
*                  weight TYPE STRING
*                  weave TYPE STRING
*                  shade TYPE STRING
*                  weftsnkg TYPE STRING
*                  finshtype TYPE STRING


           RETURNING VALUE(result12) TYPE string
           RAISING   cx_static_check .


  PROTECTED SECTION.
  PRIVATE SECTION.

    CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
        CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
        CONSTANTS  lv2_url    TYPE string VALUE 'https://btp-yvzjjpaz.authentication.eu10.hana.ondemand.com/oauth/token'  .
        CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
        CONSTANTS lc_template_name TYPE string VALUE 'ZSD_HANGER_PRINT/ZSD_HANGER_PRINT'.
ENDCLASS.



CLASS ZSD_HANGER_PRINT_CLASS IMPLEMENTATION.


       METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).


      ENDMETHOD.


       METHOD if_oo_adt_classrun~main.

       ENDMETHOD.


      method read_posts .

      DATA lv_xml TYPE string.
      DATA XSML TYPE STRING.

          SELECT * FROM zsd_hanger_tab as a WHERE a~style = @styleno into table @data(it) .

 SORT it  ASCENDING BY  style.
 READ TABLE it INTO DATA(wa) INDEX 1.


       DATA lc_template_name1 TYPE string .

      lc_template_name1 = 'ZSD_HANGER_PRINT/ZSD_HANGER_PRINT'.

 lv_xml =
*   |form1>| &&
*   |<Subform1>| &&
*     | <styleno></styleno>| &&
*      |<yarnspun></yarnspun>| &&
*      |<width></width>| &&
*      |<weight></weight>| &&
*      |<weave></weave>| &&
*      |<shade></shade>| &&
*      |<weftsnkg></weftsnkg>| &&
*     | <flnishedtype></flnishedtype>| &&
*   |</Subform1>| &&
*|</form1>|.

      |<form1>| &&
      |<Subform1>| &&
      | <styleno>{ wa-style }</styleno>| &&
      |<yarnspun>{ wa-yarnspun }</yarnspun>| &&
      |<width>{ wa-width }</width>| &&
      |<weight>{ wa-weight }</weight>| &&
      |<weave>{ wa-weave }</weave>| &&
      |<shade>{ wa-shade }</shade>| &&
      |<weftsnkg>{ wa-weftsnkg }</weftsnkg>| &&
      | <flnishedtype>{ wa-finshtype }</flnishedtype>| &&
      |</Subform1>| &&
      |</form1>|.


   CALL METHOD ycl_test_adobe=>getpdf(
       EXPORTING
         xmldata  = LV_XML
         template = lc_template_name1
       RECEIVING
         result   = result12 ).

ENDMETHOD.
ENDCLASS.
