CLASS yroadtep_class DEFINITION
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

        RETURNING VALUE(result12) TYPE string
        RAISING   cx_static_check .

  PROTECTED SECTION.
  PRIVATE SECTION.


    CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
    CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
    CONSTANTS  lv2_url    TYPE string VALUE 'https://sagar.authentication.eu10.hana.ondemand.com/oauth/token'  .
    CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
    CONSTANTS lc_template_name TYPE string VALUE 'TAX_SALE_SCRIPT/TAX_SALE_SCRIPT'.


ENDCLASS.



CLASS YROADTEP_CLASS IMPLEMENTATION.


 METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).

  ENDMETHOD .


  METHOD if_oo_adt_classrun~main.



    DATA(xml)  = read_posts( variable = '0090000130'  )   .


  ENDMETHOD.


 METHOD read_posts .

    SELECT * FROM  yeinvoice_cdss   WHERE billingdocument = @variable   INTO TABLE @DATA(it) .
    SELECT SINGLE * FROM i_billingdocumentbasic WHERE billingdocument =  @variable INTO @DATA(billhead) .
    SELECT SINGLE * FROM  i_billingdocumentitem AS a
    LEFT OUTER JOIN i_deliverydocumentitem AS b ON ( a~referencesddocument = b~deliverydocument AND a~referencesddocumentitem = b~deliverydocumentitem )
    INNER JOIN   i_deliverydocument AS f ON ( b~deliverydocument = f~deliverydocument )
    LEFT OUTER JOIN i_shippingtypetext AS s ON ( f~shippingtype = s~shippingtype AND s~language = 'E'  )
       WHERE  billingdocument  =  @variable INTO @DATA(billingitem)  .
*IF BILLINGITEM-SA
    SELECT * FROM i_billingdocumentitem WHERE billingdocument = @billingitem-a-referencesddocument INTO TABLE @DATA(deli) .

    DELETE ADJACENT DUPLICATES FROM deli COMPARING referencesddocument.

*if billhead-CreatedByUser id
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

    SELECT SINGLE * FROM zsd_dom_address WITH PRIVILEGED ACCESS WHERE addressid = @billto-addressid INTO @DATA(billtoadd1)   .




    IF it IS NOT INITIAL .

      READ TABLE it INTO DATA(gathd) INDEX 1 .

    ENDIF .



    CONCATENATE salesorder-salesdocumentdate+6(2) '/' salesorder-salesdocumentdate+4(2) '/' salesorder-salesdocumentdate+0(4) INTO DATA(SALESORDERDATE) .
*    CONCATENATE  billhead-yy1_lcdate_bdh+6(2) '/'  billhead-yy1_lcdate_bdh+4(2) '/'  billhead-yy1_lcdate_bdh+0(4) INTO  DATA(LCDATE)  .
*
*    CONCATENATE  billhead-yy1_lrdate_bdh+6(2) '/'  billhead-yy1_lrdate_bdh+4(2) '/'  billhead-yy1_lrdate_bdh+0(4) INTO  DATA(LRDATE) .
*    DATA: transmode TYPE string.
*    IF billhead-yy1_precarrierbytransp_bdh = '1'.
*      transmode  = 'By Road'  .
*    ELSEIF billhead-yy1_precarrierbytransp_bdh = '2'.
*      transmode  = 'By Air '  .
*    ELSEIF billhead-yy1_precarrierbytransp_bdh = '3'.
*      transmode  = 'By Sea '  .
*    ELSEIF billhead-yy1_precarrierbytransp_bdh = '4'.
*      transmode  = 'Road/Rail '  .
*    ELSEIF billhead-yy1_precarrierbytransp_bdh = '5'.
*      transmode  = 'Road/Air '  .
*    ELSEIF billhead-yy1_precarrierbytransp_bdh = '6'.
*      transmode  = 'Road/Sea'  .
*    ENDIF .
*

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


