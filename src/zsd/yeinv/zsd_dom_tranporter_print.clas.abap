CLASS zsd_dom_tranporter_print DEFINITION
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
        IMPORTING VALUE(variable) TYPE string
                  VALUE(remark) TYPE string
        RETURNING VALUE(result12) TYPE string
        RAISING   cx_static_check .

  PROTECTED SECTION.
  PRIVATE SECTION.


    CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
    CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
    CONSTANTS  lv2_url    TYPE string VALUE 'https://btp-yvzjjpaz.authentication.eu10.hana.ondemand.com/oauth/token'  .
    CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
    CONSTANTS lc_template_name TYPE string VALUE 'zsd_dom_tranporter_print/zsd_dom_tranporter_print'.
*    CONSTANTS lc_template_name1 TYPE string VALUE 'ZEXPORTINVOICE/ZEXPORTINVOICE'.
*    CONSTANTS lc_template_name2 TYPE string VALUE 'SCRAP_FI_SD_INVOICE/SCRAP_FI_SD_INVOICE'.
ENDCLASS.



CLASS ZSD_DOM_TRANPORTER_PRINT IMPLEMENTATION.


  METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).

  ENDMETHOD .


  METHOD if_oo_adt_classrun~main.



    DATA(xml)  = read_posts( variable = '2223100036' remark = '' )   .


  ENDMETHOD.


  METHOD read_posts .
    DATA descripition TYPE string.

    DATA var1 TYPE zchar10.
    var1 = variable.
    var1 =   |{ |{ var1 ALPHA = OUT }| ALPHA = IN }| .
    variable = var1.


 IF remark is INITIAL OR remark = '' .
  SELECT SINGLE remark FROM zinv_terms6 WHERE invoice = @var1 INTO @DATA(remark1) .
  ELSE.
  remark1 = remark  .
  ENDIF.

    SELECT SINGLE * FROM i_billingdocumentbasic WHERE billingdocument =  @variable  INTO @DATA(billhead) .

        SELECT * FROM  yeinvoice_cdss  as a
     LEFT OUTER JOIN ZPP_DELIVERY_PICK_RATE as b ON  ( b~DeliveryDocument = a~delivery_number AND b~deliverydocumentitem = a~DELIVERY_NUMBER_item )
           WHERE billingdocument = @variable   INTO TABLE @DATA(IT).
    SELECT SINGLE * FROM  i_billingdocumentitem AS a
    LEFT OUTER JOIN i_deliverydocumentitem AS b ON ( a~referencesddocument = b~deliverydocument AND a~referencesddocumentitem = b~deliverydocumentitem )
    INNER JOIN   i_deliverydocument AS f ON ( b~deliverydocument = f~deliverydocument )
    LEFT OUTER JOIN i_shippingtypetext AS s ON ( f~shippingtype = s~shippingtype AND s~language = 'E'  )
       WHERE  billingdocument  =  @variable INTO @DATA(billingitem)  .
*IF BILLINGITEM-SA
    SELECT * FROM i_billingdocumentitem WHERE billingdocument = @billingitem-a-referencesddocument INTO TABLE @DATA(deli) .

    DELETE ADJACENT DUPLICATES FROM deli COMPARING referencesddocument.

*if billhead-CreatedByUser id
    SELECT SINGLE userdescription  FROM i_user WITH PRIVILEGED ACCESS WHERE  userid = @billhead-createdbyuser INTO @DATA(username).




    SELECT SINGLE * FROM i_salesdocument WHERE salesdocument  =  @billingitem-a-salesdocument  INTO  @DATA(salesorder)  .
    READ TABLE it INTO  DATA(wt) INDEX 1 .

    SELECT SINGLE * FROM i_customer WHERE customer = @wt-a-billtoparty INTO @DATA(billto) .

    SELECT SINGLE * FROM  i_customer AS a  INNER JOIN i_billingdocumentpartner AS b ON ( a~customer = b~customer )
    WHERE b~partnerfunction = 'WE'  AND b~billingdocument = @variable   INTO @DATA(shipto)  .


    SELECT SINGLE * FROM  i_customer AS a  INNER JOIN i_billingdocumentpartner AS b ON ( a~customer = b~customer )
    WHERE b~partnerfunction = 'RE'  AND b~billingdocument = @variable   INTO @DATA(billttelo)  .

    SELECT SINGLE b~suppliername FROM i_billingdocumentpartner  AS a  INNER JOIN i_supplier AS b ON ( a~supplier = b~supplier )
   WHERE a~partnerfunction = 'ZT'  AND a~billingdocument = @variable   INTO @DATA(tranporter)  .

    SELECT SINGLE b~suppliername FROM i_billingdocumentpartner  AS a  INNER JOIN i_supplier AS b ON ( a~supplier = b~supplier )
   WHERE a~partnerfunction = 'ZA'  AND a~billingdocument = @variable   INTO @DATA(aggentname)  .

    SELECT SINGLE * FROM i_regiontext   WHERE  region = @billto-region AND language = 'E' AND country = @billto-country  INTO  @DATA(regiontext1) .


    SELECT SINGLE * FROM i_regiontext   WHERE  region = @shipto-a-region AND language = 'E' AND country = @shipto-a-country  INTO  @DATA(regiontext2) .


    SELECT SINGLE * FROM i_paymenttermstext WHERE paymentterms = @billhead-customerpaymentterms AND language = 'E'
    INTO @DATA(terms) .

    SELECT SINGLE * FROM ZI_DeliveryDocumentAddress2 WITH PRIVILEGED ACCESS WHERE addressid = @shipto-b-addressid INTO @DATA(shiptoadd1)   .

    SELECT SINGLE * FROM zsd_dom_address WITH PRIVILEGED ACCESS WHERE addressid = @billto-addressid INTO @DATA(billtoadd1)   .

    SELECT SINGLE EmailAddress FROM I_SalesDocumentPartner WHERE customer = @wt-a-billtoparty
                                          AND EmailAddress <> '' INTO @DATA(BilltoEmailAdrs) .

       SELECT SINGLE EmailAddress FROM I_SalesDocumentPartner WHERE customer = @shipto-B-Customer
                                             AND EmailAddress <> '' INTO @DATA(ShipptoEmailAdrs) .



    IF it IS NOT INITIAL .

      READ TABLE it INTO DATA(gathd) INDEX 1 .

    ENDIF .



    CONCATENATE salesorder-salesdocumentdate+6(2) '/' salesorder-salesdocumentdate+4(2) '/' salesorder-salesdocumentdate+0(4) INTO DATA(salesorderdate) .
