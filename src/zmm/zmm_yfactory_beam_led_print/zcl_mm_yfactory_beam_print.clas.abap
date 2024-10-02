CLASS zcl_mm_yfactory_beam_print DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
    CLASS-DATA : access_token TYPE string .
    CLASS-DATA : xml_file TYPE string .
    CLASS-DATA : template TYPE string .
    CLASS-DATA : tot_sum  TYPE string.

    TYPES : BEGIN OF struct,
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
        RAISING   cx_static_check,

      read_posts
        IMPORTING VALUE(CUSTOMER) TYPE string
                  VALUE(datefrom)    TYPE string
                  VALUE(dateto)      TYPE string
                  VALUE(PLANT)  TYPE string

        RETURNING VALUE(result12)    TYPE string
        RAISING   cx_static_check .


  PROTECTED SECTION.
  PRIVATE SECTION.


    CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
    CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
    CONSTANTS  lv2_url    TYPE string VALUE 'https://btp-yvzjjpaz.authentication.eu10.hana.ondemand.com/oauth/token'  .
    CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
 CONSTANTS  lc_template_name TYPE string VALUE 'YARN_FACTORY_BEAM_REPORT_PRINT/YARN_FACTORY_BEAM_REPORT_PRINT'.

ENDCLASS.



CLASS ZCL_MM_YFACTORY_BEAM_PRINT IMPLEMENTATION.


    METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).
  ENDMETHOD .


  METHOD if_oo_adt_classrun~main.
    TRY.
    ENDTRY.
  ENDMETHOD.


   METHOD read_posts .

   DATA lv_xml TYPE string.
    DATA XSML TYPE STRING.
    DATA date2 TYPE string.
    DATA gv1 TYPE string .
    DATA gv2 TYPE string .
    DATA gv3 TYPE string .

    gv3 = datefrom+6(4)  .
    gv2 = datefrom+3(2)  .
    gv1 = datefrom+0(2)  .

    CONCATENATE gv3 gv2 gv1   INTO date2.

    DATA date3 TYPE string.
    DATA gv4 TYPE string .
    DATA gv5 TYPE string .
    DATA gv6 TYPE string .

    gv6 = dateto+6(4)  .
    gv5 = dateto+3(2)  .
    gv4 = dateto+0(2)  .

    CONCATENATE gv6 gv5 gv4  INTO date3.

    DATA FromToDate TYPE string.
    DATA FromGS TYPE string.
    DATA ToGS TYPE string.
    CONCATENATE  gv1 '/' gv2 '/' gv3 INTO FromGS.
    CONCATENATE  gv4 '/' gv5 '/' gv6 INTO ToGS .
    CONCATENATE FromGS 'TO' ToGS INTO FromToDate SEPARATED BY ''.

    DATA Customer1 TYPE C LENGTH 10.
    Customer1  =   |{ Customer ALPHA = IN }| .

    DATA OPENING TYPE P DECIMALS 3.
    DATA OPENINGFEBRIC TYPE P DECIMALS 3.
    DATA TOTALOPENING TYPE P DECIMALS 3.
     data feb TYPE P DECIMALS 3 .

    SELECT SINGLE OpeningBalance FROM ZMM_YARN_FACTORY_BEAM_OPEN1(  P_KeyDate = @date2 ) WITH PRIVILEGED ACCESS
    WHERE  Customer = @customer1 AND Plant = @plant INTO @OPENING.

      SELECT SINGLE * FROM I_Customer WITH PRIVILEGED ACCESS WHERE Customer = @customer1 INTO @DATA(CUST).

    SELECT SUM( dec1_10_0 ) FROM ZPP_OPENING_FABRICPRINT_MM1(  p_fromdate = @date2 , p_todate = @date2  ) WITH PRIVILEGED ACCESS
    WHERE Partyname = @cust-CustomerName AND  Plant = @plant INTO @DATA(FABRIC).

     feb = fabric .

    TOTALOPENING =  OPENING +  feb .