*if billhead-Division = '10' .

*  SELECT SUM( itemgrossweight ) FROM i_deliverydocumentitem WHERE deliverydocument = @billingitem-a-referencesddocument INTO @grossweight .



*endif.

if billhead-Division = '10' .

 SELECT
    SUM(  grosswt )
       FROM i_deliverydocumentitem  AS a
       INNER JOIN zpackn_cds AS b ON
                        ( a~batch = b~batch  AND a~batch NE ' ' AND  b~batch NE ' ' )
                                           WHERE  a~deliverydocument =  @billingitem-a-referencesddocument   INTO @grossweight .

endif.



    SELECT
    SUM( billingquantity )
       FROM i_billingdocumentitem  AS a
       WHERE billingdocument = @billingitem-a-billingdocument
       INTO @DATA(netweight).

*DATA(MON)  =    gathd-billingdocumentdate+6(2) .

*DATA(MONTH)  = SWITCH STRING( MON
*WHEN 01 THEN 'JAN'
*WHEN 02 THEN 'FEB'
*WHEN 03 THEN 'MAR'
*WHEN 04 THEN 'APR'
*WHEN 05 THEN 'MAY'
*WHEN 06 THEN 'JUN'
*WHEN 07 THEN 'JUL'
*WHEN 08 THEN 'AUG'
*WHEN 09 THEN 'SEP'
*WHEN 10 THEN 'OCT'
*WHEN 11 THEN 'NOV'
*WHEN 12 THEN 'DEC'  ) .


    IF billhead-distributionchannel NE '80'  .


      DATA(lv_xml) = |<Form>| &&
            |<bdyMain>| &&
            |<frmBillToAddress>| &&
            |<txtLine2>{ billtoadd1-addresseefullname }</txtLine2>| &&
            |<txtLine3>{ billtoadd1-streetprefixname1 }</txtLine3>| &&
            |<txtLine4>{ billtoadd1-streetprefixname2  }</txtLine4>| &&
            |<txtLine5>{ billtoadd1-streetsuffixname1 }{ billtoadd1-streetsuffixname2 }</txtLine5>| &&
            |<txtLine6>{ billto-cityname }({ billto-postalcode  })</txtLine6>| &&
            |<txtLine7>{ regiontext1-regionname  }</txtLine7>| &&
*            |<txtLine8>{ billhead-billingdocumenttype  }</txtLine8>| &&
*            |<txtRegion>{ regiontext1-region  }</txtRegion>| &&
            |<txtGSTIN>{ billto-taxnumber3 }</txtGSTIN>| &&
            |<BillingDocument>{ gathd-billingdocument }</BillingDocument>| &&
            |<DateField1>{ gathd-billingdocumentdate+6(2) }/{ gathd-billingdocumentdate+4(2) }/{ gathd-billingdocumentdate+0(4) }</DateField1>| &&
            |<preparedby1>{ username }</preparedby1>| &&
            |</frmBillToAddress>| .

      DATA rat TYPE p DECIMALS 2 .
      DATA xsml TYPE string .
      DATA count TYPE int8 .
      DATA  N  TYPE  STRING.

        LOOP AT it INTO DATA(iv) .

        N  = N + 1 .

        SELECT COUNT(*)  FROM  i_deliverydocumentitem WHERE deliverydocument = @iv-delivery_number AND
               deliverydocumentitem =  @iv-delivery_number_item AND batch IS NOT INITIAL INTO @count   .

        SELECT SINGLE actualdeliveryquantity FROM  i_deliverydocumentitem WHERE deliverydocument = @iv-delivery_number AND
               deliverydocumentitem  =  @iv-delivery_number_item AND batch IS NOT INITIAL INTO @DATA(package) .

        IF count IS INITIAL .
          SELECT COUNT(*)  FROM  i_deliverydocumentitem WHERE deliverydocument = @iv-delivery_number AND
               higherlvlitmofbatspltitm =  @iv-delivery_number_item AND batch IS NOT INITIAL INTO @count    .

          SELECT SINGLE actualdeliveryquantity FROM i_deliverydocumentitem WHERE deliverydocument = @iv-delivery_number AND
                 higherlvlitmofbatspltitm =  @iv-delivery_number_item AND batch IS NOT INITIAL INTO @package   .

        ENDIF .

        count = COND #( WHEN count IS INITIAL THEN '1' ELSE count ).
        package = COND #( WHEN count = '1' THEN iv-billingquantity ELSE package ).

     if iv-Division = '10'  .

     package =  ' '  .

     endif .

