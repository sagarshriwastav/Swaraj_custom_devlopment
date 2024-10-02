CLASS zsd_exim_invoce DEFINITION
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
        IMPORTING variable        TYPE string
                  form            TYPE string

        RETURNING VALUE(result12) TYPE string
        RAISING   cx_static_check .

  PROTECTED SECTION.
  PRIVATE SECTION.


    CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
    CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
    CONSTANTS  lv2_url    TYPE string VALUE 'https://btp-yvzjjpaz.authentication.eu10.hana.ondemand.com/oauth/token'  .
    CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
    CONSTANTS lc_template_name1 TYPE string VALUE 'ZEXPORTINVOICE_EXIM/ZEXPORTINVOICE_EXIM'.
ENDCLASS.



CLASS ZSD_EXIM_INVOCE IMPLEMENTATION.


  METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).

  ENDMETHOD .


  METHOD if_oo_adt_classrun~main.



    DATA(xml)  = read_posts( variable = '2223000005' form = 'ZEXPORTINVOICE_EXIM/ZEXPORTINVOICE_EXIM' )   .


  ENDMETHOD.


  METHOD read_posts .
    SELECT * FROM  yeinvoice_cdss   WHERE billingdocument = @variable   INTO TABLE @DATA(it) .
    SELECT SINGLE * FROM i_billingdocumentbasic WHERE billingdocument =  @variable INTO @DATA(billhead) .
    SELECT SINGLE * FROM  i_billingdocumentitem AS a
    LEFT OUTER JOIN i_deliverydocumentitem AS b ON ( a~referencesddocument = b~deliverydocument AND a~referencesddocumentitem = b~deliverydocumentitem )
    INNER JOIN   i_deliverydocument AS f ON ( b~deliverydocument = f~deliverydocument )
    LEFT OUTER JOIN i_shippingtypetext AS s ON ( f~shippingtype = s~shippingtype AND s~language = 'E'  )
       WHERE  billingdocument  =  @variable INTO @DATA(billingitem)  .

    SELECT SINGLE * FROM yconsignedata_pr1 WHERE docno = @variable INTO @DATA(consignedata).
      SELECT SINGLE * FROM zpregen_exi WHERE docno = @variable into @data(eximdata).
      SELECT SINGLE * FROM yexim_calculatcds WHERE docno = @variable into @data(caldata).


*IF BILLINGITEM-SA
    SELECT * FROM i_billingdocumentitem WHERE billingdocument = @billingitem-a-referencesddocument INTO TABLE @DATA(deli) .

    DELETE ADJACENT DUPLICATES FROM deli COMPARING referencesddocument.

*if billhead-CreatedByUser id
    SELECT SINGLE userdescription  FROM i_user WITH PRIVILEGED ACCESS WHERE  userid = @billhead-createdbyuser INTO @DATA(username).




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

    SELECT SINGLE * FROM zsd_dom_address WITH PRIVILEGED ACCESS WHERE addressid = @billto-addressid INTO @DATA(billtoadd1)   .
    SELECT SINGLE countryname FROM i_countrytext WHERE language = 'E' AND country = @billto-country INTO @DATA(billto_country).
    SELECT SINGLE * from yconsignedata_pr1 where Docno = @billhead-BillingDocument  into @data(consignee).

    DATA(billtoadd)  =
    |{ consignee-Billtobuyrname },{ consignee-Billtostreet1 },{ consignee-Billtostreet2 } ,  { consignee-Billtostreet3 } | &&
    |,{ consignee-Billtocity },{ consignee-Billtocountry }|.

   data(NotifyTo) = |{ consignee-Notifyname },{ consignee-Notifystreet1 },{ consignee-Notifystreet2 },{ consignee-Notifystreet3 },{ consignee-Notifycity },{ consignee-Notifycountry }|.

    IF it IS NOT INITIAL .

      READ TABLE it INTO DATA(gathd) INDEX 1 .

    ENDIF .

          DATA lv TYPE string .
          if consignedata-Tobecontinue = 'X'.
          lv = 'To Be continue.'.
          else.
          lv = |{ consignee-Constoname },{ consignee-Constostreet1 },{ consignee-Constostreet2 },{ consignee-Constostreet3 },{ consignee-Constocity },{ consignee-Constocountry },|.
          ENDIF.




    CONCATENATE salesorder-salesdocumentdate+6(2) '/' salesorder-salesdocumentdate+4(2) '/' salesorder-salesdocumentdate+0(4) INTO DATA(salesorderdate) .
 "   CONCATENATE  billhead-yy1_lcdate_bdh+6(2) '/'  billhead-yy1_lcdate_bdh+4(2) '/'  billhead-yy1_lcdate_bdh+0(4) INTO  DATA(lcdate)  .

    CONCATENATE  billhead-yy1_lrdate_bdh+6(2) '/'  billhead-yy1_lrdate_bdh+4(2) '/'  billhead-yy1_lrdate_bdh+0(4) INTO  DATA(lrdate) .
    DATA: transmode TYPE string.
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

    DATA xsml TYPE string .