*    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

     SELECT SUM( StockQuantity )  FROM zsd_job_grey_dispatch_stock_cd WITH PRIVILEGED ACCESS
     WHERE  Partyname = @cust-CustomerName  INTO @DATA(STOCK2) .

     SELECT  * FROM zsd_job_grey_dispatch_stock_cd WITH PRIVILEGED ACCESS
     WHERE  Partyname = @cust-CustomerName  INTO TABLE @DATA(STOCK) .

     LOOP AT STOCK INTO DATA(ST) .

     SELECT SINGLE * FROM I_BillOfMaterialItemTP_2 WITH PRIVILEGED ACCESS WHERE Material = @ST-Material AND BillOfMaterialComponent LIKE 'Y%' INTO @DATA(MAT) .

     DATA MATQ2 TYPE I_BillOfMaterialItemTP_2-BillOfMaterialItemQuantity .
     DATA MATQ TYPE I_BillOfMaterialItemTP_2-BillOfMaterialItemQuantity .

     MATQ = MAT-BillOfMaterialItemQuantity / 100 .
     MATQ2 = MATQ2 + MATQ .
     CLEAR : MATQ .

     ENDLOOP.

*//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    SELECT * FROM ZMM_YARN_FACTORY_BEAM_PRINT( p_plant = @plant ,p_cust = @customer, p_posting = @date2 , p_posting1 = @date3 ) WITH PRIVILEGED ACCESS
    WHERE Customer = @customer1 AND Plant = @plant INTO TABLE @DATA(i_data).



    SELECT * FROM ZMM_YARN_FACTORY_BEAM_PRINT( p_plant = @plant ,p_cust = @customer, p_posting = @date2 , p_posting1 = @date3 ) WITH PRIVILEGED ACCESS as a
    INNER JOIN I_MaterialDocumentItem_2 WITH PRIVILEGED ACCESS AS B ON ( b~MaterialDocument = a~MaterialDocument )
    INNER JOIN  I_SalesDocument WITH PRIVILEGED ACCESS as C on ( C~SalesDocument = b~SalesOrder )
    WHERE A~Customer = @customer1  AND A~Plant = @plant INTO TABLE @DATA(i_data_WEFT).

   DELETE i_data_WEFT WHERE C-YY1_WarpWastagePercent_SDH IS INITIAL AND C-YY1_WarpWastagePercent_SDH = ''  .

   READ TABLE i_data_WEFT INTO DATA(WA_i_data) INDEX 1.


    SELECT SINGLE SalesOrganization FROM I_Plant WITH PRIVILEGED ACCESS WHERE Plant = @plant INTO  @DATA(COMPANYCOD) .

 DATA Register1 TYPE STRING.
 DATA Register2 TYPE STRING.
 DATA Register3 TYPE STRING.
 DATA Register4 TYPE STRING.

if Plant  = '1300'.
 Register1 = 'SWARAJ SUITING LIMITED'.
 Register2 = 'Weaving Division-I' .
 Register3 =  'F-483 To F-487 RIICO Growth Centre' .
 Register4 = 'Hamirgarh, Bhilwara-311025, Rajasthan, India'.
elseif Plant  = '2100'.
 Register1 = 'MODWAY SUITING PRIVATE LIMITED'.
 Register2 = 'Weaving Division-I' .
 Register3 = '20th Km Stone, Chittorgarh Road' .
 Register4 = 'Takhatpura, Bhilwara-311025, Rajasthan, India'.
