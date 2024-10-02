CLASS zsd_domestic_packinglist DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

    CLASS-DATA :BEGIN OF wa_add,
                  var1(80)  TYPE c,
                  var2(80)  TYPE c,
                  var3(80)  TYPE c,
                  var4(80)  TYPE c,
                  var5(80)  TYPE c,
                  var6(80)  TYPE c,
                  var7(80)  TYPE c,
                  var8(80)  TYPE c,
                  var9(80)  TYPE c,
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
        IMPORTING VALUE(variable)  TYPE string
                  VALUE(variable1) TYPE string
*                  VALUE(year) TYPE string


        RETURNING VALUE(result12)  TYPE string
        RAISING   cx_static_check .




  PROTECTED SECTION.
  PRIVATE SECTION.

    CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
    CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
    CONSTANTS  lv2_url    TYPE string VALUE 'https://btp-yvzjjpaz.authentication.eu10.hana.ondemand.com/oauth/token' .
    CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
    CONSTANTS lc_template_name TYPE string VALUE 'ZSD_DOMESTIC_PACKING_LIST/ZSD_DOMESTIC_PACKING_LIST'.

ENDCLASS.



CLASS ZSD_DOMESTIC_PACKINGLIST IMPLEMENTATION.


  METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).

  ENDMETHOD .


  METHOD if_oo_adt_classrun~main.



    DATA(xml)  = read_posts( variable = '0080000330' variable1 = '0080000330'  )   .


  ENDMETHOD.


  METHOD read_posts .


    DATA:lv  TYPE  c LENGTH 100   .
    DATA var1 TYPE zchar10.
    DATA var2 TYPE zchar10.
    var1 = variable.
    var1 =   |{ var1  ALPHA = IN }| .
    var2 = variable1.
    var2 =   |{ var2  ALPHA = IN }| .

    IF var1 IS NOT INITIAL AND var2 IS INITIAL .

      var2 = var1 .

    ENDIF.


*         select * from I_DeliveryDocument
*         where DeliveryDocument BETWEEN  @VAR1 AND @VAR2 INTO TABLE @DATA(IT_FORM) .

*        DELETE ADJACENT DUPLICATES FROM  IT_FORM COMPARING  DeliveryDocument .
    DATA   lv_xml TYPE string.

*  lv_xml  =
*         |<Form>| .

*  LOOP AT IT_FORM INTO DATA(WA_FORM) .




    SELECT a~*,
           b~*,
           @lv   AS lv,
           c~*
    FROM i_deliverydocumentitem AS a
    LEFT OUTER JOIN i_deliverydocument AS b ON ( b~deliverydocument = a~deliverydocument )
    LEFT OUTER JOIN zpack_hdr_def AS c ON  ( recbatch = a~batch )
    WHERE
       a~deliverydocument = @var1 INTO TABLE @DATA(it) .
    DATA(it_item) = it.
    DELETE it WHERE a-batch = ''.
    READ TABLE it INTO DATA(wa) INDEX 1.


    SELECT SINGLE b~taxnumber3,
    b~customer,
    b~telephonenumber1,
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
    LEFT JOIN zi_deliverydocumentaddress2 WITH PRIVILEGED ACCESS AS c ON ( c~addressid = a~addressid )
    LEFT JOIN i_regiontext AS d ON ( d~region = b~region AND d~language = 'E' AND d~country = b~country )
* left join I_Region as D on ( D~Region = a~ )
    WHERE salesdocument = @wa-a-referencesddocument AND partnerfunction = 'WE' INTO @DATA(shiptoparty).

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
   b~telephonenumber1,
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
   LEFT JOIN i_regiontext AS d ON ( d~region = b~region AND d~language = 'E' AND d~country = b~country )
* left join I_Region as D on ( D~Region = a~ )
   WHERE salesdocument = @wa-a-referencesddocument AND partnerfunction = 'RE' INTO @DATA(billtoparty).

    wa_add-var1 = billtoparty-organizationname1.
    wa_add-var2 = billtoparty-organizationname2.
    wa_add-var3 = billtoparty-organizationname3.

    DATA(billaddname) = zseparate_address=>separate( CHANGING var = wa_add ).

    wa_add-var1 = billtoparty-housenumber.
    wa_add-var2 = billtoparty-streetname.
    wa_add-var3 = billtoparty-streetprefixname1.
    wa_add-var4 = billtoparty-streetprefixname2.
    wa_add-var5 = billtoparty-streetsuffixname1.
    wa_add-var6 = billtoparty-streetsuffixname2.

    DATA(billaddhono) = zseparate_address=>separate( CHANGING var = wa_add ).

    wa_add-var1 = billtoparty-cityname.
