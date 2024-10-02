CLASS zcl_eway_generation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-DATA:BEGIN OF buyerdtls,
                 gstin(30) TYPE c,
                 lglnm     TYPE string,
                 trdnm     TYPE string,
                 addr1     TYPE string,
                 addr2     TYPE string,
                 loc       TYPE string,
                 pin       TYPE string,
                 stcd      TYPE string,
               END OF buyerdtls.

    CLASS-DATA:BEGIN OF sellerdtls,
                 gstin(30) TYPE c,
                 lglnm     TYPE string,
                 trdnm     TYPE string,
                 addr1     TYPE string,
                 addr2     TYPE string,
                 loc       TYPE string,
                 pin       TYPE string,
                 stcd      TYPE string,
               END OF sellerdtls.

    CLASS-DATA:BEGIN OF dispdtls,
                 nm    TYPE string,
                 addr1 TYPE string,
                 addr2 TYPE string,
                 loc   TYPE string,
                 pin   TYPE string,
                 stcd  TYPE string,
               END OF dispdtls.

    CLASS-DATA:BEGIN OF expshipdtls,
                 lglnm TYPE string,
                 addr1 TYPE string,
                 loc   TYPE string,
                 pin   TYPE string,
                 stcd  TYPE string,
               END OF expshipdtls.

    TYPES :BEGIN OF ty_itemlist,
             prodname     TYPE string,
             proddesc     TYPE string,
             hsncd        TYPE string,
             qty          TYPE yinv_stu-igstamt,
             unit         TYPE string,
             assamt       TYPE yinv_stu-igstamt,

             cgstrt       TYPE yinv_stu-igstamt,
             cgstamt      TYPE yinv_stu-igstamt,
             sgstrt       TYPE yinv_stu-igstamt,
             sgstamt      TYPE yinv_stu-igstamt,
             igstrt       TYPE yinv_stu-igstamt,
             igstamt      TYPE yinv_stu-igstamt,

             cesrt        TYPE yinv_stu-igstamt,
             cesamt       TYPE yinv_stu-igstamt,
             othchrg      TYPE yinv_stu-igstamt,
             cesnonadvamt TYPE yinv_stu-igstamt,
           END OF ty_itemlist.

    CLASS-DATA:itemlist    TYPE TABLE OF ty_itemlist,
               wa_itemlist LIKE LINE OF itemlist.

    TYPES:BEGIN OF ty_final,
            documentnumber(10)      TYPE c,
            documenttype(10)        TYPE c,
            documentdate(10)        TYPE c,
            supplytype(10)          TYPE c,
            subsupplytype(30)       TYPE c,
            subsupplytypedesc(30)   TYPE c,
            transactiontype(20)     TYPE c,

            buyerdtls               LIKE buyerdtls,
            sellerdtls              LIKE sellerdtls,
            expshipdtls             LIKE expshipdtls,
            dispdtls                LIKE dispdtls,
            itemlist                LIKE itemlist,

            totalinvoiceamount      TYPE yinv_stu-igstamt,
            totalcgstamount         TYPE yinv_stu-igstamt,
            totalsgstamount         TYPE yinv_stu-igstamt,
            totaligstamount         TYPE yinv_stu-igstamt,
            totalcessamount         TYPE yinv_stu-igstamt,
            totalcessnonadvolamount TYPE yinv_stu-igstamt,
            totalassessableamount   TYPE yinv_stu-igstamt,
            otheramount             TYPE yinv_stu-igstamt,
            othertcsamount          TYPE yinv_stu-igstamt,
            transid                 TYPE string,
            transname               TYPE string,
            transmode               TYPE string,
            distance                TYPE string,
            transdocno              TYPE string,
            transdocdt              TYPE string,
            vehno                   TYPE string,
            vehtype                 TYPE string,
          END OF ty_final.

    CLASS-DATA:it_final TYPE TABLE OF ty_final,
               wa_final TYPE ty_final.

    CLASS-METHODS :generated_eway_bill
      IMPORTING invoice         TYPE string
                distance        TYPE string OPTIONAL
                transpoter_name TYPE string OPTIONAL
                transportid     TYPE string OPTIONAL
                transportdoc    TYPE string OPTIONAL
                vehiclenumber   TYPE string OPTIONAL
      RETURNING VALUE(status)   TYPE string,


            create_client

        IMPORTING url           TYPE string
        RETURNING VALUE(result) TYPE REF TO if_web_http_client
        RAISING   cx_static_check .


    CLASS-DATA:user_name TYPE string,
               password  TYPE string,
               gstin_d   TYPE string.


    CLASS-DATA: BEGIN OF i_eway,
                  ewbnumber      TYPE string,
                  fromplace      TYPE string, "C length 100,
                  fromstate      TYPE string, "N length 2,
                  reasoncode     TYPE string,
                  reasonremark   TYPE string,
                  transdocno     TYPE string,
                  transdocdt     TYPE string,
                  transmode      TYPE string,
                  documentnumber TYPE string,
                  documenttype   TYPE string,
                  documentdate   TYPE string,
                  vehicletype    TYPE string,
                  vehno          TYPE string,
                  updateddate    TYPE string,
                  validupto      TYPE string,
                  errors         TYPE string,
                END OF  i_eway.

    CLASS-DATA:BEGIN OF w_user,
                 user_id  TYPE string,
                 password TYPE string,
                 gstin    TYPE string,
               END OF w_user.

    INTERFACES if_oo_adt_classrun .
     CLASS-DATA : access_token TYPE string .

         CLASS-METHODS :
      generate_authentication_token
        IMPORTING billingdocument TYPE zchar10 OPTIONAL
        RETURNING VALUE(auth_token) TYPE string .

  PROTECTED             SECTION.
  PRIVATE SECTION.
   CONSTANTS:
      base_url     TYPE      string  VALUE 'https://gsp.adaequare.com/gsp/authenticate?action=GSP&grant_type=token',
      content_type TYPE      string  VALUE 'Content-type',
      iv_name1     TYPE      string  VALUE 'GSPAPPID',
      iv_value1    TYPE      string  VALUE '3002C9D13D6D47128D08F3DE2211AAE2',
      iv_name2     TYPE      string  VALUE 'GSPAPPSECRET',
      iv_value12   TYPE      string  VALUE '0ACA16FEG3C2FG4FDFGA8F1G6A831E6ADF34',
      json_content TYPE      string  VALUE 'application/json; charxset=UTF-8'.