ENDIF.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



   SELECT SINGLE A~CustomerName, b~DistrictName , a~CityName , b~StreetPrefixName1 ,b~StreetName FROM I_Customer WITH PRIVILEGED ACCESS AS A
   LEFT OUTER JOIN  ZI_DeliveryDocumentAddress2 WITH PRIVILEGED ACCESS AS B ON B~AddressID = A~AddressID
    WHERE a~Customer = @customer1 INTO @DATA(ADDRS).

    LV_Xml =
      |<form1>| &&
      |<Subform4>| &&
      |<MODWAYSUITINGPRIVATELIMITED>{ Register1 }</MODWAYSUITINGPRIVATELIMITED>| &&
      |<FromDate>{ FromToDate }</FromDate>| &&
      |<SUVIDHIRAYONSPLIMITED-1STCONT>{ ADDRS-CustomerName }</SUVIDHIRAYONSPLIMITED-1STCONT>| &&
      |<F-BLOCKBTMPURROAD>{ ADDRS-StreetPrefixName1 }</F-BLOCKBTMPURROAD>| &&
      |<Bhilwara>{ ADDRS-CityName }</Bhilwara>| &&
      |</Subform4>| &&
      |<Bhilwara1>{ ADDRS-DistrictName }</Bhilwara1>| &&
      |<OpeingBalance>| &&
      |<TextField1>{ TOTALOPENING }</TextField1>| &&
      |<warpwastage>{ WA_i_data-C-YY1_WarpWastagePercent_SDH }</warpwastage>| &&
      |<weftwastage>{ WA_i_data-C-YY1_WeftWastagePecenta_SDH }</weftwastage>| &&
      |</OpeingBalance>| &&
      |<Table1>| &&
      |<HeaderRow/>| .

  DATA BALANCE TYPE P DECIMALS 3.
  DATA BALANCE1 TYPE P DECIMALS 3.
  DATA BALANCE2 TYPE P DECIMALS 3.
  DATA MAterialWiseWastage TYPE P DECIMALS 3.
  DATA TotReciept_Qty TYPE P DECIMALS 3.
  DATA TotReturn_Qty TYPE P DECIMALS 3.
  DATA TotDispatc_QTY TYPE P DECIMALS 3.
  DATA TotNetwt TYPE P DECIMALS 3.
  DATA TotMAterialWiseWastage TYPE P DECIMALS 3.
  DATA Date TYPE string.
  DATA billnet TYPE p DECIMALS 3.

  SORT i_data ASCENDING BY PostingDate.
  LOOP AT i_data INTO DATA(WA_data) .

    CONCATENATE WA_data-PostingDate+6(2)'/' WA_data-PostingDate+4(2)'/' WA_data-PostingDate+0(4)  INTO Date.
   SELECT SINGLE product FROM I_ProductDescription WITH PRIVILEGED ACCESS WHERE ProductDescription = @WA_data-ProductDescription AND Product LIKE 'FGJL%'   INTO @DATA(mat1) .
   SELECT  SUM( BillOfMaterialItemQuantity ) FROM I_BillOfMaterialItemTP_2 WHERE Material = @mat1 AND BillOfMaterialComponent LIKE 'Y%' INTO @DATA(MAT2) .
   billnet = mat2 * WA_data-Dispatc_QTY / 100 .
   SELECT sum( b~Netwt ) FROM I_MaterialDocumentItem_2 AS A LEFT OUTER JOIN zpp_grey_grn_report as b on a~Batch = b~Recbatch
   WHERE a~MaterialDocument = @WA_data-MaterialDocument INTO @DATA(PS).
*   SELECT SINGLE * FROM I_MaterialDocumentItem_2 AS A LEFT OUTER JOIN zpp_grey_grn_report as b on a~Batch = b~Recbatch
*   WHERE a~MaterialDocument = @WA_data-MaterialDocument INTO @DATA(PS1).
*   SELECT SUM( Netwt ) FROM zpp_grey_grn_report WHERE Recbatch = @WA_data-Batch  AND Materialdec = @WA_data-ProductDescription INTO @DATA(PSS1) .

    SELECT SINGLE Wastegpersantage FROM ZFABRIC_WASTAGE_CDS WITH PRIVILEGED ACCESS WHERE Material = @wa_data-Material INTO @DATA(Wastegpersantage) .
    IF billnet > 0 .
    MAterialWiseWastage = ps * '3.50' / 100 .
    ENDIF.
