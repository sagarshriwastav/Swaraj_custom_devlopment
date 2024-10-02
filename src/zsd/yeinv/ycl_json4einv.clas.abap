CLASS ycl_json4einv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
    CLASS-METHODS :
      create_json
        IMPORTING VALUE(invoice) TYPE string
        RETURNING VALUE(status)  TYPE string .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS YCL_JSON4EINV IMPLEMENTATION.


  METHOD create_json .
   DATA: vbeln TYPE c LENGTH 10.

*    distan = distance .
*    IMPORT vbeln FROM MEMORY ID '#EINV'.
    DATA itemlist TYPE TABLE OF yei_itemlist_tt .
    DATA wa_itemlist1 TYPE yei_itemlist_tt .
    DATA : it_data2 TYPE STANDARD TABLE OF yinv_stu,
           wa_data2 TYPE  yinv_stu.
    DATA: it_json_data TYPE TABLE OF  yqwerty,
          wa_json_data TYPE yqwerty,
          trandtls     TYPE yei_trandtls_tt,
          docdtls      TYPE yei_docdtls_st,
          sellerdtls   TYPE yei_sellerdtls_tt,
          buyerdtls    TYPE yei_buyerdtls_tt,
          dispdtls     TYPE yei_dispdtls_t1,
          shipdtls     TYPE yei_shipdtls_tt,
          it_itemlist  TYPE TABLE OF yeiv_itemlist_tt,
          wa_itemlist  TYPE yei_itemlist_tt,
          bchdtls      TYPE yei_bchdtls_tt,
          attribdtls   TYPE yei_attribdtls_tt,
          valdtls      TYPE yei_valdtls_tt,
          paydtls      TYPE yei_paydtls_tt,
          refdtls      TYPE yei_refdtls_tt,
          docpre       TYPE yei_docperddt_st,
          precdocdtls  TYPE yei_precdocdtls_tt,
          contrdtls    TYPE yei_contrdtls_tt,
          addldocdtls  TYPE yei_addldocdtls_tt,
          expdtls      TYPE yei_expdtls_tt,
          ewbdtls      TYPE yei_ewbdtls_st.

    DATA : igstamt TYPE yinv_stu-igstamt.
    DATA : cgstamt TYPE yinv_stu-igstamt.
    DATA : sgstamt TYPE yinv_stu-igstamt.
    DATA : othamount  TYPE     yinv_stu-igstamt .
***************************************************************************
***************************************************************************

    DATA: vbeln1 TYPE c LENGTH 10.

    vbeln1  =    |{ invoice ALPHA = IN }|.

*SELECT SINGLE yy1_portofloading_bdh FROM I_BillingDocumentBASIC WHERE BillingDocument = @vbeln1 INTO @DATA(PORTDATA)  .
*DATA: port TYPE string.
*      IF PORTDATA = '01' .
*        port = 'PIPAVAV' .
*      ELSEIF  PORTDATA =  '02' .
*        port = 'NHAVA SHEVA,INDIA' .
*      ELSEIF PORTDATA =  '03' .
*        port = 'J.N.P.T MUMBAI' .
*      ELSEIF PORTDATA =  '04' .
*        port = 'MUNDRA' .
*      ELSEIF PORTDATA =  '05' .
*        port = 'PETRA POLE' .
*      ELSEIF PORTDATA =  '06' .
*        port =  'ANY PORT OF INDIA' .
*      ELSEIF PORTDATA =  '07' .
*        port = 'HAZIRA PORT' .
*      ELSEIF PORTDATA =  '08' .
*        port = 'MUMBAI AIRPORT' .
*      ELSEIF PORTDATA =  '09' .
*        port = 'ICD MANDIDEEP' .
*      ELSEIF PORTDATA =  '10' .
*        port = 'IGI, DELHI, INDIA' .
*      ELSEIF PORTDATA =  '11' .
*        port = 'NSICT, INDIA' .
*      ELSEIF PORTDATA =  '12' .
*        port = 'GTI, INDIA' .
*      ELSEIF PORTDATA =  '13' .
*        port = 'KOLKATA PORT INDIA' .
*      ELSEIF PORTDATA =  '14' .
*        port = 'BHILWARA/INDIA' .
*      ELSEIF PORTDATA =  '15' .
*        port = 'VISHAKHAPATNAM' .
*      ELSEIF PORTDATA =  '16' .
*        port = 'ATTARI BORDER' .
*      ELSEIF PORTDATA =  '17' .
*        port = 'JOGBANI NEPAL' .
*      ELSEIF PORTDATA =  '18' .
*        port = ' VIZAG PORT '  .
*      ENDIF .

***************************************************************************










    SELECT SINGLE *  FROM i_billingdocumentbasic  WHERE billingdocument = @vbeln1 INTO   @DATA(bill_head).
    SELECT *  FROM i_billingdocumentpartner  WHERE billingdocument = @vbeln1 INTO TABLE  @DATA(i_billingpart).



*Billing partener "BUYER'
    SELECT SINGLE * FROM   i_billingdocumentpartner AS a  INNER JOIN i_customer AS
                 b ON   ( a~customer = b~customer  ) WHERE a~billingdocument = @vbeln1
                  AND a~partnerfunction = 'RE' INTO  @DATA(buyeradd)   .

*Shipping Partner Details
    SELECT SINGLE * FROM   i_billingdocumentpartner AS a  INNER JOIN i_customer AS
                 b ON   ( a~customer = b~customer  ) WHERE a~billingdocument = @vbeln1
                  AND a~partnerfunction = 'WE' INTO   @DATA(shippingadd)   .

**Plant ADdress
*select single  * from  i_billingdocumentbasic as a inner join I_Plant
*                      as b on  ( a~PlantSupplier =  b~Plant )*
*where BillingDocument = @vbeln1  into @data(plantaddress)      .

SELECT SINGLE * FROM zsd_plant_address AS a INNER JOIN i_billingdocumentitembasic AS b ON ( a~plant =  b~plant )
    LEFT OUTER JOIN I_CompanyCode as c ON ( c~COMPANYCODE = b~SalesOrganization )
    WHERE billingdocument =  @vbeln1 INTO @DATA(plantaddress) .

**ITEM DETAILS
    SELECT * FROM i_billingdocumentitem   WHERE
    billingdocument  =  @vbeln1   AND batch IS INITIAL  INTO TABLE @DATA(billing_item) .

   READ TABLE BILLING_ITEM INTO DATA(WAP) INDEX 1.

    SELECT SINGLE * FROM zirn_credentials WHERE PLANT = @WAP-Plant INTO @DATA(credentials)  .


*Pricing data
    SELECT * FROM i_billingdocumentitemprcgelmnt AS a  INNER JOIN   i_billingdocumentitem AS b
    ON ( a~billingdocument = b~billingdocument  )  WHERE
    a~billingdocument  = @vbeln1   AND b~batch = ' ' INTO TABLE @DATA(b_item) .


