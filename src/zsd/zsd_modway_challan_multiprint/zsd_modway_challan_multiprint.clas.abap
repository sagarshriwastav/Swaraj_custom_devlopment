CLASS zsd_modway_challan_multiprint DEFINITION
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
                  delverynoTo   TYPE string
                  pick            TYPE string

        RETURNING VALUE(result12) TYPE string
        RAISING   cx_static_check .

  PROTECTED SECTION.
  PRIVATE SECTION.


    CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
    CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
    CONSTANTS  lv2_url    TYPE string VALUE 'https://btp-yvzjjpaz.authentication.eu10.hana.ondemand.com/oauth/token'  .
    CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
*    CONSTANTS lc_template_name TYPE string VALUE 'SD_JOB_CHALLAN/SD_JOB_CHALLAN'.
    CONSTANTS lc_template_name TYPE string VALUE 'SD_JOB_CHALLAN_MODWAY/SD_JOB_CHALLAN_MODWAY'.

ENDCLASS.



CLASS ZSD_MODWAY_CHALLAN_MULTIPRINT IMPLEMENTATION.


  METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).

  ENDMETHOD .


  METHOD if_oo_adt_classrun~main.



*    DATA(xml)  = read_posts( variable = '0090000017'  )   .


  ENDMETHOD.


  METHOD read_posts .

    if pick is INITIAL .
    template = 'SD_JOB_CHALLAN_MODWAY_MULTIPLE/SD_JOB_CHALLAN_MODWAY_MULTIPLE' .
    ELSE .
    template = 'SD_JOB_CHALLAN_MODWAY_MULTIPLE/SD_JOB_CHALLAN_MODWAY_MULTIPLE'  .
    ENDIF.



    DATA:grosswt1  TYPE  p DECIMALS 3  .
    DATA:avgwt1  TYPE  p DECIMALS  3 .
    DATA pccount  TYPE i .
    DATA var1 TYPE zchar10.
    DATA var2 TYPE zchar10.
    DATA picno1(3)   TYPE c .
   DATA:LV  TYPE  C LENGTH 500   .

    var1 = delverynofrom.
    var2 = delverynoTo.
    var1 =   |{ |{ var1 ALPHA = OUT }| ALPHA = IN }| .
    var2 =   |{ |{ var2 ALPHA = OUT }| ALPHA = IN }| .
