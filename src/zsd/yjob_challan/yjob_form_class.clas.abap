CLASS yjob_form_class DEFINITION
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
        IMPORTING

                  plant           TYPE string
                  delverynofrom   TYPE string
                  delverynoto     TYPE string
                  lrnumber        TYPE string

        RETURNING VALUE(result12) TYPE string
        RAISING   cx_static_check .

  PROTECTED SECTION.
  PRIVATE SECTION.


    CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
    CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
    CONSTANTS  lv2_url    TYPE string VALUE 'https://btp-yvzjjpaz.authentication.eu10.hana.ondemand.com/oauth/token'  .
    CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
*    CONSTANTS lc_template_name TYPE string VALUE 'SD_JOB_CHALLAN/SD_JOB_CHALLAN'.
    CONSTANTS lc_template_name TYPE string VALUE 'SD_JOB_CHALLAN_NEW/SD_JOB_CHALLAN_NEW'.

ENDCLASS.



CLASS YJOB_FORM_CLASS IMPLEMENTATION.


  METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).

  ENDMETHOD .


  METHOD if_oo_adt_classrun~main.



*    DATA(xml)  = read_posts( variable = '0090000017'  )   .


  ENDMETHOD.


  METHOD read_posts .

    DATA:grosswt1  TYPE  p DECIMALS 3  .
    DATA:avgwt1  TYPE  p DECIMALS  3 .
    DATA pccount  TYPE i .
    DATA var1 TYPE zchar10.
    DATA picno1(3)   TYPE c .
    DATA:LV  TYPE  C LENGTH 500   .

    DATA WA_job_challan_tab TYPE yjob_challan_tab.

    var1 = delverynofrom.
    var1 =   |{ |{ var1 ALPHA = OUT }| ALPHA = IN }| .