* wa_add-var2 = shiptoparty-districtname.
    wa_add-var3 = billtoparty-postalcode.

    DATA(billaddcity) = zseparate_address=>separate( CHANGING var = wa_add ).

    SELECT SINGLE fullname
   FROM i_salesdocumentpartner
   WHERE salesdocument = @wa-a-referencesddocument AND partnerfunction = 'ZT' INTO @DATA(transporter).

    SELECT SINGLE * FROM i_salesdocumentitem WHERE salesdocument = @wa-a-referencesddocument
                                                  AND plant = @wa-a-plant INTO @DATA(sales).
    DATA unitofmas TYPE c LENGTH 4 .

    READ TABLE it_item INTO DATA(w) WITH KEY a-batch = ''.
    IF w-a-deliveryquantityunit = 'M' .
      unitofmas = 'MTR' .
    ELSEIF w-a-deliveryquantityunit = 'YD' .
      unitofmas = 'YARD' .
    ENDIF.


    lv_xml =
           |<Form>| &&
*            |<bdyMain>| &&
           |<Subform1>| &&
              |<Subform4>| &&
                 |<BilltoParty>| &&
                    |<AddressLineBill1>{ billaddname }</AddressLineBill1>| &&
                    |<AddressLineBill2>{ billaddhono }</AddressLineBill2>| &&
                    |<AddressLineBill3>{ billaddcity }</AddressLineBill3>| &&
                    |<AddressLineBill4>{ billtoparty-districtname }</AddressLineBill4>| &&
                    |<AddressLineBill5></AddressLineBill5>| &&
                    |<AddressLineBill6>{ billtoparty-regionname }</AddressLineBill6>| &&
                 |</BilltoParty>| &&
                 |<ShipToParty>| &&
                    |<AddressLine1ship>{ shipaddname }</AddressLine1ship>| &&
                    |<AddressLine2ship>{ shipaddhono }</AddressLine2ship>| &&
                    |<AddressLine3ship>{ shipaddcity }</AddressLine3ship>| &&
                    |<AddressLine5ship>{ shiptoparty-districtname }</AddressLine5ship>| &&
                    |<AddressLine6ship></AddressLine6ship>| &&
                    |<AddressLine7ship>{ shiptoparty-regionname }</AddressLine7ship>| &&
                    |<AddressLine8ship></AddressLine8ship>| &&
                 |</ShipToParty>| &&
              |</Subform4>| &&
              |<TextSub>| &&
              |<Subform7>| &&
              |<terms>{ wa-b-incotermsclassification }</terms>| &&
              |<destination>{ shipaddcity }</destination>| &&
              |<sddocument>{ wa-a-referencesddocument }</sddocument>| &&
              |<TransporterName>{ transporter }</TransporterName>| &&
              |</Subform7>| &&
              |</TextSub>| &&
              |</Subform1>| &&
              |<HIDDD>| &&
              |<DeliveryDocument>{ wa-a-deliverydocument }</DeliveryDocument>| &&
              |<Plant1>{ wa-a-plant }</Plant1>| &&
              |<GoodsMovementDate>{ wa-b-actualgoodsmovementdate }</GoodsMovementDate>| &&
              |</HIDDD>| &&
              |<Table2>| &&
              |<HeaderRow>| &&
              |<UnitOfmtrs>{ unitofmas }</UnitOfmtrs>| &&
              |</HeaderRow>| .

    DATA matdes TYPE string .
    DATA menge1 TYPE menge_d .
    DATA netwt TYPE menge_d .
    DATA gwt TYPE menge_d .
    DATA cnt(3) TYPE c.
    DATA pc(3) TYPE c.

    DATA(it1) = it[].
    DATA(it_fin) = it[].
    FREE:it_fin[].
    LOOP AT it1 ASSIGNING FIELD-SYMBOL(<fs>).
      IF <fs>-a-materialbycustomer IS NOT INITIAL .
        <fs>-a-materialbycustomer = <fs>-a-materialbycustomer .
      ELSE.
        <fs>-a-materialbycustomer =    <fs>-a-deliverydocumentitemtext.
      ENDIF.

      <fs>-lv = | { <fs>-a-materialbycustomer } | & | {  <fs>-c-packgrade } |.
      CONDENSE <fs>-lv NO-GAPS.
    ENDLOOP.
    DATA(it2) = it1[].
    SORT it2 ASCENDING BY lv.
    SORT it1 ASCENDING BY lv.
    DELETE ADJACENT DUPLICATES FROM it1 COMPARING lv.
    DATA:va TYPE c LENGTH 100.
    LOOP AT it1 ASSIGNING FIELD-SYMBOL(<ft>).
      LOOP AT it2 INTO DATA(wt) WHERE lv = <ft>-lv.
        menge1 = menge1 + wt-a-originaldeliveryquantity.
        netwt = netwt +  wt-c-netweight.
        gwt =   gwt +  wt-c-grossweight.
        cnt = cnt + 1.
        IF wt-c-nooftp = '1`' .
          pc = pc + 1.
        ELSE.
          pc = pc + wt-c-nooftp.
        ENDIF.
        APPEND wt TO it_fin.
      ENDLOOP.
      CLEAR:wt.


      wt-a-materialbycustomer = 'SUBTOTAL'.
      wt-a-originaldeliveryquantity = menge1.
      wt-c-netweight = netwt.
      wt-c-grossweight  = gwt.
