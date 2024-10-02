CLASS zreservationslip DEFINITION
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
        IMPORTING VALUE(matdoc)   TYPE string
                  VALUE(year)     TYPE string
        RETURNING VALUE(result12) TYPE string
        RAISING   cx_static_check .
  PROTECTED SECTION.
  PRIVATE SECTION.
    CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
    CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
    CONSTANTS  lv2_url    TYPE string VALUE 'https://btp-yvzjjpaz.authentication.eu10.hana.ondemand.com/oauth/token'.
    CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
    CONSTANTS lc_template_name TYPE string VALUE 'zmmreservationslip/zmmreservationslip'.
ENDCLASS.



CLASS ZRESERVATIONSLIP IMPLEMENTATION.


  METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).
  ENDMETHOD .


  METHOD if_oo_adt_classrun~main.
    DATA(test)  = read_posts( matdoc = '000000011'  year = ' ' )  .
  ENDMETHOD.


  METHOD read_posts .

    SELECT  * FROM  i_reservationdocumentheader AS a
               INNER JOIN i_reservationdocumentitem AS b ON ( b~reservation = a~reservation  )
               LEFT JOIN i_product AS d ON ( d~product = b~product )
               LEFT JOIN i_productdescription AS c ON ( b~product = c~product AND c~language = 'E' )
               WHERE a~reservation = @matdoc  AND B~ReservationItmIsMarkedForDeltn NE 'X'    INTO TABLE @DATA(it) .
    SORT it BY b-reservationitem .

    READ TABLE it INTO DATA(witem)  INDEX 1 .

*   SELECT SINGLE * FROM I WHERE WBSElementInternalID = @witem-a-WBSElementInternalID INTO @DATA(TEXT1).

    SELECT SINGLE goodsmovementtypename FROM i_goodsmovementtypet WHERE goodsmovementtype = @witem-a-goodsmovementtype AND language = 'E' INTO @DATA(goodsmove).
    SELECT SINGLE productdescription FROM i_productdescription WHERE product = @witem-b-product  INTO @DATA(product).
    SELECT SINGLE productoldid ,manufacturerbookpartnumber  FROM i_product WHERE product = @witem-b-product  INTO @DATA(proold).
    SELECT SINGLE * FROM I_CostCenterText WHERE CostCenter  =  @witem-a-costcenter AND Language = 'E' INTO @DATA(TEXT)  .

*
* select SINGLE * from  zmm_gr_print   where MaterialDocument = @matdoc  into @data(itt) .
*
* select single * from zsd_plant_address WITH PRIVILEGED ACCESS where PLANT = @itt-Plant INTO @DATA(PLANTADD).

* select single * from  i_reservationdocumentheader  WHERE reservation = @matdoc INTO @DATA(PLANTADD) .
 select single * from  I_ReservationDocumentItem  WHERE reservation = @matdoc INTO @DATA(PLANTADD) .
 select single PersonFullName from I_BusinessUserBasic where UserID = @witem-a-UserID into @data(person).

""""""""""""""""""""""""""""""""""""""""""""""""""""Plant Wise Address, GST & PAN"""""""""""""""""""""""""""""""""""
if PLANTADD-Plant  = '1100'.
DATA(gst1)  = '23AAHCS2781A1ZP'.
Data(pan1)  = 'AAHCS2781A'.
DATA(Register1) = 'SWARAJ SUITING LIMITED'.
Data(Register2) = 'Spinning Division-I, B-24 To B-41 Jhanjharwada Industrial Area' .
DATA(Register3) = ' Jhanjharwada, Neemuch - 458441, Madhya Pradesh, India'.
DATA(cin1) = 'L18101RJ2003PLC018359'.
elseif PLANTADD-Plant  = '1200'.
 gst1  = '23AAHCS2781A1ZP'.
 pan1  = 'AAHCS2781A'.
 Register1 = 'SWARAJ SUITING LIMITED'.
 Register2 = 'Denim Division-I, B-24 To B-41 Jhanjharwada Industrial Area' .
 Register3 = 'Jhanjharwada, Neemuch - 458441, Madhya Pradesh, India'.
 cin1 = 'L18101RJ2003PLC018359'.
elseif PLANTADD-Plant  = '1300'.
 gst1  = '08AAHCS2781A1ZH'.
 pan1  = 'AAHCS2781A'.
 Register1 = 'SWARAJ SUITING LIMITED'.
 Register2 = 'Weaving Division-I, F-483 To F-487 RIICO Growth Centre' .
 Register3 = 'Hamirgarh, Bhilwara-311025, Rajasthan, India'.
 cin1 = 'L18101RJ2003PLC018359'.
elseif PLANTADD-Plant  = '1310'.
 gst1  = '23AAHCS2781A1ZP'.
 pan1  = 'AAHCS2781A'.
 Register1 = 'SWARAJ SUITING LIMITED'.
 Register2 = 'Weaving Division-II, B-24 To B-41 Jhanjharwada Industrial Area' .
 Register3 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
 cin1 = 'L18101RJ2003PLC018359'.
