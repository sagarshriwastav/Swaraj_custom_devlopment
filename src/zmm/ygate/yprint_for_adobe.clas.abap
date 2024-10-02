CLASS yprint_for_adobe DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

     CLASS-DATA :BEGIN OF wa_add,
 var1(80) TYPE c,
 var2(80) TYPE c,
 var3(80) TYPE c,
 var4(80) TYPE c,
 var5(80) TYPE c,
 var6(80) TYPE c,
 var7(80) TYPE c,
 var8(80) TYPE c,
 var9(80) TYPE c,
 var10(80) TYPE c,
 var11(80) TYPE c,
 var12(80) TYPE c,
 var13(80) TYPE c,
 var14(80) TYPE c,
 var15(80) TYPE c,
 END OF wa_add.

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
        IMPORTING variable        TYPE string
        RETURNING VALUE(result12) TYPE string
        RAISING   cx_static_check .

  PROTECTED SECTION.
  PRIVATE SECTION.


    CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
    CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
    CONSTANTS  lv2_url    TYPE string VALUE 'https://btp-yvzjjpaz.authentication.eu10.hana.ondemand.com/oauth/token'  .
    CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
    CONSTANTS f TYPE string VALUE 'GatePass/GatePass'.


ENDCLASS.



CLASS YPRINT_FOR_ADOBE IMPLEMENTATION.


  METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).
  ENDMETHOD .


  METHOD if_oo_adt_classrun~main.

    DATA(ghjk) =  read_posts( variable = '1200000040'  ) .

  ENDMETHOD.


  METHOD read_posts .
