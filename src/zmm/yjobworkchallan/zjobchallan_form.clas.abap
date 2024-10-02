CLASS zjobchallan_form DEFINITION
   PUBLIC
  FINAL
  CREATE PUBLIC .

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
        IMPORTING VALUE(variable) TYPE STRING
         year TYPE string
         Vehiclenumber TYPE string
         Modeoftrans TYPE string
         Nameoftrans TYPE string
         disdate TYPE string
         distime TYPE string
         duration1 TYPE string
         radButton1 TYPE string
         selection TYPE string


        RETURNING VALUE(result12) TYPE string
        RAISING   cx_static_check .

  PROTECTED SECTION.
  PRIVATE SECTION.


    CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
    CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
    CONSTANTS  lv2_url    TYPE string VALUE 'https://btp-yvzjjpaz.authentication.eu10.hana.ondemand.com/oauth/token'  .
    CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
    CONSTANTS lc_template_name TYPE string VALUE 'Job_Work_Chalan_Print/Job_Work_Chalan_Print'.


ENDCLASS.



CLASS ZJOBCHALLAN_FORM IMPLEMENTATION.


  METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).

  ENDMETHOD .


  METHOD if_oo_adt_classrun~main.



*    DATA(xml)  = read_posts( variable = '0090000017'  )   .


  ENDMETHOD.


  METHOD read_posts .

   DATA descripition type string.
   DATA VAR1 TYPE ZCHAR10.
        VAR1 = VARIABLE.
        VAR1 =   |{ |{ VAR1 ALPHA = OUT }| ALPHA = IN }| .
        VARIABLE = VAR1.

    SELECT * FROM  yeinvoice_cdss   WHERE billingdocument = @variable   INTO TABLE @DATA(it) .
    SELECT SINGLE * FROM i_billingdocumentbasic WHERE billingdocument =  @variable INTO  @DATA(billhead) .
    SELECT SINGLE * FROM  i_billingdocumentitem AS a
    LEFT OUTER JOIN i_deliverydocumentitem AS b ON ( a~referencesddocument = b~deliverydocument AND a~referencesddocumentitem = b~deliverydocumentitem )
    INNER JOIN   i_deliverydocument AS f ON ( b~deliverydocument = f~deliverydocument )
    LEFT OUTER JOIN i_shippingtypetext AS s ON ( f~shippingtype = s~shippingtype AND s~language = 'E'  )
       WHERE  billingdocument  =  @variable INTO @DATA(billingitem)  .


    SELECT * FROM i_billingdocumentitem WHERE billingdocument = @billingitem-a-referencesddocument INTO TABLE @DATA(deli) .

    DELETE ADJACENT DUPLICATES FROM deli COMPARING referencesddocument.


  SELECT single UserDescription  from i_user WITH PRIVILEGED ACCESS where  UserID = @billhead-CreatedByUser into @data(username).

    SELECT SINGLE * FROM i_salesdocument WHERE salesdocument  =  @billingitem-a-salesdocument  INTO  @DATA(salesorder)  .
    READ TABLE it INTO  DATA(wt) INDEX 1 .

    SELECT SINGLE * FROM i_customer WHERE customer = @wt-billtoparty INTO @DATA(billto) .
    SELECT SINGLE * FROM  i_customer AS a  INNER JOIN i_billingdocumentpartner AS b ON ( a~customer = b~customer )
    WHERE b~partnerfunction = 'WE'  AND b~billingdocument = @variable   INTO @DATA(shipto)  .

    SELECT SINGLE * FROM i_regiontext   WHERE  region = @billto-region AND language = 'E' AND country = @billto-country  INTO  @DATA(regiontext1) .


    SELECT SINGLE * FROM i_regiontext   WHERE  region = @shipto-a-region AND language = 'E' AND country = @shipto-a-country  INTO  @DATA(regiontext2) .


    SELECT SINGLE * FROM i_paymenttermstext WHERE paymentterms = @billhead-customerpaymentterms AND language = 'E'
    INTO @DATA(terms) .

    SELECT SINGLE * FROM zsd_dom_address WITH PRIVILEGED ACCESS WHERE addressid = @shipto-a-addressid INTO @DATA(shiptoadd1)   .

    SELECT SINGLE * FROM zsd_dom_address WITH PRIVILEGED ACCESS WHERE addressid = @billto-addressid INTO @DATA(billtoadd1).

   SELECT SINGLE REGIONNAME FROM I_RegionText WHERE Region = @billtoadd1-Region AND Language = 'E' AND Country = 'IN' INTO @DATA(STATE).

    IF it IS NOT INITIAL .

      READ TABLE it INTO DATA(gathd) INDEX 1 .

    ENDIF .



    CONCATENATE salesorder-salesdocumentdate+6(2) '/' salesorder-salesdocumentdate+4(2) '/' salesorder-salesdocumentdate+0(4) INTO DATA(SALESORDERDATE) .


    IF billhead-distributionchannel NE '20'  .

   if billhead-Division = '80' .

   template = 'Job_Work_Chalan_Print/Job_Work_Chalan_Print' .

   ELSE.

      template = 'Job_Work_Chalan_Print/Job_Work_Chalan_Print'  .


      ENDIF.



