CLASS ycl_packing_label_abap DEFINITION
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
                   printtype        TYPE string  OPTIONAL


        RETURNING VALUE(result12) TYPE string
        RAISING   cx_static_check .

  PROTECTED SECTION.
  PRIVATE SECTION.


    CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
    CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
    CONSTANTS  lv2_url    TYPE string VALUE 'https://btp-yvzjjpaz.authentication.eu10.hana.ondemand.com/oauth/token' .
    CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
*    CONSTANTS lc_template_name TYPE string VALUE 'ZPP_LABEL_PACK/ZPP_LABEL'.
*    CONSTANTS lc_template_name1 TYPE string VALUE 'ZPP_LABEL_PACK_B/ZPP_LABEL_PACK_B'.

ENDCLASS.



CLASS YCL_PACKING_LABEL_ABAP IMPLEMENTATION.


   METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).

  ENDMETHOD .


  METHOD if_oo_adt_classrun~main.

DATA(TEST)  = READ_POSTS( PLANT = '1102'  lot_no  = 'P1001001'  order = '123432' BATCH = '123' PRINTTYPE = 'A' ) .

  ENDMETHOD.


  method read_posts .

  DATA : lv_xml TYPE STRING .

select * from  ZIPP_PACKING_LABEL  where MaterialDocument  = @lot_no
*AND Batch = @lot_no
 INTO
TABLE @DATA(IT) .
*
if it is not INITIAL .
*
read table it into data(PP_LABEL1) index 1 .
*
endif .
*

      DATA  :  lc_template_name TYPE string.
 DATA(LV_XML11)  =   |<form1>|   .




DATA XSML TYPE STRING .

DATA MATERIAL TYPE STRING.
data  lottt   type string .

sort it  BY Batch .

data gross type p DECIMALS 3 .


LOOP AT IT INTO DATA(PP_LABEL) .

*select SINGLE YY1_Remark_ORD from I_Order where OrderID = @PP_LABEL-OrderID into @data(order1).

select single * from zpackn_cds where Batch = @PP_LABEL-Batch into @data(packdata)  .

select single * from I_ProductDescription where Product  = @pp_label-Material
                                               and Language = 'E' INTO @DATA(MATDESC)  .

SELECT SINGLE * FROM I_PRODUCT WHERE PRODUCT = @PP_LABEL-Material  INTO @DATA(PROD) .

gross =  packdata-Grosswt .

*IF  printtype = '0'.
*      MATERIAL = MATDESC-ProductDescription .
* ELSEIF  printtype =  '1' .  "  'Neutral'.
*         MATERIAL = PROD-BasicMaterial .
*   ENDIF.

  DATA(LV_XML12)  =   |<Page1>| &&
                      |<Subform1>| &&
                      |<Count>{ MATDESC-ProductDescription }</Count>| &&
                      |<LotNo>{ PP_LABEL-MaterialDocumentItemText  }</LotNo>| &&
                      |<CartonNo>{ packdata-BagNumber }</CartonNo>| &&
                      |<GrossWt>{ gross }</GrossWt>| &&
                      |<NetWt>{ PP_LABEL-QuantityInBaseUnit }</NetWt>| &&
                      |<QRCodeBarcode1>{ PP_LABEL-Batch }</QRCodeBarcode1>| &&
                      |<batchNo>{ PP_LABEL-Batch }</batchNo>| &&
*                      |<remark>{ order1 }</remark>| &&
                      |</Subform1>| &&
                      |</Page1>| .

                       .
  CONCATENATE xsml lv_xml12 into  xsml .
CLEAR : LV_XML12 , packdata ,MATDESC ,gross,MATERIAL .
 ENDLOOP .

 DATA(LV_XML13)  =  |</form1>|  .



 CONCATENATE LV_XML11 xsml LV_XML13 INTO lv_xml  .



     IF  printtype =  '0' .    " 'Regular'.
      lc_template_name = 'ZPP_LABEL_PACK/ZPP_LABEL'.

      ELSEIF  printtype =  '1' .  " 'Neutral'.
      lc_template_name = 'ZPP_LABEL_PACK_B/ZPP_LABEL_PACK_B'.




***********************************
*************************************
ELSEIF printtype =  '3' . " 'Pallet'.
  lc_template_name = 'ZPP_LABEL_PACK_C/ZPP_LABEL_PACK_C'.

**ELSEIF printtype = 'PalletRegular'.
**  lc_template_name = 'ZPP_LABEL_PACK_D/ZPP_LABEL_PACK_D'.


**DATA MATERIAL1 TYPE STRING.

 DATA(LV_XML113)  =   |<form1>|   .



*SORT IT BY  A-BATCH .

LOOP AT IT INTO PP_LABEL .
*DO N TIMES.
*select SINGLE YY1_Remark_ORD from I_Order where OrderID = @PP_LABEL-OrderID into @data(order11).

select single * from zpackn_cds where Batch = @PP_LABEL-Batch into @data(packdata1)  .