*  select * from  zgate_ddm as a  left JOIN zgateitem_proj as b on a~Gateno = b~Gateno  where a~gateno = @variable   into table @data(it) .
    SELECT * FROM  ygate_ddm   WHERE gateno = @variable   INTO TABLE @DATA(it) .
    SELECT * FROM  ygateitem_proj   WHERE gateno = @variable   INTO TABLE @DATA(it_item) .


    IF it IS NOT INITIAL .

      READ TABLE it INTO DATA(gathd) INDEX 1 .

    ENDIF .



    """"""""""""""""""""""""""""""""""""""""""""""""""""Plant Wise Address, GST & PAN"""""""""""""""""""""""""""""""""""
    IF gathd-plant  = '1100'.
      DATA(gst1)  = '23AAHCS2781A1ZP'.
      DATA(pan1)  = 'AAHCS2781A'.
      DATA(register1) = 'SWARAJ SUITING LIMITED                 '.
      DATA(register2) = 'Spinning Division-I' .
      DATA(register3) = 'B-24 To B-41 Jhanjharwada Industrial Area'.
      DATA(register4) = 'Jhanjharwada, Neemuch - 458441, Madhya Pradesh, India'.
      DATA(cin1) = 'L18101RJ2003PLC018359'.
    ELSEIF gathd-plant  = '1200'.
      gst1  = '23AAHCS2781A1ZP'.
      pan1  = 'AAHCS2781A'.
      register1 = 'SWARAJ SUITING LIMITED'.
      register2 = 'Denim Division-I' .
      register3 = 'B-24 To B-41 Jhanjharwada Industrial Area'.
      register4 = 'Jhanjharwada, Neemuch - 458441, Madhya Pradesh, India'.
      cin1 = 'L18101RJ2003PLC018359'.
    ELSEIF gathd-plant  =  '1300'.
      gst1  = '08AAHCS2781A1ZH'.
      pan1  = 'AAHCS2781A'.
      register1 = 'SWARAJ SUITING LIMITED'.
      register2 = 'Weaving Division-I' .
      register3 = 'F-483 To F-487 RIICO Growth Centre'.
      register4 = 'Hamirgarh, Bhilwara-311025, Rajasthan, India'.
      cin1 = 'L18101RJ2003PLC018359'.
    ELSEIF gathd-plant  =   '1310'.
      gst1  = '23AAHCS2781A1ZP'.
      pan1  = 'AAHCS2781A'.
      register1 = 'SWARAJ SUITING LIMITED'.
      register2 = 'Weaving Division-II' .
      register3 = 'B-24 To B-41 Jhanjharwada Industrial Area'.
      register4 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
      cin1 = 'L18101RJ2003PLC018359'.
    ELSEIF gathd-plant  =   '1400'.
      gst1  = '23AAHCS2781A1ZP'.
      pan1  = 'AAHCS2781A'.
      register1 = 'SWARAJ SUITING LIMITED'.
      register2 = 'Process House-I' .
      register3 = 'B-24 To B-41 Jhanjharwada Industrial Area'.
      register4 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
      cin1 = 'L18101RJ2003PLC018359'.
    ELSEIF gathd-plant  =  '2100'.
      gst1  = '08AABCM5293P1ZT'.
      pan1  = 'AABCM5293P'.
      register1 = 'MODWAY SUITING PVT. LIMITED'.
      register2 = 'Weaving Division-I' .
      register3 = '20th Km Stone, Chittorgarh Road'.
      register4 = 'Takhatpura, Bhilwara-311025, Rajasthan, India'.
      cin1 = 'U18108RJ1986PTC003788'.
    ELSEIF gathd-plant  =  '2200'.
      gst1  = '23AABCM5293P1Z1'.
      pan1  = 'AABCM5293P'.
      register1 = 'MODWAY SUITING PVT. LIMITED'.
      register2 = 'Weaving Division-II' .
      register3 = 'B-24 To B-41 Jhanjharwada Industrial Area'.
      register4 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
      cin1 = 'U18108RJ1986PTC003788'.
    ENDIF.
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    DATA lc_template_name1 TYPE string .
    IF gathd-entrytype = 'WPO'  .
      lc_template_name1 = 'GatePass/GatePass'.

      DATA(lv_xml) = |<form1>| &&
            |<HaderDate>| &&
            |<LeftSide>| &&
            |<GateEntryNo>{ gathd-gateno  }</GateEntryNo>| &&
            |<OwnVehicle>{ gathd-vehicalno }</OwnVehicle>| &&
            |<GateInDateTime>{ gathd-gateindate }{ '/' }{ gathd-gateintm }</GateInDateTime>| &&
            |<GateOutDateTime>{ gathd-gateoutdt  }{ '/' }{ gathd-gateouttm  }</GateOutDateTime>| &&
            |<VehicleName>{ gathd-name1 }</VehicleName>| &&
            |<TransporterName>{ gathd-troper  }</TransporterName>| &&
            |<DriverName>{ gathd-driver  }</DriverName>| &&
            |<DriverLicenseNo>{ gathd-drlisc  }</DriverLicenseNo>| &&
            |</LeftSide>| &&
            |<RightSide>| &&
            |<OperatorName>{ gathd-operator  }</OperatorName>| &&
            |<E-wayBillNoDate>e-way</E-wayBillNoDate>| &&
            |<LRNo.Date>{ gathd-lrno  }{ '/' }{ gathd-lrdate }</LRNo.Date>| &&
            |<WeighBridge>{ gathd-wtbrno  }</WeighBridge>| &&
            |<VehicleName>{ gathd-trunit  }</VehicleName>| &&
            |<GrossWeight>{ gathd-grosswt  }</GrossWeight>| &&
            |<TareWeight>{ gathd-tarewt  }</TareWeight>| &&
            |<NetWeight>{ gathd-netwt  }</NetWeight>| &&
            |<Remarks>{ gathd-remark  }</Remarks>| &&
            |</RightSide>| &&
            |</HaderDate>| &&
            |<Subform1>| &&
            |<Table1>| &&
            |<HeaderRow/>| .

      DATA xsml TYPE string .
      DATA unit TYPE string .
      DATA n TYPE n VALUE 0 .
      LOOP AT it_item INTO DATA(iv) .
        n = n + 1 .

        IF iv-uom = 'ST' .

          unit = 'PC' .

        ELSEIF iv-uom = 'ZST' .

          unit = 'SET' .

        ELSEIF iv-uom = 'ZBL' .

          unit = 'KG' .

        ELSE.

          unit = iv-uom .

        ENDIF .


