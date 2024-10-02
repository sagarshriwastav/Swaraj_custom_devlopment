CLASS zcheque_ssf DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
    CLASS-DATA : access_token TYPE string .
    CLASS-DATA : xml_file TYPE string .
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
        RAISING   cx_static_check,

      read_posts
        IMPORTING variable        TYPE string
                  housebank       TYPE string
                  accountpayee    TYPE string
                  chekbackside    TYPE string
                  self            TYPE string
                  rtgs            TYPE string
        RETURNING VALUE(result12) TYPE string
        RAISING   cx_static_check .
  PROTECTED SECTION.

  PRIVATE SECTION.
    CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
    CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
    CONSTANTS  lv2_url    TYPE string VALUE 'https://sagar.authentication.eu10.hana.ondemand.com/oauth/token'  .
    CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
*    CONSTANTS  lc_template_name TYPE string VALUE 'RTGS_SSF/RTGS_SSF'.
*    CONSTANTS  lc_template_name TYPE string VALUE 'BOB_RTGS_SSF/BOB_RTGS_SSF'.
ENDCLASS.



CLASS ZCHEQUE_SSF IMPLEMENTATION.


   METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).

ENDMETHOD.


  METHOD if_oo_adt_classrun~main.

    TRY.
DATA(return_data) = read_posts(  variable = '400003'  accountpayee = 'true'  chekbackside = '' self = ' ' rtgs = 'true' housebank = 'SBI01'  ) .
    ENDTRY.
  ENDMETHOD.


METHOD read_posts .

DATA lc_template_name TYPE string.

 SELECT SINGLE *  FROM ychequeprint_ WHERE outgoingcheque = @variable
    INTO @DATA(chequedata).

 SELECT SINGLE * FROM i_outgoingcheck WHERE outgoingcheque = @variable INTO @DATA(chequedata1) .

 SELECT SINGLE * FROM i_housebankaccountlinkage WHERE housebank = @chequedata-housebank INTO @DATA(bankacount).

 SELECT SINGLE * FROM I_OperationalAcctgDocItem WHERE accountingdocument = @chequedata1-PaymentDocument INTO @DATA(total).

 SELECT SINGLE * FROM I_OperationalAcctgDocItem WHERE accountingdocument = @chequedata1-PaymentDocument And glaccount = '4300100000' INTO @DATA(charges).

  SELECT SINGLE * FROM I_SuplrBankDetailsByIntId WHERE supplier = @chequedata-Supplier INTO @DATA(supplier).

  SELECT SINGLE * FROM I_Bank_2 WHERE bankcountry = @Supplier-BankCountry and BankInternalID = @supplier-Bank INTO @DATA(supplier1).


 DATA lv_xml TYPE string .
    DATA selfpynam TYPE string.
    DATA bank TYPE string.
    DATA branch TYPE STRING.
    data tot type string.
    data Bankname type string.

*    IF self = 'true'.
*      selfpynam = 'SELF'.
*    ELSEIF rtgs = 'true'.
*      selfpynam = 'Your Self RTGS'.
*    ELSE.
*      selfpynam = chequedata1-payeename.
*    ENDIF.
Bankname = housebank.

CONDENSE Bankname NO-GAPS.

    IF Bankname = 'SBI01'.
      lc_template_name = 'RTGS_SSF/RTGS_SSF'.
      CONCATENATE chequedata1-chequepaymentdate+6(2) chequedata1-chequepaymentdate+4(2) chequedata1-chequepaymentdate+0(4) INTO chequedata1-chequepaymentdate .
      IF chequedata1-housebank = 'SBI01'.
        chequedata1-BankName = 'STATE BANK OF INDIA'.
        bank = 'SBIN0001920'.
     ELSEIF chequedata1-housebank = 'SBI02'.
        chequedata1-BankName = 'STATE BANK OF INDIA'.
        bank = 'SBIN0010817'.
     ELSEIF  chequedata1-housebank = 'BOB01'.
        chequedata1-BankName = 'BANK OF BARODA'.
        bank = 'BARB0H0SHRD'.
     ELSEIF  chequedata1-housebank = 'PNB01'.
        chequedata1-BankName = 'PUNJAB NATIONAL BANK'.
        bank = 'PUNB0814200'.
      ELSEIF chequedata1-housebank = 'AXB01'.
        chequedata1-BankName = 'AXIS BANK LTD'.
        bank = 'UTIB0000044'.
   ENDIF.