*************************************************************************************************
*************************************************************************************************
*************************************************************************************************
*************************************************************************************************
*************************************************************************************************
*************************************************************************************************
*fORM FOR EXPORT
************************************************************************************************
    IF billhead-distributionchannel = '02' .
      template = 'ZEXPORTINVOICE_EXIM/ZEXPORTINVOICE_EXIM'  .


       data ShippingMark1 type string.
      data ContainerNo type string.
      data RFIDSEALNo type string.
      data LineSealNo type string.


      SELECT SINGLE * FROM i_salesdocument WHERE salesdocument  = @billingitem-a-salesdocument INTO @DATA(saledocument).
*     saledocument-SalesDocumentDate = saledocument-SalesDocumentDate

       if transmode = 'By Truck'.
      ShippingMark1 = ''.
      ContainerNo = ''.
      RFIDSEALNo = ''.
      LineSealNo = ''.
      else.
      ShippingMark1 = 'Shipping Mark'.
      ContainerNo = 'Container No'.
      RFIDSEALNo = 'RFID-SEAL No.'.
      LineSealNo = 'Line Seal No'.
      ENDIF.

      DATA(lv_xml) =
           |<form1>| &&
           |<Page1>| &&
           |<Heder>| &&
           |<Irn>{ gathd-irn }</Irn>| &&
           |<AknNo>{ gathd-ackno }</AknNo>| &&
           |<AknDate>{ gathd-ackdate }</AknDate>| &&
           |<E-way>{ gathd-ebillno }</E-way>| &&
           |<LRNo>{ billhead-yy1_lrnumber_bdh }</LRNo>| &&
           |<Doctype>{ billhead-billingdocumenttype }</Doctype>| &&
           |</Heder>| &&
           |<Subform1>| &&
           |<Exporter>| &&
           |<exporter>Swaraj Suiting LIMITED</exporter>| &&
           |<Buyer>{ billtoadd }</Buyer>| &&
           |<Subform2>| &&
           |<VesselFlightNo>{ eximdata-Vesselno }</VesselFlightNo>| &&
           |<Port>{ eximdata-Portofloading }</Port>| &&
           |</Subform2>| &&
           |<Subform3>| &&
           |<PortAirportofDischarge>{ eximdata-Portofdischarge }</PortAirportofDischarge>| &&
           |<Paymentterms>{  terms-PaymentTermsDescription }</Paymentterms>| &&
           |<FinalDestination>{ billhead-incotermslocation1 }</FinalDestination>| &&
           |<Lc> { caldata-Lcno } </Lc>| &&
           |<LcDate>{ caldata-Lcdate1 }</LcDate>| &&
           |</Subform3>| &&
           |</Exporter>| &&
           |<Subform4>| &&
           |<Subform5>| &&
           |<InvoiceNo>{ gathd-billingdocument }</InvoiceNo>| &&
           |<InvoiceDate>{ billhead-billingdocumentdate }</InvoiceDate>| &&
           |<ProformInv>{ billingitem-a-salesdocument }</ProformInv>| &&
           |<ProformInvDate>{ salesorderdate }</ProformInvDate>| &&
           |<Consignee>{ lv }</Consignee>| &&
           |<OtherReferences>Mirum est ut animus agitatione motuque corporis excitetut.</OtherReferences>| &&
           |</Subform5>| &&
           |<Subform6>| &&
           |<QRCode>{ gathd-signedqrcode }</QRCode>| &&
           |</Subform6>| &&
           |<Subform7>| &&
           |<Subform8>| &&
           |<NotifyTo>{ NotifyTo }</NotifyTo>| &&
           |<CountryOfOriginofGoods>INDIA</CountryOfOriginofGoods>| &&
           |<PlaceofReceiptbyPreCarrier>{ eximdata-Precarrier }</PlaceofReceiptbyPreCarrier>| &&
