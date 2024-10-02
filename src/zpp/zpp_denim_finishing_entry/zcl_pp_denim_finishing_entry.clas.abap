class ZCL_PP_DENIM_FINISHING_ENTRY definition
  public
  create public .
********************CREATED GAJENDRA SINGH SHEKHAWAT*************************************************************
public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
   CLASS-METHODS
      get_mat
        IMPORTING VALUE(mat)      TYPE i_product-Product
        RETURNING VALUE(material) TYPE char18.
protected section.
private section.
ENDCLASS.



CLASS ZCL_PP_DENIM_FINISHING_ENTRY IMPLEMENTATION.


  METHOD get_mat.
    DATA matnr TYPE char18.

    matnr = |{ mat ALPHA = IN }|.
    material = matnr.
  ENDMETHOD.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.



     DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).

      DATA(body)  = request->get_text(  )  .

              DATA respo  TYPE zpp_denim_fin_str .

              DATA productionorder TYPE N LENGTH 12 .

     xco_cp_json=>data->from_string( body )->write_to( REF #( respo ) ).



        READ TABLE respo-atablearr1 into data(T1) INDEX 1.

    productionorder  =    |{ t1-orderno ALPHA = IN }|.

**** Validation *****
DATA totalqty TYPE string .
data result type string .
  DATA Json TYPE string.

    SELECT SINGLE OrderIsReleased , IsMarkedForDeletion,OrderIsTechnicallyCompleted FROM I_MFGORDERWITHSTATUS  as a
    LEFT OUTER JOIN I_ManufacturingOrder as b ON ( b~ManufacturingOrder = a~ManufacturingOrder )
    WHERE a~ManufacturingOrder = @productionorder INTO @DATA(CHEAKORD) .

    IF ( CHEAKORD-OrderIsReleased IS  INITIAL AND CHEAKORD-OrderIsTechnicallyCompleted is INITIAL ) OR CHEAKORD-IsMarkedForDeletion IS NOT INITIAL    .

    IF CHEAKORD-OrderIsReleased IS  INITIAL AND CHEAKORD-OrderIsTechnicallyCompleted is INITIAL.

    DATA lv TYPE string .
    LV  = 'ERROR Order Is Not Released. Please Release The Order fIRST. '.
   response->set_text(  lv   ).

   ELSEIF  CHEAKORD-IsMarkedForDeletion IS NOT INITIAL .

     LV  = 'ERROR Order Is  Deleted. Please Cheack The Order fIRST. '.
   response->set_text(  lv   ).

   ENDIF.

else .
  DATA partycode1 TYPE C LENGTH 10.
  DATA ORDERNO TYPE C LENGTH 10.

Loop AT respo-atablearr1 into data(wa_respo).

    partycode1 = |{ wa_respo-partycode ALPHA = IN }| .
    ORDERNO    = |{ wa_respo-orderno ALPHA = IN }| .
 SELECT sum( case when DebitCreditCode = 'S' THEN QuantityInBaseUnit ELSE QuantityInBaseUnit * -1 END )
 AS qty
 FROM I_MATERIALdocumentitem_2
      WHERE BATCH = @WA_RESPO-finishrollno AND Material = @wa_respo-ffmaterial AND Supplier = @partycode1
      AND Plant = @respo-plant AND OrderID = @ORDERNO AND GoodsMovementType IN ( '101','102' )
      INTO @DATA(qty).
if  qty > 0  .
json  = |{ 'ERROR' } && { WA_RESPO-finishrollno } && { 'Batch Already POSTED' } |.
           response->set_text( json  ).
 EXIT.
ENDIF.
clear:  partycode1 , ORDERNO.
ENDLOOP.

  IF json IS  INITIAL  .


**** Validation *****
******101*****
IF productionorder is NOT INITIAL.
      MODIFY ENTITIES OF i_materialdocumenttp
                ENTITY materialdocument
                CREATE FROM VALUE #( ( %cid                          = 'My%CID_1'
                                       goodsmovementcode             = '02'
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
                                %target = VALUE #( FOR any IN respo-atablearr1 INDEX INTO i ( %cid                           = |My%CID_{ i }_001|
                                                     plant                          = respo-plant
                                                     material                       =  get_mat( mat = any-ffmaterial )              "'YGI1Z14N02009040'
                                                     goodsmovementtype              = '101'
                                                     storagelocation                = respo-recloc "'YG01'
                                                     batch                          = any-finishrollno
                                                     quantityinentryunit            =  any-finishmtr
                                                     entryunit                      = 'M'
                                                     manufacturingorder             = |{ ANY-orderno ALPHA = IN }|
                                                     goodsmovementrefdoctype        = 'F'
                                                     iscompletelydelivered          = ' '
                                                     materialdocumentitemtext       = any-finishrollno
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

 IF commit_failed-materialdocument IS NOT INITIAL .

     LOOP AT  commit_reported-materialdocumentitem ASSIGNING FIELD-SYMBOL(<data>).

          DATA(msz) =  <data>-%msg  .

          DATA(mszty) = sy-msgty .
          DATA(msz_1)  = | { sy-msgv1 } { sy-msgv2 }  { sy-msgv3 } { sy-msgv4 } Message Type- { sy-msgid } Message No { sy-msgno }  |  .

        ENDLOOP .

IF msz_1 = '' .

 LOOP AT  commit_reported-materialdocument ASSIGNING FIELD-SYMBOL(<Hddata>).

          msz =  <Hddata>-%msg  .

          mszty = sy-msgty .
          msz_1 = commit_reported-materialdocument[ 1 ]-%msg->if_message~get_text( ).
        ENDLOOP .
ENDIF.

IF commit_failed-materialdocument IS INITIAL .

CLEAR mszty .
ENDIF .

ELSE .

   LOOP AT ls_create_mapped-materialdocument ASSIGNING FIELD-SYMBOL(<keys_header>).

     IF MSZTY = 'E' OR MSZTY = 'W'.
EXIT .
ENDIF .

      CONVERT KEY OF i_materialdocumenttp
      FROM <keys_header>-%pid
      TO <keys_header>-%key .
    ENDLOOP.


    LOOP AT ls_create_mapped-materialdocumentitem ASSIGNING FIELD-SYMBOL(<keys_item>).
*
 IF MSZTY = 'E' OR MSZTY = 'W'.
EXIT .
ENDIF .

      CONVERT KEY OF i_materialdocumentitemtp
      FROM <keys_item>-%pid
      TO <keys_item>-%key.
    ENDLOOP.

ENDIF.
    COMMIT ENTITIES END.

IF  MSZTY = 'E' OR MSZTY = 'W' OR MSZ_1 <> ' '.

result = |ERROR { MSZ_1 } |.

ELSE .

IF msz_1 = ''.
DATA(GRN)  = <keys_header>-MaterialDocument .
* data result type string .
data result1 type string .

result = <keys_header>-MaterialDocument .
result1 = <keys_header>-MaterialDocumentYear.
ENDIF.


ENDIF.

DATA TABRESULT TYPE STRING.


ENDIF.
*********261*******
loop at  respo-atablearr1  assigning FIELD-SYMBOL(<WAT>).
 IF <WAT>-soitem EQ '0'.
 <WAT>-soitem = ''.
 <WAT>-ind = ''.
 else.
<WAT>-soitem = |{ <WAT>-soitem ALPHA = IN }| .
<WAT>-ind = 'E'.
ENDIF.
endloop.

IF result IS NOT INITIAL AND  result1 IS NOT INITIAL .

DATA WZPPGREY TYPE zpp_finishing .
DATA soorder_gs TYPE C LENGTH 10 .

LOOP AT respo-atablearr1 ASSIGNING FIELD-SYMBOL(<FS>) .

 soorder_gs =  |{ <FS>-soorder ALPHA = IN }| .

   WZPPGREY-actualmtr  = <FS>-actualmtr.
   WZPPGREY-consloc    = respo-consloc.
   WZPPGREY-finishmtr   = <FS>-finishmtr.
   WZPPGREY-finishrollno = <FS>-finishrollno.
   WZPPGREY-greigebatch   = <FS>-greigebatch.
   WZPPGREY-greigemtr     = <FS>-greigemtr.
   WZPPGREY-material101   =  get_mat( mat =  <FS>-ffmaterial ).
   WZPPGREY-material261   =  get_mat( mat =  <FS>-consmaterial ).
   WZPPGREY-materialdocument101 = result .
   WZPPGREY-materialdocumentyear101  = result1.
   WZPPGREY-mcno         = respo-machineno .
   WZPPGREY-orderno      = |{ <FS>-orderno ALPHA = IN }|.
   WZPPGREY-partyname    = <FS>-partyname.
   WZPPGREY-plant       = respo-plant .
   WZPPGREY-postingdate  = respo-postingdate.
   WZPPGREY-recloc      = respo-recloc .
   WZPPGREY-salesorder  = soorder_gs.
   WZPPGREY-soitem      = |{ <FS>-soitem ALPHA = IN }|.
   WZPPGREY-setno       = <FS>-setno.
   WZPPGREY-shadeno     = <FS>-shadeno .
   WZPPGREY-shift      = respo-shift .
   WZPPGREY-shrinkageperc = <FS>-shrinkageper .
   WZPPGREY-sno    = <FS>-sno .
   WZPPGREY-trollyno   = <FS>-trollyno .
   WZPPGREY-zunit      = 'M' .
   WZPPGREY-route      = <FS>-route .
   WZPPGREY-remark    = <FS>-remark .
   WZPPGREY-peice    =     <FS>-peiceno.
   WZPPGREY-loomnumber = <FS>-loomno .
   WZPPGREY-regnumber  = <FS>-registerbatchno .
   WZPPGREY-optname   =  respo-operatorname .
   wzppgrey-setpeiceno = <FS>-setpcno .
   wzppgrey-supplier  =  |{ <FS>-partycode ALPHA = IN }|.
   wzppgrey-greywidth  =   <FS>-greywidth .

 MODIFY zpp_finishing FROM @WZPPGREY  .

 CLEAR  : soorder_gs.
 ENDLOOP .

      MODIFY ENTITIES OF i_materialdocumenttp
                ENTITY materialdocument
                CREATE FROM VALUE #( ( %cid                          = 'My%CID_1'
                                       goodsmovementcode             = '03'
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
                                %target = VALUE #( FOR any1 IN respo-atablearr1 INDEX INTO i ( %cid                           = |My%CID_{ i }_001|
                                                     plant                          = respo-plant
                                                     material                       = get_mat( mat = any1-consmaterial )             "'YGI1Z14N02009040'
                                                     goodsmovementtype              = '261'
                                                     storagelocation                =  respo-consloc  "'YG01'
                                                     batch                          =  any1-greigebatch
                                                     quantityinentryunit            =  any1-greigemtr
                                                     entryunit                      =  ''
                                                     manufacturingorder             =  |{ ANY1-orderno ALPHA = IN }|
                                                     goodsmovementrefdoctype        = ' '

                                                     SpecialStockIdfgSalesOrder                     = |{ ANY1-soorder ALPHA = IN }|

                                                     SpecialStockIdfgSalesOrderItem                 =  |{ ANY1-soitem ALPHA = IN }| " '000010'  " ANY1-soitem

**                                                    SpecialStockIdfgSalesOrder      =  'E'
**                                                    SpecialStockIdfgSalesOrderItem  =  'E'
                                                    InventorySpecialStockType       =     any1-ind
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
               MAPPED   DATA(ls_create_mapped2)
                FAILED   DATA(ls_create_failed2)
                REPORTED DATA(ls_create_reported2).




    COMMIT ENTITIES BEGIN
     RESPONSE OF i_materialdocumenttp
     FAILED DATA(commit_failed2)
     REPORTED DATA(commit_reported2).

     IF commit_failed2-materialdocument IS NOT INITIAL .

     LOOP AT  commit_reported2-materialdocumentitem ASSIGNING FIELD-SYMBOL(<data2>).

          DATA(msz2) =  <data2>-%msg  .

          DATA(mszty2) = sy-msgty .
          DATA(msz_12)  = | { sy-msgv1 } { sy-msgv2 }  { sy-msgv3 } { sy-msgv4 } Message Type- { sy-msgid } Message No { sy-msgno }  |  .

        ENDLOOP .

IF commit_failed2-materialdocument IS INITIAL .

CLEAR mszty2 .
ENDIF .

ELSE .


   LOOP AT ls_create_mapped2-materialdocument ASSIGNING FIELD-SYMBOL(<keys_header1>).

IF MSZTY2 = 'E' OR MSZTY2 = 'W' .
EXIT .
ENDIF .

      CONVERT KEY OF i_materialdocumenttp
      FROM <keys_header1>-%pid
      TO <keys_header1>-%key .
    ENDLOOP.


    LOOP AT ls_create_mapped2-materialdocumentitem ASSIGNING FIELD-SYMBOL(<keys_item1>).

IF MSZTY2 = 'E' OR MSZTY2 = 'W' .
EXIT .
ENDIF .
*
      CONVERT KEY OF i_materialdocumentitemtp
      FROM <keys_item1>-%pid
      TO <keys_item1>-%key.
    ENDLOOP.

ENDIF.

COMMIT ENTITIES END.


  IF  MSZTY2 = 'E' OR MSZTY2 = 'W' .

DATA(result2) = |ERROR { MSZ_12 } |.

ELSE .

  GRN  = <keys_header1>-MaterialDocument .

result2 = <keys_header1>-MaterialDocument .
DATA(GS_result2) = <keys_header1>-MaterialDocument .
DATA(result21) = <keys_header1>-MaterialDocumentYear.

ENDIF.

******261 End********************************************************************************************************

****************************261 DOCUMENT NOT GENERATED(101 REVERSE)**************************************************
IF result IS NOT INITIAL AND result1 IS NOT INITIAL AND GS_result2 IS INITIAL .

 LOOP AT respo-atablearr1 ASSIGNING FIELD-SYMBOL(<GSS1>) .

   DATA(mat) =  get_mat( mat = <GSS1>-ffmaterial ) .
              UPDATE zpp_finishing SET error261 = @result2  WHERE
              plant = @RESPO-plant AND  material101 = @mat AND setno = @<GSS1>-setno AND
              finishrollno = @<GSS1>-finishrollno AND materialdocument101 = @result AND materialdocumentyear101 = @result1.
clear:mat.
ENDLOOP .

 CONCATENATE 'GS261' result '/' result1 INTO json SEPARATED BY ' '.

ENDIF.

****************************261 DOCUMENT NOT GENERATED(101 REVERSE)**************************************************

********************************Table Save ***************************
DATA WZPPGREY1 TYPE zpp_finishing .
DATA NUMC4 TYPE N LENGTH 4.
if json is INITIAL AND result IS NOT INITIAL AND result1 IS NOT INITIAL
                   AND result2 IS NOT INITIAL AND result21 IS NOT INITIAL .

LOOP AT respo-atablearr1 ASSIGNING FIELD-SYMBOL(<FS1>) .
     NUMC4    =  NUMC4 + 001.
     mat =  get_mat( mat = <FS1>-ffmaterial ) .
              UPDATE zpp_finishing SET materialdocument261 = @result2 , materialdocumentyear261 = @result21 WHERE
              plant = @RESPO-plant AND  material101 = @mat AND setno = @<FS1>-setno AND
               finishrollno = @<FS1>-finishrollno AND materialdocument101 = @result AND materialdocumentyear101 = @result1.

      COMMIT WORK AND WAIT.
ENDLOOP .

   IF sy-subrc IS INITIAL.
          TABRESULT =  ' Data Saved!! ' .
   ELSE.
          TABRESULT = 'ERROR in saving data!!' .
   ENDIF.

   COMMIT WORK AND WAIT.
********************************Table Save ***************************

 IF MSZTY = 'E' OR MSZTY = 'W' .
    json   =   result.
ELSE .
CONCATENATE 'Matterial Document' result '/' result2 'Post Sucessfully And Table' TABRESULT  INTO json SEPARATED BY ' '.
ENDIF.

ENDIF.
ENDIF.

  response->set_text( json  ).


ENDIF.
ENDIF.

endmethod.
ENDCLASS.
