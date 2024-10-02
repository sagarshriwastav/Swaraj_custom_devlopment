class ZCL_SD_HANGER_PRINT_HTTP definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_SD_HANGER_PRINT_HTTP IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

    TYPES: BEGIN OF ty_head,
              style        TYPE zsd_hanger_tab-style,
              yarnspun     TYPE zsd_hanger_tab-yarnspun,
              width        TYPE zsd_hanger_tab-width,
              weight       TYPE zsd_hanger_tab-weight,
              shade        TYPE zsd_hanger_tab-shade,
              weave        TYPE zsd_hanger_tab-weave,
              weftsnkg     TYPE zsd_hanger_tab-weftsnkg,
              finshtype    TYPE zsd_hanger_tab-finshtype,
          END OF ty_head.


    DATA:it_head TYPE TABLE OF ty_head .
         DATA(body)  = request->get_text(  )  .
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).



DATA(req) = request->get_form_fields(  ).


 DATA styleno TYPE STRING.

  styleno = value #( req[ name = 'styleno' ]-value optional ) .

try.
    data(pdf2) = zsd_hanger_print_class=>read_posts( table = '' styleno = styleno ) .
  catch cx_static_check.
    "handle exception
endtry.


 response->set_text( pdf2  ).








  endmethod.
ENDCLASS.