**********************************************************************      |<Incoterms>meditabar aliquid enotabamque, ut, si manus vacuas, plenas tamen ceras reportarem.</Incoterms>| &&
           |<Incoterms>{ billhead-incotermsclassification }</Incoterms>| &&
           |</Subform8>| &&
           |<Subform9>| &&
           |<OtherReferences>{ wt-transname }</OtherReferences>| &&
           |<PreCarrierBy>{ transmode }</PreCarrierBy>| &&
           |<CountryofDestination>{ billhead-incotermslocation1 }</CountryofDestination>| &&
          |<BankName>{ caldata-Bank  }</BankName>| &&
           |<BankName></BankName>| &&
           |</Subform9>| &&
           |</Subform7>| &&
           |</Subform4>| &&
           |<tableForm>| &&
           |<Table1>| &&
           |<HeaderRow>| &&
           |<ShippingMarkH>{ shippingmark1 }</ShippingMarkH>| &&
           |<ContainerNoH>{ ContainerNo }</ContainerNoH>| &&
*           |<Cell3></Cell3>| &&
           |<RFID-SEALNoH>{ RFIDSEALNo }</RFID-SEALNoH>| &&
           |<LineSealNoH>{ LineSealNo }</LineSealNoH>| &&
           |</HeaderRow>| &&
*           |<HeaderRow/>| &&
           |<Row1>| &&
           |<ShippingMark>{  eximdata-Shipmentmark }</ShippingMark>| &&

**Exim Data**
           |<ContainerNo>{ eximdata-containerno }</ContainerNo>| &&
           |<TrailerNo>{ eximdata-TruckNo }</TrailerNo>| &&
           |<RFID-SEALNo>{ eximdata-RfidNo }</RFID-SEALNo>| &&
           |<LineSealNo>{ eximdata-lineseal }</LineSealNo>| &&