*    CONCATENATE  billhead-yy1_lcdate_bdh+6(2) '/'  billhead-yy1_lcdate_bdh+4(2) '/'  billhead-yy1_lcdate_bdh+0(4) INTO  DATA(LCDATE)  .
*
    CONCATENATE  billhead-yy1_lrdate_bdh+6(2) '/'  billhead-yy1_lrdate_bdh+4(2) '/'  billhead-yy1_lrdate_bdh+0(4) INTO  DATA(lrdate) .

******* GROSS WEIGHT LOGIC FOR

    SELECT
    SUM(  grosswt )
       FROM i_deliverydocumentitem  AS a
       INNER JOIN zpackn_cds AS b ON
                        ( a~batch = b~batch  AND a~batch NE ' ' AND  b~batch NE ' ' )
                                           WHERE  a~deliverydocument =  @billingitem-a-referencesddocument   INTO @DATA(grossweight) .

    IF grossweight  IS INITIAL .
      SELECT SUM( itemgrossweight ) FROM i_deliverydocumentitem WHERE deliverydocument = @billingitem-a-referencesddocument INTO @grossweight .

    ENDIF .


    IF billhead-division = '50' .

      SELECT SUM( itemgrossweight ) FROM i_deliverydocumentitem WHERE deliverydocument = @billingitem-a-referencesddocument INTO @grossweight .


    ENDIF.

    IF billhead-division = '30' .

      SELECT
         SUM(  grosswt )
            FROM i_deliverydocumentitem  AS a
            INNER JOIN zpackn_cds AS b ON
                             ( a~batch = b~batch  AND a~batch NE ' ' AND  b~batch NE ' ' )
                                                WHERE  a~deliverydocument =  @billingitem-a-referencesddocument   INTO @grossweight .

    ENDIF.


    SELECT
    SUM( billingquantity )
       FROM i_billingdocumentitem  AS a
       WHERE billingdocument = @billingitem-a-billingdocument
       INTO @DATA(netweight).


    IF billhead-distributionchannel NE '20'    .

      IF billhead-division = '13' .

        template = 'zsd_dom_tranporter_print/zsd_dom_tranporter_print'  .

      ELSE.

    if billhead-CompanyCode = '2000' .
    template = 'zsd_dom_tranporter_print/zsd_dom_tranporter_print' .
    ELSE.
      template = 'zsd_dom_tranporter_print/zsd_dom_tranporter_print'.
    ENDIF.


      ENDIF.