*        SELECT SINGLE yy1_lotno_dli FROM i_deliverydocumentitem WHERE deliverydocument = @iv-delivery_number
*                   AND deliverydocumentitem = @iv-delivery_number_item INTO @DATA(lot).

        rat = iv-basicrate .

        DATA orgqty  TYPE zpdec2 .
        DATA total_othfrt TYPE  zpdec2 .
        DATA rat1 TYPE  zpdec2 .
        DATA subtot TYPE zpdec2 .
         DATA subtot1 TYPE zpdec2 .
        orgqty = iv-billingquantity.

        total_othfrt  = iv-zdin_amt + iv-zfdo_amt + iv-zfoc_amt .

         iv-netamount = rat * iv-billingquantity.
*        ENDIF .

        subtot = subtot + iv-netamount .
data material1 type string .



*SELECT SINGLE YY1_FullDescription_PRD FROM I_PRODUCT WHERE  Product = @iv-Material    INTO @DATA(MAT2)  .


 SELECT SINGLE * FROM i_salesdocumentitem WHERE salesdocument = @iv-sddocu AND salesdocumentitem = @iv-sddocuitem INTO @DATA(sdata1)  .

*        material1  = sdata1-yy1_customermaterialde_sdi .

        IF material1 IS INITIAL .

*          material1 = |{ iv-materialdescription } { MAT2 }| .

        ENDIF .
SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
      conditiontype =  'ZDIS'   AND billingdocument = @IV-BillingDocument AND billingdocumentitem = @IV-BillingDocumentitem  INTO @DATA(discount3)  .

     subtot1 = subtot1 + iv-netamount  .

select single * from I_SalesDocumentItem where SalesDocument = @iv-sddocu
                                           and SalesDocumentItem = @iv-sddocuitem into @data(saleadditionaldata) .


         DATA(lv_xml2) =
               |<rowitem>| &&
               |<sno>{ N }</sno>| &&
               |<coldescription>{ material1 }</coldescription>| &&
               |<IN_HSNOrSACCode>{ iv-hsncode }</IN_HSNOrSACCode>| &&
               |<NetAmount>{ iv-netamount }</NetAmount>| &&
               |</rowitem>|.

          CONCATENATE xsml lv_xml2 INTO  xsml .
        CLEAR  : iv,lv_xml2,iv.

      ENDLOOP .




      SELECT SUM( billingquantity  )  FROM  i_billingdocumentitem
      WHERE billingdocument = @variable INTO @DATA(netqua) .

      SELECT SINGLE * FROM i_billingdocumentitemprcgelmnt WHERE conditiontype IN ( 'JICG', 'JOIG' , 'JOSG' )
      AND billingdocument =   @variable INTO @DATA(basicrate)  .
      DATA total TYPE p DECIMALS 2 .
      DATA bas TYPE  string .
      DATA bas1 TYPE  string .
      DATA bas2 TYPE  string .
      DATA bas3 TYPE  string .

      total = billhead-totalnetamount + billhead-totaltaxamount .

      bas = basicrate-conditionrateratio .
      bas  = bas+0(3)  .

      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
      conditiontype IN ( 'ZFFA' ,'ZFMK','ZFDO','ZFOC' ) AND billingdocument = @variable  INTO @DATA(freight)  .

 SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
      conditiontype =  'ZFFA'   AND billingdocument = @variable  INTO @DATA(freight_ffa)  .


SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
      conditiontype =  'ZDIS'   AND billingdocument = @variable  INTO @DATA(discount)  .

 SELECT SINGLE conditionrateratio FROM i_billingdocumentitemprcgelmnt WHERE conditiontype =  'ZDIS'
      AND billingdocument =   @variable INTO @DATA(discount_rate)  .

      if discount is not INITIAL .
data(discount_rate1) = discount_rate && '%' .

endif .
*conditionrateratio

*SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
*      conditiontype =  'ZDIS'   AND billingdocument = @variable  INTO @DATA(discount)  .

       SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
      conditiontype IN ( 'ZFFA' ) AND billingdocument = @variable  INTO @data(freight_fix)  .

      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
     conditiontype EQ  'ZLDA' AND billingdocument = @variable  INTO @DATA(loading)  .


      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
     conditiontype EQ  'ZPCA' AND billingdocument = @variable   INTO @DATA(packing)  .


      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
      conditiontype IN ( 'ZINS','ZDIN' ) AND billingdocument = @variable INTO @DATA(ins)  .

      SELECT SUM( conditionamount ) FROM  i_billingdocumentitemprcgelmnt WHERE
      conditiontype IN ( 'ZTCS','JTC1' ) AND billingdocument = @variable INTO @DATA(tcs)  .

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


      DATA grandtotal TYPE zpdec2 .
      DATA grandtotal1 TYPE string .
      DATA roundoff TYPE zpdec2 .

*      grandtotal  = subtot + freight + ins + gst +  tcs + loading  + packing .
grandtotal  = subtot  + ins + gst +  tcs + loading  + packing  + freight_fix  + discount.
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



*{ billhead-incotermsclassification }/{ billhead-incotermslocation1 }
*
*{ terms-paymentterms }
      SELECT SINGLE * FROM i_incotermsclassificationtext
           WHERE incotermsclassification = @billhead-incotermsclassification AND language = 'E' INTO @DATA(inconame) .


      DATA deliveryterms  TYPE string .

      DATA terms1 TYPE string .
      DATA BASIC TYPE P DECIMALS 2 .

BASIC = subtot - freight + freight_ffa .


  IF  gathd-division =  '10'.
        deliveryterms  = inconame-incotermsclassificationname .
        terms1 = terms-paymenttermsname  .

      ELSE .
        deliveryterms  = |{ billhead-incotermsclassification }/{ salesorder-IncotermsLocation1 }|.
        terms1 = terms-paymentterms .

      ENDIF .



  DATA(lv_xml3) =
              |<Subform1>| &&
              |<TOTALAMOUNT>{ Subtot1 }</TOTALAMOUNT>| &&
              |</Subform1>| &&
              |<Subform2>| &&
              |<DISCOUNT>{ discount }</DISCOUNT>| &&
              |</Subform2>| &&
              |<Subform3>| &&
              |<GROSAMOUNT>{ grandtotal }</GROSAMOUNT>| &&
              |</Subform3>| &&
              |<Subform4>| &&
              |<amountwrd></amountwrd>| &&
              |</Subform4>| &&
              |<Subform5>| &&
*              |<REMARK1>{ billhead-YY1_Remakrs1_BDH }</REMARK1>| &&
              |</Subform5>| &&
              |<Subform6/>| &&
              |</bdyMain>| &&
              |</Form>| .


          CONCATENATE lv_xml xsml lv_xml3 INTO lv_xml .

endif.

      REPLACE ALL OCCURRENCES OF '&' IN lv_xml WITH 'and'.


    CALL METHOD ycl_test_adobe=>getpdf(
      EXPORTING
        xmldata  = lv_xml
        template = lc_template_name
      RECEIVING
        result   = result12 ).


 ENDMETHOD  .
ENDCLASS.