*  WT-a-Batch = cNT.
      wt-c-nooftp = pc.
      wt-c-finishwidth = ''.
      APPEND wt TO it_fin.


      CLEAR:menge1,netwt,gwt, pc,cnt.
    ENDLOOP.
    FREE it[].
    it[] = it_fin[].

    DATA mtrtot TYPE menge_d .
    DATA ntwttot TYPE menge_d .
    DATA gwttot TYPE menge_d .
    DATA pcstot(3) TYPE  c.
    DATA sno TYPE  c LENGTH 3.
    DATA sno1 TYPE c LENGTH 3.

    LOOP AT it INTO DATA(wa_ga) .

      IF wa_ga-a-materialbycustomer NE 'SUBTOTAL'   .
        sno = sno + 1.

      ENDIF.
      IF wa_ga-a-materialbycustomer = 'SUBTOTAL'.
        sno1 = ''.
        mtrtot =  mtrtot + wa_ga-a-originaldeliveryquantity .
        ntwttot  = ntwttot + wa_ga-c-netweight .
        gwttot = gwttot  + wa_ga-c-grossweight.
        IF wa_ga-c-nooftp = '1`' .
          pcstot = pcstot  +  1 .
        ELSEIF wa_ga-c-nooftp = '*8'  .
          pcstot = pcstot  +  8 .
        ELSE.
          pcstot = pcstot  +  wa_ga-c-nooftp  .
        ENDIF.
      ELSEIF  wa_ga-a-materialbycustomer NE 'SUBTOTAL'.
        sno1 = sno .

        SELECT SINGLE dyeingshade FROM zpp_sortmaster  WHERE material = @wa_ga-a-material INTO @DATA(shadeno).

      ENDIF.

      IF wa_ga-a-materialbycustomer IS NOT INITIAL .
        matdes = wa_ga-a-materialbycustomer .
      ELSE.
        matdes =    wa_ga-a-deliverydocumentitemtext.
      ENDIF.




      lv_xml = lv_xml &&

       |<RowData>| &&
       |<SNO>{ sno1 }</SNO>| &&
       |<description>{ matdes }</description>| &&
       |<batch>{ wa_ga-a-batch }</batch>| &&
       |<width>{ wa_ga-c-finishwidth }</width>| &&
       |<mtr>{ wa_ga-a-originaldeliveryquantity }</mtr>| &&
       |<netwt>{ wa_ga-c-netweight }</netwt>| &&
       |<grosswt>{ wa_ga-c-grossweight }</grosswt>| &&
       |<pcs>{ wa_ga-c-nooftp }</pcs>| &&
       |<Grade>{ wa_ga-c-packgrade }</Grade>| &&
       |<shade>{ shadeno }</shade>| &&
       |<reamrk>{ wa_ga-c-tpremk }</reamrk>| &&
       |</RowData>| .
      CLEAR: shadeno .
    ENDLOOP.

    lv_xml = lv_xml &&
    |<RowData1>| &&
    |<MTRTOT>{ mtrtot }</MTRTOT>| &&
    |<NTWTTOT>{ ntwttot }</NTWTTOT>| &&
    |<GWTTOT>{ gwttot }</GWTTOT>| &&
*            |<PCSTOT>{ PCSTOT }</PCSTOT>| &&
    |<PCSTOT>{ sno }</PCSTOT>| &&
    |</RowData1>| &&
    |</Table2>| &&
*            |</bdyMain>| &&
    |</Form>| .


    REPLACE ALL OCCURRENCES OF '&' IN lv_xml WITH 'and'.

    CALL METHOD ycl_test_adobe=>getpdf(
      EXPORTING
        xmldata  = lv_xml
        template = lc_template_name
      RECEIVING
        result   = result12 ).

  ENDMETHOD.
ENDCLASS.
