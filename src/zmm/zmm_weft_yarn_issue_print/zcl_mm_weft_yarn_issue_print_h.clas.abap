class ZCL_MM_WEFT_YARN_ISSUE_PRINT_H definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_MM_WEFT_YARN_ISSUE_PRINT_H IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.
   DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).
*    response->set_status( i_reason = 'SUSCESSFULL'  i_code = 2 ).
  DATA omaterianumber TYPE string.
    DATA vehicleno TYPE string.

omaterianumber = value #( req[ name = 'omaterianumber' ]-value optional ) .
vehicleno = value #( req[ name = 'vehicleno' ]-value optional ) .

   SELECT SINGLE GoodsMovementType from  I_MaterialDocumentItem_2 WHERE MaterialDocument = @omaterianumber
                                             AND ( GoodsMovementType = '502'  OR GoodsMovementType = '542' ) INTO @DATA(WA_502) .

 IF WA_502 = '542' .
DATA(pdf1) = zmm_material_returt_from_weavi=>read_posts( matdoc = omaterianumber vehicleno = vehicleno ) .

ELSEif WA_502 = '502' .
 pdf1 = zcl_yarn_retun_to_customer_pri=>read_posts( matdoc = omaterianumber vehicleno = vehicleno )  .

**ELSEIF WA_502 = '542' .
**pdf1 = zmm_material_returt_from_weavi=>read_posts( matdoc = omaterianumber vehicleno = vehicleno ) .
ELSE .
 pdf1 = zcl_weft_yarn_issue_form=>read_posts( matdoc = omaterianumber vehicleno = vehicleno )  .
ENDIF.

   response->set_text( pdf1 ).


  endmethod.
ENDCLASS.