*        delveryno = VAR1.

  IF lrnumber is INITIAL OR lrnumber = '' .
  SELECT SINGLE vehicleno FROM Yjob_challan_tab WHERE delivery = @var1 INTO @DATA(vehicleno) .
  ELSE.
  vehicleno = lrnumber  .
  ENDIF.

    SELECT  a~* , b~* ,
           @grosswt1   AS grosswt1 ,
           @avgwt1  AS avgwt1,
           @pccount AS  pccount,
           @picno1 AS  picno1 ,
           @LV   AS LV
                 FROM i_deliverydocumentitem AS a
          LEFT OUTER  JOIN  zjob_grey_netwt_dispatch_cds AS b ON ( b~recbatch  = a~batch AND b~material = a~material
              AND b~plant = a~plant )
          WHERE  a~deliverydocument = @var1 AND a~plant = @plant
                  INTO TABLE @DATA(it) .

    DELETE it WHERE a-batch = ''.
    READ TABLE it INTO  DATA(wt) INDEX 1 .

    SELECT SINGLE YY1_AccountOf4_SDI FROM i_salesdocumentitem WHERE salesdocument = @wt-a-referencesddocument
       AND plant = @wt-a-plant AND Material = @wt-a-Material AND YY1_AccountOf4_SDI <> '' INTO @DATA(sales).

    SELECT SINGLE * FROM  i_customer AS a  INNER JOIN i_deliverydocument AS b ON ( a~customer = b~shiptoparty )
    WHERE deliverydocument = @var1  INTO @DATA(shipto)  .
    SELECT SINGLE * FROM i_address_2 WITH PRIVILEGED ACCESS WHERE addressid = @shipto-a-addressid INTO @DATA(shiptoadd).
    SELECT SINGLE regionname FROM i_regiontext WHERE region = @shiptoadd-region AND language ='E' AND country = 'IN' INTO @DATA(state).




    DATA rat TYPE p DECIMALS 2 .
    DATA avgwt TYPE p DECIMALS 3 .
    DATA grosswt TYPE p DECIMALS 3 .
    DATA xsml TYPE string .
    DATA count TYPE int8 .
    DATA matdes TYPE string .
    DATA menge1 TYPE menge_d .
    DATA cnt TYPE menge_d .
    DATA netwt TYPE menge_d .
    DATA gwt TYPE menge_d .
    DATA mtr TYPE menge_d .
    DATA picno(3)   TYPE c .
    DATA picno2(3)   TYPE c .
    picno = '1'.

    DATA(it1) = it[].
    DATA(it_fin) = it[].
    FREE:it_fin[].

   LOOP AT IT1 ASSIGNING FIELD-SYMBOL(<fs>).

        <FS>-LV = | { <fs>-a-deliverydocumentitemtext } | & | { <FS>-B-pick } | .
        CONDENSE <FS>-LV NO-GAPS.
 ENDLOOP.

    DATA(it2) = it1[].
    SORT it2 ASCENDING BY a-deliverydocumentitemtext b-pick.
    SORT it1 ASCENDING BY a-deliverydocumentitemtext b-pick.

    DELETE ADJACENT DUPLICATES FROM it1 COMPARING LV.
    DATA:va TYPE c LENGTH 100.
    LOOP AT it1 ASSIGNING FIELD-SYMBOL(<ft>).

      LOOP AT it2 INTO DATA(wt2) WHERE LV = <ft>-LV.
        netwt =   netwt +  wt2-b-netwt.
        gwt   =   gwt +    wt2-b-grosswt .
        cnt   =   cnt +  ( wt2-b-netwt / wt2-a-actualdeliveryquantity ).
        mtr   =   mtr + wt2-a-actualdeliveryquantity .
        wt2-grosswt1  = wt2-b-grosswt .
        wt2-avgwt1    =  wt2-b-netwt / wt2-a-actualdeliveryquantity .
        wt2-picno1    =  picno  .
        picno2 = picno2 + picno.
        pccount = pccount + 1.
         .
        APPEND wt2 TO it_fin.
      ENDLOOP.
      CLEAR:wt2.


      wt2-a-deliverydocumentitemtext = 'SUBTOTAL'.
      wt2-b-netwt = netwt.
      wt2-grosswt1  = gwt.

      if netwt <> 0 .
      wt2-avgwt1 = netwt / mtr.
      ENDIF.

      wt2-picno1 = picno2.
      wt2-a-actualdeliveryquantity = mtr .

      APPEND wt2 TO it_fin.


      CLEAR:menge1,netwt,gwt,cnt,mtr,wt2-grosswt1,wt2-avgwt1,wt2-picno1,picno2.
    ENDLOOP.
    FREE it[].
    it[] = it_fin[].

    DATA mtrtot  TYPE menge_d .
    DATA ntwttot TYPE menge_d .
    DATA gwttot  TYPE menge_d .
    DATA pcstot  TYPE  i.
    DATA sno1    TYPE c LENGTH 3.
    DATA sno     TYPE c LENGTH 3.

    """""""""""""""""""""""""""""""""""""""""""""""""""Plant Wise Address, GST & PAN"""""""""""""""""""""""""""""""""""
    IF plant = '1100'.
      DATA(gst1)  = '23AAHCS2781A1ZP'.
      DATA(pan1)  = 'AAHCS2781A'.
      DATA(register1) = 'SWARAJ SUITING LIMITED'.
      DATA(register2) = 'Spinning Division-I, B-24 To B-41 Jhanjharwada Industrial Area' .
      DATA(register3) = ' Jhanjharwada, Neemuch - 458441, Madhya Pradesh, India'.
      DATA(cin1) = 'L18101RJ2003PLC018359'.
    ELSEIF plant = '1200'.
      gst1  = '23AAHCS2781A1ZP'.
      pan1  = 'AAHCS2781A'.
      register1 = 'SWARAJ SUITING LIMITED'.
      register2 = 'Denim Division-I, B-24 To B-41 Jhanjharwada Industrial Area' .
      register3 = 'Jhanjharwada, Neemuch - 458441, Madhya Pradesh, India'.
      cin1 = 'L18101RJ2003PLC018359'.
    ELSEIF plant = '1300'.
      gst1  = '08AAHCS2781A1ZH'.
      pan1  = 'AAHCS2781A'.
      register1 = 'SWARAJ SUITING LIMITED'.
      register2 = 'Weaving Division-I, F-483 To F-487 RIICO Growth Centre' .
      register3 = 'Hamirgarh, Bhilwara-311025, Rajasthan, India'.
      cin1 = 'L18101RJ2003PLC018359'.
    ELSEIF plant  = '1310'.
      gst1  = '23AAHCS2781A1ZP'.
      pan1  = 'AAHCS2781A'.
      register1 = 'SWARAJ SUITING LIMITED'.
      register2 = 'Weaving Division-II, B-24 To B-41 Jhanjharwada Industrial Area' .
      register3 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
      cin1 = 'L18101RJ2003PLC018359'.
    ELSEIF plant  = '1400'.
      gst1  = '23AAHCS2781A1ZP'.
      pan1  = 'AAHCS2781A'.
      register1 = 'SWARAJ SUITING LIMITED'.
      register2 = 'Process House-I, B-24 To B-41 Jhanjharwada Industrial Area' .
      register3 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
      cin1 = 'L18101RJ2003PLC018359'.
    ELSEIF plant  = '2100'.
      gst1  = '08AABCM5293P1ZT'.
      pan1  = 'AABCM5293P'.
      register1 = 'MODWAY SUITING PVT. LIMITED'.
      register2 = 'Weaving Division-I, 20th Km Stone, Chittorgarh Road' .
      register3 = 'Takhatpura, Bhilwara-311025, Rajasthan, India'.
      cin1 = 'U18108RJ1986PTC003788'.
    ELSEIF plant = '2200'.
      gst1  = '23AABCM5293P1Z1'.
      pan1  = 'AABCM5293P'.
      register1 = 'MODWAY SUITING PVT. LIMITED'.
      register2 = 'Weaving Division-II, B-24 To B-41 Jhanjharwada Industrial Area' .
      register3 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
      cin1 = 'U18108RJ1986PTC003788'.
    ENDIF.
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    DATA n TYPE i.
    LOOP AT it INTO DATA(it_vi) .

      n = n + 1.

    ENDLOOP.

    SELECT SINGLE b~taxnumber3,
   b~supplier,
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
   LEFT JOIN i_supplier AS b ON ( b~supplier = a~supplier )
   LEFT JOIN i_address_2 WITH PRIVILEGED ACCESS AS c ON ( c~addressid = b~addressid )
   LEFT JOIN i_regiontext AS d ON ( d~region = b~region AND d~language = 'E' AND d~country = 'IN ')
