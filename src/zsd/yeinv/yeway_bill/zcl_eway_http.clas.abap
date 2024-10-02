CLASS zcl_eway_http DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    DATA irn1 TYPE string .
    DATA eway TYPE string .
    DATA invoice1 TYPE string .
    DATA invoice2 TYPE string .
    DATA invoice TYPE string .
    DATA year TYPE string .
    DATA transpoter_name TYPE string .
    DATA irngenrate TYPE string .
    DATA eway_generate TYPE string .
    DATA form_generate TYPE string .
    DATA eway_cancellation TYPE string .
    DATA irn_cancellation TYPE string .
    DATA vehiclenumber TYPE string .
    DATA transportdoc TYPE string .
    DATA transportid TYPE string .
    DATA json TYPE string .
    DATA irn_name TYPE string .
    DATA eway_name TYPE string .
    DATA param TYPE string .
    DATA distance TYPE string .
    DATA review TYPE string .

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_EWAY_HTTP IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.
    DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).


    invoice1          = VALUE #( req[ name = 'invoice' ]-value OPTIONAL ) .
    year              = VALUE #( req[ name = 'year' ]-value OPTIONAL ) .
    irngenrate        = VALUE #( req[ name = 'irn' ]-value OPTIONAL ) .
    eway_generate     = VALUE #( req[ name = 'eway' ]-value OPTIONAL ) .
    form_generate     = VALUE #( req[ name = 'form' ]-value OPTIONAL ) .
    transpoter_name   = VALUE #( req[ name = 'transporter' ]-value OPTIONAL ) .
    distance          = VALUE #( req[ name = 'distance' ]-value OPTIONAL ) .
    eway_cancellation = VALUE #( req[ name = 'caneway' ]-value OPTIONAL ) .
    irn_cancellation  = VALUE #( req[ name = 'canirn' ]-value OPTIONAL ) .
    vehiclenumber     = VALUE #( req[ name = 'vehiclenumber' ]-value OPTIONAL ) .
    transportid       = VALUE #( req[ name = 'transportid' ]-value OPTIONAL ) .
    transportdoc      = VALUE #( req[ name = 'transportdoc' ]-value OPTIONAL ) .
    json              = VALUE #( req[ name = 'json' ]-value OPTIONAL ) .

    DATA(invtype) =  VALUE #( req[ name = 'invoicetype' ]-value OPTIONAL ) .  "Finance Invoice  or Sales Invoice


    IF eway_generate = 'X'.

      IF invtype = 'Sales'.

        review = zcl_eway_generation=>generated_eway_bill( invoice         = invoice1
                                                              distance        = distance
                                                              transpoter_name = transpoter_name
                                                              transportid     = transportid
                                                              transportdoc    = transportdoc
                                                              vehiclenumber   = vehiclenumber ).


      ENDIF .

      response->set_text( review  ).
*    ELSEIF ( irngenrate = 'X' AND eway_generate NE 'X' ) .
*      response->set_text( |IRN GENERATION REQUEST FOR  { invoice1  } **** DENIED  |  ).
    ELSEIF  form_generate EQ 'X' .
      IF invtype = 'Sales Invoice'.
        invoice = invoice1 .
        SELECT SINGLE * FROM i_billingdocumentbasic WHERE billingdocument = @invoice  INTO @DATA(invdata)  .
        SELECT SINGLE * FROM i_deliverydocument WHERE deliverydocument = @invoice  INTO @DATA(deli)  .
        IF invdata-billingdocument IS NOT INITIAL      .
          DATA(pdf2) = zsd_dom_form=>read_posts( variable = invoice remark = '') .
        ELSEIF deli-deliverydocument IS NOT INITIAL  .
          pdf2 = zdiliveryprint=>read_posts( variable = invoice ) .
        ENDIF .
      ENDIF .


    ELSEIF json = 'X'.
      DATA(bing)  =  ycl_json4einv=>create_json( invoice = invoice1 )   .
      response->set_text( bing ).
    ENDIF .
  ENDMETHOD.
ENDCLASS.
