class ZCL_MM_MATERIL_RETURN_WEAVING definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_MM_MATERIL_RETURN_WEAVING IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

   DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).
*    response->set_status( i_reason = 'SUSCESSFULL'  i_code = 2 ).
  DATA oMaterianumber TYPE string.
    DATA Vehicleno TYPE string.

oMaterianumber = value #( req[ name = 'omaterianumber' ]-value optional ) .
Vehicleno = value #( req[ name = 'vehicleno' ]-value optional ) .

   SELECT SINGLE GoodsMovementType from  I_MaterialDocumentItem_2 WHERE MaterialDocument = @oMaterianumber
                                             AND ( GoodsMovementType = '542' ) INTO @DATA(WA_542) .
  IF wa_542 = '' .
  DATA(pdf1) = zmm_material_returt_from_weavi=>read_posts( matdoc = oMaterianumber vehicleno = Vehicleno ) .

  ENDIF.

          response->set_text( pdf1 ).

  endmethod.
ENDCLASS.