*********************************************************
      IF billingitem-a-plant IS INITIAL.
        billingitem-a-plant =  gathd-a-plant.
      ENDIF.
      """""""""""""""""""""""""""""""""""""""""""""""""""Plant Wise Address, GST & PAN"""""""""""""""""""""""""""""""""""
      IF billingitem-a-plant = '1100'.
        DATA(gst1)  = '23AAHCS2781A1ZP'.
        DATA(pan1)  = 'AAHCS2781A'.
        DATA(register1) = 'SWARAJ SUITING LIMITED                 '.
        DATA(register2) = 'Spinning Division-I' .
        DATA(register3) = 'B-24 To B-41 Jhanjharwada Industrial Area'.
        DATA(register4) = 'Jhanjharwada, Neemuch - 458441, Madhya Pradesh, India'.
        DATA(cin1) = 'L18101RJ2003PLC018359'.
      ELSEIF billingitem-a-plant = '1200'.
        gst1  = '23AAHCS2781A1ZP'.
        pan1  = 'AAHCS2781A'.
        register1 = 'SWARAJ SUITING LIMITED'.
        register2 = 'Denim Division-I' .
        register3 = 'B-24 To B-41 Jhanjharwada Industrial Area'.
        register4 = 'Jhanjharwada, Neemuch - 458441, Madhya Pradesh, India'.
        cin1 = 'L18101RJ2003PLC018359'.
      ELSEIF billingitem-a-plant = '1300'.
        gst1  = '08AAHCS2781A1ZH'.
        pan1  = 'AAHCS2781A'.
        register1 = 'SWARAJ SUITING LIMITED'.
        register2 = 'Weaving Division-I' .
        register3 = 'F-483 To F-487 RIICO Growth Centre'.
        register4 = 'Hamirgarh, Bhilwara-311025, Rajasthan, India'.
        cin1 = 'L18101RJ2003PLC018359'.
      ELSEIF billingitem-a-plant  = '1310'.
        gst1  = '23AAHCS2781A1ZP'.
        pan1  = 'AAHCS2781A'.
        register1 = 'SWARAJ SUITING LIMITED'.
        register2 = 'Weaving Division-II' .
        register3 = 'B-24 To B-41 Jhanjharwada Industrial Area'.
        register4 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
        cin1 = 'L18101RJ2003PLC018359'.
      ELSEIF billingitem-a-plant  = '1400'.
        gst1  = '23AAHCS2781A1ZP'.
        pan1  = 'AAHCS2781A'.
        register1 = 'SWARAJ SUITING LIMITED'.
        register2 = 'Process House-I' .
        register3 = 'B-24 To B-41 Jhanjharwada Industrial Area'.
        register4 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
        cin1 = 'L18101RJ2003PLC018359'.
      ELSEIF billingitem-a-plant  = '2100'.
        gst1  = '08AABCM5293P1ZT'.
        pan1  = 'AABCM5293P'.
        register1 = 'MODWAY SUITING PVT. LIMITED'.
        register2 = 'Weaving Division-I' .
        register3 = '20th Km Stone, Chittorgarh Road'.
        register4 = 'Takhatpura, Bhilwara-311025, Rajasthan, India'.
        cin1 = 'U18108RJ1986PTC003788'.
      ELSEIF billingitem-a-plant = '2200'.
        gst1  = '23AABCM5293P1Z1'.
        pan1  = 'AABCM5293P'.
        register1 = 'MODWAY SUITING PVT. LIMITED'.
        register2 = 'Weaving Division-II' .
        register3 = 'B-24 To B-41 Jhanjharwada Industrial Area'.
        register4 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
        cin1 = 'U18108RJ1986PTC003788'.
      ENDIF.
      """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    SELECT SINGLE BillingDocumentType FROM I_BillingDocument WHERE BillingDocument = @variable
                                          INTO @DATA(BillingDocumentType) .
   DATA inv TYPE STRING .
    IF BillingDocumentType = 'L2' .

    inv = 'Debit Note'.

    ELSEIF BillingDocumentType = 'CBRE' .

     inv = 'Sales Return'.

    ELSE.

      IF billhead-distributionchannel = '01'   .


      IF billhead-distributionchannel = '01' and  billhead-division = '12' .

           inv = 'Domestic Yarn Sale' .
      ELSE.
           inv = 'Domestic    '.
      ENDIF.

      ELSEIF billhead-distributionchannel = '01'  OR billhead-division = '15' .

           inv = 'Waste'.

      ELSEIF billhead-distributionchannel = '04'  OR billhead-division = '13' & '14' .

           inv = 'Job Sales'.



      ENDIF.
ENDIF.



      DATA lv_cntr TYPE sy-index.
      DATA lv_ft TYPE i_billingdocumentitem-referencesddocument.

      SELECT  * FROM  i_billingdocumentitem   WHERE  billingdocument  =  @variable INTO TABLE @DATA(tabdel)  .

      DELETE ADJACENT DUPLICATES FROM tabdel COMPARING referencesddocument billingdocument .

      TYPES : BEGIN OF it ,
                referencesddocument TYPE c LENGTH 250,
                billingdocument     TYPE i_billingdocumentitem-billingdocument,
              END OF it.

      DATA : it3 TYPE  TABLE OF it,
             wa3 TYPE it.

      LOOP AT tabdel INTO DATA(wa_tab) .

        MOVE-CORRESPONDING wa_tab TO wa3.

        wa3-referencesddocument = wa_tab-referencesddocument .
        SELECT referencesddocument FROM  i_billingdocumentitem WHERE  billingdocument = @wa_tab-billingdocument
                                        AND  referencesddocumentitem   = @wa_tab-referencesddocumentitem
                                                                       INTO @DATA(lv_ftpye) .
          lv_cntr = lv_cntr + 1.
          lv_ft = lv_ftpye .
          IF wa3-referencesddocument IS  INITIAL .
            wa3-referencesddocument  = lv_ft.
          ELSEIF   wa3-referencesddocument IS NOT INITIAL AND lv_cntr > 1  .
            CONCATENATE lv_ft '/' wa3-referencesddocument INTO  wa3-referencesddocument .
          ENDIF.
        ENDSELECT.

        APPEND wa3 TO it3.
        CLEAR : wa_tab, lv_ft,wa3.

      ENDLOOP.
      READ TABLE it3 INTO DATA(wa3a) WITH KEY billingdocument = variable .

      """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
      DATA(lv_xml) = |<form1>| &&
            |<AddressNode>| &&
            |<frmBillToAddress>| &&
            |<txtLine2>{ billtoadd1-addresseefullname }</txtLine2>| &&
            |<txtLine3>{ billtoadd1-streetprefixname1 }</txtLine3>| &&
            |<txtLine4>{ billtoadd1-streetprefixname2  }</txtLine4>| &&
            |<txtLine5>{ billtoadd1-streetsuffixname1 }   { billtoadd1-streetsuffixname2 }</txtLine5>| &&
            |<txtLine6>{ billto-cityname }({ billto-postalcode  })</txtLine6>| &&
            |<txtLine7>{ regiontext1-regionname  }</txtLine7>| &&
            |<txtLine8>{ billttelo-a-telephonenumber2 }</txtLine8>| &&
            |<txtLine9>{ BilltoEmailAdrs }</txtLine9>| &&
            |<txtRegion>{ regiontext1-region  }</txtRegion>| &&
            |<BillToPartyGSTIN>{ billto-taxnumber3 }</BillToPartyGSTIN>| &&
            |</frmBillToAddress>| &&
            |<frmShipToAddress>| &&
            |<txtLine1/>| &&
            |<txtLine2>{ shiptoadd1-addresseefullname }</txtLine2>| &&
            |<txtLine3>{ shiptoadd1-streetprefixname1 }</txtLine3>| &&
            |<txtLine4>{ shiptoadd1-streetprefixname2 }</txtLine4>| &&
            |<txtLine5>{ shiptoadd1-streetsuffixname1 }    { shiptoadd1-streetsuffixname2 }</txtLine5>| &&
            |<txtLine6>{ shiptoadd1-cityname }({ shiptoadd1-postalcode })</txtLine6>| &&
            |<txtLine7>{ regiontext2-regionname }</txtLine7>| &&
            |<txtLine8>{ shipto-a-telephonenumber2  }</txtLine8>| &&
            |<txtLine9>{ ShipptoEmailAdrs  }</txtLine9>| &&
            |<txtRegion>{  regiontext2-region }</txtRegion>| &&
            |<ShipToPartyGSTIN>{ shipto-a-taxnumber3 }</ShipToPartyGSTIN>| &&
            |</frmShipToAddress>| &&
              |<QrCode>| &&
              |<QRCodeBarcode1>{ gathd-a-signedqrcode }</QRCodeBarcode1>| &&
              |</QrCode>| &&
              |</AddressNode> | &&
              |<IRN>| &&
              |<AckNo>{ gathd-a-ackno }</AckNo>| &&
              |<IRN>{ gathd-a-irn }</IRN>| &&
              |<AckDate>{ gathd-a-ackdate }</AckDate>| &&
              |<Ebillno>{ gathd-a-ebillno }</Ebillno>| &&
              |</IRN>| &&
              |<Subform2>| &&
              |<DocNo>| &&
              |<BillingDocument>{ gathd-a-billingdocument }</BillingDocument>| &&
              |<BillingDocumentdate>{ gathd-a-billingdocumentdate }</BillingDocumentdate>| &&
              |<txtReferenceNumber>{ salesorder-purchaseorderbycustomer  }</txtReferenceNumber>| &&
              |<txtSalesDocument>{ salesorder-salesdocument  }-{ salesorder-salesdocumentdate }</txtSalesDocument>| &&
              |<DeliveryNo>{ wa3a-referencesddocument }</DeliveryNo>| &&
              |</DocNo>| &&
              |<Transporter>| &&
              |<LrNo.>{ billhead-yy1_lrnumber_bdh }-{ lrdate }</LrNo.>| &&
              |<TruckNo.>{ billhead-yy1_transportervehicle_bdh }</TruckNo.>| &&
              |<Transporter>{ tranporter }</Transporter>| &&
