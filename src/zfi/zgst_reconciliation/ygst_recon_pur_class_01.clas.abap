CLASS ygst_recon_pur_class_01 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES  if_oo_adt_classrun.

  CLASS-DATA : access_token TYPE string .
    CLASS-DATA  : zgst_recon_data type zgst_recon_data .

        TYPES:
      BEGIN OF post_s,
        user_id TYPE i,
        id      TYPE i,
        title   TYPE string,
        body    TYPE string,
      END OF post_s,

      BEGIN OF post_without_id_s,
        user_id TYPE i,
        title   TYPE string,
        body    TYPE string,
      END OF post_without_id_s.

 CLASS-METHODS :

      create_client

        IMPORTING url           TYPE string
        RETURNING VALUE(result) TYPE REF TO if_web_http_client
        RAISING   cx_static_check ,

 gst_recon_pur
 IMPORTING VBELN1 TYPE STRING
 RETURNING VALUE(gstrecon) type string.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS YGST_RECON_PUR_CLASS_01 IMPLEMENTATION.


  METHOD create_client.


    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).
  ENDMETHOD.


METHOD gst_recon_pur.
*
*ITEM DETAILS
SELECT * FROM I_BillingDocumentItem   WHERE
BillingDocument  =  @vbeln1 AND BillingQuantity NE ''  INTO TABLE @DATA(BILLING_ITEM)  .

LOOP AT BILLING_ITEM INTO DATA(WA1).
DATA(WA) = WA1.
ENDLOOP.

*""""""""""""""""""""""""""""""""""""""""""""""""""""Plant Wise Address, GST & PAN"""""""""""""""""""""""""""""""""""
READ TABLE BILLING_ITEM into data(wa_bill) index 1.
 SELECT single * FROM ZSD_PLANT_ADDRESS as a inner join I_BILLINGDOCUMENTITEMBASIC as b on ( a~Plant =  b~Plant )
 where BillingDocument =  @vbeln1 AND a~plant = @wa_bill-Plant into @data(sellerplantaddress) .

if wa_bill-Plant  = '1000'.
DATA(gst1)   = '08AAICR3451R1ZP'.
elseif wa_bill-Plant  = '1010'.
 gst1  = '27AAICR3451R1ZP'.
elseif wa_bill-Plant  = '2000'.
 gst1  = '08AAACU0596Q1ZO'.
elseif wa_bill-Plant  = '4100'.
 gst1  = '08AAGCR8565G1ZX'.
elseif wa_bill-Plant  = '1100'.
 gst1  = '08AAICR3451R1ZP'.
elseif wa_bill-Plant  = '4110'.
 gst1  = '08AAGCR8565G1ZX'.
elseif wa_bill-Plant  = '1110'.
 gst1  = '08AAICR3451R1ZP'.
elseif wa_bill-Plant  = '4120'.
 gst1  = '08AAGCR8565G1ZX'.
elseif wa_bill-Plant  = '1120'.
 gst1 = '08AAICR3451R1ZP'.
elseif wa_bill-Plant  = '4130'.
 gst1 = '08AAGCR8565G1ZX'.
elseif wa_bill-Plant  = '1130'.
 gst1 = '27AAICR3451R1ZP'.
elseif wa_bill-Plant  = '4140'.
 gst1 = '08AAGCR8565G1ZX'.
elseif wa_bill-Plant  = '1140'.
 gst1 = '24AAICR3451R1ZV'.
elseif wa_bill-Plant  = '4150'.
 gst1 = '08AAGCR8565G1ZX'.
elseif wa_bill-Plant  = '1150'.
 gst1 = '08AAICR3451R2ZO'.
elseif wa_bill-Plant  = '4160'.
 gst1 = '08AAGCR8565G1ZX'.
elseif wa_bill-Plant  = '1210'.
 gst1 = '08AAICR3451R2ZO'.
elseif wa_bill-Plant  = '1160'.
 gst1 = '24AAICR3451R1ZV'.
elseif wa_bill-Plant  = '4170'.
 gst1 = '08AAGCR8565G1ZX'.
elseif wa_bill-Plant  = '1200'.
 gst1 = '08AAICR3451R1ZP'.
elseif wa_bill-Plant  = '5100'.
 gst1 = '29AALCR4986L1ZC'.
elseif wa_bill-Plant  = '4230'.
 gst1 = '08AAGCR8565G1ZX'.
elseif wa_bill-Plant  = '7100'.
 gst1 = '24AAMCP9880A1Z7'.