elseif PLANTADD-Plant  = '1400'.
 gst1  = '23AAHCS2781A1ZP'.
 pan1  = 'AAHCS2781A'.
 Register1 = 'Swaraj Suiting Limited'.
 Register2 = 'Process House-I, B-24 To B-41 Jhanjharwada Industrial Area' .
 Register3 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
 cin1 = 'L18101RJ2003PLC018359'.
elseif PLANTADD-Plant  = '2100'.
 gst1  = '08AABCM5293P1ZT'.
 pan1  = 'AABCM5293P'.
 Register1 = 'MODWAY SUITING PVT. LIMITED'.
 Register2 = 'Weaving Division-I, 20th Km Stone, Chittorgarh Road' .
 Register3 = 'Takhatpura, Bhilwara-311025, Rajasthan, India'.
 cin1 = 'U18108RJ1986PTC003788'.
elseif PLANTADD-Plant  = '2200'.
 gst1  = '23AABCM5293P1Z1'.
 pan1  = 'AABCM5293P'.
 Register1 = 'MODWAY SUITING PVT. LIMITED'.
 Register2 = 'Weaving Division-II, B-24 To B-41 Jhanjharwada Industrial Area' .
 Register3 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
 cin1 = 'U18108RJ1986PTC003788'.
ENDIF.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""




    DATA(lv_xml) =
      |<form1>| &&
      |<Subform1>| &&
      |<head>| &&
      |<CIN>{ cin1  }</CIN>| &&
      |<GST>{ gst1 }</GST>| &&
      |<PAN>{ pan1 }</PAN>| &&
      |</head>| &&
*     |<adress3>Ego ille</adress3>| &&
      |<address2>{ Register3 }</address2>| &&
      |<address1>{ Register2 }</address1>| &&
      |<Platname>{ Register1 }</Platname>| &&
      |</Subform1>| &&
      |<Reservation>{ witem-a-reservation }</Reservation>| &&
      |<Movement>{ goodsmove }({ witem-a-goodsmovementtype })</Movement>| &&
      |<GoodRecipient>{ witem-a-goodsrecipientname }</GoodRecipient>| &&
      |<Costcenter>{ witem-a-costcenter } { TEXT-CostCenterDescription }</Costcenter>| &&
      |<receivingPlant>{ witem-a-reservationdate }</receivingPlant>| &&
      |<WBSNo>{ witem-a-wbselementinternalid }</WBSNo>| &&
      |<AssetNo>{ witem-a-assetnumber  }</AssetNo>| .

    DATA xsml TYPE string .
    LOOP AT it INTO DATA(iv) .
      IF iv-b-baseunit = 'ST' .
        DATA(unit) = 'PC' .
      ELSE  .
        unit = iv-b-baseunit .
      ENDIF .
       IF iv-d-ProductType = 'ZPRJ' .
       SELECT SUM( matlwrhsstkqtyinmatlbaseunit ) FROM i_stockquantitycurrentvalue_2( p_displaycurrency = 'INR' )
       WHERE product = @iv-b-product and Plant = @iv-b-plant
        and StorageLocation = @iv-b-storagelocation  ""@iv-b-storagelocation
         INTO @DATA(materialstock).
       ELSE.
      SELECT SUM( matlwrhsstkqtyinmatlbaseunit ) FROM i_stockquantitycurrentvalue_2( p_displaycurrency = 'INR' )
       WHERE product = @iv-b-product AND Plant = @iv-b-plant and StorageLocation =  @iv-b-storagelocation and ValuationAreaType ='1'
         INTO @materialstock.
         ENDIF.


      DATA(lv_xml2) =
       |<Matrial>{ iv-b-product }</Matrial>| &&
       |<matrialdec>{ iv-c-productdescription  }</matrialdec>| &&
       |<OldMatrial>{ iv-d-productoldid }</OldMatrial>| &&
       |<Partno>{ iv-d-productmanufacturernumber }</Partno>| &&
       |<matdec1>{ IV-B-ReservationItemText }</matdec1>| &&
       |<SendingPlant>{  iv-b-plant }</SendingPlant>| &&
       |<SendingLoc>{ iv-b-storagelocation }</SendingLoc>| &&
       |<SendingBatch>{ iv-b-batch }</SendingBatch>| &&
       |<CurrentStock>{ materialstock }</CurrentStock>| &&
       |<ReqQty>{ iv-b-resvnitmrequiredqtyinbaseunit }</ReqQty>| &&
       |<uom>{ unit }</uom>| &&
       |<Recv.Plant>{ iv-b-issuingorreceivingplant }</Recv.Plant>| &&
       |<Recv.Loc.>{ iv-b-issuingorreceivingstorageloc }</Recv.Loc.>| &&
       |<itemtext>{ iv-b-reservationitemtext }</itemtext>|.
      CONCATENATE xsml lv_xml2 INTO  xsml .
      CLEAR  : lv_xml2,iv.
    ENDLOOP .

    DATA(lv_xml3) =
           |<Sign>{ person }</Sign>| &&
           |</form1>|.

    CONCATENATE lv_xml xsml lv_xml3 INTO lv_xml .

    CALL METHOD ycl_test_adobe=>getpdf(
      EXPORTING
        xmldata  = lv_xml
        template = lc_template_name
      RECEIVING
        result   = result12 ).

  ENDMETHOD.
ENDCLASS.
