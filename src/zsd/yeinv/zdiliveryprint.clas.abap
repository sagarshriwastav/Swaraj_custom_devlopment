
CLASS zdiliveryprint DEFINITION
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

    TYPES :
      BEGIN OF ty1,
        sno1         TYPE string,
        batch1       TYPE string,
        netweight1   TYPE string,
        grossweight1 TYPE string,

        sno2         TYPE string,
        batch2       TYPE string,
        netweight2   TYPE string,
        grossweight2 TYPE string,

        sno3         TYPE string,
        batch3       TYPE string,
        netweight3   TYPE string,
        grossweight3 TYPE string,
      END OF ty1 .

    DATA it_deli TYPE TABLE OF  ty1  .
    DATA wa_deli TYPE ty1.

    CLASS-METHODS :

      create_client
        IMPORTING url           TYPE string
        RETURNING VALUE(result) TYPE REF TO if_web_http_client
        RAISING   cx_static_check ,

      read_posts
        IMPORTING VALUE(variable) TYPE string

        RETURNING VALUE(result12) TYPE string
        RAISING   cx_static_check .

  PROTECTED SECTION.
  PRIVATE SECTION.

    CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
    CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
    CONSTANTS  lv2_url    TYPE string VALUE 'https://sagar.authentication.eu10.hana.ondemand.com/oauth/token'  .
    CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
    CONSTANTS lc_template_name TYPE string VALUE 'ZDILIVERYPRINT/ZDILIVERYPRINT'.

ENDCLASS.



CLASS ZDILIVERYPRINT IMPLEMENTATION.


  METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).
  ENDMETHOD .


  METHOD if_oo_adt_classrun~main.

    DATA(xml)  = read_posts( variable = '8222310011'  )   .

  ENDMETHOD.


  METHOD read_posts .
*    TYPES: BEGIN OF ts_itab,
*             include structure i_deliverydocumentitem.
*    TYPES: lot TYPE n LENGTH 3,
*           END OF ts_itab.
    SELECT SINGLE * FROM i_deliverydocument WHERE deliverydocument = @variable INTO  @DATA(it_tab) .



    SELECT a~*,
           000 AS lot
            FROM i_deliverydocumentitem AS a WHERE deliverydocument = @it_tab-deliverydocument
    AND batch IS NOT INITIAL INTO TABLE @DATA(it_itab).



    SELECT * FROM i_deliverydocumentitem AS a
*LEFT OUTER JOIN YPP_PACKING_CDS_FIN AS B ON ( A~DeliveryDocument = B~DeliveryDocument AND a~DeliveryDocumentItem = B~DeliveryDocumentItem )
     WHERE deliverydocument = @it_tab-deliverydocument AND batch IS INITIAL  INTO TABLE @DATA(it_itab1).

*    LOOP AT it_itab INTO DATA(lv1) .

*     DATA(lotno) = VALUE #( it_itab1[ deliverydocument = lv1-a-deliverydocument deliverydocumentitem = lv1-a-higherlvlitmofbatspltitm ]-yy1_lotno_dli OPTIONAL ).
*      IF lotno IS NOT INITIAL.
*      if lv1-a-Division  = '30' .
*      SELECT SINGLE bagnumber FROM zpackncds  WHERE
*               lotnumber = @lotno AND batch = @lv1-a-batch  AND Grosswt IS NOT INITIAL INTO @DATA(lot) .
*
*      else .
*      SELECT SINGLE bagnumber FROM zpackncds  WHERE
*               lotnumber = @lotno AND batch = @lv1-a-batch INTO @lot .
*
*      endif .
*
*
*        lv1-lot = lot.
*        MODIFY it_itab FROM lv1 TRANSPORTING lot.
*      ENDIF.
*      clear : Lot .
*    ENDLOOP .

*    if it_tab-d









*    SELECT * FROM zpackncds FOR ALL ENTRIES IN @it_itab1
*     WHERE batch = @it_itab1-batch INTO TABLE @DATA(matdocdata) .
*     sort matdocdata ASCENDING by LotNumber BagNumber.
*
    SELECT SINGLE * FROM i_sddocumentpartner WITH PRIVILEGED ACCESS  WHERE sddocument = @it_tab-deliverydocument AND partnerfunction = 'WE' INTO @DATA(shipto) .
    SELECT SINGLE * FROM i_sddocumentpartner WITH PRIVILEGED ACCESS WHERE sddocument = @it_tab-deliverydocument AND partnerfunction = 'RE' INTO @DATA(billto) .

    SELECT SINGLE * FROM zsd_dom_address WITH PRIVILEGED ACCESS WHERE addressid = @shipto-addressid INTO @DATA(shiptoadd1)   .


    SELECT SINGLE * FROM zsd_dom_address WITH PRIVILEGED ACCESS WHERE addressid = @billto-addressid INTO @DATA(billtoadd1)   .

    READ TABLE it_itab1 INTO DATA(item1) INDEX 1 .