**Exin Data**
           |</Row1>| &&
           |</Table1>| &&
           |<Table2>| &&
           |<Row1>| &&
           |<TotalGrossWt>{ caldata-totalgrosswt }</TotalGrossWt>| &&
           |<TotalNatWt>{ netweight }</TotalNatWt>| &&
           |</Row1>| &&
           |<HeaderRow>| &&
           |<QuantityUnit>{ billingitem-a-billingquantityunit }</QuantityUnit>| &&
           |<Table4>| &&
           |<Row2>| &&
           |<Table5>| &&
           |<Row1>| &&
           |<RateKG>Rate({ billhead-transactioncurrency })</RateKG>| &&
           |<Currency>Value({ billhead-transactioncurrency })</Currency>| &&
           |</Row1></Table5></Row2>| &&
           |</Table4>| &&
           |</HeaderRow>| &&
           |</Table2>| &&
           |</tableForm>| &&
           |</Subform1>| &&
           |</Page1>| &&
           |<Table6>| .

      LOOP AT it INTO DATA(iv) .



        SELECT COUNT(*)  FROM  i_deliverydocumentitem WHERE deliverydocument = @iv-delivery_number AND
               deliverydocumentitem =  @iv-delivery_number_item AND batch IS NOT INITIAL INTO @DATA(count)   .

        SELECT SINGLE actualdeliveryquantity FROM  i_deliverydocumentitem WHERE deliverydocument = @iv-delivery_number AND
               deliverydocumentitem =  @iv-delivery_number_item AND batch IS NOT INITIAL INTO @DATA(package) .

        IF count IS INITIAL .
          SELECT COUNT(*)  FROM  i_deliverydocumentitem WHERE deliverydocument = @iv-delivery_number AND
               higherlvlitmofbatspltitm =  @iv-delivery_number_item AND batch IS NOT INITIAL INTO @count    .

          SELECT SINGLE actualdeliveryquantity FROM i_deliverydocumentitem WHERE deliverydocument = @iv-delivery_number AND
                 higherlvlitmofbatspltitm =  @iv-delivery_number_item AND batch IS NOT INITIAL INTO @package   .

        ENDIF .

        DATA  rate TYPE p DECIMALS 3 .
        DATA  rat TYPE p DECIMALS 3 .

        rat = iv-basicrate .
        DATA(orgqty) = iv-billingquantity.

        DATA(total_othfrt)  = iv-zdin_amt + iv-zfdo_amt + iv-zfoc_amt + iv-zein_amt .
        DATA material TYPE string .

        DATA subtot TYPE string  .

        subtot = subtot + iv-netamount .



        SELECT SINGLE * FROM i_salesdocumentitem WHERE salesdocument = @iv-sddocu
                                                   AND salesdocumentitem = @iv-sddocuitem INTO @DATA(saleadditionaldata) .
 DATA BILL TYPE CHAR6.

      BILL = IV-BillingDocumentItem.
      SHIFT BILL LEFT DELETING LEADING '0'.


        SELECT SINGLE * FROM ydraft_bl WHERE docno = @IV-BillingDocument AND litem = @BILL  INTO @DATA(BL).


        DATA(lv_xml2) =
                |<Row1>| &&
                |<Packages>{ count  }</Packages>| &&
                |<MaterialDescription>{ iv-materialdescription  }</MaterialDescription>| &&
       "         |<LotNo>{ lot }</LotNo>| &&
                |<HSNCode>{ iv-hsncode }</HSNCode>| &&
                |<Quantity>{ orgqty }</Quantity>| &&
                |<Valueprkg>{ rat }</Valueprkg>| &&
                |<valeRate>{ iv-netamount }</valeRate>| &&
                |</Row1>| .
        CONCATENATE xsml lv_xml2 INTO  xsml .
        CLEAR  : iv,lv_xml2,rat,iv,count,package,orgqty,material.

      ENDLOOP .

*************looping data end *************************



      SELECT SUM( billingquantity  )  FROM  i_billingdocumentitem
      WHERE billingdocument = @variable INTO @DATA(netqua) .

      SELECT SINGLE * FROM i_billingdocumentitemprcgelmnt WHERE conditiontype IN ( 'JICG', 'JOIG' , 'JOSG' )
      AND billingdocument =   @variable INTO  @DATA(basicrate)  .

      DATA total TYPE p DECIMALS 2 .
      DATA bas TYPE  string .
      DATA bas1 TYPE  string .
      DATA bas2 TYPE  string .
      DATA bas3 TYPE  string .
      DATA grandtotal TYPE zpdec2 .
      DATA grandtotal1 TYPE string .
      DATA roundoff TYPE zpdec2 .

      total = billhead-totalnetamount + billhead-totaltaxamount .

      bas = basicrate-conditionratevalue."ratio .
      bas  = bas+0(1)  .

      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
      conditiontype IN ( 'ZFFA' ,'ZFMK','ZLDA','ZFDO','ZFOC' ) AND billingdocument = @variable  INTO @DATA(freight)  .