ENDCLASS.



CLASS ZCL_EWAY_GENERATION IMPLEMENTATION.


   METHOD create_client.


    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).
  ENDMETHOD.


  METHOD generated_eway_bill ."if_oo_adt_classrun~main

*    DATA:invoice         TYPE string,
*         distance        TYPE string VALUE '0',
*         transpoter_name TYPE string,
*         transportid     TYPE string,
*         transportdoc    TYPE string,
*         vehiclenumber   TYPE string VALUE 'RJ141234',
*         status          TYPE string.

*    invoice  = '0090000949'.
    DATA: BEGIN OF w_ewaybill,
            ackdt        TYPE string,
            ackno        TYPE string,
            ewbno        TYPE string,
            ewbdt        TYPE string,
            status2      TYPE string,
            success      TYPE string,
            ewbvalidtill TYPE string,
            km(30)       TYPE c,
          END OF w_ewaybill.

    FIELD-SYMBOLS:
      <datax>              TYPE data,
      <datay>              TYPE data,
      <dataz>              TYPE data,
      <data2>              TYPE data,
      <data3>              TYPE any,
      <field>              TYPE any,
      <field_ackdt>        TYPE any,
      <field_ackno>        TYPE any,
      <field_irn>          TYPE any,
      <field_ewbno>        TYPE any,
      <field_ewbdt>        TYPE any,
      <field_status>       TYPE any,
      <field_success>      TYPE any,
      <field_ewbvalidtill> TYPE any.

    DATA:error_msg_part1 TYPE string,
         error_msg_part2 TYPE string.

*    DATA : access_token TYPE string .

    DATA:vbeln(10) TYPE c.
    vbeln = invoice.
    vbeln = |{ vbeln ALPHA = IN }|.

    DATA(token)  = generate_authentication_token( billingdocument = vbeln )  .

*    CALL METHOD ztoken_authentication=>generate_authentication_token
*      EXPORTING
*        vbeln  = vbeln
*      CHANGING
*        id_password = w_user
*      RECEIVING
*        auth_token  = DATA(access_token).
*    IF sy-sysid = 'XND' OR sy-sysid = 'YXC'.
*      access_token = '1.ac7743bc-1d95-40b4-9d54-7c9494d460d9_877b4326d312a8e38eb5e49cda6f4a4c522d14c493f9da434bcb451001d22e5f'.
*    ELSE.
**      access_token = '1.ac7743bc-1d95-40b4-9d54-7c9494d460d9_877b4326d312a8e38eb5e49cda6f4a4c522d14c493f9da434bcb451001d22e5f'.
*    ENDIF.

**************************************************************************
    SELECT SINGLE *  FROM i_billingdocumentbasic  WHERE billingdocument = @vbeln INTO   @DATA(bill_head).
    SELECT *  FROM i_billingdocumentpartner  WHERE billingdocument = @vbeln INTO TABLE  @DATA(i_billingpart).

*************Billing partener "BUYER'
    SELECT SINGLE * FROM   i_billingdocumentpartner AS a  INNER JOIN i_customer AS
                b ON   ( a~customer = b~customer  ) WHERE a~billingdocument = @vbeln
                 AND a~partnerfunction = 'RE' INTO  @DATA(buyeradd)   .

*************Shipping Partner Details
    SELECT SINGLE * FROM i_billingdocumentpartner AS a  INNER JOIN i_customer AS
                b ON   ( a~customer = b~customer  ) WHERE a~billingdocument = @vbeln
                 AND a~partnerfunction = 'WE' INTO   @DATA(shippingadd)   .


    SELECT SINGLE * FROM zsd_plant_address AS a INNER JOIN i_billingdocumentitembasic AS b ON ( a~plant =  b~plant )
    WHERE billingdocument =  @vbeln INTO @DATA(plantaddress) .

*************ITEM DETAILS
    SELECT * FROM i_billingdocumentitem   WHERE
    billingdocument  =  @vbeln AND billingquantity NE ''  INTO TABLE @DATA(billing_item)  .

*************Pricing data
    SELECT * FROM i_billingdocumentitemprcgelmnt AS a  INNER JOIN   i_billingdocumentitem AS b
    ON ( a~billingdocument = b~billingdocument  )  WHERE
    a~billingdocument  = @vbeln AND billingquantity NE '' INTO TABLE @DATA(b_item)   .


    wa_final-documentnumber = invoice.
    IF bill_head-sddocumentcategory EQ 'M' OR bill_head-billingdocumenttype = 'F2'.
      wa_final-documenttype = 'INV'.
    ELSEIF bill_head-sddocumentcategory = 'O'.
      wa_final-documenttype = 'CRN'.
    ELSEIF bill_head-sddocumentcategory = 'P'.
      wa_final-documenttype = 'DBN'.
    ELSEIF bill_head-sddocumentcategory = 'U'.
      wa_final-documenttype = 'CHL'.
    ENDIF.
    wa_final-documentdate = |{ bill_head-billingdocumentdate+6(2) }/{ bill_head-billingdocumentdate+4(2) }/{ bill_head-billingdocumentdate+0(4) }|.


    wa_final-supplytype        = 'Outward'.
    wa_final-subsupplytype     = '8'.
    wa_final-subsupplytypedesc = 'Stock Transfer'.
    wa_final-transactiontype   = '1'.

    READ TABLE billing_item INTO DATA(wa_bill) INDEX 1.
*      SELECT SINGLE * FROM zsd_plant_address AS a
*      INNER JOIN i_billingdocumentitembasic AS b ON ( a~plant =  b~plant )
*      WHERE billingdocument =  @vbeln AND a~plant = @wa_bill-plant INTO @DATA(sellerplantaddress) .

    SELECT SINGLE a~addressid,
                  b~addresssearchterm2 AS gstin,
                  b~careofname AS lglnm,
                  b~streetname AS addr1,
                  b~cityname AS addr2,
                  b~districtname AS city,
                  b~postalcode AS pin,
                  b~region AS stcd
    FROM i_plant AS a
    LEFT JOIN i_address_2 WITH PRIVILEGED ACCESS AS b ON ( a~addressid = b~addressid )
    WHERE plant = @wa_bill-plant INTO @DATA(sellerplantaddress).


    IF sy-sysid = 'XND' OR sy-sysid = 'YXC'.

      wa_final-sellerdtls-gstin    =  '08AAFCD5862R018' .
