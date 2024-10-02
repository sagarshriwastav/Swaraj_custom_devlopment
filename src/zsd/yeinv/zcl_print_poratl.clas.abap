CLASS zcl_print_poratl DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
   INTERFACES if_oo_adt_classrun .

    CLASS-DATA : access_token TYPE string .

       TYPES:
      BEGIN OF post_s,
        user_id TYPE i,
        id      TYPE i,
        title   TYPE string,
        body    TYPE string,
      END OF post_s,

      post_tt  TYPE TABLE OF post_s WITH EMPTY KEY,
      it_data1 TYPE STANDARD TABLE OF yinv_stu,
      wa_data1 TYPE  yinv_stu,

      BEGIN OF post_without_id_s,
        user_id TYPE i,
        title   TYPE string,
        body    TYPE string,
      END OF post_without_id_s.

       CLASS-METHODS :

      generate_authentication_token
        IMPORTING billingdocument TYPE zchar10 OPTIONAL
                  companycode     TYPE zchar4 OPTIONAL
        RETURNING VALUE(auth_token) TYPE string ,

      generate_ewaybill
        IMPORTING billingdocument TYPE zchar10 OPTIONAL
                  companycode     TYPE zchar4 OPTIONAL
        RETURNING VALUE(status)   TYPE string  ,


      create_client

        IMPORTING url           TYPE string
        RETURNING VALUE(result) TYPE REF TO if_web_http_client
        RAISING   cx_static_check ,

      "CLASS FOR PERFORM IRN DATA.
      read_posts
        IMPORTING billingdocument TYPE zchar10 OPTIONAL
                  companycode     TYPE zchar4 OPTIONAL
        RETURNING VALUE(result) TYPE post_tt
        RAISING   cx_static_check,
      "CLASS FOR IRN GENERATION
      get_table_fields
        IMPORTING billingdocument TYPE zchar10 OPTIONAL
                  companycode     TYPE zchar4 OPTIONAL
        RETURNING VALUE(result)        TYPE string  .
  PROTECTED SECTION.
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



CLASS ZCL_PRINT_PORATL IMPLEMENTATION.


 METHOD create_client.

    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).
  ENDMETHOD.


 METHOD generate_authentication_token.

  IF  SY-SYSID = 'Z6L'.
    SELECT SINGLE PLANT  FROM I_BillingDocumentItem WHERE BillingDocument = @billingdocument AND CompanyCode = @companycode INTO @DATA(plant).
    SELECT SINGLE * FROM zirn_credentials WHERE PLANT = @PLANT INTO @DATA(credentials)  .
 ENDIF.
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


   METHOD generate_ewaybill.

    DATA : token TYPE string .
    DATA : ejson TYPE string .
    DATA : json TYPE string .

    DATA ewaylink TYPE string .

    IF SY-SYSID = 'Z6L'.

   SELECT SINGLE PLANT  FROM I_BillingDocumentItem WHERE BillingDocument = @billingdocument AND CompanyCode = @companycode INTO @DATA(plant).
    SELECT SINGLE * FROM zirn_credentials WHERE PLANT = @PLANT INTO @DATA(credentials)  .

    ENDIF.
    IF credentials IS INITIAL .
      ewaylink  = 'https://gsp.adaequare.com/test/enriched/ei/api/ewaybill'  .
    ELSE .
      ewaylink  = 'https://gsp.adaequare.com/enriched/ei/api/ewaybill'  .
    ENDIF .

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

    ENDMETHOD.


    METHOD get_table_fields .

    DATA(access_token)  = generate_authentication_token( billingdocument = billingdocument companycode = companycode )  .

    "************************************************************Generate_irn
    "  https://gsp.adaequare.com/gsp/authenticate?action=GSP&grant_type=token
    "  https://gsp.adaequare.com/gsp/authenticate?action=GSP&grant_type=token

      DATA(lv_service_url) = 'https://gsp.adaequare.com/test/enriched/ei/api/invoice'.


    DATA:uuid TYPE string.
    DATA:lv_string TYPE string.

    uuid = cl_system_uuid=>create_uuid_x16_static(  ).

    DATA(url) = |{ lv_service_url }|.
    DATA(client) = create_client( url ).
    DATA(req) = client->get_http_request(  ).

      req->set_header_field( i_name = 'user_name' i_value =  'Adeq_KA_08'  ).
      req->set_header_field( i_name = 'password' i_value = 'Gsp@1234' ).
      req->set_header_field( i_name = 'gstin'    i_value = '08AABCK0452C1Z3' ).

    req->set_header_field( i_name = 'requestid' i_value = uuid ).

    CONCATENATE 'Bearer'  access_token INTO access_token SEPARATED BY space.

    req->set_header_field( i_name = 'Authorization' i_value = access_token ).
    req->set_content_type( 'application/json' ).
    req->set_text( lv_string ) .

    DATA: result9 TYPE string.
    result9 = client->execute( if_web_http_client=>post )->get_text( ).
    client->close(  ) .

    ENDMETHOD.


     METHOD read_posts.


*    " Get JSON of all posts
    DATA(url) = |{ base_url }|.
    DATA(client) = create_client( url ).
    DATA(req) = client->get_http_request(  ).
    IF SY-SYSID = 'Z6L'.

 SELECT SINGLE PLANT  FROM I_BillingDocumentItem WHERE BillingDocument = @billingdocument AND CompanyCode = @companycode INTO @DATA(plant).
    SELECT SINGLE * FROM zirn_credentials WHERE PLANT = @PLANT INTO @DATA(credentials)  .
ENDIF.
    IF credentials IS INITIAL .
      req->set_header_field( i_name = 'GSPAPPID' i_value = '3002C9D13D6D47128D08F3DE2211AAE2' ).
      req->set_header_field( i_name = 'GSPAPPSECRET' i_value = '0ACA16FEG3C2FG4FDFGA8F1G6A831E6ADF34' ).
    ELSE .
      req->set_header_field( i_name = 'GSPAPPID' i_value = '1EB88850567B4547A8B3E2696BBB17D8' ).
      req->set_header_field( i_name = 'GSPAPPSECRET' i_value = 'DB36779DG6B94G4D95G8CD7G18321BDD6D54' ).

    ENDIF .



    DATA(response) = client->execute( if_web_http_client=>post )->get_text(  ).
    client->close(  ).
*
*
*
*
    REPLACE ALL OCCURRENCES OF '{"access_token":"' IN response WITH ''.
    SPLIT response AT '","token_type"' INTO DATA(l1) DATA(l2)  .
    access_token = l1 .


    " Convert JSON to post table
*    xco_cp_json=>data->from_string( response )->apply(
*      VALUE #( ( xco_cp_json=>transformation->camel_case_to_underscore ) )
*      )->write_to( REF #( result ) ).
  ENDMETHOD.
ENDCLASS.