*  if WA_data-Material+0(3) <> 'BDJ' AND WA_data-Material+0(4) <> 'BDJL'.

    BALANCE  = BALANCE + WA_data-Reciept_Qty - ( WA_data-Return_Qty + WA_data-Netwt + MAterialWiseWastage ).

    BALANCE1  =  BALANCE + TOTALOPENING .

    IF BALANCE1 < 0 .
    BALANCE2  =  BALANCE1 * -1 .
    ELSE.
    BALANCE2  = BALANCE1 .
    ENDIF.

    TotReciept_Qty          =    TotReciept_Qty + WA_data-Reciept_Qty .
    TotReturn_Qty           =    TotReturn_Qty +  WA_data-Return_Qty .
    TotDispatc_QTY          =  TotDispatc_QTY +  WA_data-Dispatc_QTY .
*    TotNetwt                =   TotNetwt   +  billnet. "WA_data-Netwt .
    TotMAterialWiseWastage  = TotMAterialWiseWastage   +  MAterialWiseWastage .
*  ENDIF.

     DATA(lv_xml1) =
         |<Row1>| &&
         |<Date>{ Date }</Date>| &&
         |<SNo>{ WA_data-MaterialDocument }</SNo>| &&
         |<ChlNo>{ WA_data-Challan_no }</ChlNo>| &&
         |<Item>{ WA_data-ProductDescription }</Item>| &&
         |<Purch.>{ WA_data-Reciept_Qty }</Purch.>| &&
         |<Tr_rec.Wt>{ WA_data-Return_Qty }</Tr_rec.Wt>| &&
         |<Tr_Isu>{ WA_data-Dispatc_QTY }</Tr_Isu>| &&
         |<Desp-Mtrs>{ WA_data-Netwt }</Desp-Mtrs>| &&
         |<Wastage>{ MAterialWiseWastage }</Wastage>| &&
         |<Balance>{ BALANCE2 }</Balance>| &&
         |</Row1>| .

          TotNetwt                =   TotNetwt   +  WA_data-Netwt . "WA_data-Netwt .
      CONCATENATE xsml LV_XML1  INTO XSML.
      CLEAR: WA_data,BALANCE1,MAterialWiseWastage,Wastegpersantage,Date.

   ENDLOOP.
     DATA TOTALBALANCE TYPE P DECIMALS 3.
     DATA TOTALBALANCE1 TYPE P DECIMALS 3.

     TOTALBALANCE = ( TOTALOPENING + TotReciept_Qty ) - ( TotReturn_Qty + TotNetwt + TotMAterialWiseWastage ) .

    IF TOTALBALANCE < 0 .
    TOTALBALANCE1  =  TOTALBALANCE * -1 .
    ELSE.
    TOTALBALANCE1  = TOTALBALANCE .
    ENDIF.


       DATA(lv_xml2) =
         |<Row2>| &&
         |<TotPurch>{ TotReciept_Qty }</TotPurch>| &&
         |<Tr_rec.Wttotal>{ TotReturn_Qty }</Tr_rec.Wttotal>| &&
         |<Tr_Isutotal>{ TotDispatc_QTY }</Tr_Isutotal>| &&
         |<Desp-Mtrstotal>{ TotNetwt }</Desp-Mtrstotal>| &&
         |<Wastagetotal>{ TotMAterialWiseWastage }</Wastagetotal>| &&
         |<Balancetotal>{ TOTALBALANCE1 }</Balancetotal>| &&
         |</Row2>| &&
         |</Table1>| &&
         |<DenimDivisio1>{ Register2 }</DenimDivisio1>| &&
         |<B24TOB41JHANJHARWADAINDUSTRIALAREA>{ Register3 }</B24TOB41JHANJHARWADAINDUSTRIALAREA>| &&
         |<JHANJHARWADANEEMUCH458441MADHAY>{  Register4 }</JHANJHARWADANEEMUCH458441MADHAY>| &&
         |</form1>| .


     CONCATENATE LV_xml XSML lv_xml2 INTO LV_XML.

   template = 'YARN_FACTORY_BEAM_REPORT_PRINT/YARN_FACTORY_BEAM_REPORT_PRINT'.

    CALL METHOD ycl_test_adobe=>getpdf(
       EXPORTING
         xmldata  = LV_XML
         template = template
       RECEIVING
         result   = result12 ).
   ENDMETHOD.
ENDCLASS.