tot = total-AmountInFunctionalCurrency + charges-AmountInFunctionalCurrency.

IF TOT  LT 0 .

tot = -1 * TOT .

ENDIF .



* CONCATENATE chequedata1-chequepaymentdate+6(2) chequedata1-chequepaymentdate+4(2) chequedata1-chequepaymentdate+0(4) INTO chequedata1-chequepaymentdate .
*CONCATENATE supplier-BankAccount+6(2) chequedata1-chequepaymentdate+4(2) chequedata1-chequepaymentdate+0(4) INTO chequedata1-chequepaymentdate .
lv_xml =
  |<form1>| &&
  |<DATE>{ chequedata1-chequepaymentdate+0(2) } / { chequedata1-chequepaymentdatE+2(2) } / { chequedata1-chequepaymentdate+4(4) }</DATE>| &&
  |<ACNAME>SAGAR MANUFACTURERS PVT. LTD.</ACNAME>| &&
  |<ACNO.>{ bankacount-BankAccount }</ACNO.>| &&
  |<CHEQUENO.>{ chequedata1-OutgoingCheque }</CHEQUENO.>| &&
  |<BEN.NAME>{ chequedata1-PayeeName }</BEN.NAME>| &&
  |<BEN.BANK>{ supplier1-BankName }</BEN.BANK>| &&
  |<BRANCH>{ supplier1-Branch }</BRANCH>| &&
  |<AMOUNTREMITTED>{ total-AmountInFunctionalCurrency }</AMOUNTREMITTED>| &&
  |<BANKCHARGES>{ charges-AmountInFunctionalCurrency }</BANKCHARGES>| &&
  |<TOTAL>{ tot }</TOTAL>| &&
  |<TOTALINWORDS>{ 8 }</TOTALINWORDS>| &&
  |<IFSCSubform1>| &&
      |<A>{ supplier1-BankInternalID+0(1) }</A>| &&
      |<B>{ supplier1-BankInternalID+1(1) }</B>| &&
      |<C>{ supplier1-BankInternalID+2(1) }</C>| &&
      |<D>{ supplier1-BankInternalID+3(1) }</D>| &&
      |<E>{ supplier1-BankInternalID+4(1) }</E>| &&
      |<F>{ supplier1-BankInternalID+5(1) }</F>| &&
      |<G>{ supplier1-BankInternalID+6(1) }</G>| &&
      |<H>{ supplier1-BankInternalID+7(1) }</H>| &&
      |<I>{ supplier1-BankInternalID+8(1) }</I>| &&
      |<J>{ supplier1-BankInternalID+9(1) }</J>| &&
      |<K>{ supplier1-BankInternalID+10(1) }</K>| &&
      |<L>{ supplier1-BankInternalID }</L>| &&
      |<M>{ supplier1-BankInternalID }</M>| &&
      |<N>{ supplier1-BankInternalID }</N>| &&
  |</IFSCSubform1>| &&
   |<Subform1>| &&
      |<A1>1</A1>| &&
      |<B1>{ supplier-BankAccount  }</B1>| &&
      |<C1>{ supplier-BankAccount  }</C1>| &&
      |<D1>{ 4 }</D1>| &&
      |<E1>{ 5 }</E1>| &&
      |<F1>{ 6 }</F1>| &&
      |<G1>{ 7 }</G1>| &&
      |<H1>{ 8 }</H1>| &&
      |<I1>{ 9 }</I1>| &&
      |<J1>{ 10 }</J1>| &&
      |<K1>{ 11 }</K1>| &&
      |<L>{ 12 }</L>|   &&
   |</Subform1>|   &&
   |<Amount>{ supplier-BankAccount  }</Amount>|   &&
 |</form1>|.



