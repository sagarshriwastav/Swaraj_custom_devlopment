CLASS zsd_job_sales_ord_print_class DEFINITION
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
        IMPORTING VALUE(salesorderno) TYPE string
*                  VALUE(year) TYPE string


        RETURNING VALUE(result12) TYPE string
        RAISING   cx_static_check .




  PROTECTED SECTION.
  PRIVATE SECTION.

     CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
    CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
    CONSTANTS  lv2_url    TYPE string VALUE 'https://btp-yvzjjpaz.authentication.eu10.hana.ondemand.com/oauth/token' .
    CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
    CONSTANTS lc_template_name TYPE string VALUE 'JOB_SALES_ORDER/JOB_SALES_ORDER'.

ENDCLASS.



CLASS ZSD_JOB_SALES_ORD_PRINT_CLASS IMPLEMENTATION.


  METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).

  ENDMETHOD .


  METHOD if_oo_adt_classrun~main.



    DATA(xml)  = read_posts( salesorderno = '0080000330'  )   .


  ENDMETHOD.


   METHOD read_posts .


    DATA:LV  TYPE  C LENGTH 100   .
     DATA VAR1 TYPE ZCHAR10.
     DATA VAR2 TYPE ZCHAR10.
        VAR1 = salesorderno.
        VAR1 =   |{ VAR1  ALPHA = IN }| .


         data   lv_xml type string.

         select  * from I_SalesDocumentItem as a
             where a~SalesDocument = @var1 AND a~Material LIKE 'A00%'
           INTO TABLE @DATA(it) .

         READ TABLE It INTO DATA(WA) INDEX 1.


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
 WHERE salesdocument = @wa-SalesDocument AND partnerfunction = 'WE' INTO @DATA(shiptoparty).

 wa_add-var1 = shiptoparty-organizationname1.
 wa_add-var2 = shiptoparty-organizationname2.
 wa_add-var3 = shiptoparty-organizationname3.

 DATA(shipaddname) = zseparate_address=>separate( CHANGING var = wa_add ).

 wa_add-var1 = shiptoparty-housenumber.
 wa_add-var2 = shiptoparty-streetname.
 wa_add-var3 = shiptoparty-streetprefixname1.
 wa_add-var4 = shiptoparty-streetprefixname2.
 wa_add-var5 = shiptoparty-streetsuffixname1.
 wa_add-var6 = shiptoparty-streetsuffixname2.

 DATA(shipaddhono) = zseparate_address=>separate( CHANGING var = wa_add ).

 wa_add-var1 = shiptoparty-cityname.
* wa_add-var2 = shiptoparty-districtname.
 wa_add-var3 = shiptoparty-postalcode.

 DATA(shipaddcity) = zseparate_address=>separate( CHANGING var = wa_add ).

  wa_add-var1 = shiptoparty-cityname.

 DATA(shipaddcity1) = zseparate_address=>separate( CHANGING var = wa_add ).

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
 WHERE salesdocument = @wa-SalesDocument AND partnerfunction = 'RE' INTO @DATA(BilLtoparty).

 wa_add-var1 = BilLtoparty-organizationname1.
 wa_add-var2 = BilLtoparty-organizationname2.
 wa_add-var3 = BilLtoparty-organizationname3.

 DATA(Billaddname) = zseparate_address=>separate( CHANGING var = wa_add ).

 wa_add-var1 = BilLtoparty-housenumber.
 wa_add-var2 = BilLtoparty-streetname.
 wa_add-var3 = BilLtoparty-streetprefixname1.
 wa_add-var4 = BilLtoparty-streetprefixname2.
 wa_add-var5 = BilLtoparty-streetsuffixname1.
 wa_add-var6 = BilLtoparty-streetsuffixname2.

 DATA(Billaddhono) = zseparate_address=>separate( CHANGING var = wa_add ).

 wa_add-var1 = BilLtoparty-cityname.
