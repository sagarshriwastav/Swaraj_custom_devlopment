class ZCL_PP_TROLLY_TF_HTTP definition
  public
  create public .
********************CREATED GAJENDRA SINGH SHEKHAWAT*************************************************************
public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_PP_TROLLY_TF_HTTP IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.


    DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).




    DATA(body)  = request->get_text(  )  .
    DATA sddocument TYPE znumc12 .
    DATA sddocumentITEM TYPE N LENGTH 6 .

    DATA respo  TYPE ztrolly_tf .
     xco_cp_json=>data->from_string( body )->write_to( REF #( respo ) ).





      READ TABLE respo-tabledata into data(T1) INDEX 1.
      sddocument = t1-sddocument.

 data  totalqty1 type  string.
 data result type string .
data result1 type string .


 if sddocument is  INITIAL .

 MODIFY ENTITIES OF i_materialdocumenttp
             ENTITY MaterialDocument
             CREATE FROM VALUE #( ( %cid                          = 'My%CID_1'
                                    goodsmovementcode             = '04'
                                    postingdate                   = sy-datum
                                    documentdate                  =   sy-datum
                                    %control-goodsmovementcode                    = cl_abap_behv=>flag_changed
                                    %control-postingdate                          = cl_abap_behv=>flag_changed
                                    %control-documentdate                         = cl_abap_behv=>flag_changed
                                ) )

*FF001
*FF001A  1.  FN01  2 . FG01
             ENTITY MaterialDocument
             CREATE BY \_MaterialDocumentItem
             FROM VALUE #( (
                             %cid_ref = 'My%CID_1'
                             %target = VALUE #( FOR any IN respo-tabledata index INTO i  ( %cid                           = |My%CID_{ i }_001|
                                                  plant                          = any-plant
                                                  material                       = any-material
                                                  GoodsMovementType              = '311'
                                                  storagelocation                = any-storagelocation
                                                  QuantityInEntryUnit            =  any-matlwrhsstkqtyinmatlbaseunit
                                                  entryunit                      = 'M'
                                                  Batch                          = any-batch
                                                  IssuingOrReceivingPlant        = any-plant
                                                  IssuingOrReceivingStorageLoc   = respo-receivingsloc
                                                  IssgOrRcvgBatch                = any-batch
                                                  IssgOrRcvgSpclStockInd         = ''
*                                                  ManufacturingOrder             = '000001000057'
*                                                  GoodsMovementRefDocType        = 'F'
*                                                  IsCompletelyDelivered          = ' '
                                                  MaterialDocumentItemText       =    any-remark   " 'Trolly Transfer'
                                                  %control-plant                 = cl_abap_behv=>flag_changed
                                                  %control-material              = cl_abap_behv=>flag_changed
                                                  %control-GoodsMovementType     = cl_abap_behv=>flag_changed
                                                  %control-storagelocation       = cl_abap_behv=>flag_changed
                                                  %control-QuantityInEntryUnit   = cl_abap_behv=>flag_changed
                                                  %control-entryunit             = cl_abap_behv=>flag_changed
                                              ) )


                         ) )
             MAPPED   DATA(ls_create_mapped)
             FAILED   DATA(ls_create_failed)
             REPORTED DATA(ls_create_reported).

  COMMIT ENTITIES BEGIN
   RESPONSE OF i_materialdocumenttp
   FAILED DATA(commit_failed)
   REPORTED DATA(commit_reported).
**************


   If ls_create_mapped-materialdocument  is INITIAL.

 loop at  commit_reported-materialdocumentitem ASSIGNING FIELD-SYMBOL(<data>).
* IF <data>-%msg IS NOT INITIAL.

data(msz) =  <data>-%MSG  .
*ENDIF.

DATA(MSZTY) = SY-msgty .
DATA(MSZ_1)  = | { SY-msgv1 } { SY-msgv2 }  { SY-msgv3 } { SY-msgv4 } Message Type- { SY-msgty } Message No { sy-msgno }  |  .

ENDLOOP .

**************************
else.



    LOOP AT ls_create_mapped-materialdocument ASSIGNING FIELD-SYMBOL(<keys_header>).
*****
IF MSZTY = 'E' .
EXIT .
ENDIF .
***

      CONVERT KEY OF i_materialdocumenttp
      FROM <keys_header>-%pid
      TO <keys_header>-%key .
    ENDLOOP.


    LOOP AT ls_create_mapped-materialdocumentitem ASSIGNING FIELD-SYMBOL(<keys_item>).
*********

IF MSZTY = 'E' .
EXIT .
ENDIF .

      CONVERT KEY OF i_materialdocumentitemtp
      FROM <keys_item>-%pid
      TO <keys_item>-%key.
    ENDLOOP.

ENDIF.

     COMMIT ENTITIES END.

* data result type string .
* data result1 type string .

    IF  MSZTY = 'E' .

result = |ERROR { MSZ_1 } |.

ELSE .
**DATA(GRN)  = <keys_header>-MaterialDocument .

**result = <keys_header>-MaterialDocument .
  DATA   JSON   TYPE STRING.

  CONCATENATE  ' Material Document '  <keys_header>-MaterialDocument   ' Post Successfuly '  INTO JSON SEPARATED BY ' '.



DATA(GRN1)  = <keys_header>-MaterialDocument .