*      wa_final-sellerdtls-lglnm    =  'RAJASTHAN BARYTES LTD' .
*      wa_final-sellerdtls-trdnm    =  'RAJASTHAN BARYTES LTD' .
*      wa_final-sellerdtls-addr1    =  'Ostwal Bhilwara' .
*      wa_final-sellerdtls-addr2    =  ' ' .
*      wa_final-sellerdtls-loc      =  'Near R. K. Circle' .
*      wa_final-sellerdtls-pin      =  '313001' .
*      wa_final-sellerdtls-stcd     =  '08' .

    ELSE.
      wa_final-sellerdtls-gstin    =  sellerplantaddress-gstin.
    ENDIF.
    wa_final-sellerdtls-lglnm    =  sellerplantaddress-lglnm.
    wa_final-sellerdtls-trdnm    =  sellerplantaddress-lglnm.
    wa_final-sellerdtls-addr1    =  sellerplantaddress-addr1.
    wa_final-sellerdtls-addr2    =  sellerplantaddress-addr2 .
    wa_final-sellerdtls-loc      =  sellerplantaddress-city .
    wa_final-sellerdtls-stcd     =  sellerplantaddress-stcd.
    wa_final-sellerdtls-pin      =  sellerplantaddress-pin.


    REPLACE ALL OCCURRENCES OF ',' IN wa_final-sellerdtls-addr1 WITH ' ' .
    REPLACE ALL OCCURRENCES OF '’' IN wa_final-sellerdtls-addr1 WITH ' ' .
    REPLACE ALL OCCURRENCES OF ',' IN wa_final-sellerdtls-addr2 WITH ' ' .
    REPLACE ALL OCCURRENCES OF '’' IN wa_final-sellerdtls-addr2 WITH ' ' .


    wa_final-dispdtls-nm       =  sellerplantaddress-lglnm.
    wa_final-dispdtls-addr1    =  sellerplantaddress-addr1.
    wa_final-dispdtls-addr2    =  sellerplantaddress-addr2.
    wa_final-dispdtls-loc      =  sellerplantaddress-city.
    wa_final-dispdtls-stcd     =  sellerplantaddress-stcd.
    wa_final-dispdtls-pin      =  sellerplantaddress-pin.
    REPLACE ALL OCCURRENCES OF ',' IN wa_final-dispdtls-addr1 WITH ' ' .
    REPLACE ALL OCCURRENCES OF '’' IN wa_final-dispdtls-addr1 WITH ' ' .
    REPLACE ALL OCCURRENCES OF ',' IN wa_final-dispdtls-addr2 WITH ' ' .
    REPLACE ALL OCCURRENCES OF '’' IN wa_final-dispdtls-addr2 WITH ' ' .

    IF buyeradd-b-country EQ 'IN' .
      wa_final-buyerdtls-gstin = buyeradd-b-taxnumber3.
      wa_final-buyerdtls-lglnm = buyeradd-b-customername.
      wa_final-buyerdtls-trdnm = buyeradd-b-customername.
      wa_final-buyerdtls-addr1 = buyeradd-b-customerfullname.
      wa_final-buyerdtls-addr2 = ''.
      wa_final-buyerdtls-loc   = buyeradd-b-cityname .
      wa_final-buyerdtls-pin   = buyeradd-b-postalcode  .
      wa_final-buyerdtls-stcd  = buyeradd-b-region  .
*    ELSE .
*      wa_final-buyerdtls-gstin = 'URP'.
*      wa_final-buyerdtls-lglnm = buyeradd-b-customername.
*      wa_final-buyerdtls-trdnm = buyeradd-b-customername.
*      wa_final-buyerdtls-addr1 = buyeradd-b-customerfullname.
*      wa_final-buyerdtls-addr2 = ''.
*      wa_final-buyerdtls-loc   = buyeradd-b-cityname .
*      wa_final-buyerdtls-pin   = '999999'  .
*      wa_final-buyerdtls-stcd  = '96' .
    ENDIF .
    REPLACE ALL OCCURRENCES OF ',' IN wa_final-buyerdtls-addr1 WITH ' ' .
    REPLACE ALL OCCURRENCES OF '’' IN wa_final-buyerdtls-addr1 WITH ' ' .
    REPLACE ALL OCCURRENCES OF ',' IN wa_final-buyerdtls-addr2 WITH ' ' .
    REPLACE ALL OCCURRENCES OF '’' IN wa_final-buyerdtls-addr2 WITH ' ' .



