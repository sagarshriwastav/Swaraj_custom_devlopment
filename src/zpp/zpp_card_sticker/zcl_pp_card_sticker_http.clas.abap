class ZCL_PP_CARD_STICKER_HTTP definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_PP_CARD_STICKER_HTTP IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

   DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).


DATA beamno type string.
DATA orderno type C LENGTH 12.
data orderno1  type C LENGTH 12.
DATA fromsticker type string.
DATA tosticker type string.

beamno = value #( req[ name = 'beamno' ]-value optional ) .
orderno = value #( req[ name = 'orderno' ]-value optional ) .
fromsticker = value #( req[ name = 'fromsticker' ]-value optional ) .
tosticker = value #( req[ name = 'tosticker' ]-value optional ) .

orderno1   =  |{ orderno ALPHA = IN }| .
data(pdf2) = zpp_card_sticker_class=>read_posts( beamno = beamno orderno = orderno1
                                               fromsticker  = fromsticker tosticker = tosticker ) .

response->set_text( pdf2  ).


  endmethod.
ENDCLASS.