*              |<TransportMode>{ transmode }</TransportMode>| &&
               |<Agentname>{ aggentname  }</Agentname>| &&
              |</Transporter>| &&
              |</Subform2>| &&
              |<Subform3>| &&
              |<Table1>| &&
              |<HeaderRow/>|
               .

      DATA rat TYPE p DECIMALS 2 .
      DATA pccount TYPE i .
      DATA netwt TYPE menge_d .
      DATA gwt TYPE menge_d .
      DATA GRADE TYPE C LENGTH 40 .
      DATA xsml TYPE string .
      DATA count TYPE int8 .
************************************
*LOOPING DATA
************************************
      LOOP AT it INTO DATA(iv) .

        SELECT  * FROM  i_deliverydocumentitem  AS a
        LEFT OUTER JOIN zpack_hdr_def AS b ON (  b~recbatch = a~batch AND b~materialnumber = a~material
                                              ) WHERE deliverydocument = @iv-a-delivery_number AND
            a~higherlvlitmofbatspltitm =  @iv-a-delivery_number_item AND deliverydocumentitemcategory = 'CB99' INTO TABLE @DATA(it1).
        LOOP AT it1 INTO DATA(wa1) .

          netwt  = netwt   + wa1-b-netweight.
          gwt    = gwt     + wa1-b-grossweight.

        ENDLOOP.
       GRADE = wa1-b-PackGrade.

        SELECT COUNT(*)  FROM  i_deliverydocumentitem WHERE deliverydocument = @iv-a-delivery_number AND
               deliverydocumentitem =  @iv-a-delivery_number_item AND batch IS NOT INITIAL INTO @count   .

        SELECT SINGLE actualdeliveryquantity FROM  i_deliverydocumentitem WHERE deliverydocument = @iv-a-delivery_number AND
               deliverydocumentitem  =  @iv-a-delivery_number_item AND batch IS NOT INITIAL INTO @DATA(package) .

        IF count IS INITIAL .
          SELECT COUNT(*)  FROM  i_deliverydocumentitem WHERE deliverydocument = @iv-a-delivery_number AND
               higherlvlitmofbatspltitm =  @iv-a-delivery_number_item AND batch IS NOT INITIAL INTO @count    .

          SELECT SINGLE actualdeliveryquantity FROM i_deliverydocumentitem WHERE deliverydocument = @iv-a-delivery_number AND
                 higherlvlitmofbatspltitm =  @iv-a-delivery_number_item AND batch IS NOT INITIAL INTO @package   .

        ENDIF .

        pccount = pccount + count .
        count = COND #( WHEN count IS INITIAL THEN '1' ELSE count ).
        package = COND #( WHEN count = '1' THEN iv-a-billingquantity ELSE package ).

        IF iv-a-division = '30'  .

          package =  ' '  .

        ENDIF .

*        SELECT SINGLE yy1_lotno_dli FROM i_deliverydocumentitem WHERE deliverydocument = @iv-delivery_number
*                   AND deliverydocumentitem = @iv-delivery_number_item INTO @DATA(lot).

        rat = iv-a-basicrate .