if item1-Division = '30'  .

 SORT it_itab ASCENDING BY a-batch .

else .
 SORT it_itab ASCENDING BY a-material lot .
endif .


    DATA billtoaddrs TYPE string.
    DATA billtoaddrs1 TYPE string.



    DATA(lv)  = 1 .


    DELETE it_itab1 WHERE batch NE ' ' .
    SORT it_itab1 BY deliverydocumentitem .
select single * from i_salesdocument where SalesDocument = @item1-referencesddocument into @data(salesata) .
select single * from I_SalesDocumentItem where SalesDocument = @item1-referencesddocument into @data(salesataitem) .

select single * from I_BillingDocumentItem as a inner join I_BillingDocumentBasic as b on ( a~BillingDocument =  b~BillingDocument )
where a~ReferenceSDDocument = @it_tab-deliverydocument and b~BillingDocumentIsCancelled is INITIAL
and b~CancelledBillingDocument is INITIAL AND b~SDDocumentCategory  NE 'N' INTO @DATA(SALESDATA)  .

* SELECT SINGLE * FROM YCONSIGNEDATA_PR1 WITH PRIVILEGED ACCESS WHERE Docno = @SALESDATA-b-BillingDocument AND Doctype = 'PS' INTO  @DATA(billtoadd) .

*    IF billtoadd-Billtobuyrname IS NOT INITIAL .
*    billtoaddrs  = billtoadd-Billtobuyrname .
*    DATA(adde) =  |{ billtoadd-Billtostreet1 },{ billtoadd-Billtostreet2 },{ billtoadd-Billtostreet3 },{ billtoadd-Billtocity },{ billtoadd-Billtocountry }| .
*    ELSE .
*    billtoaddrs = billtoadd1-customername .
*    adde = |{ billtoadd1-streetprefixname1 },{ billtoadd1-streetprefixname2 },{ billtoadd1-streetsuffixname1 },{ billtoadd1-streetsuffixname2 },{ billtoadd1-cityname },{ billtoadd1-postalcode },{ billtoadd1-country }| .
*    ENDIF.
*    IF billtoadd-Constoname IS NOT INITIAL .
*    billtoaddrs1  = billtoadd-Constoname .
*    DATA(adde2) = |{ billtoadd-Constostreet1 },{ billtoadd-Constostreet2 },{ billtoadd-Constostreet3 },{ billtoadd-Constocity },{ billtoadd-Constocountry }|.
*    ELSE.
*    billtoaddrs1 = shiptoadd1-customername .
*    adde2 = |{ shiptoadd1-streetprefixname1 },{ shiptoadd1-streetprefixname2 },{ shiptoadd1-streetsuffixname1 },{ shiptoadd1-streetsuffixname2 },{ shiptoadd1-cityname },{ shiptoadd1-postalcode },{ shiptoadd1-country }| .
*    ENDIF.


*and b~SDDocumentCategory  != 'N' .
*data Carton type string.
*if salesataitem-YY1_TypeOfCartonPackin_SDI = 'Neutral_Carton'.
*Carton = 'Neutral Carton'.
*elseif salesataitem-YY1_TypeOfCartonPackin_SDI = 'Neutral_Patlets'.
*Carton = 'Neutral Patlets'.
*elseif salesataitem-YY1_TypeOfCartonPackin_SDI = 'Neutral_Rolls'.
*Carton = 'Neutral Rolls'.
*elseif salesataitem-YY1_TypeOfCartonPackin_SDI = 'Regular_Carton'.
*Carton = 'Regular Carton'.
*elseif salesataitem-YY1_TypeOfCartonPackin_SDI = 'Regular_Patlets'.
*Carton = 'Regular Patlets'.
*elseif salesataitem-YY1_TypeOfCartonPackin_SDI = 'Regular_Rolls'.
*Carton = 'Regular Rolls'.
*endif.
*DATA(INVDATE)  =



    DATA(head_xml) =
            |<form1>| &&
            |<Page>| &&
            |<Header/>| &&
            |<Subform1>| &&
            |<BillTOParty>| &&
            |<BillTOPartyf>{ billtoaddrs }</BillTOPartyf>| &&
*            |<Adnr1>{ adde }</Adnr1>| &&
            |</BillTOParty>| &&
            |<ShipToParty>| &&
            |<ShipToPartyf>{ billtoaddrs1 },</ShipToPartyf>| &&