*        delveryno = VAR1.

    SELECT  a~* , b~* ,
           @grosswt1   AS grosswt1 ,
           @avgwt1  AS avgwt1,
           @pccount AS  pccount,
           @picno1 AS  picno1,
           C~*,
           @LV   AS LV
                 FROM i_deliverydocumentitem AS a
          LEFT OUTER  JOIN  zjob_grey_netwt_dispatch_cds AS b ON ( b~recbatch  = a~batch AND b~material = a~material
                                                          AND b~plant = a~plant )
          LEFT OUTER JOIN i_salesdocumentitem as c ON ( c~SalesDocument = A~ReferenceSDDocument
                                                      AND c~SalesDocumentItem = a~ReferenceSDDocumentItem
                                                    )
          WHERE a~deliverydocument GE @var1 AND a~deliverydocument LE @var2 AND a~plant = @plant
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
    DATA netwt TYPE p DECIMALS 3 .
    DATA gwt TYPE menge_d .
    DATA mtr TYPE p DECIMALS 2 .
    DATA picno(3)   TYPE c .
    DATA picno2(3)   TYPE c .
    picno = '1'.

    DATA(it1) = it[].
    DATA(it_fin) = it[].
    FREE:it_fin[].

 LOOP AT IT1 ASSIGNING FIELD-SYMBOL(<fs>).

        <FS>-LV = | { <fs>-A-MaterialByCustomer } | & | { <FS>-A-BatchBySupplier } | & | { <FS>-a-deliverydocumentitemtext } |.
        CONDENSE <FS>-LV NO-GAPS.
 ENDLOOP.

    DATA(it2) = it1[].
    SORT it2 ASCENDING BY a-deliverydocumentitemtext.
    SORT it1 ASCENDING BY a-deliverydocumentitemtext.

    DELETE ADJACENT DUPLICATES FROM it1 COMPARING a-deliverydocumentitemtext A-BatchBySupplier a-deliverydocumentitemtext.
    DATA:va TYPE c LENGTH 100.
    LOOP AT it1 ASSIGNING FIELD-SYMBOL(<ft>).

      LOOP AT it2 INTO DATA(wt2) WHERE LV = <ft>-LV.
        netwt =   netwt +  wt2-b-netwt.
        gwt   =   gwt +    wt2-b-netwt + '16.5' .

        IF wt2-a-actualdeliveryquantity <> 0.
        cnt   =   cnt +  ( wt2-b-netwt / wt2-a-actualdeliveryquantity ).
        mtr   =   mtr + wt2-a-actualdeliveryquantity .
        wt2-avgwt1    =  wt2-b-netwt / wt2-a-actualdeliveryquantity .
        ENDIF.

        wt2-grosswt1  = wt2-b-netwt + '16.5' .
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
*      wt2-avgwt1 = cnt .
      wt2-picno1 = picno2.
      wt2-a-actualdeliveryquantity = mtr .

      APPEND wt2 TO it_fin.


      CLEAR:menge1,netwt,gwt,cnt,mtr,wt2-grosswt1,wt2-avgwt1,wt2-picno1,picno2.
    ENDLOOP.
    FREE it[].
    it[] = it_fin[].

    DATA mtrtot  TYPE p DECIMALS 2 .
    DATA ntwttot TYPE p DECIMALS 3 .
    DATA gwttot  TYPE menge_d .
    DATA pcstot  TYPE  i.
    DATA sno1    TYPE c LENGTH 3.
    DATA sno     TYPE c LENGTH 3.

    """""""""""""""""""""""""""""""""""""""""""""""""""Plant Wise Address, GST & PAN"""""""""""""""""""""""""""""""""""

    IF plant  = '2100'.
      DATA(gst1) = '08AABCM5293P1ZT'.
      DATA(pan1)  = 'AABCM5293P'.
      DATA(register1) = 'MODWAY SUITING PVT. LTD.'.
      DATA(register2) = 'Weaving Division-I, 20th Km Stone, Chittorgarh Road' .
      DATA(register3) = 'Takhatpura, Bhilwara-311025, Rajasthan, India'.
      DATA(cin1) = 'U18108RJ1986PTC003788'.
    ELSEIF plant = '2200'.
      gst1  = '23AABCM5293P1Z1'.
      pan1  = 'AABCM5293P'.
      register1 = 'MODWAY SUITING PVT. LTD.'.
      register2 = 'Weaving Division-II, B-24 To B-41 Jhanjharwada Industrial Area' .
      register3 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
      cin1 = 'U18108RJ1986PTC003788'.
    ENDIF.
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
   FROM I_SalesDocumentItemPartner AS a
   LEFT JOIN i_supplier AS b ON ( b~supplier = a~supplier )
   LEFT JOIN i_address_2 WITH PRIVILEGED ACCESS AS c ON ( c~addressid = b~addressid )
   LEFT JOIN i_regiontext AS d ON ( d~region = b~region AND d~language = 'E' AND d~country = 'IN ')
