CLASS ycl_gst_recon_api DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    CLASS-DATA : access_token TYPE string .
    CLASS-METHODS :
      postclear_tax
        IMPORTING
                  GSTIN           TYPE STRING
                  json            TYPE string
                  billingdocument TYPE string
        RETURNING VALUE(status1)  TYPE  string  ,

      create_client2
        IMPORTING url           TYPE string
        RETURNING VALUE(result) TYPE REF TO if_web_http_client
        RAISING   cx_static_check,
      create_client
        IMPORTING url           TYPE string
        RETURNING VALUE(result) TYPE REF TO if_web_http_client
        RAISING   cx_static_check .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS YCL_GST_RECON_API IMPLEMENTATION.


  METHOD create_client.

    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).

  ENDMETHOD.


METHOD create_client2.

    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).

  ENDMETHOD.


  METHOD postclear_tax.

    DATA: uuid      TYPE string.
    DATA: password  TYPE string.
    DATA: user_name TYPE string.

    uuid = cl_system_uuid=>create_uuid_x16_static(  ).
    IF sy-sysid = 'XMV' OR sy-sysid = 'XWL'.
      DATA : ewaylink  TYPE  string VALUE 'https://api-sandbox.clear.in/integration/v2/ingest/json/sales'  .
      DATA(url) = |{ ewaylink }|.
      DATA(client) = create_client2( url ).
      DATA(req) = client->get_http_request(  ).
      req->set_header_field( i_name = 'X-Cleartax-Auth-Token'  i_value = '1.f93c0d92-3ea6-4887-8b14-7908f7c3c468_e8a283e052e7ceffd0223e9d8523581b4979383eb13484682a140089cee46ab8' ) .
      req->set_header_field( i_name = 'x-cleartax-gstin'    i_value = gstin ).
      req->set_content_type( 'application/json' ).
      req->set_header_field( i_name = 'requestid' i_value = uuid ).
      req->set_header_field( i_name = 'Authorization' i_value = access_token ).
      req->set_text( json ) .

      status1 = client->execute( if_web_http_client=>post )->get_text( ).

      client->close(  )  .

    ELSE.
      ewaylink =  'https://api.clear.in/integration/v2/ingest/json/sales'  .
      url = |{ ewaylink }|.
      client = create_client2( url ).
      req = client->get_http_request(  ).
*      req->set_header_field( i_name = 'X-Cleartax-Auth-Token'  i_value = '1.b12919a1-99ff-4cf4-8cdd-bd8f037a1ea5_6b44af02dd87da5c9ab574bfaae55a0cde24db5b02868e513b74f1541c3ffc32' ) .
      req->set_header_field( i_name = 'X-Cleartax-Auth-Token'  i_value = '1.e71490da-f060-40bf-b3f8-8307d8f59f05_c18b2cee6878a5b4a12fb859a60d72076916324d783eeb313f96959e0ba04391' ) .
      req->set_header_field( i_name = 'x-cleartax-gstin'    i_value = gstin ).
      req->set_content_type( 'application/json' ).
      req->set_header_field( i_name = 'requestid' i_value = uuid ).
      req->set_header_field( i_name = 'Authorization' i_value = access_token ).
      req->set_text( json ) .

      status1 = client->execute( if_web_http_client=>post )->get_text( ).

      client->close(  )  .

    ENDIF.
  ENDMETHOD.
ENDCLASS.