"""""""""""""""""""""""""""""""""""""""""""""""""""Plant Wise Address, GST & PAN"""""""""""""""""""""""""""""""""""
if gathd-Plant = '1100'.
DATA(gst1)  = '23AAHCS2781A1ZP'.
Data(pan1)  = 'AAHCS2781A'.
DATA(Register1) = 'SWARAJ SUITING LIMITED'.
Data(Register2) = 'Spinning Division-I, B-24 To B-41 Jhanjharwada Industrial Area' .
DATA(Register3) = ' Jhanjharwada, Neemuch - 458441, Madhya Pradesh, India'.
DATA(cin1) = 'L18101RJ2003PLC018359'.
elseif gathd-Plant = '1200'.
 gst1  = '23AAHCS2781A1ZP'.
 pan1  = 'AAHCS2781A'.
 Register1 = 'SWARAJ SUITING LIMITED'.
 Register2 = 'Denim Division-I, B-24 To B-41 Jhanjharwada Industrial Area' .
 Register3 = 'Jhanjharwada, Neemuch - 458441, Madhya Pradesh, India'.
 cin1 = 'L18101RJ2003PLC018359'.
elseif gathd-Plant = '1300'.
 gst1  = '08AAHCS2781A1ZH'.
 pan1  = 'AAHCS2781A'.
 Register1 = 'SWARAJ SUITING LIMITED'.
 Register2 = 'Weaving Division-I, F-483 To F-487 RIICO Growth Centre' .
 Register3 = 'Hamirgarh, Bhilwara-311025, Rajasthan, India'.
 cin1 = 'L18101RJ2003PLC018359'.
elseif gathd-Plant  = '1310'.
 gst1  = '23AAHCS2781A1ZP'.
 pan1  = 'AAHCS2781A'.
 Register1 = 'SWARAJ SUITING LIMITED'.
 Register2 = 'Weaving Division-II, B-24 To B-41 Jhanjharwada Industrial Area' .
 Register3 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
 cin1 = 'L18101RJ2003PLC018359'.
elseif gathd-Plant  = '1400'.
 gst1  = '23AAHCS2781A1ZP'.
 pan1  = 'AAHCS2781A'.
 Register1 = 'SWARAJ SUITING LIMITED'.
 Register2 = 'Process House-I, B-24 To B-41 Jhanjharwada Industrial Area' .
 Register3 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
 cin1 = 'L18101RJ2003PLC018359'.
elseif gathd-Plant  = '2100'.
 gst1  = '08AABCM5293P1ZT'.
 pan1  = 'AABCM5293P'.
 Register1 = 'MODWAY SUITING PVT. LIMITED'.
 Register2 = 'Weaving Division-I, 20th Km Stone, Chittorgarh Road' .
 Register3 = 'Takhatpura, Bhilwara-311025, Rajasthan, India'.
 cin1 = 'U18108RJ1986PTC003788'.