********************
      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
      conditiontype IN ( 'ZI01','ZI02' ) AND billingdocument = @variable INTO  @DATA(ins)  .


      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
      conditiontype IN ( 'ZROF' ) AND billingdocument = @variable INTO  @DATA(rof)  .



      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
      conditiontype IN ( 'JOSG', 'JOCG','JOIG','JOUG' )  AND billingdocument = @variable INTO  @DATA(gst)  .


      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
      conditiontype IN ( 'JOIG' )  AND billingdocument = @variable INTO  @DATA(igst1)  .


      SELECT * FROM i_addrorgnamepostaladdress INTO TABLE @DATA(addes)  .



      SELECT SINGLE * FROM i_billingdocumentitemprcgelmnt WHERE conditiontype IN ( 'JOIG' )
      AND billingdocument =   @variable INTO  @DATA(igst_rate)  .
      IF igst_rate IS NOT INITIAL .
        bas1  =  igst_rate-conditionrateratio.
        CONCATENATE '(' bas1+0(1) '%'  ')' INTO bas1 .
      ENDIF .
      DATA : assebible_inusd1  TYPE  zpdec2 .
      DATA : assebible_inrs  TYPE  zpdec2 .

      grandtotal  = subtot + freight + ins .

      IF freight < 0 .
        freight = -1 * freight .
      ENDIF .
      IF ins < 0 .
        ins = -1 * ins .
      ENDIF .

      assebible_inusd1 = subtot - freight - ins .

      assebible_inrs  = assebible_inusd1 * billhead-accountingexchangerate .
      igst1   = igst1 * billhead-accountingexchangerate .

      DELETE ADJACENT DUPLICATES FROM  it COMPARING hsncode .
      DATA hsnxml TYPE string .
      DATA hsnxml1 TYPE string .


      LOOP AT it INTO iv .

        SELECT SINGLE * FROM i_ae_cnsmpntaxctrlcodetxt WHERE
         consumptiontaxctrlcode = @iv-hsncode AND countrycode = 'IN' AND language = 'E' INTO @DATA(hsndec).
        hsnxml =  |<Table8>| &&
            |<Row1>| &&
              |<HSNtab>{ iv-hsncode } { hsndec-consumptiontaxctrlcodetext1  } { hsndec-consumptiontaxctrlcodetext2  } { hsndec-consumptiontaxctrlcodetext3  } { hsndec-consumptiontaxctrlcodetext4  }</HSNtab>| &&
              |</Row1>| &&
              |</Table8>|  .

        CONCATENATE  hsnxml1 hsnxml INTO  hsnxml1 .
        CLEAR : hsnxml,iv,hsndec.
      ENDLOOP .
      DATA pi TYPE p .
      SELECT SINGLE * FROM i_divisiontext WHERE division = @billhead-division AND language = 'E' INTO @DATA(division).
      SELECT SINGLE * FROM i_salesdocumentpricingelement
      WHERE salesdocument = @gathd-sddocu AND   conditiontype = 'ZA01' INTO @DATA(saleorderpricing)  .

      IF billhead-distributionchannel = '02'.
        SELECT SUM( conditionrateratio ) FROM i_billingdocprcgelmntbasic
      WHERE billingdocument = @billhead-billingdocument AND conditiontype IN ( 'ZA01' ) INTO @saleorderpricing-conditionrateratio .
      ENDIF.


      DATA: str TYPE string.
      str = saleorderpricing-conditionrateratio.
      SPLIT str AT '.' INTO DATA(a1) DATA(a2) .
      DATA(a3) = a2+0(2) .
      CONCATENATE a1 '.' a3 INTO a1 .
      DATA line1 TYPE string.
      DATA line2 TYPE string.

      DATA tot1 TYPE string .
      tot1 = subtot .
      CONDENSE tot1 .
      SPLIT tot1 AT '.' INTO tot1 DATA(tot2).

      IF tot2 NE '00' .
        DATA: amt_in2 TYPE string.
        DATA(amt_in) = ycl_spellinwords=>spellamt( iv_num =  tot1 )  .
        CLEAR:amt_in2.
        amt_in2  = ycl_spellinwords=>spellamt( iv_num =  tot2 )  .
        CONDENSE amt_in2.
        REPLACE ALL OCCURRENCES OF ' and ' IN amt_in WITH  ' ' .
        amt_in2 = COND #( WHEN amt_in2 IS NOT INITIAL THEN |US Dollors { amt_in } and { amt_in2 } Cents|
                           ELSE |US Dollors { amt_in }| )."|{ amt_in } DOLLARS { amt_in2 } CENTS |  .

      ELSE .



        amt_in = ycl_spellinwords=>spellamt( iv_num =  tot1 )  .

*        amt_in2 = |{ amt_in } DOLLARS |  .
        amt_in2 = COND #( WHEN amt_in2 IS NOT INITIAL THEN |US Dollors { amt_in } and { amt_in2 } Cents|
                           ELSE |US Dollors { amt_in }| ).
      ENDIF .