elseif wa_bill-Plant  = '4240'.
 gst1 = '08AAGCR8565G1ZX'.
elseif wa_bill-Plant  = '1220'.
 gst1 = '24AAICR3451R1ZV'.
elseif wa_bill-Plant  = '3200'.
 gst1 = '24AAMFA7916M1Z2'.
elseif wa_bill-Plant  = '1300'.
 gst1 = '19AAICR3451R1ZM'.
elseif wa_bill-Plant  = '4180'.
 gst1 = '08AAGCR8565G1ZX'.
elseif wa_bill-Plant  = '1310'.
 gst1 = '09AAICR3451R1ZN'.
elseif wa_bill-Plant  = '4190'.
 gst1 = '08AAGCR8565G1ZX'.
elseif wa_bill-Plant  = '2100'.
 gst1 = '08AAACU0596Q1ZO'.
elseif wa_bill-Plant  = '4200'.
 gst1 = '08AAGCR8565G1ZX'.
elseif wa_bill-Plant  = '2110'.
 gst1 = '08AAACU0596Q1ZO'.
elseif wa_bill-Plant  = '4210'.
 gst1 = '08AAGCR8565G1ZX'.
elseif wa_bill-Plant  = '2200'.
 gst1 = '08AAACU0596Q1ZO'.
elseif wa_bill-Plant  = '2120'.
 gst1 =  '37AAACU0596Q1ZN'.
elseif wa_bill-Plant  = '4220'.
 gst1 = '08AAGCR8565G1ZX'.
 elseif wa_bill-Plant  = '4170'.
 gst1 = '08AAGCR8565G1ZX'.
ENDIF.

*************************************************************************************************************************


data bracketo type string .
data bracketc type string .
data lv_xml   type string .
data lv_xml13 type string .
data lv_xml14 type string .

bracketo  = '{' .
bracketc  = '}' .


data(lv_xml3) =
   |{ bracketo }"userInputArgs" :{ bracketo }"templateId":"618a5623836651c01c1498ad","groupId":"TEST197","settings":{ bracketo }"ignoreHsnValidation":true{ bracketc }{ bracketc },| &&
   |"jsonRecords":[ | .

zgst_recon_data-templateid =  '618a5623836651c01c1498ad' .
zgst_recon_data-groupid    =  'TEST197' .

*data(bill_data)    =     ygst_recon_class_2=>gst_reconcile( vbeln1 = 'RB12300016' )  .


data(lv_xml5) =
|] { bracketc } | .

*CONCATENATE lv_xml3 bill_data lv_xml5 into lv_xml14 .
*****************************************************************************************************************************

  DATA: uuid      TYPE string.
  DATA: PASSWORD  TYPE STRING.
  DATA: USER_NAME TYPE STRING.
  DATA: GSTIN_D   TYPE STRING.
        GSTIN_D = GST1.

    uuid = cl_system_uuid=>create_uuid_x16_static(  ).
  if sY-SYSID = 'YXD' OR SY-SYSID = 'YXC'.
data : ewaylink  type  string value 'https://api-sandbox.clear.in/integration/v2/ingest/json/sales'  .
    DATA(url) = |{ ewaylink }|.
    DATA(client) = create_client( url ).
    DATA(req) = client->get_http_request(  ).
    req->set_header_field( i_name = 'X-Cleartax-Auth-Token'  i_value = '1.9e3059ac-a5d6-4ba1-a663-2289df64dd44_8a2f974821c10c2187cf3570af2b4aa75693edd42d3535482db9a1b64c8d45a9' ) .
    req->set_header_field( i_name = 'x-cleartax-gstin'    i_value = '08AAICR3451R2ZO' ).
    req->set_content_type( 'application/json' ).
    req->set_header_field( i_name = 'requestid' i_value = uuid ).
    req->set_header_field( i_name = 'Authorization' i_value = access_token ).
    req->set_text( lv_xml14 ) .

    DATA: result9 TYPE string.
    result9 = client->execute( if_web_http_client=>post )->get_text( ).

    client->close(  )  .

ENDIF.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


ENDMETHOD.


METHOD if_oo_adt_classrun~main.

* DATA: vbeln1 TYPE c LENGTH 10.
*
* TRY.
*
*    DATA(return_data) = gst_recon_pur( vbeln1 = 'RB12300016' ).
*
*  ENDTRY.

ENDMETHOD.
ENDCLASS.
