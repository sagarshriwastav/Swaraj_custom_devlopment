class ZCL_PP_DENIM_HTTP definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_PP_DENIM_HTTP IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

    DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' )..
data : packing type string .


data Fromdate type datn .
data Todate type datn.
data order type string .

   types: BEGIN OF struct,
        error TYPE string,
        xml_data     TYPE string,
        form_type    TYPE string,
        form_locale  TYPE string,
        tagged_pdf   TYPE string,
        embed_font   TYPE string,
      END OF struct.

          TYPES : BEGIN OF it ,
              plant TYPE zpackhdr_d-plant,
              rec_batch TYPE zpackhdr_d-rec_batch,
              batch TYPE zpackhdr_d-rec_batch,
              ftype TYPE string,

            END OF it.

    DATA : it  TYPE  TABLE OF it,
           wa1 TYPE it.


Fromdate = value #( req[ name = 'fromdate' ]-value optional ) .
Todate = value #( req[ name = 'todate' ]-value optional ) .

DATA(REVIEW) = zpp_denim_packing_class=>read_posts(  Fromdate = Fromdate Todate = Todate  ) .


response->set_text( review  ).




  endmethod.
ENDCLASS.