*SHIFT VBELN1  LEFT DELETING LEADING '0'.


    IF bill_head-distributionchannel = '20' .


      IF buyeradd-b-country EQ 'IN' AND buyeradd-b-taxnumber3 IS  NOT INITIAL.

        wa_data2-taxsch     =  'GST'.
        wa_data2-version    =  '1.1'.
        wa_data2-irn        =  'GST'.
        wa_data2-suptyp     =  'SEZWP'.
        wa_data2-regrev     =  'N'.
        wa_data2-ecmgstin   =  ' '.

        wa_data2-b_state    =  buyeradd-b-region  .
        wa_data2-b_pos      =  buyeradd-b-region .
        wa_data2-b_pin      =  buyeradd-b-postalcode  .


      ELSEIF buyeradd-b-country NE 'IN' AND buyeradd-b-taxnumber3 IS   INITIAL.  .
        wa_data2-taxsch     =  'GST'.
        wa_data2-version    =  '1.1'.
        wa_data2-irn        =  'GST'.
        wa_data2-suptyp = 'EXPWP'.
        wa_data2-regrev     =  'N'.
        wa_data2-ecmgstin   =  ' '.
        "BUYER DETAILS
        wa_data2-b_pin = '999999'.
        wa_data2-b_pos = '96'.
        wa_data2-b_state = '96'.

      ENDIF .


    ELSE .

      wa_data2-taxsch     =  'GST'.
      wa_data2-version    =  '1.1'.
      wa_data2-irn        =  'GST'.
      wa_data2-suptyp     =  'B2B'.
      wa_data2-regrev     =  'N'.
      wa_data2-ecmgstin   =  ' '.
      "BUYER DETAILS
      wa_data2-b_state    =  buyeradd-b-region  .
      wa_data2-b_pos      =  buyeradd-b-region .
      wa_data2-b_pin      =  buyeradd-b-postalcode  .

    ENDIF .


    IF bill_head-sddocumentcategory EQ 'M'.
      wa_data2-i_typ = 'INV'.
    ELSEIF bill_head-sddocumentcategory = 'O'.
      wa_data2-i_typ = 'CRN'.
    ELSEIF bill_head-sddocumentcategory = 'P'.
      wa_data2-i_typ = 'DBN'.
    ENDIF.








    wa_data2-i_no       =  vbeln1 .   "'0090000002' .
    SHIFT wa_data2-i_no  LEFT DELETING LEADING '0'.
    wa_data2-i_dt       =  bill_head-billingdocumentdate."'20/09/2022' .

    wa_data2-totinvval  =  ' ' .

    "   supplier details I_supplier
    IF credentials IS INITIAL .
      wa_data2-s_gstin    =  '08AABCK0452C1Z3' .
      wa_data2-s_lglnm    =  'Kanchan India Limited' .
      wa_data2-s_trdnm    =  'Kanchan India Limited' .
      wa_data2-s_addr1    =  '19-20Bhiwara Textile MarketPur Road' .
      wa_data2-s_addr2    =  ' ' .
      wa_data2-s_loc      =  'Pur Road' .
      wa_data2-s_state    =  '08' .
      wa_data2-s_pin      =  '311001' .
      wa_data2-s_ph       =  ' '  .
      wa_data2-s_em       =  ' '  .
    ELSE .

      wa_data2-s_gstin    =  '23AAPCS1247M1Z1' .
      wa_data2-s_lglnm    =  'SAGAR MANUFACTURERS PRIVATE LIMITED' .
      wa_data2-s_trdnm    =  'SAGAR MANUFACTURERS PRIVATE LIMITED' .
      wa_data2-s_addr1    =  'The Sagar E2/4,ARERA COLONYOPP.HABIBGANJ ' .
      wa_data2-s_addr2    =  'RLY STATION  ' .
      wa_data2-s_loc      =  'HABIBGANJ' .
      wa_data2-s_state    =  '23' .
      wa_data2-s_pin      =  '462016' .
      wa_data2-s_ph       =  ' '  .
      wa_data2-s_em       =  ' '  .



    ENDIF .

     READ TABLE BILLING_ITEM into data(wa_bill) index 1.
  SELECT single * FROM ZSD_PLANT_ADDRESS as a inner join I_BILLINGDOCUMENTITEMBASIC as b on ( a~Plant =  b~Plant )
  LEFT OUTER JOIN I_CompanyCode as c ON ( c~COMPANYCODE = b~SalesOrganization )
                  where BillingDocument =  @vbeln1 AND a~plant = @wa_bill-Plant into @data(sellerplantaddress) .

   IF wa_bill-Plant  = '1200'.
    DATA(gst1)   = '23AAHCS2781A1ZP'.
    elseif wa_bill-Plant  = '1300'.
     gst1  = '08AAHCS2781A1ZH'.
    elseif wa_bill-Plant  = '2100'.
     gst1  = '08AABCM5293P1ZT'.
    ENDIF.

    wa_data2-s_gstin    =   gst1.
    wa_data2-s_lglnm    =  sellerplantaddress-c-CompanyCodeName.
    wa_data2-s_trdnm    =  sellerplantaddress-a-PlantName.
    wa_data2-s_addr1    =  sellerplantaddress-a-AddresseeFullName .
    wa_data2-s_addr2    =  ' ' .
    wa_data2-s_loc      =  sellerplantaddress-a-city .
    wa_data2-s_state    =  sellerplantaddress-a-regcode.
    wa_data2-s_pin      =  sellerplantaddress-a-post .
    wa_data2-s_ph       =  ' '  .
    wa_data2-s_em       =  ' '  .



    "Buyer details i_Customer details

    IF buyeradd-b-country EQ 'IN' .
      wa_data2-b_gstin    =  buyeradd-b-taxnumber3.
    ELSE .
      wa_data2-b_gstin    =  'URP'.
    ENDIF .

    wa_data2-b_lglnm    =  buyeradd-b-customername.      "'J.K.TE' .
    wa_data2-b_trdnm    =  buyeradd-b-customername .
    wa_data2-b_addr1    =  buyeradd-b-customerfullname .
    wa_data2-b_addr2    =  ' ' .
    wa_data2-b_loc      =  buyeradd-b-cityname .
*    wa_data2-b_state    =  buyeradd-b-Region  .
*    wa_data2-b_pos      =  buyeradd-b-Region .
*    wa_data2-b_pin      =  buyeradd-b-PostalCode  .
    wa_data2-b_ph       =  buyeradd-b-faxnumber .
    wa_data2-b_em       =  ' ' .

    "   Dispatch details company address

