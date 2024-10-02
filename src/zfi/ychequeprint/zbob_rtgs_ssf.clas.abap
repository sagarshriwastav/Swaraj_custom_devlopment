CLASS zbob_rtgs_ssf DEFINITION
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
    CONSTANTS lc_template_name TYPE string VALUE 'BOB_RTGS_SSF/BOB_RTGS_SSF'.


ENDCLASS.



CLASS ZBOB_RTGS_SSF IMPLEMENTATION.


 METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).
 ENDMETHOD.


 METHOD if_oo_adt_classrun~main.

    TRY.
DATA(return_data) = read_posts(  variable = '5000001'  accountpayee = 'true'  chekbackside = '' self = ' ' rtgs = 'true' housebank = 'SBI01'  ) .
    ENDTRY.
  ENDMETHOD.


 METHOD read_posts .


 SELECT SINGLE * FROM i_outgoingcheck WHERE outgoingcheque = @variable INTO @DATA(chequedata) .

 SELECT SINGLE * FROM I_SuplrBankDetailsByIntId WHERE supplier = @chequedata-Supplier INTO @DATA(supplier).

 SELECT SINGLE * FROM I_Bank_2 WHERE bankcountry = @Supplier-BankCountry  INTO @DATA(supplier1).

 SELECT SINGLE * FROM i_housebankaccountlinkage WHERE housebank = @chequedata-housebank INTO @DATA(bankacount).

 DATA lv_xml TYPE string .

  lv_xml =
  |<form1>| &&
   |<Subform1>| &&
      |<Branch>{ supplier1-Branch }</Branch>| &&
      |<Date>{ chequedata-ChequePaymentDate }</Date>| &&
      |<Date>{ chequedata-ChequePaymentDate }</Date>| &&
      |<Branch>{ supplier1-Branch }</Branch>| &&
   |</Subform1>|.

DATA lv_xml2 TYPE string .
  lv_xml2 =
  |<Table1>| &&
      |<Row1>| &&
         |<Senderacno>{ bankacount-BankAccount }</Senderacno>| &&
         |<Senderacno1>{ bankacount-BankAccount }</Senderacno1>| &&
      |</Row1>| &&
      |<Row2>| &&
         |<Nameacholder>SAGAR MANUFACTURERS PVT. LTD.</Nameacholder>| &&
         |<Nameacholder1>SAGAR MANUFACTURERS PVT. LTD.</Nameacholder1>| &&
      |</Row2>| &&
      |<Row3>| &&
         |<Payeename>SAGAR MANUFACTURERS PVT. LTD.</Payeename>| &&
         |<Bene.name>SAGAR MANUFACTURERS PVT. LTD.</Bene.name>| &&
      |</Row3>| &&
      |<Row4>| &&
         |<Bank>{ supplier1-BankName }</Bank>| &&
         |<Receivingbank>{ supplier1-BankName }</Receivingbank>| &&
      |</Row4>| &&
      |<Row5>| &&
         |<Branch>{ supplier1-Branch }</Branch>| &&
         |<Receivingbranch>{ supplier1-Branch }</Receivingbranch>| &&
      |</Row5>| &&
      |<Row6>| &&
         |<IFSC>Mirum est</IFSC>| &&
         |<ReceivingIFSC>Licebit auctore</ReceivingIFSC>| &&
      |</Row6>| &&
      |<Row7>| &&
         |<Bene.acno>Proinde</Bene.acno>| &&
         |<Subform2>| &&
            |<A>A</A>| &&
            |<B>A</B>| &&
            |<C>V</C>| &&
            |<D>E</D>| &&
            |<E>S</E>| &&
            |<F>A</F>| &&
            |<G>M</G>| &&
            |<H>L</H>| &&
            |<I>P</I>| &&
            |<J>A</J>| &&
            |<K>A</K>| &&
            |<L>V</L>| &&
            |<M>E</M>| &&
            |<N>S</N>| &&
            |<O>A</O>| &&
         |</Subform2>| &&
      |</Row7>| &&
      |<Row8>| &&
         |<Bene.actype>Mirum est</Bene.actype>| &&
         |<Bene.actype1>Licebit auctore</Bene.actype1>| &&
      |</Row8>| &&
      |<Row9>| &&
         |<Amount>Proinde</Amount>| &&
         |<Amount1>Am undique</Amount1>| &&
      |</Row9>| &&
      |<Row10>| &&
         |<Exchange>Ad retia sedebam</Exchange>| &&
         |<Exchange1>Vale</Exchange1>| &&
      |</Row10>| &&
      |<Row11>| &&
         |<Tot.amount>Ego ille</Tot.amount>| &&
         |<Tot.amount1>Si manu vacuas</Tot.amount1>| &&
      |</Row11>| &&
      |<Row12>| &&
         |<Inwords>Apros tres et quidem</Inwords>| &&
         |<Inwords1>Mirum est</Inwords1>| &&
      |</Row12>| &&
      |<Row13>| &&
         |<Subform2>| &&
            |<A1>L</A1>| &&
            |<B1>P</B1>| &&
            |<C1>A</C1>| &&
            |<D1>A</D1>| &&
            |<E1>V</E1>| &&
            |<F1>E</F1>| &&
            |<G1>S</G1>| &&
            |<H1>A</H1>| &&
            |<I1>M</I1>| &&
            |<J1>L</J1>| &&
            |<K1>P</K1>| &&
            |<L1>A</L1>| &&
            |<M1>A</M1>| &&
            |<N1>V</N1>| &&
            |<O1>E</O1>| &&
         |</Subform2>| &&
      |</Row13>| &&
   |</Table1>| &&
   |<Subform3>| &&
      |<Subform4/>| &&
      |<TextField1>Si manu vacuas</TextField1>| &&
      |<TextField2>Apros tres et quidem</TextField2>| &&
   |</Subform3>| &&
|</form1>|.




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

    DATA(ls_body) = VALUE struct( xdp_template = 'BOB_RTGS_SSF/BOB_RTGS_SSF'
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