result = JSON .
result1 = <keys_header>-MaterialDocumentYear.

DATA(MATDOC) = <keys_header>-MaterialDocument .


ENDIF .



    ELSEIF  sddocument is NOT INITIAL .



      MODIFY ENTITIES OF i_materialdocumenttp
                ENTITY materialdocument
                CREATE FROM VALUE #( ( %cid                          = 'My%CID_1'
                                       goodsmovementcode             = '04'
                                       postingdate                   = sy-datum
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

                                                  plant                          = any1-plant
                                                  material                       = any1-material
                                                  GoodsMovementType              = '311'
                                                  storagelocation                = any1-storagelocation
                                                  QuantityInEntryUnit            =  any1-matlwrhsstkqtyinmatlbaseunit
                                                  entryunit                      = 'M'
                                                  Batch                          = any1-batch
                                                  IssuingOrReceivingPlant        = any1-plant
                                                  IssuingOrReceivingStorageLoc   = respo-receivingsloc
                                                  IssgOrRcvgBatch                = any1-batch
                                                  IssgOrRcvgSpclStockInd         = 'E'
                                                  InventorySpecialStockType      = 'E'
                                                  SpecialStockIdfgSalesOrder     =  |{ ANY1-sddocument ALPHA = IN }|
                                                  SpecialStockIdfgSalesOrderItem  =  |{ ANY1-sddocumentitem ALPHA = IN }|
*                                                  ManufacturingOrder            = '000001000057'
*                                                  GoodsMovementRefDocType       = 'F'
*                                                  IsCompletelyDelivered         = ' '
                                                  MaterialDocumentItemText       =   any1-remark "  'Trolly Transfer'
                                                  %control-plant                 = cl_abap_behv=>flag_changed
                                                  %control-material              = cl_abap_behv=>flag_changed
                                                  %control-GoodsMovementType     = cl_abap_behv=>flag_changed
                                                  %control-storagelocation       = cl_abap_behv=>flag_changed
                                                  %control-QuantityInEntryUnit   = cl_abap_behv=>flag_changed
                                                  %control-entryunit             = cl_abap_behv=>flag_changed
                                                 )     )


                            ) )
               MAPPED   DATA(ls_create_mapped1)
                FAILED   DATA(ls_create_failed1)
                REPORTED DATA(ls_create_reported1).




    COMMIT ENTITIES BEGIN
     RESPONSE OF i_materialdocumenttp
     FAILED DATA(commit_failed1)
     REPORTED DATA(commit_reported1).

  If ls_create_mapped1-materialdocument is INITIAL.
loop at  commit_reported1-materialdocumentitem ASSIGNING FIELD-SYMBOL(<data2>).

* IF  <data2>-%MSG  IS NOT INITIAL .

data(msz2) =  <data2>-%MSG  .

*ENDIF.

MSZTY = SY-msgty .
MSZ_1  = | { SY-msgv1 } { SY-msgv2 }  { SY-msgv3 } { SY-msgv4 } Message Type- { SY-msgty } Message No { sy-msgno } { SY-msgid } |  .

ENDLOOP .
************************************

else.

    LOOP AT ls_create_mapped1-materialdocument ASSIGNING FIELD-SYMBOL(<keys_header1>).
IF MSZTY = 'E' .
EXIT .
ENDIF .


      CONVERT KEY OF i_materialdocumenttp
      FROM <keys_header1>-%pid
      TO <keys_header1>-%key .
    ENDLOOP.


    LOOP AT ls_create_mapped1-materialdocumentitem ASSIGNING FIELD-SYMBOL(<keys_item1>).
    IF MSZTY = 'E' .
EXIT .
ENDIF .

*
      CONVERT KEY OF i_materialdocumentitemtp
      FROM <keys_item1>-%pid
      TO <keys_item1>-%key.
    ENDLOOP.

ENDIF.

     COMMIT ENTITIES END.
*******************************
     IF MSZTY = 'E' .

result = |ERROR { MSZ_1 } |.

ELSE .


  CONCATENATE  ' Material Document '  <keys_header1>-MaterialDocument   ' Post Successfuly '  INTO JSON  SEPARATED BY ' ' .

  GRN1  = <keys_header1>-MaterialDocument .

* result = <keys_header1>-MaterialDocument .
result = JSON.
result1 = <keys_header1>-MaterialDocumentYear .
  MATDOC  = <keys_header1>-MaterialDocument .

ENDIF.


ENDIF.

IF GRN1 is not INITIAL  .

if respo-trollynumber is not INITIAL .
DATA WA TYPE ztrolly_tf_table .

WA-trollyno = RESPO-trollynumber.
WA-dataoptn = RESPO-dataentryoperator.
WA-fnmc = RESPO-finishmc.
WA-headremark = RESPO-headerremark.
WA-materialdoc = MATDOC.
WA-materialdocyear = result1.
WA-noofpec = RESPO-noofpieces.
WA-optname = respo-operatorname.
WA-poastingdate = RESPO-postingdate.
WA-shift = RESPO-shift.
WA-storagelocation = RESPO-stocloc.
WA-totqty = RESPO-totalqty.



 MODIFY ztrolly_tf_table FROM @wa  .
      COMMIT WORK AND WAIT.

    ENDIF.
    ENDIF.

   response->set_text( result ) .


******261 End*****




  endmethod.
ENDCLASS.