*    wa_data2-d_nm       =   'SAGAR MANUFACRORING INDUSTRIES ' .
*    wa_data2-d_addr1    =   'Tamot, Tehsil Goharganj, Obedulaganj to Jabalpur Road (NH 12)  ' .
*    wa_data2-d_addr2    =   'District Raisen - 464993, Madhya Pradesh 464990 ' .
*    wa_data2-d_loc      =  'RAISEN' .
*    wa_data2-d_stcd     =  '23' .
*    wa_data2-d_pin      =  '464990' .

    wa_data2-d_nm       =  plantaddress-c-CompanyCodeName. "'SAGAR MANUFACRORING INDUSTRIES ' .
    wa_data2-d_addr1    =  plantaddress-a-addresseefullname. "'Tamot, Tehsil Goharganj, Obedulaganj to Jabalpur Road (NH 12)  ' .
    wa_data2-d_addr2    =  plantaddress-a-streete. "'District Raisen - 464993, Madhya Pradesh 464990 ' .
    wa_data2-d_loc      =  plantaddress-a-city  . "'Tamot'. "'RAISEN' .
    wa_data2-d_stcd     =   plantaddress-a-regcode.        "" '23' .
    wa_data2-d_pin      =  plantaddress-a-post.             "'464990' .

    "  Shiping Details  "Ship to party address
    IF wa_data2-suptyp =  'SEZWP' .

      wa_data2-sh_gstin   =  'URP' .
*      wa_data2-sh_stcd    =   bill_head-yy1_portstatecode_bdh . "  Shippingadd-b-Region .
*      wa_data2-sh_pin     =   bill_head-yy1_portpincode_bdh .                     " Shippingadd-b-PostalCode .
       wa_data2-sh_loc     =  shippingadd-b-cityname .
    ELSEIF wa_data2-suptyp =  'EXPWP' .

      wa_data2-sh_gstin   =  'URP'  .
*      wa_data2-sh_stcd    =   bill_head-yy1_portstatecode_bdh .   "wa_data2-b_state  .
*      wa_data2-sh_pin     =     bill_head-yy1_portpincode_bdh .   " wa_data2-B_pin  .
*       wa_data2-sh_loc     =  PORT .

    ELSE .

      wa_data2-sh_gstin   =  shippingadd-b-taxnumber3 .
      wa_data2-sh_stcd    =  shippingadd-b-region .
      wa_data2-sh_pin     =  shippingadd-b-postalcode .
      wa_data2-sh_loc     =  shippingadd-b-cityname .

    ENDIF .



    wa_data2-sh_lglnm   =  shippingadd-b-customername .
    wa_data2-sh_trdnm   =  shippingadd-b-customerfullname .
    wa_data2-sh_addr1   =  shippingadd-b-customerfullname .
    wa_data2-sh_addr2   = ' '  .
*    wa_data2-sh_loc     =  shippingadd-b-cityname .


    "ItemList
    LOOP AT  billing_item INTO DATA(bill_item) .


      SELECT SINGLE conditionbaseamount FROM i_billingdocumentitemprcgelmnt WHERE billingdocument = @bill_item-billingdocument
                                          AND billingdocumentitem = @bill_item-billingdocumentitem AND
      conditionbaseamount IS NOT INITIAL AND  conditiontype IN ( 'JOIG' ,'JOCG' ,'JOSG' ) INTO @DATA(baseamount)  .


      wa_itemlist1-slno       =  bill_item-billingdocumentitem .
      wa_itemlist1-prddesc    =  bill_item-material .

      SELECT SINGLE consumptiontaxctrlcode FROM i_productplantbasic
       WHERE product = @bill_item-material AND plant = @bill_item-plant  INTO @DATA(hsnsac).

     IF ( Bill_item-planT = '1300' OR Bill_item-planT = '2100' ) AND Bill_item-Division = '13'.

    SELECT SINGLE * FROM y1ig_invrefnum WHERE  docno = @vbeln1  INTO  @DATA(HSNCHEACK) .

    IF HSNCHEACK-irn IS  INITIAL AND HSNCHEACK-irn_status <> 'ACT' .

    wa_itemlist1-isservc    =  'Y' .
    wa_itemlist1-hsncd      =  '998821' .
   ELSE.
   wa_itemlist1-isservc    =  'N' .
   wa_itemlist1-hsncd      =  hsnsac .
   ENDIF.

      ELSE .
        wa_itemlist1-isservc    =  'N' .
       wa_itemlist1-hsncd      =  hsnsac .
      ENDIF.

      wa_itemlist1-barcde     =  ' ' .
      wa_itemlist1-qty        =  bill_item-billingquantity .

         IF bill_item-billingquantityunit = 'KG' .
        wa_itemlist1-unit       =  'KGS' .
      ELSEIF bill_item-billingquantityunit = 'M' .
        wa_itemlist1-unit       =  'MTR' .
      ELSEIF bill_item-billingquantityunit = 'ST' .
        wa_itemlist1-unit       =  'ST' .
      ELSEIF bill_item-billingquantityunit = 'PC' .
        wa_itemlist1-unit       =  'PC' .
      ELSEIF bill_item-billingquantityunit = 'PCS' .
        wa_itemlist1-unit       =  'PCS' .
      ELSEIF bill_item-billingquantityunit+0(3) = 'BAG' .
        wa_itemlist1-unit       =  'BAG'.
      ELSE .
        wa_itemlist1-unit       =  'OTH'.
      ENDIF .


      READ TABLE b_item INTO DATA(zbasic) WITH KEY a-conditiontype = 'ZR00' a-billingdocumentitem = bill_item-billingdocumentitem .
      wa_itemlist1-unitprice  =  zbasic-a-conditionratevalue * bill_head-accountingexchangerate   .
      IF  baseamount IS NOT INITIAL .
        wa_itemlist1-totamt     =  baseamount  * bill_head-accountingexchangerate     .
      ELSE.
        wa_itemlist1-totamt     = zbasic-a-conditionamount   * bill_head-accountingexchangerate   .
      ENDIF .
      wa_itemlist1-discount   =  '0.0' .
      wa_itemlist1-pretaxval  =  '0.0' .
      wa_itemlist1-assamt     = wa_itemlist1-totamt . "BASEAMOUNT . "        ZBASIC-a-ConditionAmount .   " BILL_ITEM-NetAmount   .
      """""""""""""""""""""""""""""""""""""""""""""""TAX DATA*******************************
      READ TABLE b_item INTO DATA(zbasicigst) WITH KEY a-conditiontype = 'JOIG'  a-billingdocumentitem = bill_item-billingdocumentitem .
      IF sy-subrc EQ 0 .
        wa_itemlist1-gstrt      =  zbasicigst-a-conditionrateratio .
        wa_itemlist1-igstamt    =  zbasicigst-a-conditionamount   * bill_head-accountingexchangerate   .
        igstamt  = igstamt +  wa_itemlist1-igstamt .

      ELSE.
        READ TABLE b_item INTO DATA(zbasicgst) WITH KEY a-conditiontype = 'JOCG'  a-billingdocumentitem = bill_item-billingdocumentitem .
        IF sy-subrc EQ 0 .
          wa_itemlist1-gstrt      =  zbasicgst-a-conditionrateratio * 2 .
          wa_itemlist1-cgstamt    =  zbasicgst-a-conditionamount  * bill_head-accountingexchangerate   .
          cgstamt = cgstamt + wa_itemlist1-cgstamt  .
        ENDIF.
        READ TABLE b_item INTO DATA(zbasisgst) WITH KEY a-conditiontype = 'JOSG'  a-billingdocumentitem = bill_item-billingdocumentitem .
        IF sy-subrc EQ 0 .
          wa_itemlist1-sgstamt    =  zbasisgst-a-conditionamount * bill_head-accountingexchangerate .
          sgstamt = sgstamt + wa_itemlist1-sgstamt     .
        ENDIF.
      ENDIF .

      """""""""""""""""""""""""""""""""""""""""""""""TAX DATA*******************************

      wa_itemlist1-cesrt      =     '0'   .
      wa_itemlist1-cesamt      =    '0'  .
      wa_itemlist1-statecesrt   =   '0'  .

      wa_itemlist1-statecesamt =    '0'  .
      wa_itemlist1-statecesnonadvlamt =   '0'  .

      SELECT SUM( conditionamount )    FROM i_billingdocumentitemprcgelmnt
