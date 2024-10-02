class ZCL_TECO definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_TECO IMPLEMENTATION.


 method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

            data ztecotable type ztecotable .

      DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).







*        DATA variable TYPE char8.
*        DATA variable1 TYPE CHAR10.
*
*        variable = req[ 3 ]-NAME.
*        variable1 = req[ 3 ]-value.

    DATA(body)  = request->get_text(  )  .

    DATA respo  TYPE zteco_stucture .

     xco_cp_json=>data->from_string( body )->write_to( REF #( respo ) ).



          ztecotable-beamno = respo-beamno.
          ztecotable-plant = respo-plant.
          ztecotable-vendorcode = respo-vendorcode.
          ztecotable-proorder = respo-proorder.
          ztecotable-beamgattingdate = respo-beamgattingdate.
          ztecotable-beamfalldate = respo-beamfalldate.


               modify  ztecotable from @ztecotable  .

      COMMIT WORK AND WAIT.

            IF sy-subrc IS INITIAL.
          DATA(TABRESULT) =  ' Data Saved!! ' .
        ELSE.
          TABRESULT = 'Error in saving data!!' .
        ENDIF.




  DATA JSON TYPE STRING.
         CONCATENATE  TABRESULT 'Table TECO Entry' INTO json SEPARATED BY ' '.

      response->set_text( json ).


  endmethod.
ENDCLASS.