select single * from I_ProductDescription where Product  = @pp_label-Material
                                               and Language = 'E' INTO @DATA(MATDESC1)  .

SELECT SINGLE * FROM I_PRODUCT WHERE PRODUCT = @PP_LABEL-Material  INTO @DATA(PROD1) .

gross =  packdata1-Grosswt .

**************************************
*IF  printtype = 'Pallet'.
*      MATERIAL1 = PROD1-BasicMaterial .
* ELSEIF  printtype = 'PalletRegular'.
*         MATERIAL1 = MATDESC1-ProductDescription .
*   ENDIF.
**********************************************


*GROSSWT =  PP_LABEL-c-Grosswt .
  DATA(LV_XML20)  =   |<page>| &&
      |<Subform1>| &&
         |<COUNT>{ MATDESC1-ProductDescription }</COUNT>| &&
         |<PALLETNO>{ packdata1-BagNumber }</PALLETNO>| &&
         |<LOTNO>{ PP_LABEL-MaterialDocumentItemText  }</LOTNO>| &&
         |<CONETIP>{ packdata1-Conetip }</CONETIP>| &&
         |<NOOFCONES>{ packdata1-Noofcones }</NOOFCONES>| &&
         |<GROSSWT>{ gross }</GROSSWT>| &&
         |<NETWT>{ PP_LABEL-QuantityInBaseUnit }</NETWT>| &&
         |<barcode>{ PP_LABEL-Batch }</barcode>| &&
         |<BATCHNO>{ PP_LABEL-Batch }</BATCHNO>| &&
*         |<REMARK>{ order11 }</REMARK>| &&
      |</Subform1>| &&
   |</page>| .
                       .
  CONCATENATE xsml lv_xml20 into  xsml .
CLEAR :  LV_XML20, packdata1 ,MATDESC1 ,gross .  .
 ENDLOOP .
*ENDDO.

 DATA(LV_XML21)  =  |</form1>|  .



 CONCATENATE LV_XML113 xsml LV_XML21 INTO lv_xml  .


********************************
ELSEIF printtype =  '2'  . " 'PalletRegular'.
  lc_template_name = 'ZPP_LABEL_PACK_D/ZPP_LABEL_PACK_D'.


 DATA(LV_XML123)  =   |<form1>|   .



*SORT IT BY  A-BATCH .

LOOP AT IT INTO PP_LABEL .
*DO N TIMES.
*select SINGLE YY1_Remark_ORD from I_Order where OrderID = @PP_LABEL-OrderID into @data(order111).

select single * from zpackn_cds where Batch = @PP_LABEL-Batch into @data(packdata11)  .

select single * from I_ProductDescription where Product  = @pp_label-Material
                                               and Language = 'E' INTO @DATA(MATDESC11)  .

SELECT SINGLE * FROM I_PRODUCT WHERE PRODUCT = @PP_LABEL-Material  INTO @DATA(PROD11) .

gross =  packdata11-Grosswt .

**************************************
*IF  printtype = 'Pallet'.
*      MATERIAL1 = PROD1-BasicMaterial .
* ELSEIF  printtype = 'PalletRegular'.
*         MATERIAL1 = MATDESC1-ProductDescription .
*   ENDIF.
**********************************************


*GROSSWT =  PP_LABEL-c-Grosswt .
  DATA(LV_XML25)  =   |<page>| &&
      |<Subform1>| &&
         |<COUNT>{ MATDESC11-ProductDescription }</COUNT>| &&
         |<PALLETNO>{ packdata11-BagNumber }</PALLETNO>| &&
         |<LOTNO>{ PP_LABEL-MaterialDocumentItemText  }</LOTNO>| &&
         |<CONETIP>{ packdata11-Conetip }</CONETIP>| &&
         |<NOOFCONES>{ packdata11-Noofcones }</NOOFCONES>| &&
         |<GROSSWT>{ gross }</GROSSWT>| &&
         |<NETWT>{ PP_LABEL-QuantityInBaseUnit }</NETWT>| &&
         |<barcode>{ PP_LABEL-Batch }</barcode>| &&
         |<BATCHNO>{ PP_LABEL-Batch }</BATCHNO>| &&
*         |<REMARK>{ order111 }</REMARK>| &&
      |</Subform1>| &&
   |</page>| .
                       .
  CONCATENATE xsml lv_xml25 into  xsml .
CLEAR :  LV_XML25, packdata1 ,MATDESC11 ,gross .  .
 ENDLOOP .
*ENDDO.

 DATA(LV_XML26)  =  |</form1>|  .



 CONCATENATE LV_XML123 xsml LV_XML26 INTO lv_xml  .

ENDIF.

   CALL METHOD ycl_test_adobe=>getpdf(
      EXPORTING
        xmldata  = lv_xml
        template = lc_template_NAME
      RECEIVING
        result   = result12 ).



  ENDMETHOD.
ENDCLASS.
