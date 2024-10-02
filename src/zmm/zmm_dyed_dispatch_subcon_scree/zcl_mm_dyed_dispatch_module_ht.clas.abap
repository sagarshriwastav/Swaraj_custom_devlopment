CLASS zcl_mm_dyed_dispatch_module_ht DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
********************CREATED GAJENDRA SINGH SHEKHAWAT*************************************************************

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_MM_DYED_DISPATCH_MODULE_HT IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.


    DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).

    DATA(body)  = request->get_text(  )  .


    DATA respo  TYPE zmm_dyed_dispatch_str .
    DATA json TYPE string .


    xco_cp_json=>data->from_string( body )->write_to( REF #( respo ) ).


    LOOP AT  respo-tabledataarray  ASSIGNING FIELD-SYMBOL(<wat>).
      DATA:item TYPE i_purchaseorderitemapi01-yy1_salesorderitem_pdi.
      item = <wat>-soitem.
      SELECT SINGLE yy1_salesorder_pdi FROM i_purchaseorderitemapi01
              WHERE purchaseorder = @<wat>-poorder AND purchaseorderitem = @<wat>-poitem
              AND yy1_salesorder_pdi = @<wat>-soorder
              AND yy1_salesorderitem_pdi = @item INTO @DATA(po) .
      IF sy-subrc <> 0 .
*   IF   IS NOT INITIAL .
        json  = |{ 'ERROR' }  { po }  { 'Check Sales Order' }|.
        response->set_text( json  ).
        DATA(error) = 'X'.
        EXIT.
      ENDIF.
      IF <wat>-soitem EQ '0'.
        <wat>-soitem = ''.
        <wat>-ind = ''.
      ELSE.
        <wat>-soitem = |{ <wat>-soitem ALPHA = IN }| .
        <wat>-ind = 'E'.
      ENDIF.
    ENDLOOP.

    CHECK error IS INITIAL.

    MODIFY ENTITIES OF i_materialdocumenttp
               ENTITY materialdocument
               CREATE FROM VALUE #( ( %cid                          = 'My%CID_1'
                                      goodsmovementcode             = '04'
                                      postingdate                   = respo-postingdate
                                      documentdate                  = sy-datum
                                      %control-goodsmovementcode                    = cl_abap_behv=>flag_changed
                                      %control-postingdate                          = cl_abap_behv=>flag_changed
                                      %control-documentdate                         = cl_abap_behv=>flag_changed
                                  ) )

               ENTITY materialdocument
               CREATE BY \_materialdocumentitem
               FROM VALUE #(   (
                               %cid_ref = 'My%CID_1'

                               %target = VALUE #( FOR any1 IN respo-tabledataarray INDEX INTO i ( %cid     = |My%CID_{ i }_001|

                                                 plant                          =  any1-plant
                                                 material                       =  any1-materialcode
                                                 goodsmovementtype              = '541'
                                                 inventoryspecialstocktype      = any1-ind
                                                 storagelocation                = any1-soloca
                                                 purchaseorder                 =   |{ any1-poorder ALPHA = IN }|
                                                 purchaseorderitem            =    |{ any1-poitem ALPHA = IN }|
                                                 quantityinentryunit            =  any1-quantity
                                                 entryunit                      = 'M'
                                                 batch                          = any1-setcode
                                                 supplier                       = |{ respo-suplier ALPHA = IN }|
                                                 issgorrcvgspclstockind         = 'B'
                                                 specialstockidfgsalesorder     =   |{ any1-soorder ALPHA = IN }|
                                                 specialstockidfgsalesorderitem  =  |{ any1-soitem ALPHA = IN }|
                                                 materialdocumentitemtext       =  ' '
                                                 %control-plant                 = cl_abap_behv=>flag_changed
                                                 %control-material              = cl_abap_behv=>flag_changed
                                                 %control-goodsmovementtype     = cl_abap_behv=>flag_changed
                                                 %control-storagelocation       = cl_abap_behv=>flag_changed
                                                 %control-quantityinentryunit   = cl_abap_behv=>flag_changed
                                                 %control-entryunit             = cl_abap_behv=>flag_changed
                                                )     )


                           ) )
              MAPPED   DATA(ls_create_mapped)
               FAILED   DATA(ls_create_failed)
               REPORTED DATA(ls_create_reported).

    COMMIT ENTITIES BEGIN