* wa_add-var2 = shiptoparty-districtname.
 wa_add-var3 = BilLtoparty-postalcode.

 DATA(Billaddcity) = zseparate_address=>separate( CHANGING var = wa_add ).


 SELECT SINGLE  FullName FROM  i_salesdocumentpartner WHERE salesdocument = @wa-SalesDocument AND partnerfunction = 'ZT'
                     INTO @DATA(Transporter).

 SELECT SINGLE FullName FROM  i_salesdocumentpartner WHERE salesdocument = @wa-SalesDocument AND partnerfunction = 'ZA'
                     INTO @DATA(AGENT).
 SELECT SINGLE * FROM I_PaymentTermsText WHERE PaymentTerms = @wa-CustomerPaymentTerms AND Language = 'E' INTO @data(pterm) .
 SELECT SINGLE * FROM I_SalesDocumentPartner as a  LEFT OUTER JOIN
 zsupplier_details as b on ( b~Supplier = a~Supplier ) WHERE a~SalesDocument = @var1 and a~PartnerFunction = 'ZA'
  INTO @data(email).
     lv_xml =
            |<Form>| &&
   |<frmShipToAddress>| &&
   |<txtShipToAddressID></txtShipToAddressID>| &&
   |<txtShipToPersonnelID></txtShipToPersonnelID>| &&
   |<txtShipToAddressType></txtShipToAddressType>| &&
   |</frmShipToAddress>| &&
   |<HIDPLANT>| &&
   |<COMPANYCODE>{ wa-SalesOrganization }</COMPANYCODE>| &&
   |<PLANT>{ wa-Plant }</PLANT>| &&
   |</HIDPLANT>| &&
   |<HIDEDATESUB>| &&
   |<HIDEDATE>{ WA-CreationDate }</HIDEDATE>| &&
   |<HIDEJOBORDER>{ VAR1 }</HIDEJOBORDER>| &&
   |</HIDEDATESUB>| &&
   |<Billtoadd1>{ Billaddname }</Billtoadd1>| &&
   |<Billtoadd2>{ Billaddhono }</Billtoadd2>| &&
   |<Billtoadd3>{ Billaddcity }</Billtoadd3>| &&
   |<Billtoadd4>{ BilLtoparty-DistrictName }</Billtoadd4>| &&
   |<Billtoadd5>{ BilLtoparty-RegionName }</Billtoadd5>| &&
   |<txtLine8></txtLine8>| &&
   |<txtLine7></txtLine7>| &&
   |<txtLine1></txtLine1>| &&
   |<Agent>{ AGENT }</Agent>| &&
   |<Agentemail>{ email-b-EmailAddress }</Agentemail>| &&
   |<paymentterm></paymentterm>| &&
   |<ContractNo>{ WA-OriginSDDocument }</ContractNo>| &&
   |<Transport>{ Transporter }</Transport>| &&
   |<Paymentterm>{ pterm-PaymentTermsDescription }</Paymentterm>| &&
   |<Dispatch></Dispatch>| &&
   |<DeliveryDays></DeliveryDays>| &&
   |<Plant>Miru</Plant>| &&
   |<ShpAdd1>{ shipaddname }</ShpAdd1>| &&
   |<ShpAdd2>{ shipaddhono }</ShpAdd2>| &&
   |<ShpAdd3>{ shipaddcity }</ShpAdd3>| &&
   |<txtLine7></txtLine7>| &&
   |<ShpAdd4>{ shiptoparty-districtname }</ShpAdd4>| &&
   |<ShpAdd5>{ shiptoparty-regionname }</ShpAdd5>| &&
   |<txtLine1></txtLine1>| &&
   |<ShpAdd6></ShpAdd6>| &&
   |<TABSUB>| &&
   |<tblRemarkRowTable/>| &&
   |</TABSUB>| &&
   |<Table1>| .