*""" FOR STO
*    IF iv-basicrate IS INITIAL.
*
*       rat    = iv-sto_amt .
*    ENDIF.

        """"""""""""STO""""""""""""""""""
        IF iv-a-basicrate IS INITIAL.

          SELECT SUM( conditionratevalue ) FROM  i_billingdocumentitemprcgelmnt WHERE
          conditiontype IN ( 'PCIP','ZST1','ZR01' ) AND billingdocument = @variable
          AND billingdocumentitem = @iv-a-billingdocumentitem INTO @iv-a-basicrate .

          rat = iv-a-basicrate.

        ENDIF.


        DATA orgqty  TYPE zpdec2 .
        DATA total_othfrt TYPE  zpdec2 .
        DATA rat1 TYPE  zpdec2 .
        DATA subtot TYPE zpdec2 .
        orgqty = iv-a-billingquantity.

        total_othfrt  = iv-a-zdin_amt + iv-a-zfdo_amt + iv-a-zfoc_amt .

        iv-a-netamount = rat * iv-a-billingquantity.


        subtot = subtot + iv-a-netamount .

        DATA material1 TYPE string .

        SELECT SINGLE * FROM i_salesdocumentitem WHERE salesdocument = @iv-a-sddocu AND salesdocumentitem = @iv-a-sddocuitem INTO @DATA(sdata1)  .

        DATA hp TYPE string.

        IF hp IS INITIAL.
          hp = 900000.
        ENDIF.

        hp = hp + 1.
        DATA co TYPE p .
        co = count .

        SELECT SINGLE * FROM  i_billingdocumentitembasic  WHERE billingdocument = @iv-a-billingdocument AND billingdocumentitem = @iv-a-billingdocumentitem  INTO  @DATA(itemdis) .
        IF billhead-division = '80' .
          descripition  =  itemdis-billingdocumentitemtext .
        ELSE.
        ENDIF.

    template = 'zsd_dom_tranporter_print/zsd_dom_tranporter_print' .

          SHIFT billingitem-a-yy1_pcs_bdi LEFT DELETING LEADING '0'.

          IF sdata1-materialbycustomer IS NOT INITIAL.


            DATA(lv_xml2) =
                   |<Row1>| &&
                   |<Cell1/>| &&
                   |<MaterialDis.>DENIM FINISH FABRIC</MaterialDis.>| &&
                   |<HSN>{ iv-a-hsncode }</HSN>| &&
*                   |<Grade>{ GRADE }</Grade>| &&
*                   |<Lot>{ GRADE }</Lot>| &&
                   |<NoOfPackages></NoOfPackages>| &&
                   |<PackageQty></PackageQty>| &&
                   |<Qty>{ iv-a-billingquantity }</Qty>| &&
                   |<UOM>{ iv-a-unit }</UOM>| &&
*                   |<Rate>{ rat  }</Rate>| &&
                   |<cut>{ sdata1-yy1_cut1_sdi }</cut>| &&
*               |<cut>{ iv-YY1_Cut_BDI }</cut>| &&
                   |<pcs>{ count }</pcs>| &&
*               |<TotalAmount>{ iv-netamount }</TotalAmount>| &&
                   |<TotalAmount>{ iv-a-netamount }</TotalAmount>| &&
                   |</Row1>|.
            CONCATENATE xsml lv_xml2 INTO  xsml .


          ELSEIF sdata1-materialbycustomer IS INITIAL.
            lv_xml2 =
            |<Row1>| &&
            |<Cell1/>| &&
            |<MaterialDis.>DENIM FINISH FABRIC</MaterialDis.>| &&
            |<HSN>{ iv-a-hsncode }</HSN>| &&
            |<Grade>{ GRADE }</Grade>| &&
*               |<Lot>{ GRADE }</Lot>| &&
            |<NoOfPackages></NoOfPackages>| &&
            |<PackageQty></PackageQty>| &&
            |<Qty>{ iv-a-billingquantity }</Qty>| &&
            |<UOM>{ iv-a-unit }</UOM>| &&
            |<Rate>{ rat  }</Rate>| &&
*               |<cut>{ billingitem-a-YY1_Cut_BDI }</cut>| &&
            |<cut>{ sdata1-yy1_cut1_sdi }</cut>| &&
            |<pcs>{ count }</pcs>| &&
*               |<TotalAmount>{ iv-netamount }</TotalAmount>| &&
            |<TotalAmount>{ iv-a-netamount }</TotalAmount>| &&
            |</Row1>|.
            CONCATENATE xsml lv_xml2 INTO  xsml .


          ELSE.
            lv_xml2 =
            |<Row1>| &&
            |<Cell1/>| &&
            |<MaterialDis.>DENIM FINISH FABRIC</MaterialDis.>| &&
            |<HSN>{ iv-a-hsncode }</HSN>| &&
            |<Grade>{ GRADE }</Grade>| &&
*               |<Lot>{ GRADE }</Lot>| &&
            |<NoOfPackages></NoOfPackages>| &&
            |<PackageQty></PackageQty>| &&
            |<Qty>{ iv-a-billingquantity }</Qty>| &&
            |<UOM>{ iv-a-unit }</UOM>| &&
            |<Rate>{ rat  }</Rate>| &&
            |<cut>{ billingitem-a-yy1_cut_bdi }</cut>| &&
            |<pcs>{ pccount }</pcs>| &&
*               |<TotalAmount>{ iv-netamount }</TotalAmount>| &&
            |<TotalAmount>{ iv-a-netamount }</TotalAmount>| &&
            |</Row1>|.
            CONCATENATE xsml lv_xml2 INTO  xsml .


          ENDIF.

          CLEAR  : iv,lv_xml2,rat,iv,count,package,orgqty,co,pccount,GRADE.



      ENDLOOP .

************************************
*LOOPING DATA END
************************************




      SELECT SUM( billingquantity  )  FROM  i_billingdocumentitem
      WHERE billingdocument = @variable INTO @DATA(netqua) .

      SELECT SINGLE * FROM i_billingdocumentitemprcgelmnt WHERE conditiontype IN ( 'JICG', 'JOIG' , 'JOSG' )
      AND billingdocument =   @variable INTO @DATA(basicrate)  .
      DATA total TYPE p DECIMALS 2 .
      DATA bas TYPE  string .
      DATA bas1 TYPE  string .
      DATA bas2 TYPE  string .
      DATA bas3 TYPE  string .
      DATA bas4 TYPE  string .
      DATA cdp TYPE  string .

      total = billhead-totalnetamount + billhead-totaltaxamount .

      bas = basicrate-conditionrateratio .
      bas  = bas+0(3)  .

      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
      conditiontype IN ( 'ZFFA' ,'ZFMK','ZFDO','ZFOC' ) AND billingdocument = @variable  INTO @DATA(freight)  .

      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
           conditiontype =  'ZFFA'   AND billingdocument = @variable  INTO @DATA(freight_ffa)  .


      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
          ( conditiontype =  'ZD02' OR conditiontype =  'ZD03' OR conditiontype =  'ZD05' )  AND billingdocument = @variable  INTO @DATA(discount)  .

      SELECT SINGLE conditionrateratio FROM i_billingdocumentitemprcgelmnt WHERE  ( conditiontype =  'ZD02' OR conditiontype =  'ZD03' OR conditiontype =  'ZD05' )
           AND billingdocument =   @variable INTO @DATA(discount_rate)  .

      IF discount IS NOT INITIAL .
        bas4  =  discount_rate .
        CONCATENATE '(' bas4+0(3) '%'  ')' INTO bas4 .
        DATA(discount_rate1) =   bas4.

      ENDIF .
*conditionrateratio

*SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
*      conditiontype =  'ZDIS'   AND billingdocument = @variable  INTO @DATA(discount)  .

      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
     conditiontype IN ( 'ZFFA' ) AND billingdocument = @variable  INTO @DATA(freight_fix)  .

      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
     conditiontype EQ  'ZLDA' AND billingdocument = @variable  INTO @DATA(loading)  .


      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
     conditiontype EQ  'ZP01' AND billingdocument = @variable   INTO @DATA(packing)  .

      DATA packingrateratio TYPE  string .
      IF packing IS NOT INITIAL .

        SELECT SINGLE * FROM  i_billingdocumentitemprcgelmnt WHERE
  conditiontype EQ  'ZP01' AND billingdocument = @variable   INTO @DATA(packingratio)  .
        packingrateratio  =  packingratio-conditionrateratio .
        CONCATENATE '(' packingrateratio+0(3) '%' ')' INTO packingrateratio .
      ENDIF .

      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
      conditiontype IN ( 'ZINS','ZDIN' ) AND billingdocument = @variable INTO @DATA(ins)  .

      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
      conditiontype IN ( 'JTC1' ) AND billingdocument = @variable INTO @DATA(tcs)  .

      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
      conditiontype IN ( 'ZROF' ) AND billingdocument = @variable INTO @DATA(rof)  .


      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
      conditiontype IN ( 'JOSG', 'JOCG','JOIG','JOUG' )  AND billingdocument = @variable INTO @DATA(gst)  .

      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
      conditiontype IN ( 'JOSG' )  AND billingdocument = @variable INTO @DATA(sgst)  .
      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
      conditiontype IN ( 'JOCG' )  AND billingdocument = @variable INTO @DATA(cgst)  .
      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
      conditiontype IN ( 'JOIG' )  AND billingdocument = @variable INTO @DATA(igst1)  .

      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
      conditiontype =  'ZMND'   AND billingdocument = @variable  INTO @DATA(mnd_amt)  .

      DATA mnd_amtraevalue TYPE p  DECIMALS 2.
      SELECT SINGLE conditionratevalue  FROM  i_billingdocumentitemprcgelmnt WHERE
      conditiontype =  'ZMND'   AND billingdocument = @variable  INTO @mnd_amtraevalue  .


      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
      conditiontype =  'ZROL'   AND billingdocument = @variable  INTO @DATA(roll_amt)  .

      DATA roll_amtratevalu TYPE p  DECIMALS 2.
      SELECT SINGLE conditionratevalue FROM  i_billingdocumentitemprcgelmnt WHERE
     conditiontype =  'ZROL'   AND billingdocument = @variable  INTO @roll_amtratevalu  .

      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
      conditiontype =  'ZCHD'   AND billingdocument = @variable  INTO @DATA(cashdis_amt)  .

      SELECT SINGLE conditionrateratio FROM i_billingdocumentitemprcgelmnt WHERE conditiontype =  'ZCHD'
      AND billingdocument =   @variable INTO @DATA(cashdis_rate)  .

      IF cashdis_rate IS NOT INITIAL .
        cdp  =  cashdis_rate.
        CONCATENATE '(' cdp+0(3) '%' ')' INTO cdp .
      ENDIF .

      CLEAR bas .

      SELECT  * FROM  i_address_2 INTO TABLE  @DATA(address)  .

      SELECT SINGLE * FROM i_billingdocumentitemprcgelmnt WHERE conditiontype IN ( 'JOSG',  'JOCG' )
      AND billingdocument =   @variable INTO @DATA(cgst_rate)  .
      IF cgst_rate IS NOT INITIAL .
        bas  =  cgst_rate-conditionrateratio .
        CONCATENATE '(' bas+0(3) '%' ')' INTO bas .
      ENDIF .

      SELECT SINGLE * FROM i_billingdocumentitemprcgelmnt WHERE conditiontype IN ( 'JOIG' )
      AND billingdocument =   @variable INTO @DATA(igst_rate)  .
      IF igst_rate IS NOT INITIAL .
        bas1  =  igst_rate-conditionrateratio.
        CONCATENATE '(' bas1+0(3) '%'  ')' INTO bas1 .
      ENDIF .

      SELECT SINGLE * FROM i_billingdocumentitemprcgelmnt WHERE conditiontype IN ( 'ZTCS','JTC1' )
      AND billingdocument =   @variable INTO @DATA(tcs_rate)  .
      IF tcs_rate IS NOT INITIAL .
        bas2  = tcs_rate-conditionrateratio . .
        CONCATENATE '('  bas2+0(4) '%' ')' INTO bas2 .
      ENDIF .


      DATA amt TYPE p DECIMALS 2.
      """""""""""""""""""""""""""""""""add nsp """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt  WHERE
      conditiontype IN ( 'ZR00' ,'ZR01' ) AND billingdocument = @variable INTO @DATA(netamtn)  .

      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt  WHERE
      conditiontype IN ( 'ZCHD','ZD02','ZD03','ZD05' ) AND billingdocument = @variable INTO @DATA(disamtn)  .

      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt  WHERE
      conditiontype IN ( 'ZI01','ZI02' ) AND billingdocument = @variable INTO @DATA(insurance)  .

      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt  WHERE
      conditiontype IN ( 'JOIG','JOCG','JOSG' )  AND billingdocument = @variable INTO @DATA(gstn)  .

      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt  WHERE
conditiontype IN ( 'ZC01','ZP01','ZPOS','ZP02' )  AND billingdocument = @variable INTO @DATA(oth)  .

      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
    conditiontype =  'ZPOS'   AND billingdocument = @variable  INTO @DATA(postage)   .

      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
      conditiontype =  'ZC01'   AND billingdocument = @variable  INTO @DATA(cartage)  .

      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
conditiontype =  'ZI02'   AND billingdocument = @variable  INTO @DATA(insfixamt)  .

      SELECT SINGLE SUM( conditionamount )  FROM  i_billingdocumentitemprcgelmnt WHERE
      conditiontype EQ  'ZPIC' AND billingdocument = @variable  INTO @DATA(amount)  .


      SELECT SUM( conditionamount ) FROM i_billingdocumentitemprcgelmnt WHERE conditiontype IN ( 'ZI01' )
      AND billingdocument =   @variable INTO @DATA(insamt)  .
      DATA insfixper TYPE  string .
      IF insamt IS NOT INITIAL .
        SELECT SINGLE * FROM i_billingdocumentitemprcgelmnt WHERE conditiontype IN ( 'ZI01' )
       AND billingdocument =   @variable INTO @DATA(insamtratio)  .
        insfixper  =  insamtratio-conditionrateratio .
        CONCATENATE '(' insfixper+0(3) '%' ')' INTO insfixper .
      ENDIF .


      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
      ( conditiontype =  'ZD02' OR conditiontype =  'ZD03' OR conditiontype =  'ZD05' )  AND billingdocument = @variable  INTO @DATA(disfixamt)  .

      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
     conditiontype =  'ZP02'   AND billingdocument = @variable  INTO @DATA(packingfixamt)  .



*****************************************************************************************************
      DATA taxablevalue TYPE p DECIMALS 2.
      DATA DiscountJob TYPE p DECIMALS 2.

      DATA grandtotal TYPE zpdec2 .
      DATA grandtotal1 TYPE string .
      DATA roundoff TYPE zpdec2 .
      DATA inv1 TYPE p DECIMALS 2.
      DATA amt1 TYPE p DECIMALS 2.
      DATA taxbalevalue1 TYPE p DECIMALS 2.
      DATA invoicevalue1 TYPE p DECIMALS 2.
      DATA invoicevalue2 TYPE p DECIMALS 2.
      DATA invoicevalue11 TYPE string .
      DATA roundof1 TYPE zpdec2 .
      DATA totalamt TYPE p DECIMALS 2 .



      inv1 = netamtn + disamtn.

      grandtotal = inv1 + insurance + gstn + oth.

      taxablevalue   =  inv1 + cartage + postage + packing + insurance + packingfixamt .
      totalamt          = taxablevalue + gstn .
*      grandtotal  = subtot + freight + ins + gst +  tcs + loading  + packing .
*      grandtotal  = subtot  + ins + gst +  tcs + loading  + packing  + freight_fix  + discount + MND_AMT + ROLL_AMT.
      grandtotal1 = grandtotal .
      SPLIT grandtotal1 AT '.' INTO DATA(a) DATA(b) .

      IF b GE 50 .
        grandtotal = a + 1 .
        roundoff = grandtotal - grandtotal1 .
      ELSE .
        grandtotal = a .
        roundoff = grandtotal - grandtotal1 .

      ENDIF .


      TYPES: BEGIN OF ty1,
               batch TYPE string,
             END OF ty1 .
      DATA : batch1 TYPE TABLE OF ty1 .


      SELECT SINGLE * FROM i_incotermsclassificationtext
            WHERE incotermsclassification = @billhead-incotermsclassification AND language = 'E' INTO @DATA(inconame) .





       SELECT SINGLE BillingDocumentIsCancelled FROM I_BillingDocument WHERE BillingDocument = @variable INTO @DATA(CancelBill) .
       DATA CANCELED TYPE string.

        IF CancelBill = 'X' .
        CANCELED = 'Cancel' .
      ELSE.
      CANCELED = CancelBill  .
      ENDIF.


      DATA deliveryterms  TYPE string .

      DATA terms1 TYPE string .
      DATA basic TYPE p DECIMALS 2 .

      basic = subtot - freight + freight_ffa .


      IF  gathd-a-division =  '50' OR gathd-a-division =  '60'.
        deliveryterms  = inconame-incotermsclassificationname .
      IF terms-paymenttermsname <> '' .
        terms1 = terms-paymenttermsname  .
      ELSE.
      terms1 = terms-PaymentTermsDescription  .
      ENDIF.
      ELSE .
        deliveryterms  = |{ billhead-incotermsclassification }/{ salesorder-incotermslocation1 }|.

        IF terms-paymenttermsname <> '' .
        terms1 = terms-paymenttermsname  .
      ELSE.
      terms1 = terms-PaymentTermsDescription  .
      ENDIF.

      ENDIF .
      DATA got TYPE string.
      DATA bci TYPE string.


      DATA(lv_xml3) =
      |</Table1>| &&
      |<Row2tot>| &&
      |<SUBTotalAmount></SUBTotalAmount>| &&
       |<Totpcs></Totpcs>| &&
        |<TotQty></TotQty>| &&
           |</Row2tot>| &&
      |</Subform3>| &&
      |<Terms>| &&
      |<Terms>| &&
      |<DeliveryTerms>{ deliveryterms }</DeliveryTerms>| &&
      |<BasicValue>{ basic }</BasicValue>| &&
      |<PaymentTerms>{ terms1 }</PaymentTerms>| &&
      |<TotalNetWeight>{ netwt }</TotalNetWeight>| &&
      |<TotalGrossWeight>{ gwt }</TotalGrossWeight>| &&
      |</Terms>| &&
      |<PricingConditions>| &&   "Changes in Xml
      |<FrieightChargeNew>hp</FrieightChargeNew>| &&   "Changes in Xml
      |<Gst>{ igst1 }</Gst>| &&
      |<GstP>{ bas1 }</GstP>| &&
      |<TotInvAmount>{ grandtotal }</TotInvAmount>| &&
      |<TotalInvoiceAmount1>{ invoicevalue2 }</TotalInvoiceAmount1>| &&
      |<Insurance>{ insamt }</Insurance>| &&
      | <InsuranceRate>{ insfixper }</InsuranceRate>| &&
      |<Cartage>{ cartage }</Cartage>| &&
      |<InsuranceFixAmt>{ insfixamt }</InsuranceFixAmt>| &&
      |<PostageCharges>{ postage }</PostageCharges>| &&
      |<TaxableValue>{ taxablevalue }</TaxableValue>| &&
      |<DiscountFixAmount>{ disfixamt }</DiscountFixAmount>| &&
      |<mendingcharge>{ mnd_amt  }</mendingcharge>| &&
      |<mendingchargeRatio>{ mnd_amtraevalue }</mendingchargeRatio>| &&
      |<rollcharge>{ roll_amt }</rollcharge>| &&
      |<rollchargeRatio>{ roll_amtratevalu }</rollchargeRatio>| &&
      |<Amount>{ amt1 }</Amount>| &&
      |<DiscountJob>{ disamtn }</DiscountJob>| &&
      |<TaxableValueJob>{ taxbalevalue1 }</TaxableValueJob>| &&
      |<DiscountP>{ discount_rate1 }</DiscountP>| &&
      |<DiscountAmount>{ discount }</DiscountAmount>|  &&
      |<CashDiscount>{ cashdis_amt }</CashDiscount>|  &&
      |<CashDiscountrate>{ cdp }</CashDiscountrate>|  &&
      |<CGSTP>{ bas }</CGSTP>| &&
      |<CgstAmount>{ cgst }</CgstAmount>| &&
      |<SGSTP>{ bas }</SGSTP>| &&
      |<SgstAmount>{ sgst }</SgstAmount>| &&
      |<TCSP>{ bas2 }</TCSP>| &&
      |<TCSAmount>{ tcs }</TCSAmount>| &&
      |<mendingcharge>{ mnd_amt }</mendingcharge>| &&
      |<Rollcharge>{ roll_amt }</Rollcharge>| &&
      |<Rateunit>INR</Rateunit>| &&
      |<FrieightCharge>{ freight }</FrieightCharge>| &&
      |<InvoiceValue>{ inv1 }</InvoiceValue>| &&
       |<InvoiceValue1>{ invoicevalue1 }</InvoiceValue1>| &&
      |<Loading>{ loading }</Loading>| &&
      |<Packing>{ packing }</Packing>| &&
      |<PackingchargeRate>{ packingrateratio }</PackingchargeRate>| &&
      |<PackingFixamt>{ packingfixamt }</PackingFixamt>| &&
      |<Total>{ totalamt }</Total>| &&
      |<Roundedoff>{ roundoff }</Roundedoff>| &&
      |<Roundedoff1>{ roundof1 }</Roundedoff1>| &&
       |<termscond6>{ remark1 }</termscond6>| &&
             |</PricingConditions>| &&
             |</Terms>| &&
             |<Remarks>| &&
             |<Division>{ gathd-a-division }</Division>| &&
             |<SMPLBCI>{ bci }</SMPLBCI>| &&
             |<SMPLGOTS>{ got }</SMPLGOTS>| &&
             |<CANCELED>{ CANCELED }</CANCELED>| &&
             |<Address1>{ register1 }</Address1>| &&
             |<Address2>{ register2 }</Address2>| &&
             |<Address3>{ register3 }</Address3>| &&
             |<Address4>{ register4 }</Address4>| &&
             |<GSTIN>{ gst1 }</GSTIN>| &&
             |<PAN>{ pan1 }</PAN>| &&
             |<CINNO>{ cin1 }</CINNO>| &&
             |<INV>{ inv }</INV>| &&
             |<Subform6/>| &&
             |</Remarks>| &&
             |<PreparedBy>{ username }</PreparedBy>| &&
             |</form1>| .


      CONCATENATE lv_xml xsml lv_xml3 INTO lv_xml .

      REPLACE ALL OCCURRENCES OF '&' IN lv_xml WITH 'and'.


    ENDIF .

   DATA WA_Terms_REMARK TYPE zinv_terms6.
   wa_terms_remark-invoice = var1.
   wa_terms_remark-remark = remark1.
   MODIFY zinv_terms6 FROM @wa_terms_remark .

    CALL METHOD ycl_test_adobe=>getpdf(
      EXPORTING
        xmldata  = lv_xml
        template = template
      RECEIVING
        result   = result12 ).




  ENDMETHOD.
ENDCLASS.