elseif gathd-Plant = '2200'.
 gst1  = '23AABCM5293P1Z1'.
 pan1  = 'AABCM5293P'.
 Register1 = 'MODWAY SUITING PVT. LIMITED'.
 Register2 = 'Weaving Division-II, B-24 To B-41 Jhanjharwada Industrial Area' .
 Register3 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
 cin1 = 'U18108RJ1986PTC003788'.
ENDIF.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   SELECT SINGLE b~PurchaseOrder FROM i_billingdocumentitem AS A

    LEFT OUTER JOIN I_MaterialDocumentItem_2 AS B ON B~Material = A~Material AND B~MaterialDocument = A~ReferenceSDDocument
     WHERE  billingdocument  =  @variable INTO @DATA(PURCHASE).

      DATA(lv_xml) =  |<form1>| &&
        |<Subform1>| &&
        |<head>| &&
        |<CIN>{ cin1 }</CIN>| &&
        |<GST>{ gst1 }</GST>| &&
*        |<PAN>{ pan1 }</PAN>| &&
        |</head>| &&
        |<adress3></adress3>| &&
        |<address2>{ Register3 }</address2>| &&
        |<address1>{ Register2 }</address1>| &&
        |<Platname>{ Register1 }</Platname>| &&
        |<PAN>{ pan1 }</PAN>| &&
        |</Subform1>| &&
        |<Reservation></Reservation>| &&
        |<Range></Range>| &&
        |<Challanno>{ gathd-BillingDocument }</Challanno>| &&
        |<Division></Division>| &&
        |<Pono>{ PURCHASE  }</Pono>| &&
        |<Subform2>| &&
        |<nameofsupplier>{ Register1 }</nameofsupplier>| &&
        |<supplieradd1>{ Register2 }</supplieradd1>| &&
        |<supplieradd2>{ Register3 }</supplieradd2>| &&
        |<gstin>{ gst1 }</gstin>| &&
        |<identificationmark>Ad retia sedebam</identificationmark>| &&
        |<dateofdispatch>{ disdate  } { distime  }</dateofdispatch>| &&
        |<natureforprocess>{ selection }</natureforprocess>| &&
        |<nameofjobwork>{ billtoadd1-CustomerName }</nameofjobwork>| &&
        |<Sup_GSTIN>{ billtoadd1-TaxNumber3 }</Sup_GSTIN>| &&
        |<nameofjobwork1>{ billtoadd1-city }, { STATE }, {  billtoadd1-PostalCode }</nameofjobwork1>| &&
        |<exceedduration>{ duration1 }</exceedduration>| &&
        |</Subform2>|.

      DATA rat TYPE p DECIMALS 2 .
      DATA xsml TYPE string .
      DATA count TYPE int8 .
************************************
*LOOPING DATA
************************************
      LOOP AT it INTO DATA(iv) .


        DATA orgqty  TYPE zpdec2 .
        DATA TOTLENGHT TYPE P DECIMALS 2 .
        DATA TOTLEGROSWT TYPE P DECIMALS 2 .
        DATA TOTNTWT TYPE P DECIMALS 2 .
        DATA TOTAMT TYPE P DECIMALS 2 .

        orgqty = iv-billingquantity.

 SELECT single * from I_MaterialDocumentItem_2  WHERE Material = @iv-Material and MaterialDocumentItem = @iv-DELIVERY_NUMBER_item and MaterialDocument = @iv-delivery_number  INTO  @DATA(MAT).

 SELECT SINGLE * FROM ZPP_DYEING_CDS as a
 INNER JOIN I_MaterialDocumentItem_2 as b ON ( B~Material = a~Material
                                             AND b~Batch = a~Beamno
                                             AND b~MaterialDocument = a~materialdocument
                                             AND B~MaterialDocumentYear = a~materialdocumentyear )
  INNER JOIN YMSEG4 as c ON ( c~MaterialDocument = b~MaterialDocument
                           AND C~MaterialDocumentItem = B~MaterialDocumentItem
                           AND C~MaterialDocumentYear = B~MaterialDocumentYear )
                           WHERE a~Material = @mat-Material AND a~Beamno = @mat-Batch INTO @DATA(lv).