*    wa_final-expshipdtls-lglnm    = 'Hellas asdasd asdasdasd'.
*    wa_final-expshipdtls-addr1    = 'Bhilwara asddasdasd asdasdasd'.
*    wa_final-expshipdtls-loc      = plantaddress-a-city.
*    wa_final-expshipdtls-stcd     = plantaddress-a-regcode.
*    wa_final-expshipdtls-pin      = plantaddress-a-post.

    LOOP AT  billing_item INTO DATA(bill_item) .

      SELECT SINGLE conditionbaseamount FROM i_billingdocumentitemprcgelmnt WHERE billingdocument = @bill_item-billingdocument
                                          AND billingdocumentitem = @bill_item-billingdocumentitem AND
      conditionbaseamount IS NOT INITIAL AND  conditiontype IN ( 'JOIG' ,'JOCG' ,'JOSG' ) INTO @DATA(baseamount)  .

      wa_itemlist-prodname    =  bill_item-product .
      wa_itemlist-proddesc    =  bill_item-billingdocumentitemtext .

      SELECT SINGLE * FROM i_productplantbasic AS a LEFT JOIN i_product AS b ON ( a~product = b~product )
       WHERE a~product = @bill_item-material AND a~plant = @bill_item-plant  INTO @DATA(hsnsac).

      IF hsnsac-b-producttype = 'SERV'.
        wa_itemlist-hsncd      =  hsnsac-a-consumptiontaxctrlcode .
      ELSE.
        wa_itemlist-hsncd      =  hsnsac-a-consumptiontaxctrlcode .
      ENDIF.
      wa_itemlist-qty        =  bill_item-billingquantity .
      IF bill_item-billingquantityunit           = 'TO' .
        wa_itemlist-unit       =  'TON' .
      ELSEIF bill_item-billingquantityunit      = 'MTR' .
        wa_itemlist-unit       =  'MTR' .
      ELSEIF bill_item-billingquantityunit     = 'KG' .
        wa_itemlist-unit       =  'KGS' .
      ELSEIF bill_item-billingquantityunit+0(3) = 'BAG' .
        wa_itemlist-unit       =  'BAGS'.
      ELSE .
        wa_itemlist-unit        =  'OTH'.
      ENDIF .

      DATA:unitprice TYPE yinv_stu-igstamt,
           totamt    TYPE yinv_stu-igstamt.


      """""""""""""""""""""BASIC PRICE""""""""""""""""""""""""""
      READ TABLE b_item INTO DATA(zbasic) WITH KEY a-conditiontype = 'ZTIV' a-billingdocumentitem = bill_item-billingdocumentitem .
      IF sy-subrc = 0.
        totamt     = zbasic-a-conditionamount.
      ENDIF .

*      READ TABLE b_item INTO DATA(zbasic) WITH KEY a-conditiontype = 'ZR00' a-billingdocumentitem = bill_item-billingdocumentitem .
*      unitprice  =  zbasic-a-conditionratevalue * bill_head-accountingexchangerate   .
*      IF  baseamount IS NOT INITIAL .
*        totamt     =  baseamount  * bill_head-accountingexchangerate     .
*      ELSE.
*        totamt     = zbasic-a-conditionamount   * bill_head-accountingexchangerate   .
*      ENDIF .
*
*      READ TABLE b_item INTO zbasic WITH KEY a-conditiontype = 'ZR01' a-billingdocumentitem = bill_item-billingdocumentitem .
*      unitprice  =  zbasic-a-conditionratevalue * bill_head-accountingexchangerate   .
*      IF  baseamount IS NOT INITIAL .
*        totamt     =  baseamount  * bill_head-accountingexchangerate     .
*      ELSE.
*        totamt     = zbasic-a-conditionamount   * bill_head-accountingexchangerate   .
*      ENDIF .
*
*      IF  bill_head-distributionchannel = '20' .
*        bill_head-accountingexchangerate = bill_head-accountingexchangerate * 100.
*        unitprice  =  zbasic-a-conditionratevalue * bill_head-accountingexchangerate   .
*      ENDIF.
*
*
*      READ TABLE b_item INTO zbasic WITH KEY a-conditiontype = 'ZSCP' a-billingdocumentitem = bill_item-billingdocumentitem .
*      unitprice  =  zbasic-a-conditionratevalue * bill_head-accountingexchangerate   .
*      IF  baseamount IS NOT INITIAL .
*        totamt     =  baseamount  * bill_head-accountingexchangerate     .
*      ELSE.
*        totamt     = zbasic-a-conditionamount   * bill_head-accountingexchangerate   .
*      ENDIF .
*
*      READ TABLE b_item INTO zbasic WITH KEY a-conditiontype = 'ZST1' a-billingdocumentitem = bill_item-billingdocumentitem .
*      unitprice  =  zbasic-a-conditionratevalue * bill_head-accountingexchangerate   .
*      IF  baseamount IS NOT INITIAL .
*        totamt     =  baseamount  * bill_head-accountingexchangerate     .
*      ELSE.
*        totamt     = zbasic-a-conditionamount   * bill_head-accountingexchangerate   .
*      ENDIF .

      """"""""""""""""""""""""""""""""""""""discount"""""""""""""""""""""""""""""""""""""
      SELECT SUM( conditionamount )    FROM i_billingdocumentitemprcgelmnt
       WHERE   conditiontype IN ( 'ZDPQ','ZDPR', 'ZDFA' )
       AND billingdocument = @bill_item-billingdocument AND billingdocumentitem = @bill_item-billingdocumentitem
        INTO @DATA(discount) .

*      SELECT SUM( conditionamount )    FROM i_billingdocumentitemprcgelmnt
*       WHERE   conditiontype IN ( 'ZPFW','ZINS', 'ZLOD','JTC1','JTC2','ZFC','ZFRE' ,'ZFPQ','ZFCP' )
*       AND billingdocument = @bill_item-billingdocument AND billingdocumentitem = @bill_item-billingdocumentitem
*        INTO @DATA(otchg) .

      wa_itemlist-assamt       = totamt .
      wa_itemlist-cesnonadvamt = '0'.

      """""""""""""""""""""""""""""""""""""""""""""""TAX DATA*******************************
      READ TABLE b_item INTO DATA(zbasicigst) WITH KEY a-conditiontype = 'JOIG'  a-billingdocumentitem = bill_item-billingdocumentitem .
      IF sy-subrc EQ 0 .

        wa_itemlist-igstrt      =  zbasicigst-a-conditionrateratio .
        wa_itemlist-igstamt    =  zbasicigst-a-conditionamount ."  * bill_head-accountingexchangerate   .

      ELSE.

        READ TABLE b_item INTO DATA(zbasicgst) WITH KEY a-conditiontype = 'JOCG'  a-billingdocumentitem = bill_item-billingdocumentitem .
        wa_itemlist-cgstrt      =  zbasicgst-a-conditionrateratio." * 2.
        wa_itemlist-cgstamt    =  zbasicgst-a-conditionamount ." * bill_head-accountingexchangerate   .

        READ TABLE b_item INTO DATA(zbasisgst) WITH KEY a-conditiontype = 'JOSG'   a-billingdocumentitem = bill_item-billingdocumentitem .
        wa_itemlist-sgstrt     =  zbasisgst-a-conditionrateratio .
        wa_itemlist-sgstamt    =  zbasisgst-a-conditionamount ."* bill_head-accountingexchangerate .

      ENDIF .
