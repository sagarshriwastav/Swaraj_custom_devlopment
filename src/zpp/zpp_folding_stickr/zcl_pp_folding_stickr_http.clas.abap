class ZCL_PP_FOLDING_STICKR_HTTP definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_PP_FOLDING_STICKR_HTTP IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.
   DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).


 data beamno type string.
 data rollnofrom  type string.
 data rollnoto  type string.

beamno = value #( req[ name = 'beamno' ]-value optional ) .
rollnofrom = value #( req[ name = 'rollnofrom' ]-value optional ) .
rollnoto = value #( req[ name = 'rollnoto' ]-value optional ) .

    DATA(pdf1) = zpp_folding_stickr_class=>read_posts( beamno = beamno
                                          RollNoFrom = rollnofrom
                                          RollNoTo = rollnoto ) .

                                          response->set_text( pdf1 ).
  endmethod.
ENDCLASS.