ELSEIF Bankname = 'BOB01'.
 lc_template_name = 'BOB_RTGS_SSF/BOB_RTGS_SSF'.
 CONCATENATE chequedata1-chequepaymentdate+6(2) chequedata1-chequepaymentdate+4(2) chequedata1-chequepaymentdate+0(4) INTO chequedata1-chequepaymentdate .
 tot = total-AmountInFunctionalCurrency + charges-AmountInFunctionalCurrency.

 IF TOT  LT 0 .

tot = -1 * TOT .

ENDIF .

  lv_xml =
  |<form1>| &&
   |<Subform1>| &&
      |<Branch>{ supplier1-Branch }</Branch>| &&
      |<Date>{ chequedata-ChequePaymentDate }</Date>| &&
      |<Date>{ chequedata-ChequePaymentDate }</Date>| &&
      |<Branch>{ supplier1-Branch }</Branch>| &&
   |</Subform1>| &&
   |<Table1>| &&
      |<Row1>| &&
         |<Senderacno>{ bankacount-BankAccount }</Senderacno>| &&
         |<Senderacno1>{ bankacount-BankAccount }</Senderacno1>| &&
      |</Row1>| &&
      |<Row2>| &&
         |<Nameacholder>Sagar Manufacturers Pvt. Ltd.</Nameacholder>| &&
         |<Nameacholder1>Sagar Manufacturers Pvt. Ltd.</Nameacholder1>| &&
      |</Row2>| &&
      |<Row3>| &&
         |<Payeename>{ chequedata1-PayeeName }</Payeename>| &&
         |<Bene.name>{ chequedata1-PayeeName }</Bene.name>| &&
      |</Row3>| &&
      |<Row4>| &&
         |<Bank>{ supplier1-BankName }</Bank>| &&
         |<Receivingbank>{ supplier1-BankName }</Receivingbank>| &&
      |</Row4>| &&
      |<Row5>| &&
         |<Branch>{ supplier1-BankBranch }</Branch>| &&
         |<Receivingbranch>{ supplier1-BankBranch }</Receivingbranch>| &&
      |</Row5>| &&
      |<Row6>| &&
         |<IFSC>{ supplier1-BankInternalID }</IFSC>| &&
         |<ReceivingIFSC>{ supplier1-BankInternalID }</ReceivingIFSC>| &&
      |</Row6>| &&
      |<Row7>| &&
         |<Bene.acno>{ supplier-BankAccount }</Bene.acno>| &&
         |<Subform2>| &&
            |<A></A>| &&
            |<B></B>| &&
            |<C></C>| &&
            |<D></D>| &&
            |<E></E>| &&
            |<F></F>| &&
            |<G></G>| &&
            |<H></H>| &&
            |<I></I>| &&
            |<J></J>| &&
            |<K></K>| &&
            |<L></L>| &&
            |<M></M>| &&
            |<N></N>| &&
            |<O></O>| &&
         |</Subform2>| &&
        |<Amount>{ supplier-BankAccount  }</Amount>|   &&
      |</Row7>| &&
      |<Row8>| &&
         |<Bene.actype></Bene.actype>| &&
         |<Bene.actype1></Bene.actype1>| &&
      |</Row8>| &&
      |<Row9>| &&
         |<Amount>{ total-AmountInFunctionalCurrency }</Amount>| &&
         |<Amount1>{ total-AmountInFunctionalCurrency }</Amount1>| &&
      |</Row9>| &&
      |<Row10>| &&
         |<Exchange>{ charges-AmountInFunctionalCurrency }</Exchange>| &&
         |<Exchange1>{ charges-AmountInFunctionalCurrency }</Exchange1>| &&
      |</Row10>| &&
      |<Row11>| &&
      |<Tot.amount>{ tot }</Tot.amount>| &&
      |<Tot.amount1>{ tot }</Tot.amount1>| &&

      |</Row11>| &&
      |<Row12>| &&
         |<Inwords>{ 8 }</Inwords>| &&
         |<Inwords1>{ 8 }</Inwords1>| &&
      |</Row12>| &&
      |<Row13>| &&
         |<Subform2>| &&
            |<A1>1</A1>| &&
            |<B1>{ supplier-BankAccount  }</B1>| &&
            |<C1>{ supplier-BankAccount  }</C1>| &&
            |<D1>{ 4 }</D1>| &&
            |<E1>{ 5 }</E1>| &&
            |<F1>{ 6 }</F1>| &&
            |<G1>{ 7 }</G1>| &&
            |<H1>{ 8 }</H1>| &&
            |<I1>{ 9 }</I1>| &&
            |<J1>{ 10 }</J1>| &&
            |<K1>{ 11 }</K1>| &&
            |<L1>{ 11 }</L1>| &&
            |<M1>{ 12 }</M1>| &&
            |<N1>{ 13 }</N1>| &&