*            |<Adnr1>{ adde2 }</Adnr1>| &&
            |</ShipToParty>| &&
            |<Subform2>| &&
            |<SalesOrder>{ item1-referencesddocument }</SalesOrder>| &&
*            |<CartonType>{ Carton }</CartonType>| &&
            |<Destination>{ salesata-IncotermsLocation1 }</Destination>| &&
*            |<TruckNo>{ it_tab-YY1_VehicleNumber_DLH }</TruckNo>| &&
*            |<ContainerNo>{ it_tab-YY1_VehicleContainerNu_DLH }</ContainerNo>| &&
            |</Subform2>| &&
            |<Subform3>| &&
*            |<PackingMode>{ wa_tab-a-pa }</PackingMode>| &&
            |<invoiceandDe>| &&
            |<deliveryNo>{ it_tab-deliverydocument }</deliveryNo>| &&
            |<InvoiceNo>{ SALESDATA-b-BillingDocument }</InvoiceNo>| &&
            |</invoiceandDe>| &&
            |<date>| &&
            |<deliveryDate>{ it_tab-documentdate+6(2) }/{ it_tab-documentdate+4(2) }/{ it_tab-documentdate+0(4) }</deliveryDate>| &&
            |<InvoiceDate>{  SALESDATA-b-BillingDocumentDate+6(2) }/{  SALESDATA-b-BillingDocumentDate+4(2) }/{  SALESDATA-b-BillingDocumentDate+0(4) }</InvoiceDate>| &&
            |</date>| &&
*            |<RFIDSealNo>{ SALESDATA-b-YY1_RFIDNumber_BDH }</RFIDSealNo>| &&
*            |<LineSealNo>{ SALESDATA-b-YY1_LineSealNumber_BDH }</LineSealNo>| &&
            |</Subform3>| &&
            |<Subform4>|.

    DATA rat TYPE p DECIMALS 2 .
    DATA xsml TYPE string .
    DATA xsml1 TYPE string .
    DATA xsml2 TYPE string .
    DATA xml1 TYPE string .

    DATA n TYPE n LENGTH 1 VALUE 1.
    DATA: tabix1 TYPE sy-tabix,
          tabix2 TYPE sy-tabix.
    LOOP AT it_itab1 ASSIGNING FIELD-SYMBOL(<fs>)  .
      tabix1 = sy-tabix.
      data desc type string .


      SELECT SINGLE * FROM i_salesdocumentitem  WHERE salesdocument = @<fs>-referencesddocument
      AND salesdocumentitem = @<fs>-referencesddocumentitem  INTO @DATA(sales) .

*      IF sales-yy1_customermaterialde_sdi IS NOT INITIAL .
*
*        desc =  sales-yy1_customermaterialde_sdi .
*      ELSE .

        SELECT SINGLE productdescription FROM i_productdescription
        WHERE product = @<fs>-material AND language = 'E'  INTO @desc  .
*SELECT SINGLE YY1_FullDescription_PRD FROM I_PRODUCT WHERE
* Product = @<fs>-Material    INTO @DATA(MAT2)  .
*
*
*      desc =  |{ desc } { MAT2 }| .
*
*
*      ENDIF .
      SELECT SUM( grosswt ) FROM zpackn_cds AS a INNER JOIN i_deliverydocumentitem AS b
                                    ON ( a~batch  = b~batch   )
                                    WHERE b~higherlvlitmofbatspltitm  =  @<fs>-deliverydocumentitem
*                                    AND a~lotnumber = @<fs>-yy1_lotno_dli and b~DeliveryDocument = @it_tab-deliverydocument
                                    INTO @DATA(gross)  .
if <fs>-Division = '30' .
      SELECT SUM( grosswt ) FROM zpackn_cds AS a INNER JOIN i_deliverydocumentitem AS b
                                    ON ( a~batch  = b~batch   )
                                    WHERE b~higherlvlitmofbatspltitm  =  @<fs>-deliverydocumentitem
*                                    AND a~lotnumber = @<fs>-yy1_lotno_dli+0(4) and b~DeliveryDocument = @it_tab-deliverydocument
                                    INTO @gross  .


endif .



*      IF gross IS INITIAL .
*        gross = <fs>-itemgrossweight .
*      ENDIF .
      gross = COND #(  WHEN gross IS INITIAL THEN <fs>-itemgrossweight ELSE gross ).
      DATA:int TYPE sy-tabix.
      int = tabix1 - 1.
      head_xml = head_xml && |<Table8>| &&
             |<Row1>|   &&
             |<Table9>| &&
             |<Row1>| &&
             |<sn>{ sy-abcde+int(1) }</sn>| &&