* left join I_Region as D on ( D~Region = a~ )
   WHERE salesdocument = @wt-a-referencesddocument AND a~SalesDocumentItem = @wt-a-ReferenceSDDocumentItem AND partnerfunction = 'ZP'  INTO @DATA(shiptoparty).

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
|<Accountsof>{ sales }</Accountsof>| &&
|<exceedduration></exceedduration>| &&
|<Subform2>| &&
|<gstin></gstin>| &&
|<identificationmark></identificationmark>| &&
|<Process>{ shipaddname }</Process>| &&
|<ProcessAdd1>{ shipaddhono }</ProcessAdd1>| &&
|<ProcessAdd2>{ shipaddcity }</ProcessAdd2>| &&
|<ProcessGSTIN>{ shiptoparty-taxnumber3 }</ProcessGSTIN>| &&
|<vino></vino>| &&
|<Challanno>{ wt-a-deliverydocument }</Challanno>| &&
|<Date>{ shipto-b-ActualGoodsMovementDate+6(2) }/{ shipto-b-ActualGoodsMovementDate+4(2) }/{ shipto-b-ActualGoodsMovementDate+0(4) }</Date>| &&
|</Subform2>| .





*LOOPING DATA
************************************
 DATA mtr2 TYPE p DECIMALS 2 .
  DATA Ntwt2 TYPE p DECIMALS 3 .

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

 DATA PICKRATEA(3) TYPE C .
   IF  iv-a-deliverydocumentitemtext NE 'SUBTOTAL'   .

      SELECT SINGLE consumptiontaxctrlcode FROM  i_productplantbasic  WHERE product = @iv-a-material AND plant = @iv-a-plant   INTO  @DATA(hsn) .
      SELECT SINGLE * FROM zpackhdr_ddm WHERE batch = @iv-a-batch AND plant = @iv-a-plant INTO @DATA(shd).
      SELECT SINGLE pick FROM zpp_grey_grn_tab WHERE recbatch =  @IV-A-Batch AND material = @IV-A-Material INTO @DATA(PICKRATE).
ENDIF .
        IF PICKRATE = '0' .
        PICKRATEA = '' .
        ELSE.
        PICKRATEA = PICKRATE .
        ENDIF.

  mtr2   = iv-a-actualdeliveryquantity .
  Ntwt2   =   iv-b-netwt .

      DATA(lv_xml2) =

      |<Row1>| &&
      |<sno>{ sno1 }</sno>| &&
      |<Materialdis>{ iv-a-deliverydocumentitemtext }</Materialdis>| &&
      |<Selvedge>{ IV-C-MaterialByCustomer }</Selvedge>| &&
      |<HSNno>{ hsn }</HSNno>| &&
      |<POno>{ IV-B-setno }</POno>| &&
      |<Pick>{ PICKRATEA }</Pick>| &&
      |<Shade>{ IV-A-BatchBySupplier }</Shade>| &&
      |<Rollno1>{ IV-A-Batch }</Rollno1>| &&
      |<Mtrs>{ mtr2 }</Mtrs>| &&
      |<NetWt>{ Ntwt2   }</NetWt>| &&
      |<AvWt>{ iv-avgwt1 }</AvWt>| &&
      |<Grroswt>{ iv-grosswt1 }</Grroswt>| &&
      |</Row1>| .

      CONCATENATE xsml lv_xml2 INTO  xsml .
        CLEAR  : iv,lv_xml2,rat,iv,count,hsn,PICKRATE,PICKRATEA,mtr2,Ntwt2.

    ENDLOOP .

*LOOPING DATA END
************************************


    DATA bci TYPE string.
   DATA Awttot2  TYPE menge_d .
   Awttot2 = ntwttot / mtrtot .

    DATA(lv_xml3) =


    |<itemtext></itemtext>| &&
    |<Table3>| &&
    |<Row2>| &&
    |<TOT_RollPicNo>{ pccount }</TOT_RollPicNo>| &&
    |<TOT_Mtrs>{ mtrtot }</TOT_Mtrs>| &&
    |<TOT_NetWt>{ ntwttot }</TOT_NetWt>| &&
    |<TOT_GROSSWT>{ pcstot }</TOT_GROSSWT>| &&
    |<TOT_AvWt>{ Awttot2 }</TOT_AvWt>| &&
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


  CALL METHOD ycl_test_adobe=>getpdf(
       EXPORTING
         xmldata  = LV_XML
         template = lc_template_name
       RECEIVING
         result   = result12 ).


  ENDMETHOD.
ENDCLASS.