*DATA igst1 TYPE STRING .
      IF igst1 IS INITIAL .
        line1 = 'DB002-“I declare that no refund of Integrated Goods and Services Tax Paid on export goods shall be claimed.”' .
        line2 = 'SUPPLY MEANT FOR EXPORT UNDER LETTER OF UNDERTAKING WITHOUT PAYMENT OF IGST'.
      ELSE.
        line2 = 'SUPPLY MEANT FOR EXPORT ON PAYMENT OF IGST'.
      ENDIF.


      DATA(text1) = | 100% COTTON GREY { division-divisionname  }|  .
      DATA(lv_xml3) =
            |</Table6>| &&
            |<tottab>| &&
            |<Table7>| &&
            |<Row1>| &&
            |<ExchangeRate>{ billhead-accountingexchangerate }</ExchangeRate>| &&
            |</Row1>| &&
            |<Row2>| &&
            |<valCur>({ billhead-transactioncurrency })</valCur>| &&
            |<Value>{ subtot }</Value>| &&
            |</Row2>| &&
            |<Row3>| &&
            |<OceabFreightCur>({ billhead-transactioncurrency })</OceabFreightCur>| &&
            |<OceanFreight>{ freight }</OceanFreight>| &&
            |</Row3>| &&
            |<Row4>| &&
            |<InsuranceCur>({ billhead-transactioncurrency })</InsuranceCur>| &&
            |<Insurance>{ ins }</Insurance>| &&
            |</Row4>| &&
            |<Row5>| &&
            |<TotalCur>({ billhead-transactioncurrency })</TotalCur>| &&
            |<Total>{ assebible_inusd1 }</Total>| &&
            |</Row5>| &&
            |<Row6>| &&
            |<AssenssableValueinRs>{ assebible_inrs }</AssenssableValueinRs>| &&
            |</Row6>| &&
            |<Row7>| &&
            |<IgstCur></IgstCur>| && "billhead-transactioncurrency })</IgstCur>| &&
            |<IGDT>{ igst1 }</IGDT>| &&
            |</Row7>| &&
            |<Row8>| &&
            |<ToralDuty>{ igst1 }</ToralDuty>| &&
            |</Row8>| &&
            |</Table7>| &&
            |</tottab>| &&
            |<Bank>Bank :BOB AD CODE:02002FC,IFSC CODE :BARB0DBBLWD,COMMISSION-{ a1 }%,| &&
  "          |SALES TURNOVER POLICY NO.2377967-0000-01-10042023 EPCG LICENCE NO.{ billhead-yy1_epcgmiesno_bdh } DT { billhead-yy1_epcgdate_bdh+6(2) }.{ billhead-yy1_epcgdate_bdh+4(2) }.{ billhead-yy1_epcgdate_bdh(4) }</Bank>| &&
            |SALES TURNOVER POLICY NO.1413002-123P-10-4493459 EPCG LICENCE NO.{ eximdata-Epcgno } DT { eximdata-Epcgdate }</Bank>| &&
            |<Hardcode>| &&
            |</Hardcode>| &&
            |<TotalAmountwords>{ amt_in2 }</TotalAmountwords>| &&
            |<Subform10>| &&
            |{ hsnxml1 }| &&
            |<Subform11>| &&
            |<DECLARATION>| &&
            |<dISC>{ text1 }</dISC>| &&
            |<neigst>| &&
            |<Line1></Line1>| &&
            |<Line2>{ line2 }</Line2>| &&
            |<Line3>{ line1 }</Line3>| &&
            |<Line4>DB003-"I declare that CENVATcredit on the input or input services used in the manufacture of the export goods has not been carried forward in terms of the Central Goods and Services Tax Act. 2017"</Line4>| &&
            |<Line5>I.E CODE NO.1304005470 PAN. NO. AAHCS2781A</Line5>| &&
            |</neigst>| &&
            |<igst/>| &&
            |</DECLARATION>| &&
            |<Subform12>| &&
            |<Remark>{ eximdata-Remarks } { eximdata-Remarks1 } { eximdata-Remarks2 }</Remark>| &&
            |<Remark></Remark>| &&
            |</Subform12>| &&
            |</Subform11>| &&
            |</Subform10>| &&
            |</form1>|.

      CONCATENATE lv_xml xsml lv_xml3 INTO lv_xml .

    ENDIF .

    CALL METHOD ycl_test_adobe=>getpdf(
      EXPORTING
        xmldata  = lv_xml
        template = template
      RECEIVING
        result   = result12 ).







  ENDMETHOD.
ENDCLASS.
