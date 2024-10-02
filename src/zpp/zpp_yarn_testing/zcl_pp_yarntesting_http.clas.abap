class ZCL_PP_YARNTESTING_HTTP definition
  public
  create public .
********************CREATED GAJENDRA SINGH SHEKHAWAT*************************************************************
public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_PP_YARNTESTING_HTTP IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.




      DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).

          DATA NAME TYPE C LENGTH 20.
            NAME = req[ 2 ]-value.
          DATA(body)  = request->get_text(  )  .


       DATA respo  TYPE zpp_yarn_testing_str .

         xco_cp_json=>data->from_string( body )->write_to( REF #( respo ) ).

         DATA WA TYPE zpp_yarn_testing .

*****************************HeadarTable Save ********************************

     LOOP AT respo-atablearr1 ASSIGNING FIELD-SYMBOL(<FS>).
      WA-batch                     =  <FS>-batch .
      WA-lotnumber               =  <FS>-lotnumber.
      WA-matdesc               =  <FS>-matdesc .
      WA-material               =  <FS>-material .
      WA-millname               =  <FS>-millname .
      WA-noofbags               =  <FS>-noofbags .
      WA-noofcones               =  <FS>-noofcones.
      WA-partybilldate         =  <FS>-partybilldate.
      WA-partybillnumber      =  <FS>-partybillnumber.
      WA-plant                =  <FS>-plant.
      WA-postingdate          =  <FS>-postingdate.
      WA-quantitybaseunit     =  <FS>-quantitybaseunit.
      WA-remark               =  respo-remark.
      WA-salesorder           =  <FS>-salesorder.
      WA-status               =  respo-status.
      WA-stpragelocation      =  <FS>-storagelocation.
      WA-suppliercountcvper   =  <FS>-suppliercountcvper.
      WA-suppliercode         =  <FS>-suppliercode.
      WA-suppliercount        =  <FS>-suppliercount.
      WA-suppliercsp          =  <FS>-suppliercsp.
      WA-suppliercspcvper     =  <FS>-suppliercspcvper.
      WA-suppliername         =  <FS>-suppliername.
      WA-vehiclenumber        =  <FS>-vehiclenumber.
      WA-testingdate         =   SY-datum.


    MODIFY zpp_yarn_testing FROM @wa  .
      COMMIT WORK AND WAIT.

    ENDLOOP.

    DATA WAItem TYPE zpp_yarn_testtem .
    DATA json TYPE string.
    DATA TABRESULT TYPE string.

  READ TABLE respo-atablearr1 into data(WA1) INDEX 1.

  LOOP AT respo-atablearr2 ASSIGNING FIELD-SYMBOL(<F2>).
*  WAItem-batch  = wa-batch .
  WAItem-parmeters   =  <F2>-parmeters .
  WAItem-partybillnumber    =  WA1-partybillnumber  .
  WAItem-remark         =  respo-remark  .
  WAItem-sno            =  <F2>-sno   .
  WAItem-status        =  respo-status   .
  WAItem-zresult         =  <F2>-result .
  WAItem-partycode     =   WA1-suppliercode.

   MODIFY zpp_yarn_testtem FROM @WAItem  .
      COMMIT WORK AND WAIT.

    ENDLOOP.
   IF sy-subrc IS  INITIAL.
          TABRESULT =  ' Data Saved!! ' .
        ELSE.
          TABRESULT = 'Error in saving data!!' .
        ENDIF.


   response->set_text( TABRESULT ).

  endmethod.
ENDCLASS.