* left join I_Region as D on ( D~Region = a~ )
   WHERE salesdocument = @wt-a-referencesddocument  AND partnerfunction = 'ZP' INTO @DATA(shiptoparty).

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



    DATA(lv_xml) =
|<form1>| &&
|<Subform1>| &&
|<head>| &&
|<CIN>{ cin1 }</CIN>| &&
|<GST>{ gst1 }</GST>| &&
|<PAN>{ pan1 }</PAN>| &&
|</head>| &&
|<adress3></adress3>| &&
|<address2>{ register3 }</address2>| &&
|<address1>{ register2 }</address1>| &&
|<Platname>{ register1 }</Platname>| &&
|</Subform1>| &&
|<Reservation></Reservation>| &&
|<Range></Range>| &&
|<Division></Division>| &&
|<nameofsupplier>{ shiptoadd-organizationname1 }</nameofsupplier>| &&
|<supplieradd1>{ shiptoadd-cityname } { shiptoadd-postalcode }</supplieradd1>| &&
|<supplieradd2>{ state } ({ shiptoadd-country })</supplieradd2>| &&
|<SupplierGSTIN>{ shipto-a-taxnumber3 } </SupplierGSTIN>| &&
|<Meters></Meters>| &&
|<Peices>{ pccount }</Peices>| &&
|<FdPd></FdPd>| &&
|<AccountOf>{ sales }</AccountOf>| &&
|<exceedduration></exceedduration>| &&
|<Subform2>| &&
|<gstin></gstin>| &&
|<identificationmark></identificationmark>| &&
|<Process>{ shipaddname }</Process>| &&
|<ProcessAdd1>{ shipaddhono }</ProcessAdd1>| &&
|<ProcessAdd2>{ shipaddcity }</ProcessAdd2>| &&
|<ProcessGSTIN>{ shiptoparty-taxnumber3 }</ProcessGSTIN>| &&
|<vino>{ vehicleno }</vino>| &&
|<Challanno>{ wt-a-deliverydocument }</Challanno>| &&
|<Date>{ shipto-b-ActualGoodsMovementDate+6(2) }/{ shipto-b-ActualGoodsMovementDate+4(2) }/{ shipto-b-ActualGoodsMovementDate+0(4) }</Date>| &&
|</Subform2>| .