*        DATA(lv_xml2) =
      lv_xml = lv_xml &&
             |<Row1>| &&
             |<SrNo>{ n }</SrNo>| &&  """"28.12.2022
             |<Cell1>{ iv-maktx }</Cell1>| &&
             |<InvoiceNo>{ gathd-invoice  }</InvoiceNo>| &&
             |<UOM>{ unit  }</UOM>| &&
             |<Qty>{ iv-gateqty  }</Qty>| &&
*       |<Package>{ iv-ZbagQty  }</Package>| &&        27.12.2022 sk
             |<Remark>{ iv-remark  }</Remark>| &&
             |</Row1>| .

*        CONCATENATE xsml lv_xml2 INTO  xsml .
*        CLEAR  : iv,lv_xml2.
      ENDLOOP .



*
*      DATA(lv_xml3) =
    lv_xml = lv_xml &&
             |</Table1>| &&
             |</Subform1>| &&
              |<hide>| &&
              |<PLANT>{  register1 }</PLANT>| &&
              |<ADD1>{  register2 }</ADD1>| &&
              |<ADD2>{  register3 }</ADD2>| &&
              |<SIGN>{  register1 }</SIGN>| &&
              |<PAN>{ pan1 }</PAN>| &&
              |<GSTIN>{ gst1 }</GSTIN>| &&
              |<CINNO>{ cin1 }</CINNO>| &&
              |</hide>| &&
            |</form1>|  .

*      CONCATENATE lv_xml xsml lv_xml3 INTO lv_xml .

    ELSEIF gathd-entrytype = 'RGP'  OR gathd-entrytype = 'NRGP' .

      IF gathd-entrytype = 'RGP' .
        DATA(gatentry)  =  'Returnable Gate Pass' .
      ELSE .
        gatentry  =  'Non-Returnable Gate Pass' .
      ENDIF .









      lc_template_name1 = 'GATEPASSRETURNABL/GATEPASSRETURNABL' .
      READ TABLE it_item INTO DATA(wa) INDEX 1 .
      SELECT SINGLE * FROM i_supplier WHERE supplier = @wa-lifnr INTO @DATA(tab_sup).

      SELECT SINGLE * FROM zmm_gr_address  WHERE addressid = @tab_sup-addressid INTO @DATA(adds).

      SELECT SINGLE * FROM i_addressphonenumber_2 WITH PRIVILEGED ACCESS WHERE addressid = @adds-addressid AND phonenumbertype  = '3' INTO @DATA(add1).

      lv_xml =
      |<form1>| &&
      |<Page>| &&
      |<GATEPASS>{ gatentry }</GATEPASS>| &&
      |<Hdata>| &&
         |<Left>| &&
            |<DCNo>{ gathd-gateno }</DCNo>| &&
            |<PartyCode>{ wa-lifnr }</PartyCode>| &&
            |<artyName>{ wa-name1 }</artyName>| &&
            |<Notes>Licebit auctore</Notes>| &&
            |<Address>{ wa-address1 }{ adds-streetname }{ adds-streetprefixname1 }{ adds-streetprefixname2 }{ adds-city }{ adds-postalcode }{ adds-region }</Address>| &&
            |<GSTIN>{ tab_sup-taxnumber3 }</GSTIN>| &&
            |<GROSSWT>{ gathd-grosswt }</GROSSWT>| &&
            |<purpose>{ gathd-remark }</purpose>| &&
         |</Left>| &&
         |<Right>| &&
            |<DCDate>{ gathd-entrydate }</DCDate>| &&
            |<VehicleNo>{ gathd-vehicalno }</VehicleNo>| &&
            |<Transporter>{ gathd-troper }</Transporter>| &&
            |<ChallanNo>{ wa-zinvoice }</ChallanNo>| &&
            |<PARTYMOBNO>{ add1-internationalphonenumber }</PARTYMOBNO>| &&
         |</Right>| &&
      |</Hdata>| &&
      |<Table>| &&
         |<Table1>| &&
            |<HeaderRow/>| .


      SELECT SINGLE * FROM i_purchasinggroup WHERE purchasinggroup = @gathd-puchgrp INTO @DATA(gate).
*data n type n value 0 .
      LOOP AT it_item INTO iv .
        DATA unit1 TYPE string.         """""30.12
        IF gathd-refgate IS INITIAL .

          DATA(gateqty)  = iv-outqty .

        ELSE  .

          gateqty  = iv-gateqty .

        ENDIF .

        IF   gathd-entrytype = 'NRGP' .
          gateqty  = iv-gateqty .

        ENDIF .


        """"""""""
        IF iv-uom = 'ST' .

          unit1 = 'PC' .

        ELSEIF iv-uom = 'ZST' .

          unit1 = 'SET' .

        ELSEIF iv-uom = 'ZBL' .

          unit1 = 'KG' .

        ELSE.

          unit1 = iv-uom .

        ENDIF .




        n = n + 1 .
        lv_xml = lv_xml &&
               |<Row1>| &&
               |<Cell1>{ n }</Cell1>| &&
               |<Itemcode>{ iv-maktx }</Itemcode>| &&
               |<ItemDesc>{ iv-matnr }</ItemDesc>| &&
               |<UOM>{ unit1  }</UOM>| &&
               |<HSN>{ iv-lpnum  }</HSN>| &&
               |<Quantity>{ gateqty  }</Quantity>| &&
               |<Retrun>{ iv-outvalue }</Retrun>| &&
               |</Row1>|.






*        CONCATENATE xsml lv_xml2 INTO  xsml .
*        CLEAR  : iv,lv_xml2,gateqty.
      ENDLOOP .



*
      lv_xml = lv_xml &&

  |</Table1>| &&
   |</Table>| &&
   |</Page>| &&
   |<Platname>{  register1 }</Platname>| &&
   |<address1>{  register2 }</address1>| &&
   |<address2>{  register3 }</address2>| &&
   |<adress3></adress3>| &&
   |<Signature>{  register1 }</Signature>| &&
   |<PAN>{ pan1 }</PAN>| &&
   |<GSTIN>{ gst1 }</GSTIN>| &&
   |<CINNO>{ cin1 }</CINNO>| &&
  |</form1>|.

*      CONCATENATE lv_xml xsml lv_xml3 INTO lv_xml .

    ELSEIF gathd-entrytype = 'DEL' or gathd-entrytype = 'RDEL'    .

      lc_template_name1 = 'Grey_gate_pass/Grey_gate_pass' .


       SELECT * FROM  ygate_ddm   AS a
       LEFT OUTER JOIN  ygateitem_proj  as b ON (  b~Gateno = a~Gateno  )
          WHERE a~gateno = @variable   INTO TABLE @DATA(it_FI) .


      SELECT SINGLE * FROM i_billingdocumentbasic WHERE billingdocument = @gathd-invoice INTO @DATA(billtab).

DATA DELDOCUMENT1 TYPE vbeln_vl.
*DATA REFDOCUMENT1 TYPE vbeln_vl.
DATA:LV(10) TYPE C.
      READ TABLE it_FI  INTO DATA(wa_data) INDEX 1 .

 CONDENSE wa_data-B-Sono NO-GAPS.
SHIFT wa_data-B-Sono RIGHT DELETING TRAILING SPACE.
CONDENSE wa_data-B-Sono NO-GAPS.
SHIFT wa_data-B-Sono LEFT DELETING LEADING SPACE.
CONDENSE wa_data-B-Sono NO-GAPS.

    DATA(LEN) = STRLEN( wa_DATA-b-Sono ).
 if  LEN <= '8'.
 CONCATENATE '00' wa_data-B-Sono INTO LV.
 CONDENSE LV NO-GAPS.
 ENDIF.

     SELECT SINGLE b~taxnumber3,
 b~customer,
 b~TelephoneNumber1,
 c~organizationname1,
 c~organizationname2,
 c~organizationname3,
 c~housenumber,
 c~streetname,
 c~streetprefixname1,
 c~streetprefixname2,
 c~streetsuffixname1,
 c~streetsuffixname2,
 c~districtname,
 c~cityname,
 c~postalcode,
 c~addresssearchterm1,
 d~regionname
 FROM i_salesdocumentpartner AS a
 LEFT JOIN i_customer AS b ON ( b~customer = a~customer )
 LEFT JOIN i_address_2 WITH PRIVILEGED ACCESS AS c ON ( c~addressid = b~addressid )
 LEFT JOIN i_regiontext AS d ON ( d~region = b~region AND d~language = 'E' AND d~country = 'IN ')
* left join I_Region as D on ( D~Region = a~ )
 WHERE salesdocument = @LV AND partnerfunction = 'WE' INTO @DATA(shiptoparty).

 wa_add-var1 = shiptoparty-organizationname1.
 wa_add-var2 = shiptoparty-organizationname2.
 wa_add-var3 = shiptoparty-organizationname3.

 DATA(shipaddname) = zseparate_address=>separate( CHANGING var = wa_add ).



      lv_xml =

      |<form1>| &&
      |<PARTY>{ shipaddname }</PARTY>| &&
      |<GPNo>{ gathd-gateno }</GPNo>| &&
      |<Transport>{ gathd-troper }</Transport>| &&
      |<TruckNo>{ gathd-vehicalno }</TruckNo>| &&
      |<GPDate>{ gathd-GateOutDt }/{ gathd-GateOutTm }</GPDate>| &&
      |<Table1>| &&
      |<HeaderRow/>| .

DATA TOTQTY TYPE P DECIMALS 3.
DATA TOTWT TYPE P DECIMALS 3.
DATA TOTPC TYPE I.
DATA DEL TYPE C LENGTH 10.

    LOOP AT it_FI INTO DATA(IV_FI) .

    SELECT SINGLE BASEUNIT FROM I_PRODUCT WHERE Product = @iv_fi-B-Matnr INTO @DATA(LV_UO).

      SELECT SINGLE ProductDescription FROM I_ProductDescription WHERE Product = @iv_fi-B-Matnr  AND Language = 'E'  INTO @DATA(desc).



        TOTQTY = TOTQTY + IV_FI-B-OrderQty .
*        TOTWT  = TOTWT .
        TOTPC  = TOTPC + IV_FI-B-ZbagQty.

        iv-uom = SWITCH #( iv-uom
                           WHEN 'ST' THEN 'PC'
                           WHEN 'ZST' THEN 'SET'
                           WHEN 'ZBAL' THEN 'KG'
                           WHEN 'ZBL' THEN 'KG'
                           ELSE iv-uom ).

        lv_xml = lv_xml &&

          |<Row1>| &&
         |<ChallanNo>{ IV_FI-B-Delievery }</ChallanNo>| &&
         |<Material>{ desc }</Material>| &&
         |<TotalPcs>{ IV_FI-B-ZbagQty }</TotalPcs>| &&
         |<GMtrs>{ IV_FI-B-OrderQty }</GMtrs>| &&
*         |<gross>{ gross }</gross>| &&
         |<Uom>{ LV_UO }</Uom>| &&
         |</Row1>|.

      ENDLOOP.

   DATA GROSS TYPE P DECIMALS 3 .
     select  SUM( c~GrossWeight ) as GrossWeight
         from YGATECDS_PRINT  as a
         LEFT OUTER JOIN I_DeliveryDocumentItem as b ON ( b~DeliveryDocument = A~Delievery )
         LEFT OUTER JOIN zpack_HDR_DEF AS C ON  ( RecBatch = b~Batch )
         where a~gateno = @variable AND B~Batch <> ''  INTO @GROSS .
*AND B~Batch <> ''
      lv_xml = lv_xml &&
   |<ROW2>| &&
   |<TOTALPCS>{ TOTPC }</TOTALPCS>| &&
   |<TOTALQTY>{ TOTQTY }</TOTALQTY>| &&
   |<TOTALWT></TOTALWT>| &&
   |</ROW2>| &&
   |</Table1>| &&
   |<Gross>{ GROSS }</Gross>| &&
   |<Remark>{ gathd-remark }</Remark>| &&
   |<PLANT>{ register1 }</PLANT>| &&
   |<ADD1>{ register2 }</ADD1>| &&
   |<ADD2>{ register3 }</ADD2>| &&
   |<ADD3>{ register4 }</ADD3>| &&
   |<SIGN>{ register1 }</SIGN>| &&
   |<CINNO>{ cin1 }</CINNO>| &&
   |<GSTIN>{ gst1 }</GSTIN>| &&
   |<PAN>{ pan1 }</PAN>| &&
   |</form1>|.


*      CONCATENATE lv_xml xsml lv_xml3 INTO lv_xml .
    ENDIF .


      CALL METHOD ycl_test_adobe=>getpdf(
       EXPORTING
         xmldata  = LV_XML
         template = lc_template_name1
       RECEIVING
         result   = result12 ).

  ENDMETHOD.
ENDCLASS.