DATA N TYPE I .
DATA N1 TYPE I .
DATA TOTQTY TYPE menge_d.
DATA CDPICKRATE TYPE P DECIMALS 2.
DATA MNDRATE TYPE P DECIMALS 2.
DATA ROLRATE TYPE P DECIMALS 2.
DATA TotlRoll TYPE I.
DATA TotlRollOUT TYPE I.

 LOOP AT it INTO DATA(WA_FI) .
       N1 = N1 + 1.
       TOTQTY = TOTQTY + WA_FI-OrderQuantity .
        SELECT SINGLE conditionRateValue  FROM  I_SalesOrderItemPricingElement WHERE
      conditiontype IN ( 'ZPIC' )   AND SalesOrder = @WA_FI-SalesDocument
                              AND SalesOrderItem = @WA_FI-SalesDocumentItem
         INTO @CDPICKRATE  .

      SELECT SINGLE conditionRateValue  FROM  I_SalesOrderItemPricingElement WHERE
      conditiontype IN ( 'ZMND' )   AND SalesOrder = @WA_FI-SalesDocument
                              AND SalesOrderItem = @WA_FI-SalesDocumentItem
         INTO @MNDRATE  .

         SELECT SINGLE conditionRateValue  FROM  I_SalesOrderItemPricingElement WHERE
      conditiontype IN ( 'ZROL' )   AND SalesOrder = @WA_FI-SalesDocument
                              AND SalesOrderItem = @WA_FI-SalesDocumentItem
         INTO @ROLRATE  .

       SELECT SINGLE dyeingshade FROM zpp_sortmaster  WHERE material = @WA_FI-Material INTO @DATA(SHadeno).


        SELECT SINGLE PRICESPECIFICATIONPRODUCTGROUP FROM I_PRODUCTSALESDELIVERY
        WHERE PRODUCT =  @WA_FI-MATERIAL and ProductDistributionChnl = '04' INTO @DATA(GROUP) .
        SELECT SINGLE YY1_WarpWastagePercent_SDH FROM I_SalesDocument WHERE SalesDocument = @wa_fi-SalesDocument INTO @DATA(warp).
         SELECT SINGLE YY1_WeftWastagePecenta_SDH FROM I_SalesDocument WHERE SalesDocument = @wa_fi-SalesDocument INTO @DATA(weft).

        IF GROUP = 'A1' .
        N = '100'.
        ELSEIF GROUP = 'A2' .
        N = '101'.
        ELSEIF GROUP = 'A3' .
        N = '102'.
        ELSEIF GROUP = 'A4' .
        N = '103'.
        ELSEIF GROUP = 'A5' .
        N = '104'.
        ELSEIF GROUP = 'A6' .
        N = '105'.
        ELSEIF GROUP = 'A7' .
        N = '106'.
        ELSEIF GROUP = 'A8' .
        N = '107'.
        ELSEIF GROUP = 'A9' .
        N = '108'.
        ELSEIF GROUP = 'A0' .
        N = '109'.
        ELSEIF GROUP = 'B1' .
        N = '110'.
        ELSEIF GROUP = 'B2' .
        N = '111'.
        ELSEIF GROUP = 'B3' .
        N = '112'.
        ELSEIF GROUP = 'B4' .
        N = '113'.
        ELSEIF GROUP = 'B5' .
        N = '114'.
        ELSEIF GROUP = 'B6' .
        N = '115'.
        ELSEIF GROUP = 'B7' .
        N = '116'.
        ELSEIF GROUP = 'B8' .
        N = '117'.
        ELSEIF GROUP = 'B9' .
        N = '118'.
        ELSEIF GROUP = 'B0' .
        N = '119'.
        ELSEIF GROUP = 'C1' .
        N = '120'.
        ELSE .
        N = GROUP .
        ENDIF.

  TotlRollOUT  = | { WA_FI-YY1_Rolls_SDI ALPHA = OUT } | .

  TotlRoll  = TotlRoll + TotlRollOUT .

         lv_xml = lv_xml &&

         |<Row1>| &&
         |<SNO>{ N1 }</SNO>| &&
         |<CUT>{ WA_FI-YY1_Cut1_SDI }</CUT>| &&
         |<ITEM>{  WA_FI-SalesDocumentItemText  }</ITEM>| &&
         |<QTY>{ WA_FI-OrderQuantity }</QTY>| &&
         |<UNIT>{ WA_FI-OrderQuantityUnit }</UNIT>| &&
         |<SHADE>{ SHadeno }</SHADE>| &&
         |<ROLLS>{ | { WA_FI-YY1_Rolls_SDI ALPHA = OUT } | }</ROLLS>| &&
         |<PICK>{ N }</PICK>| &&
         |<PICKRATE>{ CDPICKRATE }</PICKRATE>| &&
         |<MNDCHARGE>{ MNDRATE }</MNDCHARGE>| &&
         |<ROLLCHARGE>{ ROLRATE }</ROLLCHARGE>| &&
         |<warppersantage>{ warp }</warppersantage>| &&
         |<weftpersantage>{ weft }</weftpersantage>| &&
      |</Row1>|.
   ENDLOOP.

            lv_xml = lv_xml &&
            |</Table1>| &&
            |<TOTQTY>{ TOTQTY }</TOTQTY>| &&
            |<TOTROLLS>{ TotlRoll }</TOTROLLS>| &&
            |</Form>| .



    REPLACE ALL OCCURRENCES OF '&' IN lv_xml WITH 'and'.

  CALL METHOD ycl_test_adobe=>getpdf(
       EXPORTING
         xmldata  = LV_XML
         template = lc_template_name
       RECEIVING
         result   = result12 ).

  ENDMETHOD.
ENDCLASS.