* WHERE   ConditionType IN ( 'ZLDA','ZPCA','JTC1','JTC2' )
       WHERE   conditiontype IN ( 'JTC1','JTC2','ZTCS' )
       AND billingdocument = @bill_item-billingdocument AND billingdocumentitem = @bill_item-billingdocumentitem
        INTO @DATA(otchg) .

      wa_itemlist1-othchrg      =    otchg  * bill_head-accountingexchangerate    .
      othamount = othamount + wa_itemlist1-othchrg .
      wa_itemlist1-totitemval   =    wa_itemlist1-assamt  +  otchg  +  wa_itemlist1-igstamt + wa_itemlist1-cgstamt + wa_itemlist1-sgstamt .
      wa_itemlist1-ordlineref   =    ' '  .
      wa_itemlist1-orgcntry     =    ' '  .
      wa_itemlist1-prdslno      =    ' '  .

      DATA  assesmentval TYPE p DECIMALS 2 .
      assesmentval = assesmentval +  wa_itemlist1-totamt   .




      APPEND wa_itemlist1 TO itemlist .

      CLEAR :  wa_itemlist1 ,otchg.


    ENDLOOP .




    "AttribDtls Attribute
    wa_data2-a_nm        =  ' '  .
    wa_data2-a_val       =  ' '  .

    "Batch details{ }
    wa_data2-b_nm        =  '12345'  .
    wa_data2-b_expdt     =  ' '  .
    wa_data2-b_wrdt      =  ' '  .


    SELECT SUM( conditionamount ) FROM i_billingdocumentitemprcgelmnt WHERE
     billingdocument = @bill_head-billingdocument AND conditiontype = 'ZROF' INTO @DATA(roundof)  .



    "ValDtls Value details{final} "ASSESENT LOGIC
    wa_data2-assval      =   assesmentval  .
    wa_data2-cgstval     =   cgstamt  .
    wa_data2-sgstval     =   sgstamt  .
    wa_data2-igstval     =   igstamt .
    wa_data2-cesval      =   '0.0'  .
    wa_data2-stcesval    =   '0.0'  .
    wa_data2-othchrg     =    othamount .
    wa_data2-rndoffamt   =   roundof  .
    wa_data2-totinvval   =      wa_data2-assval + cgstamt + sgstamt +  igstamt  + othamount + roundof.
    wa_data2-totinvvalfc  =  '0.0 ' .


    "Payment Details
    wa_data2-p_nm       =  ' '  .
    wa_data2-p_mode     =  ' '  .
    wa_data2-p_fininsbr =  ' '  .
    wa_data2-p_payterm  =  ' '  .
    wa_data2-p_payinstr =  ' '.
    wa_data2-p_crtrn    =  ' '  .
    wa_data2-p_dirdr    =  ' '  .
    wa_data2-p_crday    =  ' '  .
    wa_data2-p_paidamt  =  '0.0 '  .
    wa_data2-p_paymtdue =  '0.0'  .
    wa_data2-p_accdet   =   ' '  .


    "RefDtls  refrence details  "Invoice remarks
    wa_data2-invrm      =   ' '  .

    "DocPerdDtls Perceding Details
    wa_data2-invstdt    =  '01/01/2022'  .
    wa_data2-invenddt   =  '01/01/2022'  .


    "PRECDocDtls
    wa_data2-p_invno    =   bill_head-documentreferenceid   .
    wa_data2-p_invdt    = |{ bill_head-billingdocumentdate+6(2) }/{ bill_head-billingdocumentdate+4(2) }/{ bill_head-billingdocumentdate+0(4) } |    . "'20/09/2022'  .
    wa_data2-othrefno   =  ' '  .

    ""ContrDtls
    wa_data2-recadvrefr =  ' '  .
    wa_data2-recadvdt   =  ' '  .
    wa_data2-tendrefr   =  ' '  .
    wa_data2-contrrefr  =  ' '  .
    wa_data2-extrefr    =  ' '  .
    wa_data2-projrefr   =  ' '  .
    wa_data2-porefr     =  ' '  .
    wa_data2-porefdt    =  ' '  .

    "ADDLDocDtls
    wa_data2-url        =  ' '  .
    wa_data2-docs       =  ' '  .
    wa_data2-info       =  ' '  .

    "ExpDtls
    wa_data2-shipbno      =   ' '  .
    wa_data2-shipbdt      =   ' '  .
    wa_data2-port         =   ' '  .
    wa_data2-refclm       =   ' '  .
    wa_data2-totinvvalfc  =   ' ' .
    wa_data2-forcur       =    bill_head-transactioncurrency  .
    wa_data2-cntcode      =   ' ' .
    wa_data2-expduty      =   ' '  .

    "EwbDtls"
    wa_data2-transid    =   ' '  .
    wa_data2-transname  =   ' '  .
    wa_data2-transmode  =   '1'  .
    wa_data2-distance   =   ' '  .
    wa_data2-transdocno =   ' '  .
    wa_data2-transdocdt =   ' '  .
    wa_data2-vehno      =   ' ' .
    wa_data2-vehtype    =   'R'  .
    wa_data2-prctr      =   ' '  .
    wa_data2-distance1  =   ' '  .

    APPEND wa_data2  TO it_data2 .








    LOOP AT it_data2 INTO DATA(wa_final) .

      wa_json_data-version  =  wa_final-version .


      IF bill_head-billingdocumenttype = 'CBRE' OR bill_head-billingdocumenttype = 'G2'.

        docdtls-typ  = 'CRN'  .
      ELSEIF bill_head-billingdocumenttype = 'L2'.
        docdtls-typ  = 'DBN'  .
      ELSE .
        docdtls-typ  = 'INV'  .
      ENDIF .
      docdtls-no  =  wa_final-i_no .


      docdtls-dt  = yeinvoice_te=>dateformat( date = wa_final-i_dt )   .

      "Transport data


      trandtls-taxsch  = wa_final-taxsch  .
      trandtls-suptyp = wa_final-suptyp.
      trandtls-regrev = wa_final-regrev.
      trandtls-ecmgstin = wa_final-ecmgstin.


      "Seller_Data
      sellerdtls-gstin = wa_final-s_gstin.
      sellerdtls-lglnm = wa_final-s_lglnm.
      sellerdtls-trdnm = wa_final-s_trdnm.
      sellerdtls-addr1 = wa_final-s_addr1.
      REPLACE ALL OCCURRENCES OF ',' IN sellerdtls-addr1 WITH ' ' .
      REPLACE ALL OCCURRENCES OF '’' IN sellerdtls-addr1 WITH ' ' .