*
      READ TABLE b_item INTO DATA(tcs) WITH KEY a-conditiontype = 'JTC1'  a-billingdocumentitem = bill_item-billingdocumentitem .
      IF sy-subrc EQ 0 .
        DATA(tcsamt) = tcs-a-conditionamount .
      ENDIF.

      wa_itemlist-othchrg              = '0'."otchg  * bill_head-accountingexchangerate .
      wa_final-totalassessableamount   = wa_final-totalassessableamount  + wa_itemlist-assamt  .
      wa_final-totaligstamount         = wa_final-totaligstamount + wa_itemlist-igstamt .
      wa_final-totalsgstamount         = wa_final-totalsgstamount + wa_itemlist-sgstamt .
      wa_final-totalcgstamount         = wa_final-totalcgstamount + wa_itemlist-cgstamt .
      wa_final-otheramount             = '0'."wa_final-otheramount + wa_itemlist-othchrg.
      wa_final-othertcsamount          = wa_final-othertcsamount + tcsamt .
      wa_final-totalinvoiceamount      = wa_final-totalinvoiceamount + wa_itemlist-assamt +
                                         wa_itemlist-igstamt + wa_itemlist-cgstamt +
                                         wa_itemlist-sgstamt + wa_itemlist-othchrg + tcsamt.



      IF wa_itemlist-cgstrt IS INITIAL.
        wa_itemlist-cgstrt = '0'.
      ENDIF.
      IF wa_itemlist-cgstamt IS INITIAL.
        wa_itemlist-cgstamt = '0'.
      ENDIF.
      IF wa_itemlist-sgstrt IS INITIAL.
        wa_itemlist-sgstrt = '0'.
      ENDIF.
      IF wa_itemlist-sgstamt IS INITIAL.
        wa_itemlist-sgstamt = '0'.
      ENDIF.
      IF wa_itemlist-igstrt IS INITIAL.
        wa_itemlist-igstrt = '0'.
      ENDIF.
      IF wa_itemlist-igstamt IS INITIAL.
        wa_itemlist-igstamt = '0'.
      ENDIF.
      IF wa_itemlist-cesrt IS INITIAL.
        wa_itemlist-cesrt = '0'.
      ENDIF.
      IF wa_itemlist-cesamt IS INITIAL.
        wa_itemlist-cesamt = '0'.
      ENDIF.
      IF wa_itemlist-othchrg IS INITIAL.
        wa_itemlist-othchrg = '0'.
      ENDIF.
      IF wa_itemlist-cesnonadvamt IS INITIAL.
        wa_itemlist-cesnonadvamt = '0'.
      ENDIF.

      APPEND wa_itemlist TO itemlist .
      CLEAR :  wa_itemlist ,tcsamt,discount,unitprice ,totamt.

    ENDLOOP .

    IF wa_final-totalinvoiceamount IS INITIAL.
      wa_final-totalinvoiceamount = '0'.
    ENDIF.
    IF wa_final-totalcgstamount IS INITIAL.
      wa_final-totalcgstamount = '0'.
    ENDIF.
    IF wa_final-totalsgstamount IS INITIAL.
      wa_final-totalsgstamount = '0'.
    ENDIF.
    IF wa_final-totaligstamount IS INITIAL.
      wa_final-totaligstamount = '0'.
    ENDIF.
    IF wa_final-totalcessamount IS INITIAL.
      wa_final-totalcessamount = '0'.
    ENDIF.
    IF wa_final-totalcessnonadvolamount IS INITIAL.
      wa_final-totalcessnonadvolamount = '0'.
    ENDIF.
    IF wa_final-totalassessableamount IS INITIAL.
      wa_final-totalassessableamount = '0'.
    ENDIF.
    IF wa_final-otheramount IS INITIAL.
      wa_final-otheramount = '0'.
    ENDIF.
    IF wa_final-othertcsamount IS INITIAL.
      wa_final-othertcsamount = '0'.
    ENDIF.

    wa_final-itemlist   = itemlist .
    wa_final-distance   = distance        .
    wa_final-transname  = transpoter_name .
    wa_final-transid    = transportid     .
    wa_final-transdocno = 'TEST-123' ."transportdoc    .
    wa_final-transdocdt = wa_final-documentdate    .
    wa_final-vehno      = vehiclenumber   ..
    wa_final-vehtype    = 'R'   .

    SELECT SINGLE b~shippingtype
    FROM i_billingdocumentitem AS a
    INNER JOIN i_deliverydocument AS b ON ( b~deliverydocument = a~referencesddocument )
    WHERE a~billingdocument =  @vbeln
    INTO @DATA(shippingtype).

    CASE shippingtype.
      WHEN '01'.
        wa_final-transmode   = '1'   .
      WHEN '03'.
        wa_final-transmode   = '2'   .
      WHEN '04'.
        wa_final-transmode   = '4'   .
      WHEN '05'.
        wa_final-transmode   = '3'   .
    ENDCASE.

*    wa_final-transmode  = '1'   .
    APPEND wa_final TO it_final.