*       |<O1>{ 14 }</O1>| &&
         |</Subform2>| &&
      |</Row13>| &&
   |</Table1>| &&
   |<Subform3>| &&
      |<Subform4/>| &&
      |<TextField1>Si manu vacuas</TextField1>| &&
      |<TextField2>Apros tres et quidem</TextField2>| &&
   |</Subform3>| &&
|</form1>|.
ENDIF.

data xsml type string .
REPLACE ALL OCCURRENCES OF '&' IN lv_xml WITH 'and'.
    DATA(url) = |{ lv2_url }|.
    DATA(client) = create_client( url ).
    DATA(req) = client->get_http_request(  ).

    req->set_authorization_basic( i_username = 'sb-4ca1944d-dd19-411f-acf8-b589d16153c2!b140156|ads-xsappname!b102452 ' i_password = '4dYRPjiGklmsqqVnmi8PWTbdhXA=')  .
    req->set_content_type( 'application/x-www-form-urlencoded'  ).
    req->set_form_field( EXPORTING i_name  = 'grant_type'
                                            i_value = 'client_credentials' ) .

    DATA(response) = client->execute( if_web_http_client=>post )->get_text(  ).

    REPLACE ALL OCCURRENCES OF '{"access_token":"' IN response WITH ''.
    SPLIT response AT '","token_type' INTO DATA(v1) DATA(v2) .
    DATA(access_token) = v1 .
    client->close(  ).



    DATA(gv) = 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2' .
    DATA(ls_data_xml) = cl_web_http_utility=>encode_base64( lv_xml ).

    url = |{ gv }|.
    client = create_client( url ).
    req = client->get_http_request(  ).
    req->set_authorization_bearer( access_token ) .

    DATA(ls_body) = VALUE struct( xdp_template = lc_template_name
                                     xml_data = ls_data_xml
                                     form_type = 'print'
                                     form_locale = 'en_US'
                                     tagged_pdf = '0'
                                     embed_font = '0' ).
    DATA(lv_json) = /ui2/cl_json=>serialize( data = ls_body compress = abap_true pretty_name = /ui2/cl_json=>pretty_mode-camel_case ).
    req->append_text(
              EXPORTING
                data   = lv_json
            ).
    req->set_content_type( 'application/json' ).


    DATA: result9 TYPE string.
*    DATA(result2) = client->execute( if_web_http_client=>post )->get_status( ) .
    result9 = client->execute( if_web_http_client=>post )->get_text( ).



    result12 = result9 .

    FIELD-SYMBOLS:
      <data>                TYPE data,
      <field>               TYPE any,
      <pdf_based64_encoded> TYPE any.
    DATA : lr_d TYPE string .

    DATA(lr_d1) = /ui2/cl_json=>generate( json = result9 ).

    IF lr_d1 IS BOUND.
      ASSIGN lr_d1->* TO <data>.
      ASSIGN COMPONENT `fileContent` OF STRUCTURE <data> TO <field>.
      IF sy-subrc EQ 0.
        ASSIGN <field>->* TO <pdf_based64_encoded>.
        result12 = <pdf_based64_encoded> .

      ENDIF.
    ENDIF.

  ENDMETHOD .
ENDCLASS.