*             |<MaterialDescription>{ <fs>-material }({ desc })---LotNo( { <fs>-yy1_lotno_dli } )</MaterialDescription>| &&
             |<NetWt>{ <fs>-cumulativebatchqtyinbaseunit }</NetWt>| &&
             |<GrossWt>{ gross }</GrossWt>| &&
         |</Row1>| &&
         |</Table9>| &&
         |</Row1>| .
*    |<Row2>| &&
*    |<Table10>| &&
*     |<Row1>| .

      CLEAR: tabix2.
      DATA(lt_tab) = it_itab.
*      DELETE lt_tab WHERE material NE <fs>-material.
      DELETE lt_tab WHERE a-higherlvlitmofbatspltitm NE <fs>-deliverydocumentitem.
      DATA(len) = lines( lt_tab ).


*      LOOP AT it_itab INTO DATA(iv) WHERE material = <fs>-material .
      LOOP AT it_itab INTO DATA(iv) WHERE a-higherlvlitmofbatspltitm = <fs>-deliverydocumentitem .
        tabix2 = tabix2 + 1.

*select single * from YPP_PACKING_CDS_FIN  where
*DeliveryDocument = @iv-DeliveryDocument and DeliveryDocumentItem = @iv-DeliveryDocumentItem
*and Batch = @iv-Batch into @data(matdocdata)  .

*        SELECT SINGLE * FROM zpackncds  WHERE
*        lotnumber = @<fs>-yy1_lotno_dli AND batch = @iv-a-batch INTO @DATA(matdocdata)  .

if <fs>-Division = '30' .  "Knitting logic for gross weight
* SELECT SINGLE * FROM zpackncds  WHERE
*        lotnumber = @<fs>-yy1_lotno_dli+0(4) AND batch = @iv-a-batch AND Grosswt IS NOT INITIAL INTO @matdocdata  .
IF iv-lot IS INITIAL .
* iv-lot  = matdocdata-batch+7(3) .
ENDIF  .
endif .


        IF n EQ 1 .
*          DATA(header) =     |<Row2>| &&
          head_xml = head_xml && |<Row2>| &&
               |<Table10>| &&
                 |<Row1>| .
        ENDIF .

*        xml1    =  xml1 &&    |<Table{ 10 + n }>| &&
        head_xml =  head_xml && |<Table{ 10 + n }>| &&
                     |<Row1>| &&
                     |<sn>{ tabix2 }</sn>| &&
                     |<Batch>{ iv-lot }</Batch>| &&
                     |<NetWeight>{ iv-a-actualdeliveryquantity }</NetWeight>| &&
*                     |<GrossWeight>{ matdocdata-grosswt }</GrossWeight>| &&
                     |</Row1>| &&
                   |</Table{ 10 + n }>| .
        IF ( n EQ 3 ) OR tabix2 = len.

          head_xml = head_xml && |</Row1>| &&
                         |</Table10>| &&
                         |</Row2>|.
*          xsml1 = header && xml1 && footer.

          CLEAR :   xml1 .
          n = 1 .
*        ELSEIF tabix2 = len AND n NE 3.
*          head_xml = head_xml && |</Row1>| &&
*                       |</Table10>| &&
*                       |</Row2>|.
**          xsml1 = header && xml1 && footer.
*
*          CLEAR :   xml1 .
        ELSE .
          n = n + 1 .
        ENDIF.

*   clear matdocdata .
      ENDLOOP .

*      DATA(lv_xml_3) =
*                 |</Row1>| &&
*                 |</Table10>| &&
*                 |</Row2>| &&
      head_xml = head_xml &&
                     |<Row3>| &&
                     |<Table15>| &&
                     |<Row1>| &&
                     |<TotGrosswt>Total Gross Wt</TotGrosswt>| &&
                     |<Totnetwtt>Total Net Wt</Totnetwtt>| &&
            |</Row1>| &&
        |</Table15>| &&
    |</Row3>| &&
    |</Table8>|  .

*XSML1 =  XSML1  && LV_XML_1 && xsml && LV_XML_3 .
*      CLEAR : lv_xml_1 ,xsml ,lv_xml_3 .
      CLEAR : gross.
    ENDLOOP .

* CONCATENATE xsml lv_xml2 INTO  xsml .
* CLEAR  : iv,lv_xml2,rat,iv

*    DATA(lv_xml3) =
    head_xml = head_xml &&
              |</Subform4>| &&
              |</Subform1>| &&
              |</Page>| &&
              |</form1>|.

    DATA(lv_xml) = head_xml.
*    lv_xml = lv_xml && lv_xml_1

   CALL METHOD ycl_test_adobe=>getpdf(
      EXPORTING
        xmldata  = lv_xml
        template = lc_template_name
      RECEIVING
        result   = result12 ).



  ENDMETHOD.
ENDCLASS.
