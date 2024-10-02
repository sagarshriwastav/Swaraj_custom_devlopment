class ZCL_PP_DYEC_HTTP definition
  public
  create public .

********************CREATED GAJENDRA SINGH SHEKHAWAT*************************************************************
public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_PP_DYEC_HTTP IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.
      DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).

    DATA(body)  = request->get_text(  )  .
    DATA productionorder TYPE N LENGTH 12. .

    DATA respo  TYPE ZPP_DYEC .




    xco_cp_json=>data->from_string( body )->write_to( REF #( respo ) ).

        READ TABLE respo-tabledata into data(T1) INDEX 1.

    productionorder  =    |{ t1-orderid ALPHA = IN }|.

    SELECT SINGLE OrderIsReleased , IsMarkedForDeletion FROM I_MFGORDERWITHSTATUS  as a
    LEFT OUTER JOIN I_ManufacturingOrder as b ON ( b~ManufacturingOrder = a~ManufacturingOrder ) WHERE a~ManufacturingOrder = @productionorder INTO @DATA(CHEAKORD) .

    IF CHEAKORD-OrderIsReleased IS  INITIAL OR CHEAKORD-IsMarkedForDeletion IS NOT INITIAL    .

    IF CHEAKORD-OrderIsReleased IS  INITIAL .

    DATA lv TYPE string .
    LV  = 'ERROR Order Is Not Released. Please Release The Order First. '.
   response->set_text(  lv   ).

   ELSEIF  CHEAKORD-IsMarkedForDeletion IS NOT INITIAL .

     LV  = 'ERROR Order Is  Deleted. Please Cheack The Order First. '.
   response->set_text(  lv   ).

   ENDIF.

else .


     LOOP AT respo-tabledata ASSIGNING FIELD-SYMBOL(<wa_tab>) .

     <wa_tab>-totalqty = <wa_tab>-consqty + <wa_tab>-bathadjustment .

     ENDLOOP.

      MODIFY ENTITIES OF i_materialdocumenttp
                ENTITY materialdocument
                CREATE FROM VALUE #( ( %cid                          = 'My%CID_1'
                                       goodsmovementcode             = '03'
                                       postingdate                   = t1-postdate
                                       documentdate                  = sy-datum
                                       %control-goodsmovementcode                    = cl_abap_behv=>flag_changed
                                       %control-postingdate                          = cl_abap_behv=>flag_changed
                                       %control-documentdate                         = cl_abap_behv=>flag_changed
                                   ) )

                ENTITY materialdocument
                CREATE BY \_materialdocumentitem
                FROM VALUE #(   (
                                %cid_ref = 'My%CID_1'

                                %target = VALUE #( FOR any1 IN respo-tabledata INDEX INTO i ( %cid                           = |My%CID_{ i }_001|
*                                  %target = VALUE #( ( %cid = 'My%CID_1_001'
                                                     plant                          =  any1-plant
                                                     material                       =  any1-product ""     any1-product       "'YGI1Z14N02009040'
                                                     goodsmovementtype              = '261'
                                                     storagelocation                =   any1-storagelocation   "" 'YRM1' any1-storagelocation "'YG01'
                                                     batch                          =   any1-batch ""any1-batch  "" 'LOT-01'
                                                     quantityinentryunit            =   any1-totalqty  ""
                                                     entryunit                      =   any1-baseunit ""
                                                     manufacturingorder             =   productionorder      " productionorder       " '000001000000'
                                                     goodsmovementrefdoctype        = ' '

                                                     SalesOrder =  ' '
                                                     SalesOrderItem =  ' '
                                                    SpecialStockIdfgSalesOrder =  ' '
                                                    SpecialStockIdfgSalesOrderItem  =  ' '
**                                                     iscompletelydelivered          = ''
**                                                     materialdocumentitemtext       = ''
                                                     %control-plant                 = cl_abap_behv=>flag_changed
                                                     %control-material              = cl_abap_behv=>flag_changed
                                                     %control-goodsmovementtype    = cl_abap_behv=>flag_changed
                                                     %control-storagelocation       = cl_abap_behv=>flag_changed
                                                     %control-quantityinentryunit  = cl_abap_behv=>flag_changed
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

 If commit_failed-materialdocument is NOT INITIAL.