RESPONSE OF i_materialdocumenttp
FAILED DATA(commit_failed)
REPORTED DATA(commit_reported).


    IF commit_failed-materialdocument IS NOT INITIAL .

      LOOP AT  commit_reported-materialdocumentitem ASSIGNING FIELD-SYMBOL(<data>).

        DATA(msz) =  <data>-%msg  .

        DATA(mszty) = sy-msgty .
        DATA(msz_1)  = | { sy-msgv1 } { sy-msgv2 }  { sy-msgv3 } { sy-msgv4 } Message Type- { sy-msgid } Message No { sy-msgno }  |  .

      ENDLOOP .

      IF commit_failed-materialdocument IS INITIAL .

        CLEAR mszty .
      ENDIF .

    ELSE .

      LOOP AT ls_create_mapped-materialdocument ASSIGNING FIELD-SYMBOL(<keys_header>).

        IF mszty = 'E' .
          EXIT .
        ENDIF .

        CONVERT KEY OF i_materialdocumenttp
        FROM <keys_header>-%pid
        TO <keys_header>-%key .
      ENDLOOP.


      LOOP AT ls_create_mapped-materialdocumentitem ASSIGNING FIELD-SYMBOL(<keys_item>).
*
        IF mszty = 'E' .
          EXIT .
        ENDIF .

        CONVERT KEY OF i_materialdocumentitemtp
        FROM <keys_item>-%pid
        TO <keys_item>-%key.
      ENDLOOP.

    ENDIF.
    COMMIT ENTITIES END.

    DATA result TYPE string .
    DATA tabresult TYPE string .

    IF  mszty = 'E' .

      result = |Error { msz_1 } |.

    ELSE .

      DATA(grn)  = <keys_header>-materialdocument .
* data result type string .
      DATA result1 TYPE string .

      result = <keys_header>-materialdocument .
      result1 = <keys_header>-materialdocumentyear.

    ENDIF.


    DATA wzppgrey TYPE zmm_dyed_dis_tab .
    IF result IS NOT INITIAL AND  result1 IS NOT INITIAL .

      LOOP AT respo-tabledataarray ASSIGNING FIELD-SYMBOL(<fs>) .
******************prem singh



*  SELECT SINGLE matdocument , partychlaan FROM ZMM_GREY_RECEIPT_CHECK WHERE Piecenumber = @WA_CHECK-piecenumber
*                                                          AND supplier = @wa_check-supplier
*                                                          AND Itemcode =  @wa_check-itemcode INTO @DATA(CHEACK) .
*  IF CHEACK IS NOT INITIAL .
*
*    json  = |{ 'ERROR' }  { WA_CHECK-piecenumber }  { 'Piece Already Received in Challan' } { CHEACK-partychlaan }|.
*           response->set_text( json  ).
* EXIT.
*  ENDIF.



        wzppgrey-material = <fs>-materialcode  .
        wzppgrey-purchaseorder = <fs>-poorder .
        wzppgrey-purchaseorderitem  = <fs>-poitem .
        wzppgrey-materialdocument541  = result .
        wzppgrey-materialdocumentyear   = result1 .
        wzppgrey-batch                 = <fs>-setcode .
        wzppgrey-materialbaseunit            = <fs>-uom .
        wzppgrey-matlwrhsstkqtyinmatlbaseunit   = <fs>-quantity .
        wzppgrey-partybeam          = <fs>-beampatry .
        wzppgrey-plant              = <fs>-plant .
        wzppgrey-greysort             = <fs>-greysort .
        wzppgrey-productdescription      = <fs>-matdescrption .
        wzppgrey-sddocument          = <fs>-soorder .
        wzppgrey-sddocumentitem        = <fs>-soitem .
        wzppgrey-storagelocation      = <fs>-soloca .
        wzppgrey-supplier             = respo-suplier .

        MODIFY zmm_dyed_dis_tab FROM @wzppgrey  .

      ENDLOOP .
      IF sy-subrc IS INITIAL.
        tabresult =  ' Data Saved!! ' .
      ELSE.
        tabresult = 'Error in saving data!!' .
      ENDIF.

      COMMIT WORK AND WAIT.
    ENDIF.

    IF  mszty = 'E' .
      json   =   result.

    ELSE .

      CONCATENATE 'Material Document' result  'Post Sucessfully And Table' tabresult  INTO json SEPARATED BY ' '.

    ENDIF.

    response->set_text( json  ).



  ENDMETHOD.
ENDCLASS.
