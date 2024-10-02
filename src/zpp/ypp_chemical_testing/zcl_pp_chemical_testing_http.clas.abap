class ZCL_PP_CHEMICAL_TESTING_HTTP definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_PP_CHEMICAL_TESTING_HTTP IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.


     DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).

          DATA NAME TYPE C LENGTH 20.
            NAME = req[ 2 ]-value.
          DATA(body)  = request->get_text(  )  .


       DATA respo  TYPE zpp_chemical_testing_str .

         xco_cp_json=>data->from_string( body )->write_to( REF #( respo ) ).

         DATA WA TYPE zpp_chemical_tab .

*****************************HeadarTable Save ********************************

     LOOP AT respo-atablearr1 ASSIGNING FIELD-SYMBOL(<FS>).
      WA-batch                     =  <FS>-batch .
      WA-lotno               =  <FS>-lotno.
      WA-matdesc               =  <FS>-matdesc .
      WA-material               =  <FS>-material .
      WA-noofbags               =  <FS>-noofbags .
      WA-partybilldate         =  <FS>-partybilldate.
      WA-partybillnumber      =  <FS>-partybillnumber.
      WA-plant                =  <FS>-plant.
      WA-postingdate          =  <FS>-postingdate.
      WA-quantitybaseunit     =  <FS>-quantitybaseunit.
      WA-suppliercode         =  <FS>-suppliercode.
      WA-stpragelocation      =  <FS>-storagelocation.
      WA-suppliername         =  <FS>-suppliername.
      WA-vehiclenumber        =  <FS>-vehiclenumber.
      wa-purchaseorder       =   <FS>-purchaseorder .
      wa-purchaseorderdate   =  <FS>-purchaseorderdate .
      WA-hsn                 =  <FS>-hsn .
      WA-gateno              =  <FS>-gateno .
      WA-materialdocumentyear  =  <FS>-materialdocumentyear .
      WA-charcvaluedescription   = <FS>-charcvaluedescription .
      WA-testing                = <FS>-testing .
      WA-prquantity           = <FS>-prquantity .
      WA-orderquantity        = <FS>-orderquantity .
      WA-testingdate          = <fs>-testingdate.



    MODIFY zpp_chemical_tab FROM @wa  .
      COMMIT WORK AND WAIT.

    ENDLOOP.

    DATA WAItem TYPE zpp_chemicl_tab2 .
    DATA json TYPE string.
    DATA TABRESULT TYPE string.

  READ TABLE respo-atablearr1 into data(WA1) INDEX 1.

  LOOP AT respo-atablearr2 ASSIGNING FIELD-SYMBOL(<F2>).

  WAItem-parmeters   =  <F2>-parmeters .
  WAItem-partybillnumber    =  WA1-partybillnumber  .
  WAItem-remark         =  respo-remark  .
  WAItem-sno            =  <F2>-sno   .
  WAItem-status        =  respo-status   .
  WAItem-zresult         =  <F2>-result .
  WAItem-partycode     =   WA1-suppliercode.


   MODIFY zpp_chemicl_tab2 FROM @WAItem  .
      COMMIT WORK AND WAIT.

    ENDLOOP.
   IF sy-subrc IS INITIAL.
          TABRESULT =  ' Data Saved!! ' .
        ELSE.
          TABRESULT = 'Error in saving data!!' .
        ENDIF.


   response->set_text( TABRESULT ).

  endmethod.
ENDCLASS.