loop at  commit_reported-materialdocumentitem ASSIGNING FIELD-SYMBOL(<data>).


data(msz2) =  <data>-%MSG  .


data(MSZTY) = SY-msgty .
DATA(MSZ_1)  = | { SY-msgv1 } { SY-msgv2 }  { SY-msgv3 } { SY-msgv4 } Message Type- { SY-msgty } Message No { sy-msgno } { SY-msgid } |  .

ENDLOOP .

IF commit_failed-materialdocumentitem IS INITIAL .

CLEAR mszty .

ENDIF  .

else.


    LOOP AT ls_create_mapped-materialdocument ASSIGNING FIELD-SYMBOL(<keys_header>).

    IF MSZTY = 'E' .
EXIT .
ENDIF .

      CONVERT KEY OF i_materialdocumenttp
      FROM <keys_header>-%pid
      TO <keys_header>-%key .
    ENDLOOP.


    LOOP AT ls_create_mapped-materialdocumentitem ASSIGNING FIELD-SYMBOL(<keys_item>).


IF MSZTY = 'E' .
EXIT .
ENDIF .

      CONVERT KEY OF i_materialdocumentitemtp
      FROM <keys_item>-%pid
      TO <keys_item>-%key.
    ENDLOOP.

ENDIF.

     COMMIT ENTITIES END.

 data result type string .
data result1 type string .

  IF MSZTY = 'E' .

result = |ERROR { MSZ_1 } |.

ELSE .

 result = <keys_header>-MaterialDocument .
 result1 = <keys_header>-MaterialDocumentYear .

ENDIF.

DATA WAItem TYPE zpp_dyec_chemica .


if result is NOT INITIAL and  result1 is NOT INITIAL .

LOOP AT respo-tabledata INTO data(wa).

   READ TABLE RESPO-tabledataarray3 WITH KEY recipe = WA-recipedes INTO DATA(WA_GS) .
    waitem-recipecostmtr       =  WA_GS-recipecostmtr.
   WAItem-alreadycqty          =     wa-ResvnItmWithdrawnQtyInBaseUnit .
   WAItem-chemical             =    wa-product .
   WAItem-consbatch            =     wa-batch.
   WAItem-consloc              =    WA-storagelocation .
   WAItem-consqty              =    wa-consqty .
   WAItem-dyeingsort           =    respo-dysort.
   WAItem-feedltr              =    wa-feed_ltr.
   WAItem-lastusedgpl          =    wa-last_use_gpl.
   WAItem-matdes               =    wa-productdescription.
   WAItem-materialdocumentno   =   result.
   WAItem-materialdocumentyear =   result1.
   WAItem-orderno              =    |{ respo-orderno ALPHA = IN }|.
   WAItem-plant                =    respo-plant.
   WAItem-poastingdate         =    respo-date.
   WAItem-prodgpl              =    wa-prodgpl.
   WAItem-reciepeno            =    wa-recipedes.
   WAItem-setno                =    wa-setnumber.
   WAItem-reqqty               =    wa-ResvnItmRequiredQtyInBaseUnit .
   WAItem-zunitkg              =    'KG' .
   WAItem-zunitm               =   'L' .
   WAItem-bathadjustment       = wa-bathadjustment .
   WAItem-stdgpl               =    wa-stdgpl .
   waitem-costpermtr           = wa-costpermtr .

   MODIFY zpp_dyec_chemica FROM @WAItem  .

ENDLOOP.

    DATA TABRESULT TYPE STRING.
     IF sy-subrc IS INITIAL.
          TABRESULT =  ' Data Saved!! ' .
        ELSE.
          TABRESULT = 'Error in saving data!!' .
        ENDIF.

      COMMIT WORK AND WAIT.

ENDIF.


      lv   = |Material Document'  '{ result }'  'Posted'|  .


    response->set_text(  lv   ).

ENDIF.


  endmethod.
ENDCLASS.