*PERFORM format_data USING sellerdtls-addr1.
      sellerdtls-addr2 = wa_final-s_addr2.
      REPLACE ALL OCCURRENCES OF ',' IN sellerdtls-addr2 WITH ' ' .
      REPLACE ALL OCCURRENCES OF '’' IN sellerdtls-addr2 WITH ' ' .
      sellerdtls-loc = wa_final-s_loc.
      sellerdtls-pin = wa_final-s_pin.
      sellerdtls-stcd = wa_final-s_state.
      sellerdtls-ph = wa_final-s_ph .
      sellerdtls-em = wa_final-s_em .

      "Buyer details
      buyerdtls-gstin = wa_final-b_gstin.
      buyerdtls-lglnm = wa_final-b_lglnm.
      buyerdtls-trdnm = wa_final-b_trdnm.
      buyerdtls-pos = wa_final-b_pos.
      buyerdtls-addr1 = wa_final-b_addr1.
      REPLACE ALL OCCURRENCES OF ',' IN  buyerdtls-addr1 WITH ' ' .
      REPLACE ALL OCCURRENCES OF '’' IN  buyerdtls-addr1 WITH ' ' .
      buyerdtls-addr2 = wa_final-b_addr2.
      REPLACE ALL OCCURRENCES OF ',' IN  buyerdtls-addr2 WITH ' ' .
      REPLACE ALL OCCURRENCES OF '’' IN  buyerdtls-addr2 WITH ' ' .
      buyerdtls-loc = wa_final-b_loc .
      buyerdtls-pin = wa_final-b_pin .
      IF buyerdtls-pin = '0'.
        buyerdtls-pin = '111111'.
      ENDIF.
      buyerdtls-stcd = wa_final-b_state.
      buyerdtls-ph = wa_final-b_ph.
      buyerdtls-em = wa_final-b_em.

      "Dispatch details
      dispdtls-nm = wa_final-d_nm.
      dispdtls-addr1 = wa_final-d_addr1.
      REPLACE ALL OCCURRENCES OF ',' IN dispdtls-addr1 WITH ' ' .
      REPLACE ALL OCCURRENCES OF '’' IN dispdtls-addr1 WITH ' ' .
      dispdtls-addr2 = wa_final-d_addr2.
      REPLACE ALL OCCURRENCES OF ',' IN dispdtls-addr2 WITH ' ' .
      REPLACE ALL OCCURRENCES OF '’' IN dispdtls-addr2 WITH ' ' .
      dispdtls-loc = wa_final-d_loc.
      dispdtls-pin = wa_final-d_pin.
      dispdtls-stcd = wa_final-d_stcd.

      "shiping details

      shipdtls-gstin = wa_final-sh_gstin.
      shipdtls-lglnm = wa_final-sh_lglnm.
      shipdtls-trdnm = wa_final-sh_trdnm.
      shipdtls-addr1 = wa_final-sh_addr1.
      REPLACE ALL OCCURRENCES OF ',' IN shipdtls-addr1 WITH ' ' .
      REPLACE ALL OCCURRENCES OF '’' IN shipdtls-addr1 WITH ' ' .
      shipdtls-addr2 = wa_final-sh_addr2.
      REPLACE ALL OCCURRENCES OF ',' IN shipdtls-addr2 WITH ' ' .
      REPLACE ALL OCCURRENCES OF '’' IN shipdtls-addr2 WITH ' ' .
      shipdtls-loc = wa_final-sh_loc.
      shipdtls-pin = wa_final-sh_pin.
      shipdtls-stcd = wa_final-sh_stcd.



      LOOP AT itemlist INTO wa_itemlist  .


        APPEND wa_itemlist TO wa_json_data-itemlist .
        CLEAR wa_itemlist .
      ENDLOOP .


      attribdtls-nm = wa_final-a_nm.
      attribdtls-val = wa_final-a_val.
      DATA:assval TYPE string.
      DATA:inv    TYPE string.
      DATA:invfc  TYPE string.
      DATA:oth    TYPE string.
      DATA:sgst   TYPE string.
      DATA:cgst   TYPE string.
      DATA:igst   TYPE string.
      assval = assval + wa_final-assval.

      valdtls-assval = assval.   "1

      cgst = cgst + wa_final-cgstval.
      sgst = sgst + wa_final-sgstval.
      igst = igst + wa_final-igstval.
      valdtls-cgstval = cgst.              "2
      valdtls-sgstval = sgst.            "3
      valdtls-igstval = igst.              "4

      valdtls-cesval = wa_final-cesval.   "5
      valdtls-stcesval = wa_final-stcesval.  "6
      valdtls-rndoffamt = wa_final-rndoffamt.  "7