*=========================  Json Converter ==============================


    DATA:json TYPE REF TO if_xco_cp_json_data.

    xco_cp_json=>data->from_abap(
      EXPORTING
        ia_abap      = wa_final
      RECEIVING
        ro_json_data = json   ).
    json->to_string(
      RECEIVING
        rv_string =   DATA(lv_string) ).

    REPLACE ALL OCCURRENCES OF 'DOCUMENTNUMBER'           IN lv_string WITH 'DocumentNumber'.
    REPLACE ALL OCCURRENCES OF 'DOCUMENTTYPE'             IN lv_string WITH 'DocumentType'.
    REPLACE ALL OCCURRENCES OF 'DOCUMENTDATE'             IN lv_string WITH 'DocumentDate'.
    REPLACE ALL OCCURRENCES OF 'SUPPLYTYPE'               IN lv_string WITH 'SupplyType'.
    REPLACE ALL OCCURRENCES OF 'SUBSUPPLYTYPE'            IN lv_string WITH 'SubSupplyType'.
    REPLACE ALL OCCURRENCES OF 'SUBSupplyType'            IN lv_string WITH 'SubSupplyType'.
    REPLACE ALL OCCURRENCES OF 'SUBSUPPLYTYPEDESC'        IN lv_string WITH 'SubSupplyTypeDesc'.
    REPLACE ALL OCCURRENCES OF 'SubSupplyTypeDESC'        IN lv_string WITH 'SubSupplyTypeDesc'.
    REPLACE ALL OCCURRENCES OF 'TRANSACTIONTYPE'          IN lv_string WITH 'TransactionType'.
    REPLACE ALL OCCURRENCES OF 'BUYERDTLS'                IN lv_string WITH 'BuyerDtls'.
    REPLACE ALL OCCURRENCES OF 'GSTIN'                    IN lv_string WITH 'Gstin'.
    REPLACE ALL OCCURRENCES OF 'LGLNM'                    IN lv_string WITH 'LglNm'.
    REPLACE ALL OCCURRENCES OF 'TRDNM'                    IN lv_string WITH 'TrdNm'.
    REPLACE ALL OCCURRENCES OF 'ADDR1'                    IN lv_string WITH 'Addr1'.
    REPLACE ALL OCCURRENCES OF 'ADDR2'                    IN lv_string WITH 'Addr2'.
    REPLACE ALL OCCURRENCES OF 'LOC'                      IN lv_string WITH 'Loc'.
    REPLACE ALL OCCURRENCES OF 'PIN'                      IN lv_string WITH 'Pin'.
    REPLACE ALL OCCURRENCES OF 'STCD'                     IN lv_string WITH 'Stcd'.
    REPLACE ALL OCCURRENCES OF 'SELLERDTLS'               IN lv_string WITH 'SellerDtls'.
    REPLACE ALL OCCURRENCES OF 'GSTIN'                    IN lv_string WITH 'Gstin'.
    REPLACE ALL OCCURRENCES OF 'LGLNM'                    IN lv_string WITH 'LglNm'.
    REPLACE ALL OCCURRENCES OF 'TRDNM'                    IN lv_string WITH 'TrdNm'.
    REPLACE ALL OCCURRENCES OF 'ADDR1'                    IN lv_string WITH 'Addr1'.
    REPLACE ALL OCCURRENCES OF 'ADDR2'                    IN lv_string WITH 'Addr2'.
    REPLACE ALL OCCURRENCES OF 'LOC'                      IN lv_string WITH 'Loc'.
    REPLACE ALL OCCURRENCES OF 'PIN'                      IN lv_string WITH 'Pin'.
    REPLACE ALL OCCURRENCES OF 'STCD'                     IN lv_string WITH 'Stcd'.
    REPLACE ALL OCCURRENCES OF 'EXPSHIPDTLS'              IN lv_string WITH 'ExpShipDtls'.
    REPLACE ALL OCCURRENCES OF 'LGLNM'                    IN lv_string WITH 'LglNm'.
    REPLACE ALL OCCURRENCES OF 'ADDR1'                    IN lv_string WITH 'Addr1'.
    REPLACE ALL OCCURRENCES OF 'LOC'                      IN lv_string WITH 'Loc'.
    REPLACE ALL OCCURRENCES OF 'PIN'                      IN lv_string WITH 'Pin'.
    REPLACE ALL OCCURRENCES OF 'STCD'                     IN lv_string WITH 'Stcd'.
    REPLACE ALL OCCURRENCES OF 'DISPDTLS'                 IN lv_string WITH 'DispDtls'.
    REPLACE ALL OCCURRENCES OF 'NM'                       IN lv_string WITH 'Nm'.
    REPLACE ALL OCCURRENCES OF 'ADDR1'                    IN lv_string WITH 'Addr1'.
    REPLACE ALL OCCURRENCES OF 'ADDR2'                    IN lv_string WITH 'Addr2'.
    REPLACE ALL OCCURRENCES OF 'LOC'                      IN lv_string WITH 'Loc'.
    REPLACE ALL OCCURRENCES OF 'PIN'                      IN lv_string WITH 'Pin'.
    REPLACE ALL OCCURRENCES OF 'STCD'                     IN lv_string WITH 'Stcd'.
    REPLACE ALL OCCURRENCES OF 'ITEMLIST'                 IN lv_string WITH 'ItemList'.


    REPLACE ALL OCCURRENCES OF 'PRODNAME'                IN lv_string WITH 'ProdName'.
    REPLACE ALL OCCURRENCES OF 'PRODDESC'                IN lv_string WITH 'ProdDesc'.
    REPLACE ALL OCCURRENCES OF 'HSNCD'                   IN lv_string WITH 'HsnCd'.
    REPLACE ALL OCCURRENCES OF 'QTY'                     IN lv_string WITH 'Qty'.
    REPLACE ALL OCCURRENCES OF 'UNIT'                    IN lv_string WITH 'Unit'.
    REPLACE ALL OCCURRENCES OF 'ASSAMT'                  IN lv_string WITH 'AssAmt'.
    REPLACE ALL OCCURRENCES OF 'CGSTRT'                  IN lv_string WITH 'CgstRt'.
    REPLACE ALL OCCURRENCES OF 'CGSTAMT'                 IN lv_string WITH 'CgstAmt'.
    REPLACE ALL OCCURRENCES OF 'SGSTRT'                  IN lv_string WITH 'SgstRt'.
    REPLACE ALL OCCURRENCES OF 'SGSTAMT'                 IN lv_string WITH 'SgstAmt'.
    REPLACE ALL OCCURRENCES OF 'IGSTRT'                  IN lv_string WITH 'IgstRt'.
    REPLACE ALL OCCURRENCES OF 'IGSTAMT'                 IN lv_string WITH 'IgstAmt'.
    REPLACE ALL OCCURRENCES OF 'CESRT'                   IN lv_string WITH 'CesRt'.
    REPLACE ALL OCCURRENCES OF 'CESAMT'                  IN lv_string WITH 'CesAmt'.
    REPLACE ALL OCCURRENCES OF 'OTHCHRG'                 IN lv_string WITH 'OthChrg'.
    REPLACE ALL OCCURRENCES OF 'CESNONADVAMT'            IN lv_string WITH 'CesNonAdvAmt'.
    REPLACE ALL OCCURRENCES OF 'TOTALINVOICEAMOUNT'      IN lv_string WITH 'TotalInvoiceAmount'.
    REPLACE ALL OCCURRENCES OF 'TOTALCGSTAMOUNT'         IN lv_string WITH 'TotalCgstAmount'.
    REPLACE ALL OCCURRENCES OF 'TOTALSGSTAMOUNT'         IN lv_string WITH 'TotalSgstAmount'.
    REPLACE ALL OCCURRENCES OF 'TOTALIGSTAMOUNT'         IN lv_string WITH 'TotalIgstAmount'.
    REPLACE ALL OCCURRENCES OF 'TOTALCESSAMOUNT'         IN lv_string WITH 'TotalCessAmount'.
    REPLACE ALL OCCURRENCES OF 'TOTALCESSNONADVOLAMOUNT' IN lv_string WITH 'TotalCessNonAdvolAmount'.
    REPLACE ALL OCCURRENCES OF 'TOTALASSESSABLEAMOUNT'   IN lv_string WITH 'TotalAssessableAmount'.
    REPLACE ALL OCCURRENCES OF 'OTHERAMOUNT'             IN lv_string WITH 'OtherAmount'.
    REPLACE ALL OCCURRENCES OF 'OTHERTCSAMOUNT'          IN lv_string WITH 'OtherTcsAmount'.
    REPLACE ALL OCCURRENCES OF 'TRANSID'                 IN lv_string WITH 'TransId'.
    REPLACE ALL OCCURRENCES OF 'TRANSNAME'               IN lv_string WITH 'TransName'.
    REPLACE ALL OCCURRENCES OF 'TRANSMODE'               IN lv_string WITH 'TransMode'.
    REPLACE ALL OCCURRENCES OF 'DISTANCE'                IN lv_string WITH 'Distance'.
    REPLACE ALL OCCURRENCES OF 'TRANSDOCNO'              IN lv_string WITH 'TransDocNo'.
    REPLACE ALL OCCURRENCES OF 'TRANSDOCDT'              IN lv_string WITH 'TransDocDt'.
    REPLACE ALL OCCURRENCES OF 'VEHNO'                   IN lv_string WITH 'VehNo'.
    REPLACE ALL OCCURRENCES OF 'VEHTYPE'                 IN lv_string WITH 'VehType'.



    REPLACE ALL OCCURRENCES OF '**' IN lv_string WITH '*'.
    REPLACE ALL OCCURRENCES OF '"Distance": 0.0,' IN lv_string WITH '"Distance": 0,'.
    REPLACE ALL OCCURRENCES OF '0.0' IN lv_string WITH '0'.
    REPLACE ALL OCCURRENCES OF '""' IN lv_string WITH 'null'.
    REPLACE ALL OCCURRENCES OF '111111' IN lv_string WITH 'null'.
    REPLACE ALL OCCURRENCES OF '*' IN lv_string WITH ''.


        DATA ewaylink TYPE string .

  IF SY-SYSID = 'Z6L'.
   SELECT SINGLE PLANT  FROM I_BillingDocumentItem WHERE BillingDocument = @vbeln INTO @DATA(plant).
    SELECT SINGLE * FROM zirn_credentials WHERE PLANT = @PLANT INTO @DATA(credentials)  .
  ENDIF.

    IF credentials IS INITIAL .
      ewaylink  = 'https://gsp.adaequare.com/test/enriched/ei/api/ewaybill'  .
    ELSE .
      ewaylink  = 'https://gsp.adaequare.com/enriched/ei/api/ewaybill'  .
    ENDIF .

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    data ejson type string.

    DATA:uuid TYPE string.
    uuid = cl_system_uuid=>create_uuid_x16_static(  ).

    DATA(url) = |{ ewaylink }|.
    DATA(client) = create_client( url ).
    DATA(req) = client->get_http_request(  ).
    IF credentials IS INITIAL .
      req->set_header_field( i_name = 'user_name' i_value =  'Adeq_KA_08'  ).
      req->set_header_field( i_name = 'password' i_value = 'Gsp@1234' ).
      req->set_header_field( i_name = 'gstin'    i_value = '08AABCK0452C1Z3' ).
    ELSE.
      req->set_header_field( i_name = 'user_name' i_value =  |{ credentials-id }|  ).
      req->set_header_field( i_name = 'password' i_value = |{ credentials-password }| ).
      req->set_header_field( i_name = 'gstin'    i_value = |{ credentials-gstin }| ).
    ENDIF.
    req->set_header_field( i_name = 'requestid' i_value = uuid ).
    CONCATENATE 'Bearer'  token INTO access_token SEPARATED BY space.

    req->set_header_field( i_name = 'Authorization' i_value = access_token ).
    req->set_content_type( 'application/json' ).

    req->set_text( ejson ) .
    DATA: result9 TYPE string.
    result9 = client->execute( if_web_http_client=>post )->get_text( ).

    client->close(  )  .




