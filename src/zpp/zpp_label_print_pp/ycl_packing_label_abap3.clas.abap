CLASS ycl_packing_label_abap3 DEFINITION
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

      END OF struct.


    CLASS-METHODS :

      create_client
        IMPORTING url           TYPE string
        RETURNING VALUE(result) TYPE REF TO if_web_http_client
        RAISING   cx_static_check ,
      read_posts
        importing  Plant  type string
                   Lot_No  type string  OPTIONAL
                   Order    type string  OPTIONAL
                   BATCH TYPE STRING
                   printtype        TYPE string  OPTIONAL              """""18

        RETURNING VALUE(result12) TYPE string
        RAISING   cx_static_check .

  PROTECTED SECTION.
  PRIVATE SECTION.


    CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
    CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
    CONSTANTS  lv2_url    TYPE string VALUE 'https://sagar.authentication.eu10.hana.ondemand.com/oauth/token'  .
    CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
*    CONSTANTS lc_template_name TYPE string VALUE 'ZPP_LABEL_PACK/ZPP_LABEL'.


ENDCLASS.



CLASS YCL_PACKING_LABEL_ABAP3 IMPLEMENTATION.


   METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).

  ENDMETHOD .


  METHOD if_oo_adt_classrun~main.

DATA(TEST)  = READ_POSTS( PLANT = '1101'  lot_no  = '4900000600'  order = '123432' BATCH = '123' PRINTTYPE = 'C' ) .

  ENDMETHOD.


  method read_posts .

  DATA : lv_xml TYPE STRING .

if batch is  INITIAL .
select * from  ZIPP_PACKING_LABEL as a
    inner join I_ProductDescription as b on ( b~product = a~Material )
    left OUTER join zpackncds as c on ( c~Batch = a~Batch and c~Material = a~Material )
    left outer join I_Order as d on ( d~OrderID = a~OrderID ) where a~MaterialDocument  = @lot_no
 INTO
TABLE @DATA(IT) .
else .
select * from  ZIPP_PACKING_LABEL as a
inner join I_ProductDescription as b on ( b~product = a~Material )
left OUTER join zpackncds as c on ( c~Batch = a~Batch and c~Material = a~Material )
left outer join I_Order as d on ( d~OrderID = a~OrderID ) where a~MaterialDocument  = @lot_no
AND a~Batch = @batch
INTO
TABLE @IT .



endif .
if it is not INITIAL .
*
read table it into data(PP_LABEL1) index 1 .
*6
endif .
*



    DATA  :  MACHINENUM TYPE STRING .
    DATA  :  ROLLNO TYPE ZROLLNO .
    data :   init_lot  type zrollno .
    DATA  :  lc_template_name TYPE string.

 IF  printtype = 'A'.     """"18
  lc_template_name = 'ZPP_LABEL_PACK/ZPP_LABEL'.

 DATA(LV_XML11)  =   |<form1>|   .




DATA XSML TYPE STRING .


data  lottt   type string .
DATA GROSSWT TYPE P DECIMALS 3 .

SORT IT BY  A-BATCH .

LOOP AT IT INTO DATA(PP_LABEL) .


GROSSWT =  PP_LABEL-c-Grosswt .
  DATA(LV_XML12)  =   |<Page1>| &&
                      |<Subform1>| &&
                      |<Count>{ PP_LABEL-b-ProductDescription }</Count>| &&
                      |<LotNo>{ PP_LABEL-a-MaterialDocumentItemText  }</LotNo>| &&
                      |<CartonNo>{ PP_LABEL-c-BagNumber }</CartonNo>| &&
                      |<GrossWt>{ GROSSWT }</GrossWt>| &&
                      |<NetWt>{ PP_LABEL-a-QuantityInBaseUnit }</NetWt>| &&
                      |<QRCodeBarcode1>{ PP_LABEL-a-Batch }</QRCodeBarcode1>| &&
                      |<batchNo>{ PP_LABEL-a-Batch }</batchNo>| &&
*                      |<remark>{ PP_LABEL-d-YY1_Remark_ORD }</remark>| &&
                      |</Subform1>| &&
                      |</Page1>|.
                       .
  CONCATENATE xsml lv_xml12 into  xsml .
CLEAR :  LV_XML12, GROSSWT   .
 ENDLOOP .

 DATA(LV_XML13)  =  |</form1>|  .



 CONCATENATE LV_XML11 xsml LV_XML13 INTO lv_xml  .

**********************************************************
***************************************************
 ELSEIF printtype = 'B'.
  lc_template_name = 'ZPP_LABEL_PACK_B/ZPP_LABEL_PACK_B'.



 DATA(LV_XML111)  =   |<form1>|   .




*DATA XSMLL TYPE STRING .


*data  lotttT   type string .
*DATA GROSSWT1 TYPE P DECIMALS 3 .

SORT IT BY  A-BATCH .

LOOP AT IT INTO PP_LABEL .
*DO N TIMES.

GROSSWT =  PP_LABEL-c-Grosswt .
  LV_XML12  =   |<Page1>| &&
                      |<Subform1>| &&
                      |<Count>{ PP_LABEL-A-OLDMATERIAL }</Count>| &&
                      |<LotNo>{ PP_LABEL-a-MaterialDocumentItemText  }</LotNo>| &&
                      |<CartonNo>{ PP_LABEL-c-BagNumber }</CartonNo>| &&
                      |<GrossWt>{ GROSSWT }</GrossWt>| &&
                      |<NetWt>{ PP_LABEL-a-QuantityInBaseUnit }</NetWt>| &&
                      |<QRCodeBarcode1>{ PP_LABEL-a-Batch }</QRCodeBarcode1>| &&
                      |<batchNo>{ PP_LABEL-a-Batch }</batchNo>| &&
                      |</Subform1>| &&
                      |</Page1>|.
                       .
  CONCATENATE xsml lv_xml12 into  xsml .
CLEAR :  LV_XML12, GROSSWT   .
 ENDLOOP .
*ENDDO.

 LV_XML13  =  |</form1>|  .



 CONCATENATE LV_XML111 xsml LV_XML13 INTO lv_xml  .




 ENDIF.
****************************************************
***************************************************

   CALL METHOD ycl_test_adobe=>getpdf(
      EXPORTING
        xmldata  = lv_xml
        template = lc_template_name
      RECEIVING
        result   = result12 ).
DATA WYPO1  TYPE YP01 .

IF result12 NE 'ERROR'  .

WYPO1-materialdoc  = lot_no  .
WYPO1-flag     = 'X'  .


 MODIFY YP01 FROM  @WYPO1 .
        COMMIT WORK AND WAIT.



ENDIF .





  ENDMETHOD.
ENDCLASS.