*       valdtls-othchrg  = wa_final-othchrg .   " new value added Rishi
      invfc = invfc +  wa_final-totinvvalfc.

      valdtls-totinvvalfc = invfc .       "8
      inv = inv + wa_final-totinvval .
      valdtls-totinvval = inv.     "9

      paydtls-nm = wa_final-p_nm.
      paydtls-accdet = wa_final-p_accdet.
      paydtls-mode = wa_final-p_mode.
      paydtls-fininsbr = wa_final-p_fininsbr.
      paydtls-payterm = wa_final-p_payterm.
      paydtls-payinstr = wa_final-p_payinstr.
      paydtls-crtrn = wa_final-p_crtrn.
      paydtls-dirdr = wa_final-p_dirdr.
      paydtls-crday = wa_final-p_crday.
      paydtls-paidamt = wa_final-p_paidamt.
      paydtls-paymtdue = wa_final-p_paymtdue.

      refdtls-invrm = wa_final-invrm.

      docpre-invstdt = wa_final-invstdt.

      docpre-invenddt = wa_final-invenddt.
      precdocdtls-invno = wa_final-p_invno.
      precdocdtls-invdt = wa_final-p_invdt.
      precdocdtls-othrefno = wa_final-othrefno.

      contrdtls-recadvrefr = wa_final-recadvrefr.
      contrdtls-recadvdt = wa_final-recadvdt.
      contrdtls-tendrefr = wa_final-tendrefr.
      contrdtls-contrrefr = wa_final-contrrefr.
      contrdtls-extrefr = wa_final-extrefr.
      contrdtls-projrefr = wa_final-projrefr.
      contrdtls-porefr = wa_final-porefr.
      contrdtls-porefdt = wa_final-porefdt.


      addldocdtls-url = wa_final-url.
      addldocdtls-docs = wa_final-docs.


      expdtls-shipbno = wa_final-shipbno.
      expdtls-shipbdt = wa_final-shipbdt.
      expdtls-port = wa_final-port.
      expdtls-refclm = wa_final-refclm.
      expdtls-forcur = wa_final-forcur.
      expdtls-cntcode = wa_final-cntcode.


      bchdtls-nm = wa_final-b_nm.
      bchdtls-expdt = wa_final-b_expdt.
      bchdtls-wrdt = wa_final-b_wrdt.

      ewbdtls-transid = wa_final-transid.
      ewbdtls-transname = wa_final-transname.
      ewbdtls-transmode = wa_final-transmode.

      DATA: del1 TYPE string,
            del2 TYPE string.

      DATA : dest TYPE string .
      dest  =    wa_final-distance  .
      SPLIT dest AT '.' INTO del1 del2.
      ewbdtls-distance = del1."WA_FINAL-DISTANCE.
      IF del1 IS INITIAL.
        ewbdtls-distance = '0'.
      ENDIF.
      ewbdtls-transdocno = wa_final-transdocno.
      ewbdtls-transdocdt = wa_final-transdocdt.
      REPLACE ALL OCCURRENCES OF '.' IN ewbdtls-transdocdt WITH '/'.
      ewbdtls-vehno = wa_final-vehno.
      ewbdtls-vehtype = wa_final-vehtype.


      MOVE-CORRESPONDING trandtls TO wa_json_data-trandtls.
      MOVE-CORRESPONDING docdtls TO wa_json_data-docdtls.
      MOVE-CORRESPONDING sellerdtls TO wa_json_data-sellerdtls.
      MOVE-CORRESPONDING buyerdtls TO wa_json_data-buyerdtls.
      MOVE-CORRESPONDING dispdtls TO wa_json_data-dispdtls.
      MOVE-CORRESPONDING shipdtls TO wa_json_data-shipdtls.
      MOVE-CORRESPONDING attribdtls TO wa_json_data-attribdtls.
      MOVE-CORRESPONDING valdtls TO wa_json_data-valdtls.
      MOVE-CORRESPONDING paydtls TO wa_json_data-paydtls.
      MOVE-CORRESPONDING precdocdtls TO wa_json_data-precdocdtls.
      MOVE-CORRESPONDING contrdtls TO wa_json_data-contrdtls.
      MOVE-CORRESPONDING refdtls TO wa_json_data-refdtls.
      MOVE-CORRESPONDING docpre TO  wa_json_data-docpre.
      MOVE-CORRESPONDING addldocdtls TO wa_json_data-addldocdtls.
      MOVE-CORRESPONDING expdtls TO wa_json_data-expdtls.
      MOVE-CORRESPONDING bchdtls TO wa_json_data-bchdtls.
      MOVE-CORRESPONDING ewbdtls TO wa_json_data-ewbdtls.
      APPEND wa_json_data TO it_json_data.

      CLEAR: wa_final, trandtls, docdtls, sellerdtls, buyerdtls, dispdtls, shipdtls, wa_itemlist,
           bchdtls, valdtls, paydtls, refdtls, addldocdtls, expdtls, ewbdtls.


    ENDLOOP .

    DATA(json_writer) = cl_sxml_string_writer=>create(
                            type = if_sxml=>co_xt_json ).
    CALL TRANSFORMATION id SOURCE result = it_json_data
                           RESULT XML json_writer.
    DATA(jsonx) = json_writer->get_output( ).


    DATA: lv_json TYPE string.


    DATA :lv_xstring_var TYPE xstring,
          strc           TYPE string.

    DATA(lv_string) = xco_cp=>xstring( jsonx
      )->as_string( xco_cp_character=>code_page->utf_8
      )->value.

    REPLACE ALL OCCURRENCES OF 'VERSION' IN lv_string WITH 'Version'.
    REPLACE ALL OCCURRENCES OF 'IRN' IN lv_string WITH 'Irn'.
    REPLACE ALL OCCURRENCES OF 'TRANDTLS' IN lv_string WITH 'TranDtls'.
    REPLACE ALL OCCURRENCES OF 'DOCDTLS' IN lv_string WITH 'DocDtls'.
    REPLACE ALL OCCURRENCES OF 'SELLERDTLS' IN lv_string WITH 'SellerDtls'.
    REPLACE ALL OCCURRENCES OF 'BUYERDTLS' IN lv_string WITH 'BuyerDtls'.
    REPLACE ALL OCCURRENCES OF 'DISPDTLS' IN lv_string WITH 'DispDtls'.
    REPLACE ALL OCCURRENCES OF 'SHIPDTLS' IN lv_string WITH 'ShipDtls'.
    REPLACE ALL OCCURRENCES OF 'ITEMLIST' IN lv_string WITH 'ItemList'.
    REPLACE ALL OCCURRENCES OF 'VALDTLS' IN lv_string WITH 'ValDtls'.
    REPLACE ALL OCCURRENCES OF 'PAYDTLS' IN lv_string WITH 'PayDtls'.
    REPLACE ALL OCCURRENCES OF 'REFDTLS' IN lv_string WITH 'RefDtls'.
    REPLACE ALL OCCURRENCES OF 'ADDLDOCDTLS' IN lv_string WITH 'AddlDocDtls'.
    REPLACE ALL OCCURRENCES OF 'EXPDTLS' IN lv_string WITH 'ExpDtls'.
    REPLACE ALL OCCURRENCES OF 'EWBDTLS' IN lv_string WITH 'EwbDtls'.
    REPLACE ALL OCCURRENCES OF 'TAXSCH' IN lv_string WITH 'TaxSch'.
    REPLACE ALL OCCURRENCES OF 'SUPTYP' IN lv_string WITH 'SupTyp'.
    REPLACE ALL OCCURRENCES OF 'REGREV' IN lv_string WITH 'RegRev'.
    REPLACE ALL OCCURRENCES OF 'ECMGSTIN' IN lv_string WITH 'EcmGstin'.
    REPLACE ALL OCCURRENCES OF 'TYP' IN lv_string WITH 'Typ'.
    REPLACE ALL OCCURRENCES OF 'NO' IN lv_string WITH 'No'.
    REPLACE ALL OCCURRENCES OF 'DT' IN lv_string WITH 'Dt'.
    REPLACE ALL OCCURRENCES OF 'GSTIN' IN lv_string WITH 'Gstin'.
    REPLACE ALL OCCURRENCES OF 'LGLNM' IN lv_string WITH 'LglNm'.
    REPLACE ALL OCCURRENCES OF 'TRDNM' IN lv_string WITH 'TrdNm'.
    REPLACE ALL OCCURRENCES OF 'ADDR1' IN lv_string WITH 'Addr1'.
    REPLACE ALL OCCURRENCES OF 'ADDR2' IN lv_string WITH 'Addr2'.
    REPLACE ALL OCCURRENCES OF 'LOC' IN lv_string WITH 'Loc'.
    REPLACE ALL OCCURRENCES OF 'PIN' IN lv_string WITH 'Pin'.
    REPLACE ALL OCCURRENCES OF 'STATE' IN lv_string WITH 'State'.
    REPLACE ALL OCCURRENCES OF 'PH' IN lv_string WITH 'Ph'.
    REPLACE ALL OCCURRENCES OF 'EM' IN lv_string WITH 'Em'.
    REPLACE ALL OCCURRENCES OF 'POS' IN lv_string WITH 'Pos'.
    REPLACE ALL OCCURRENCES OF 'NM' IN lv_string WITH 'Nm'.
    REPLACE ALL OCCURRENCES OF 'STCD' IN lv_string WITH 'Stcd'.
    REPLACE ALL OCCURRENCES OF 'SLNO' IN lv_string WITH 'SlNo'.
    REPLACE ALL OCCURRENCES OF 'PRDDESC' IN lv_string WITH 'PrdDesc'.
    REPLACE ALL OCCURRENCES OF 'ISSERVC' IN lv_string WITH 'IsServc'.
    REPLACE ALL OCCURRENCES OF 'HSNCD' IN lv_string WITH 'HsnCd'.
    REPLACE ALL OCCURRENCES OF 'BCHDTLS' IN lv_string WITH 'BchDtls'.
    REPLACE ALL OCCURRENCES OF 'BARCDE' IN lv_string WITH 'Barcde'.
    REPLACE ALL OCCURRENCES OF 'QTY' IN lv_string WITH 'Qty'.
    REPLACE ALL OCCURRENCES OF 'FREEQTY' IN lv_string WITH 'FreeQty'.
    REPLACE ALL OCCURRENCES OF 'UNIT' IN lv_string WITH 'Unit'.