*  ELSE.

    """""""""""""""""""""PLANT Wise Credentials""""""""""""""""""""""""""""""""""""""""

*      uuid = cl_system_uuid=>create_uuid_x16_static(  ).
*      url = |{ ewaylink }|.
*      client = ztoken_authentication=>create_client( url ).
*      req = client->get_http_request(  ).
*      req->set_header_field( i_name = 'user_id' i_value =  user_name  ).
*      req->set_header_field( i_name = 'password' i_value = password ).
*      req->set_header_field( i_name = 'gstin'    i_value = gstin_d  ).
*      req->set_header_field( i_name = 'X-Cleartax-Auth-Token'    i_value = '1.d67b4ae4-cd4f-4ad4-8a43-ea4ca9b12f57_35c4ac47984eaeea82d6fb8295f352ffff73b994ff65846179ab46edb7857833' ).
*      req->set_header_field( i_name = 'requestid' i_value = uuid ).
*      CONCATENATE 'X-Cleartax-Auth-Token'  token INTO access_token SEPARATED BY space.
*
*      req->set_header_field( i_name = 'Authorization' i_value = access_token ).
*      req->set_content_type( 'application/json' ).
*
*      req->set_text( lv_string ) .
*      result = client->execute( if_web_http_client=>post )->get_text( ).
*      client->close(  )  .
*
*    ENDIF.



    DATA(lr_d1) = /ui2/cl_json=>generate( json = result9 ).
    IF lr_d1 IS BOUND.
      ASSIGN lr_d1->* TO <datax>.
      IF sy-subrc = 0 .
        ASSIGN COMPONENT 'error_message' OF STRUCTURE <datax> TO FIELD-SYMBOL(<error_msg1>).
        IF <error_msg1> IS ASSIGNED.
          error_msg_part1 = <error_msg1>->*.
        ELSE.
          ASSIGN COMPONENT `GOVT_RESPONSE` OF STRUCTURE <datax> TO <field>    .
        ENDIF.

        IF <field> IS ASSIGNED.
          ASSIGN <field>->* TO <data2>  .
          IF sy-subrc = 0 .

*            ASSIGN COMPONENT `Irn` OF STRUCTURE <data2>  TO   <field_irn>    .
*            ASSIGN <field_irn>->* TO <field_irn> .
*            IF <field_irn> IS ASSIGNED.
*              irn = <field_irn> .
*            ENDIF.

            ASSIGN COMPONENT `EwbNo` OF STRUCTURE <data2>  TO   <field_ewbno>     .
            IF sy-subrc = 0.
              ASSIGN  <field_ewbno>->* TO  <field_ewbno>  .
              w_ewaybill-ewbno  = <field_ewbno> .
            ENDIF.

            ASSIGN COMPONENT `EwbDt` OF STRUCTURE <data2>  TO   <field_ewbdt>     .
            IF sy-subrc = 0.
              ASSIGN  <field_ewbdt>->* TO  <field_ewbdt>  .
              w_ewaybill-ewbdt  = <field_ewbdt> .
            ENDIF.

            ASSIGN COMPONENT `status` OF STRUCTURE <data2>  TO   <field_status>     .
            IF sy-subrc = 0.
              ASSIGN  <field_status>->* TO  <field_status>  .
              w_ewaybill-status2  = <field_status> .
            ENDIF.

            ASSIGN COMPONENT `Success` OF STRUCTURE <data2>  TO   <field_success>     .
            IF sy-subrc = 0.
              ASSIGN  <field_success>->* TO  <field_success>  .
              w_ewaybill-success  = <field_success> .
            ENDIF.