*LOOPING DATA
************************************

    LOOP AT it INTO DATA(iv) .


      IF  iv-a-deliverydocumentitemtext NE 'SUBTOTAL'   .
        sno = sno + 1.

      ENDIF.
      IF  iv-a-deliverydocumentitemtext = 'SUBTOTAL'.
        sno1 = ' '.
        mtrtot   =  mtrtot  +  iv-a-actualdeliveryquantity .
        ntwttot  =  ntwttot +  iv-b-netwt  .
        gwttot   =  gwttot  +  iv-avgwt1.
        pcstot   =  pcstot  +  iv-grosswt1   .

      ELSEIF   iv-a-deliverydocumentitemtext NE 'SUBTOTAL'.
        sno1 = sno .
      ENDIF.




      SELECT SINGLE consumptiontaxctrlcode FROM  i_productplantbasic  WHERE product = @iv-a-material AND plant = @iv-a-plant   INTO  @DATA(hsn) .
      SELECT SINGLE * FROM zpackhdr_ddm WHERE batch = @iv-a-batch AND plant = @iv-a-plant INTO @DATA(shd).

      DATA:lt TYPE char10.
      DATA(lv2) = iv-a-batch+5(2).
      IF lv2 = 'E1' OR lv2 = 'E2' OR lv2 = 'E3' OR lv2 = 'E4' OR lv2 = 'E5' OR lv2 = 'E6' OR lv2 = 'E8' OR lv2 = 'E9' .
      DATA(lv1) = iv-a-batch+0(6).
*        CONCATENATE iv-a-batch '-' INTO lt.
        CONCATENATE lv1  iv-a-batch+6(2) INTO lt SEPARATED BY space.
      ELSE.
        lt = iv-a-batch.
      ENDIF.

      DATA(lv_xml2) =
      |<Table2>| &&
      |<Row1>| &&
      |<sno>{ sno1 }</sno>| &&
      |<Materialdis>{ iv-a-deliverydocumentitemtext }</Materialdis>| &&
      |<LoomNo>{ iv-b-loomno }</LoomNo>| &&
      |<HSNno>{ hsn }</HSNno>| &&
      |<SetCode>{ iv-b-setno }</SetCode>| &&
      |<POno>{ | { iv-a-referencesddocument ALPHA = OUT } | }</POno>| &&
      |<Rollno1>{ lt }</Rollno1>| &&
      |<Pick>{ IV-B-pick }</Pick>| &&
      |<PicNo>{ iv-picno1 } </PicNo>| &&
      |<Mtrs>{ iv-a-actualdeliveryquantity }</Mtrs>| &&
      |<NetWt>{ iv-b-netwt   }</NetWt>| &&
      |<AvWt>{ iv-avgwt1 }</AvWt>| &&
      |<Grroswt>{ iv-grosswt1 }</Grroswt>| &&
      |</Row1>| &&
      |</Table2>|.

      CONCATENATE xsml lv_xml2 INTO  xsml .
*        CLEAR  : iv,lv_xml2,rat,iv,count,package,orgqty,co.

    ENDLOOP .

*LOOPING DATA END
************************************


    DATA bci TYPE string.

    DATA(lv_xml3) =


    |<itemtext></itemtext>| &&
    |<Table3>| &&
    |<Row2>| &&
    |<TOT_RollPicNo>{ pccount }</TOT_RollPicNo>| &&
    |<TOT_Mtrs>{ mtrtot }</TOT_Mtrs>| &&
    |<TOT_NetWt>{ ntwttot }</TOT_NetWt>| &&
    |<TOT_GROSSWT>{ pcstot }</TOT_GROSSWT>| &&
    |<TOT_AvWt>{ gwttot }</TOT_AvWt>| &&
    |</Row2>| &&
    |</Table3>| &&
    |<Footer>| &&
    |<Signature/>| &&
    |</Footer>| &&
    |<FooterSF>| &&
    |<Footer>| &&
    |<Place></Place>| &&
    |</Footer>| &&
    |<footertext/>| &&
    |</FooterSF>| &&
    |<PreparedBy></PreparedBy>| &&
    |<AuthoSign>{ register1 }</AuthoSign>| &&
    |</form1>|.





    CONCATENATE lv_xml xsml lv_xml3 INTO lv_xml .

    REPLACE ALL OCCURRENCES OF '&' IN lv_xml WITH 'and'.

   WA_job_challan_tab-delivery = var1.
   WA_job_challan_tab-vehicleno = vehicleno.
   MODIFY Yjob_challan_tab FROM @WA_job_challan_tab .


  CALL METHOD ycl_test_adobe=>getpdf(
       EXPORTING
         xmldata  = LV_XML
         template = lc_template_name
       RECEIVING
         result   = result12 ).

  ENDMETHOD.
ENDCLASS.