*  REPLACE ALL OCCURRENCES OF 'UNITPRICE' IN lv_string WITH 'UnitPrice'.
    REPLACE ALL OCCURRENCES OF 'TOTAMT' IN lv_string WITH 'TotAmt'.
    REPLACE ALL OCCURRENCES OF 'DISCOUNT' IN lv_string WITH 'Discount'.
    REPLACE ALL OCCURRENCES OF 'PRETAXVAL' IN lv_string WITH 'PreTaxVal'.
    REPLACE ALL OCCURRENCES OF 'ASSAMT' IN lv_string WITH 'AssAmt'.
    REPLACE ALL OCCURRENCES OF 'GSTRT' IN lv_string WITH 'GstRt'.
    REPLACE ALL OCCURRENCES OF 'IGSTAMT' IN lv_string WITH 'IgstAmt'.
    REPLACE ALL OCCURRENCES OF 'CGSTAMT' IN lv_string WITH 'CgstAmt'.
    REPLACE ALL OCCURRENCES OF 'SGSTAMT' IN lv_string WITH 'SgstAmt'.
    REPLACE ALL OCCURRENCES OF 'CESRT' IN lv_string WITH 'CesRt'.
    REPLACE ALL OCCURRENCES OF 'CESAMT' IN lv_string WITH 'CesAmt'.
    REPLACE ALL OCCURRENCES OF 'CESNONADVLAMT' IN lv_string WITH 'CesNonAdvlAmt'.
    REPLACE ALL OCCURRENCES OF 'STATECESRT' IN lv_string WITH 'StateCesRt'.
    REPLACE ALL OCCURRENCES OF 'STATECESAMT' IN lv_string WITH 'StateCesAmt'.
    REPLACE ALL OCCURRENCES OF 'STATECESNONADVLAMT' IN lv_string WITH 'StateCesNonAdvlAmt'.
    REPLACE ALL OCCURRENCES OF 'OTHCHRG' IN lv_string WITH 'OthChrg'.
    REPLACE ALL OCCURRENCES OF 'TOTITEMVAL' IN lv_string WITH 'TotItemVal'.
    REPLACE ALL OCCURRENCES OF 'ORDLINEREF' IN lv_string WITH 'OrdLineRef'.
    REPLACE ALL OCCURRENCES OF 'ORGCNTRY' IN lv_string WITH 'OrgCntry'.
    REPLACE ALL OCCURRENCES OF 'PRDSLNO' IN lv_string WITH 'PrdSlNo'.
    REPLACE ALL OCCURRENCES OF 'ATTRIBDTLS' IN lv_string WITH 'AttribDtls'.
    REPLACE ALL OCCURRENCES OF 'VAL' IN lv_string WITH 'Val'.
    REPLACE ALL OCCURRENCES OF 'EXPDT' IN lv_string WITH 'ExpDt'.
    REPLACE ALL OCCURRENCES OF 'WRDT' IN lv_string WITH 'WrDt'.
    REPLACE ALL OCCURRENCES OF 'ASSVAL' IN lv_string WITH 'AssVal'.
    REPLACE ALL OCCURRENCES OF 'CGSTVAL' IN lv_string WITH 'CgstVal'.
    REPLACE ALL OCCURRENCES OF 'SGSTVAL' IN lv_string WITH 'SgstVal'.
    REPLACE ALL OCCURRENCES OF 'IGSTVAL' IN lv_string WITH 'IgstVal'.
    REPLACE ALL OCCURRENCES OF 'CESVAL' IN lv_string WITH 'CesVal'.
    REPLACE ALL OCCURRENCES OF 'STCESVAL' IN lv_string WITH 'StCesVal'.
    REPLACE ALL OCCURRENCES OF 'RNDOFFAMT' IN lv_string WITH 'RndOffAmt'.
    REPLACE ALL OCCURRENCES OF 'TOTINVVALFC' IN lv_string WITH 'TotInvValFc'.
    REPLACE ALL OCCURRENCES OF 'ACCDET' IN lv_string WITH 'AccDet'.
    REPLACE ALL OCCURRENCES OF 'MODE' IN lv_string WITH 'Mode'.
    REPLACE ALL OCCURRENCES OF 'FININSBR' IN lv_string WITH 'FinInsBr'.
    REPLACE ALL OCCURRENCES OF 'PAYTERM' IN lv_string WITH 'PayTerm'.
    REPLACE ALL OCCURRENCES OF 'PAYINSTR' IN lv_string WITH 'PayInstr'.
    REPLACE ALL OCCURRENCES OF 'CRTRN' IN lv_string WITH 'CrTrn'.
    REPLACE ALL OCCURRENCES OF 'DIRDR' IN lv_string WITH 'DirDr'.
    REPLACE ALL OCCURRENCES OF 'CRDAY' IN lv_string WITH 'CrDay'.
    REPLACE ALL OCCURRENCES OF 'PAIDAMT' IN lv_string WITH 'PaidAmt'.
    REPLACE ALL OCCURRENCES OF 'PAYMTDUE' IN lv_string WITH 'PaymtDue'.
    REPLACE ALL OCCURRENCES OF 'INVRM' IN lv_string WITH 'InvRm'.
    REPLACE ALL OCCURRENCES OF 'INVSTDT' IN lv_string WITH 'InvStDt'.
    REPLACE ALL OCCURRENCES OF 'INVENDDTT' IN lv_string WITH 'InvEndDt'.
    REPLACE ALL OCCURRENCES OF 'PRECDOCDTLS' IN lv_string WITH 'PrecDocDtls'.
    REPLACE ALL OCCURRENCES OF 'CONTRDTLS' IN lv_string WITH 'ContrDtls'.
    REPLACE ALL OCCURRENCES OF 'INVNO' IN lv_string WITH 'InvNo'.
    REPLACE ALL OCCURRENCES OF 'INVDT' IN lv_string WITH 'InvDt'.
    REPLACE ALL OCCURRENCES OF 'OTHREFNO' IN lv_string WITH 'OthRefNo'.
    REPLACE ALL OCCURRENCES OF 'RECADVREFR' IN lv_string WITH 'RecAdvRefr'.
    REPLACE ALL OCCURRENCES OF 'RECADVDT' IN lv_string WITH 'RecAdvDt'.
    REPLACE ALL OCCURRENCES OF 'TENDREFR' IN lv_string WITH 'TendRefr'.
    REPLACE ALL OCCURRENCES OF 'CONTRREFR' IN lv_string WITH 'ContrRefr'.
    REPLACE ALL OCCURRENCES OF 'EXTREFR' IN lv_string WITH 'ExtRefr'.
    REPLACE ALL OCCURRENCES OF 'PROJREFR' IN lv_string WITH 'ProjRefr'.
    REPLACE ALL OCCURRENCES OF 'POREFR' IN lv_string WITH 'PORefr'.
    REPLACE ALL OCCURRENCES OF 'POREFDT' IN lv_string WITH 'PORefDt'.
    REPLACE ALL OCCURRENCES OF 'URL' IN lv_string WITH 'Url'.
    REPLACE ALL OCCURRENCES OF 'DOCS' IN lv_string WITH 'Docs'.
    REPLACE ALL OCCURRENCES OF 'INFO' IN lv_string WITH 'Info'.
    REPLACE ALL OCCURRENCES OF 'SHIPBNO' IN lv_string WITH 'ShipBNo'.
    REPLACE ALL OCCURRENCES OF 'SHIPBDT' IN lv_string WITH 'ShipBDt'.
    REPLACE ALL OCCURRENCES OF 'PORT' IN lv_string WITH 'Port'.
    REPLACE ALL OCCURRENCES OF 'REFCLM' IN lv_string WITH 'RefClm'.
    REPLACE ALL OCCURRENCES OF 'FORCUR' IN lv_string WITH 'ForCur'.
    REPLACE ALL OCCURRENCES OF 'CNTCODE' IN lv_string WITH 'CntCode'.
    REPLACE ALL OCCURRENCES OF 'TRANSID' IN lv_string WITH 'TransId'.
    REPLACE ALL OCCURRENCES OF 'TRANSNAME' IN lv_string WITH 'TransName'.
    REPLACE ALL OCCURRENCES OF 'TRANSMODE' IN lv_string WITH 'TransMode'.
    REPLACE ALL OCCURRENCES OF 'DISTANCE' IN lv_string WITH 'Distance'.
    REPLACE ALL OCCURRENCES OF 'TRANSDOCNO' IN lv_string WITH 'TransDocNo'.
    REPLACE ALL OCCURRENCES OF 'TRANSDOCDT' IN lv_string WITH 'TransDocDt'.
    REPLACE ALL OCCURRENCES OF 'VEHNO' IN lv_string WITH 'VehNo'.
    REPLACE ALL OCCURRENCES OF 'VEHTYPE' IN lv_string WITH 'VehType'.
    REPLACE ALL OCCURRENCES OF 'SLNo' IN lv_string WITH 'SlNo'.
    REPLACE ALL OCCURRENCES OF 'UnitPRICE' IN lv_string WITH 'UnitPrice'.
    REPLACE ALL OCCURRENCES OF 'TOTITEmVal' IN lv_string WITH 'TotItemVal'.
    REPLACE ALL OCCURRENCES OF 'TOTINVVal' IN lv_string WITH 'TotInvVal'.



    SHIFT lv_string LEFT DELETING LEADING '{"RESULT":'.
    REPLACE ALL OCCURRENCES OF '[{'  IN lv_string WITH '{'.
    REPLACE ALL OCCURRENCES OF '{'  IN lv_string WITH '{*'.
    REPLACE ALL OCCURRENCES OF ',"' IN lv_string WITH ',*"'.
    REPLACE ALL OCCURRENCES OF '}]' IN lv_string WITH '}'.
    REPLACE ALL OCCURRENCES OF '},' IN lv_string WITH '},*'.
    REPLACE ALL OCCURRENCES OF '}' IN lv_string WITH '*}'.
    REPLACE ALL OCCURRENCES OF '*}*}*}' IN lv_string WITH '*}*}'.
    REPLACE ALL OCCURRENCES OF 'ItemList":{' IN lv_string WITH 'ItemList":[{'.
    REPLACE ALL OCCURRENCES OF '},**"ATTRIBDtLS":{' IN lv_string WITH '},*"AttribDtls":[{'.
    REPLACE ALL OCCURRENCES OF '},**"ValDtls":' IN lv_string WITH '}]}],*"ValDtls":'.
    REPLACE ALL OCCURRENCES OF '"PRECDocDtls":' IN lv_string WITH '"PRECDocDtls":['.
    REPLACE ALL OCCURRENCES OF '},**"ADDLDocDtls":' IN lv_string WITH '}]},*"ADDLDocDtls":['.
    REPLACE ALL OCCURRENCES OF '},**"ExpDtls":' IN lv_string WITH '}],*"ExpDtls":'.
    REPLACE ALL OCCURRENCES OF '"CONTRDtLS":' IN lv_string WITH '"ContrDtls":['.
    REPLACE ALL OCCURRENCES OF '},**"BCHDtLS":' IN lv_string WITH ',*"BchDtls":'.
    REPLACE ALL OCCURRENCES OF '},**"DOCPRE":{' IN lv_string WITH ',*"DocPerdDtls":{'.
    REPLACE ALL OCCURRENCES OF '},**"ContrDtls":[{' IN lv_string WITH '}],*"ContrDtls":[{'.
    REPLACE ALL OCCURRENCES OF '**' IN lv_string WITH '*'.
    REPLACE ALL OCCURRENCES OF '"Distance": 0.0,' IN lv_string WITH '"Distance": 0,'.

    REPLACE ALL OCCURRENCES OF '""' IN lv_string WITH 'null'.
    REPLACE ALL OCCURRENCES OF '111111' IN lv_string WITH 'null'.




    REPLACE ALL OCCURRENCES OF '*' IN lv_string WITH ''.
      status  = lv_string .

  ENDMETHOD.
ENDCLASS.