*            ASSIGN COMPONENT `EwbNumber` OF STRUCTURE <data2>  TO  FIELD-SYMBOL(<field_ewbnumber>)    .
*            IF <field_ewbnumber>->* IS ASSIGNED.
*              ASSIGN <field_ewbnumber>->* TO <field_ewbnumber>   .
*              i_eway-ewbnumber = <field_ewbnumber> .
*            ENDIF.

*            ASSIGN COMPONENT `UpdatedDate` OF STRUCTURE <data2>  TO FIELD-SYMBOL(<field_updateddate>)    .
*            IF <field_updateddate>->* IS ASSIGNED.
*              ASSIGN <field_updateddate>->* TO <field_updateddate> .
*              i_eway-updateddate = <field_updateddate> .
*            ENDIF.

            ASSIGN COMPONENT `ewbvalidtill` OF STRUCTURE <data2>  TO FIELD-SYMBOL(<field_validupto>)   .
            IF sy-subrc = 0.
              ASSIGN <field_validupto>->* TO <field_validupto> .
              i_eway-validupto = <field_validupto> .
            ENDIF.

            ASSIGN COMPONENT `alert` OF STRUCTURE <data2>  TO  FIELD-SYMBOL(<km>)     .
            IF sy-subrc = 0.
              IF <km> IS BOUND.
                w_ewaybill-km = reverse( <km>->* ).
                SPLIT w_ewaybill-km+1(*) AT '' INTO w_ewaybill-km DATA(other).
                w_ewaybill-km = w_ewaybill-km+1(*).
                w_ewaybill-km = reverse( w_ewaybill-km ).
              ENDIF.
            ENDIF.
          ENDIF.

        ENDIF .
      ENDIF.

      """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
      DATA respo  TYPE yewayrescoll .
      DATA ewaybilldata TYPE yj1ig_ewaybill .

      IF w_ewaybill-ewbno IS NOT INITIAL.
        SELECT SINGLE sddocumentcategory, companycode FROM i_billingdocumentbasic
              WHERE billingdocument = @vbeln  INTO (@DATA(bill_typ),@DATA(comp) )   .


        ewaybilldata-bukrs       =  comp.
        ewaybilldata-doctyp      =  wa_final-documenttype.
        ewaybilldata-docno       =  vbeln  .
        ewaybilldata-gjahr       =  sy-datum+0(4)  .
        ewaybilldata-ebillno     =  w_ewaybill-ewbno .
        ewaybilldata-egen_dat    =  sy-datum .
        ewaybilldata-status      =  'ACT'   .
        ewaybilldata-vehiclenum  =  vehiclenumber .
        ewaybilldata-distance    =  distance .
        ewaybilldata-vdtodate    = w_ewaybill-ewbvalidtill .
*        ewaybilldata-km          = w_ewaybill-km .

        MODIFY yj1ig_ewaybill FROM @ewaybilldata  .
        COMMIT WORK AND WAIT.




*        IF i_eway-ewbnumber IS NOT INITIAL.
*          ewaypartb-docno       = billingdocument .
*          ewaypartb-ewbnumber   = i_eway-ewbnumber.
*          ewaypartb-updateddate = i_eway-updateddate.
*          ewaypartb-validupto   = i_eway-validupto.
*        ENDIF.
*
*        IF   i_eway-ewbnumber = w_ewaybill-ewbno .
*          MODIFY zeway_part_b FROM @ewaypartb  .
*          COMMIT WORK AND WAIT.
*        ENDIF.
        """"""""""""""""""""""""""""""""""""""""""""""EWAY PART TWO,,,,end""""""""""""""""""""""""""""""""""
*        status = |EWAY Bill No.-{ ewaypartb-ewbnumber } Generated .|.
*        IF error_msg_part2 IS NOT INITIAL.
*          status = |{ status } EWAY Bill Part 2 Error :- { error_msg_part2 }|.
*        ENDIF.
      ELSE .

      ENDIF  .

    ENDIF.

    IF i_eway-ewbnumber IS NOT INITIAL.
      status = |EWAY Bill No.-{ i_eway-ewbnumber } Generated .|.
    ELSEIF error_msg_part1 IS NOT INITIAL.
      status = |EWAY Bill -{ error_msg_part1 } |.
    ELSE.
      status = |EWAY Bill -{ result9 } |.
    ENDIF.

  ENDMETHOD.


    METHOD generate_authentication_token.
    SELECT SINGLE PLANT  FROM I_BillingDocumentItem WHERE BillingDocument = @billingdocument  INTO @DATA(plant).
    SELECT SINGLE * FROM zirn_credentials WHERE PLANT = @PLANT INTO @DATA(credentials)  .

    DATA gsp_url TYPE string VALUE 'https://gsp.adaequare.com/gsp/authenticate?action=GSP&grant_type=token' .
    DATA(url) = |{ gsp_url }|.
    DATA(client) = create_client( url ).
    DATA(req) = client->get_http_request(  ).
    IF credentials IS INITIAL .
      req->set_header_field( i_name = 'GSPAPPID' i_value = '3002C9D13D6D47128D08F3DE2211AAE2' ).
      req->set_header_field( i_name = 'GSPAPPSECRET' i_value = '0ACA16FEG3C2FG4FDFGA8F1G6A831E6ADF34' ).
    ELSE .
      req->set_header_field( i_name = 'GSPAPPID' i_value = '1EB88850567B4547A8B3E2696BBB17D8' ).
      req->set_header_field( i_name = 'GSPAPPSECRET' i_value = 'DB36779DG6B94G4D95G8CD7G18321BDD6D54' ).

    ENDIF .

    DATA(response) = client->execute( if_web_http_client=>post )->get_text(  ).
    client->close(  ).

    REPLACE ALL OCCURRENCES OF '{"access_token":"' IN response WITH ''.
    SPLIT response AT '","token_type"' INTO DATA(l1) DATA(l2)  .
    access_token = l1 .

    auth_token = access_token .



  ENDMETHOD.
ENDCLASS.