SELECT SINGLE StandardPricePrevYear FROM I_ProductValuationAcct AS D WHERE D~Product = @IV-Material and D~ValuationArea = @IV-Plant
 INTO @DATA(PORATE).

DATA pickrate TYPE p DECIMALS 2.
 SELECT SINGLE ConditionRateValue  FROM I_PurOrdItmPricingElementAPI01  WHERE PurchaseOrder = @MAT-PurchaseOrder
        AND PurchaseOrderItem  =  @mat-PurchaseOrderItem AND  ConditionType = 'ZP01' INTO @pickrate.

     TOTAMT = TOTAMT + ( orgqty * PORATE ).
     TOTNTWT = TOTNTWT + LV-A-Netweight .
     TOTLENGHT = TOTLENGHT + orgqty .
     TOTLEGROSWT = TOTLEGROSWT + LV-A-Grossweight .


      DATA(lv_xml2) =
      |<Row1>| &&
      |<HSNCODE>{ iv-hsncode }</HSNCODE>| &&
      |<material>{ iv-Material }</material>| &&
*      |<Materialdis>{ iv-MaterialDescription }</Materialdis>| &&
      |<uom>{ iv-unit }</uom>| &&
      |<batchno>{ MAT-Batch }</batchno>| &&
     |<PipeNo>{ LV-A-Pipenumber }</PipeNo>| &&
      |<QUANTITY>{ orgqty }</QUANTITY>| &&
     |<GreySort>{ LV-A-Greyshort }</GreySort>| &&
     |<TotalEnds>{ LV-A-Totalends }</TotalEnds>| &&
*      |<weight>{ PONUMBER-c-Grossweight }</weight>| &&
      |<weight>{ LV-A-Grossweight }</weight>| &&
      |<netweight>{ LV-A-Netweight }</netweight>| &&
      |<PICKRATE>{ pickrate }</PICKRATE>| &&
      |<rate>{ PORATE }</rate>| &&
      |<amount>{ iv-NetAmount }</amount>| &&
      |</Row1>|.

        CONCATENATE xsml lv_xml2 INTO  xsml .
        CLEAR  : iv,lv_xml2,PORATE,iv,orgqty,pickrate.

      ENDLOOP .


      DATA(lv_xml3) =
      |<TABLE3>| &&
      |<TOTLENGHT>{ TOTLENGHT }</TOTLENGHT>| &&
      |<TotlGrossweight>{ TOTLEGROSWT }</TotlGrossweight>| &&
      |<netweightTot>{ TOTNTWT }</netweightTot>| &&
      |<amountTot>{ TOTAMT }</amountTot>| &&
      |</TABLE3>| &&
      |<Footer>| &&
      |<Placee></Placee>| &&
      |<Signature>| &&
      |<authosig>{ Register1 }</authosig>| &&
      |</Signature>| &&
      |</Footer>| &&
      |<FooterSF>| &&
*      |<SenderAddress>{ Register1 }</SenderAddress>| &&
      |<SenderAddress>{ billtoadd1-CustomerName }</SenderAddress>| &&
      |<SenderAddress1>{ billtoadd1-city }, { STATE }, {  billtoadd1-PostalCode }</SenderAddress1>| &&
      |<SenderAddress2>{ billtoadd1-TaxNumber3 }</SenderAddress2>| &&
      |<VehicleNumber>{ Vehiclenumber }</VehicleNumber>| &&
      |<Footer>| &&
      |<Place>Am undique</Place>| &&
      |<TextField4>{ billhead-BillingDocumentDate }</TextField4>| &&
      |</Footer>| &&
      |<footertext/>| &&
      |</FooterSF>| &&
      |</form1>|.

      CONCATENATE lv_xml xsml lv_xml3 INTO lv_xml .

      REPLACE ALL OCCURRENCES OF '&' IN lv_xml WITH 'and'.

    ENDIF .

   CALL METHOD ycl_test_adobe=>getpdf(
      EXPORTING
        xmldata  = lv_xml
        template = lc_template_name
      RECEIVING
        result   = result12 ).

  ENDMETHOD.
ENDCLASS.
