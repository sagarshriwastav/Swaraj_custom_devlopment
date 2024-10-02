class ZCL_MM_GREY_RECEIPT_MODULE_HTT definition
  public
  create public .

public section.
********************CREATED GAJENDRA SINGH SHEKHAWAT*************************************************************
  interfaces IF_HTTP_SERVICE_EXTENSION .
     DATA S TYPE STRING.
     DATA : N2 TYPE  STRING.


  CLASS-METHODS
      get_mat
        IMPORTING VALUE(mat)      TYPE i_product-Product
        RETURNING VALUE(material) TYPE char18.

protected section.
private section.
ENDCLASS.



CLASS ZCL_MM_GREY_RECEIPT_MODULE_HTT IMPLEMENTATION.


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

              DATA respo  TYPE zmm_grey_rec_mod_pool_str .

              DATA productionorder TYPE N LENGTH 12 .
                 DATA json TYPE STRING .

     xco_cp_json=>data->from_string( body )->write_to( REF #( respo ) ).

LOOP AT respo-tabledataarray INTO DATA(WA_CHECK) .

   SELECT SINGLE internalbatch FROM zmm_grey_receipt
          WHERE internalbatch = @WA_CHECK-finishroll INTO @DATA(internalbatch) .
   IF SY-subrc = 0 .
   IF  internalbatch IS NOT INITIAL .
    json  = |{ 'ERROR' }  { WA_CHECK-finishroll }  { 'Internal Batch Already Posted' }|.
           response->set_text( json  ).
   EXIT.
   ENDIF.
   ENDIF.
  SELECT SINGLE matdocument , partychlaan FROM ZMM_GREY_RECEIPT_CHECK WHERE Piecenumber = @WA_CHECK-piecenumber
                                                          AND supplier = @wa_check-supplier
                                                          and FiscalYear <> '2023'
                                                          AND Itemcode =  @wa_check-itemcode INTO @DATA(CHEACK) .
  IF CHEACK IS NOT INITIAL .

    json  = |{ 'ERROR' }  { WA_CHECK-piecenumber }  { 'Piece Already Received in Challan' } { CHEACK-partychlaan }|.
           response->set_text( json  ).
 EXIT.
  ENDIF.

ENDLOOP.

LOOP AT respo-tabledataarray INTO DATA(PO_CHECK) .

SELECT SINGLE EBELN  FROM  ygateitem_proj
          WHERE EBELN = @PO_CHECK-PO INTO @DATA(PO) .

*     IF SY-subrc = 0 .

          if  po is INITIAL .

   json  = |{ 'ERROR' }  { PO }  { 'Gate Entry Is Pending for this PURCHASE ORDER ' }  |.
           response->set_text( json  ).

 EXIT.
 ENDIF.
*************************************prem singh**************************
 LOOP AT respo-tabledataarray INTO DATA(PIECE_CHECK) .

     SELECT SINGLE * FROM  zsubcon_item  WHERE rollno = @piece_check-piecenumber
           AND Party = @piece_check-supplier INTO @DATA(PIECE) .

           IF piece IS  INITIAL .

   json  = |{ 'ERROR' } { piece-rollno } { 'Folding Entry is Pending ' }  |.
             response->set_text( json  ).
      ENDIF.
      ENDLOOP.
*****************************end*********************************
ENDLOOP.

  IF json IS INITIAL .
   DATA :  WA_ta type zmm_grey_rec_mod_pool_str3.

   READ TABLE respo-tabledataarray INTO DATA(WA) INDEX 1 .
********************************************DATA APPREND START 543 DATA******************************

  LOOP AT respo-tabledataarray1 INTO DATA(WA3) .


     WA_ta-sno = WA3-sno .
     WA_ta-descrption = WA3-descrption .
     WA_ta-grossweight   = '' .
     WA_ta-itemcode    = WA3-itemcode .
     WA_ta-loom      = '' .
     WA_ta-movtype    = WA3-movtype .
     WA_ta-netweight   = '' .
     WA_ta-partychlaan   = '' .
     WA_ta-permtravgweight  = '' .
     WA_ta-pick    = '' .
     WA_ta-piecenumber  = WA3-setnumber .
     WA_ta-po    = WA3-po .
     WA_ta-poitem  = WA3-poitem .
     WA_ta-qtylength  = WA3-reqqty .
      WA_ta-salesorder    = WA3-salesoder .
      WA_ta-solineitem   =  WA3-solineitem  .
     WA_ta-setnumber   = ' ' .

     WA_ta-supplier  = WA-supplier .
     WA_ta-tareweight  = '' .
     WA_ta-remark      =   wa3-remark .

   APPEND WA_TA TO respo-tabledataarray .

     ENDLOOP.


********************************************DATA APPREND END 543 DATA******************************



********************************************DATA SORT PO POITEN SNO 101 -> 543 DATA************
     SORT respo-tabledataarray  BY po poitem  sno movtype .


********************************************DATA START APPREND materialdocumentline materialdocumentparentline
****                                              101 -> 543 DATA******************************
  LOOP AT respo-tabledataarray assigning FIELD-SYMBOL(<WA_GA>) .
              S = S + 1.
 IF <WA_GA>-movtype = '101' .
              N2 = S .
    IF <WA_GA>-solineitem EQ '0'.
 <WA_GA>-solineitem = ''.
 <WA_GA>-InventorySpecialStockType = ''.
 else.
<WA_GA>-solineitem = |{ <WA_GA>-solineitem ALPHA = IN }| .
<WA_GA>-InventorySpecialStockType = 'E'.
ENDIF.

      <WA_GA>-materialdocumentline    =   S .
      <WA_GA>-materialdocumentparentline =  '0'  .
      <WA_GA>-specialstockidfgsalesorder  = <WA_GA>-salesorder .
      <WA_GA>-specialstockidfgsalesorderitem = <WA_GA>-solineitem .
      <WA_GA>-SalesOrderScheduleLine =  '0' .
      <WA_GA>-unitz    = 'M' .

  ELSEIF   <WA_GA>-movtype = '543' .
     IF <WA_GA>-solineitem EQ '0'.
 <WA_GA>-solineitem = ''.
 <WA_GA>-InventorySpecialStockType = 'O'.
 else.
<WA_GA>-solineitem = |{ <WA_GA>-solineitem ALPHA = IN }| .
<WA_GA>-InventorySpecialStockType = 'F'.
ENDIF.

    SELECT SINGLE Baseunit FROM ZMM_GREY_RECEIPT_MAT WHERE Material = @<WA_GA>-itemcode INTO @DATA(UNITWA) .

      <WA_GA>-materialdocumentline    =   S .
      <WA_GA>-materialdocumentparentline =  N2  .
      <WA_GA>-specialstockidfgsalesorder  = '' .
      <WA_GA>-specialstockidfgsalesorderitem = '' .
      <WA_GA>-SalesOrderScheduleLine =  ' ' .
       <WA_GA>-unitz    = UNITWA .


  ENDIF.
   COMMIT WORK AND WAIT.
     ENDLOOP.


********************************************DATA END  APPREND materialdocumentline materialdocumentparentline
****                                                   101 -> 543 DATA******************************



********************************************CHECK CONSUMPTION QUANTITY START**********************************
DATA(it1) = respo-tabledataarray[].
DATA(it_FIN) = respo-tabledataarray[].
FREE:it_FIN[].
DATA(it2) = it1[].
sORT IT2 ASCENDING BY piecenumber.
SORT IT1 ASCENDING BY piecenumber.
DELETE ADJACENT DUPLICATES FROM IT1 COMPARING piecenumber.
DATA MENGE1 TYPE menge_d .
  LOOP AT it1 ASSIGNING FIELD-SYMBOL(<ft>).

  LOOP AT iT2 INTO DATA(wt) WHERE piecenumber = <ft>-piecenumber.
  MENGE1 = MENGE1 + WT-qtylength.
  APPEND WT TO it_FIN.
  ENDLOOP.
  CLEAR:wt.
  WT-movtype = <ft>-movtype .
  wt-cheack = 'X'.
  wt-qtylength = MENGE1.
  WT-piecenumber = <ft>-piecenumber .
  WT-supplier   =   <ft>-supplier .
  APPEND WT TO it_FIN.
  CLEAR:MENGE1.
  ENDLOOP.

 DELETE it_FIN WHERE cheack <> 'X' .
 DELETE it_FIN WHERE  movtype <> '543' .

DATA SUPPLIER_GS TYPE C LENGTH 10 .
 Loop AT it_FIN into data(wa_respo).
    SUPPLIER_GS =   |{ wA_RESPO-supplier ALPHA = IN }| .
 SELECT sum( MatlWrhsStkQtyInMatlBaseUnit )
 AS qty
 FROM I_MaterialStock_2
      WHERE BATCH = @WA_RESPO-piecenumber AND Supplier = @SUPPLIER_GS AND Plant = '1200'
      INTO @DATA(qty).

if  qty < wa_respo-qtylength.

json  = |{ 'ERROR' } { WA_RESPO-piecenumber } { 'CHECK CONSUMPTION QUANTITY' } |.

           response->set_text( json  ).
 EXIT.
ENDIF.
CLEAR:SUPPLIER_GS.
ENDLOOP.
********************************************CHECK CONSUMPTION QUANTITY END**********************************
********************************************DATA Start Bapi 543 And 101 Movmnt *****************************

 IF json IS INITIAL .

      MODIFY ENTITIES OF i_materialdocumenttp
                ENTITY materialdocument
                CREATE FROM VALUE #( ( %cid                          = 'My%CID_1'
                                       goodsmovementcode             = '01'
                                       postingdate                   =   RESPO-postingdate    " sy-datum
                                       documentdate                  =  respo-docdate " sy-datum
                                       ReferenceDocument             = Respo-challan
                                       MaterialDocumentHeaderText    = Respo-challan

                                       %control-goodsmovementcode                    = cl_abap_behv=>flag_changed
                                       %control-postingdate                          = cl_abap_behv=>flag_changed
                                       %control-documentdate                         = cl_abap_behv=>flag_changed
                                   ) )

                ENTITY materialdocument
                CREATE BY \_materialdocumentitem
                FROM VALUE #(   (
                                %cid_ref = 'My%CID_1'
                                %target = VALUE #( FOR any IN respo-tabledataarray  INDEX INTO i  (  %cid   = |My%CID_{ i }_001|
                                                     material                       = get_mat( mat = any-itemcode ) "  'FGO00090904'
                                                     plant                          =    '1200'
                                                     storagelocation                = 'PH01'

                                                     goodsmovementtype              =  any-movtype " '101'
                                                     InventorySpecialStockType      =  any-inventoryspecialstocktype  " 'E'
                                                     Supplier                       =  |{ any-supplier ALPHA = IN }| " '0001100157'
                                                     Customer                       =  ' '
                                                     quantityinentryunit            =   any-qtylength " '20'
                                                     entryunit                      =   any-unitz
                                                     PurchaseOrder                  =   |{ ANY-po ALPHA = IN }|  " '1430000052'
                                                     PurchaseOrderItem              =   |{ any-poitem ALPHA = IN }| "  '00010'
                                                     goodsmovementrefdoctype        = 'B'
                                                     materialdocumentitemtext       = any-remark
                                                     batch                          =  ANY-piecenumber    " '1062315HA'
                                                     GoodsMovementReasonCode        = '0'
                                                     IsCompletelyDelivered         =  ' '
                                                     MaterialDocumentLine           =   |{ ANY-materialdocumentline ALPHA = IN }| "  '1'
                                                     MaterialDocumentParentLine     =   |{ ANY-materialdocumentparentline ALPHA = IN }| " '0'
                                                     SpecialStockIdfgSalesOrder     =   |{ ANY-salesorder ALPHA = IN }|  "  '0070000004'
                                                     SpecialStockIdfgSalesOrderItem =   |{ ANY-solineitem ALPHA = IN }|    " '000010'
                                                     ReservationIsFinallyIssued      = ' '
                                                     SalesOrder                     =   |{ ANY-specialstockidfgsalesorder ALPHA = IN }|   " '0070000004'
                                                     SalesOrderItem                 =    |{ ANY-specialstockidfgsalesorderitem ALPHA = IN }| " '000010'
                                                     SalesOrderScheduleLine         =   ANY-salesorderscheduleline "  '0'

                                                 )

                                             )




                            ) )
                MAPPED   DATA(ls_create_mapped)
                FAILED   DATA(ls_create_failed)
                REPORTED DATA(ls_create_reported).




    COMMIT ENTITIES BEGIN
     RESPONSE OF i_materialdocumenttp
     FAILED DATA(commit_failed)
     REPORTED DATA(commit_reported).

  DATA result TYPE STRING .
  DATA TABRESULT TYPE STRING .

 IF commit_failed IS NOT INITIAL.

      DATA(message1) = commit_reported-materialdocumentitem[ 1 ]-%msg->if_message~get_text( ).
      result = |ERROR { message1 } |.

 ELSE.

    LOOP AT ls_create_mapped-materialdocument ASSIGNING FIELD-SYMBOL(<keys_header>).
      CONVERT KEY OF i_materialdocumenttp
              FROM <keys_header>-%pid
              TO <keys_header>-%key.
    ENDLOOP.
    LOOP AT ls_create_mapped-materialdocumentitem ASSIGNING FIELD-SYMBOL(<keys_item>).
      CONVERT KEY OF i_materialdocumentitemtp
              FROM <keys_item>-%pid
              TO <keys_item>-%key.
    ENDLOOP.
  message1  =  commit_reported-materialdocumentitem[ 1 ]-%msg->if_message~get_text( ).
  result = |{ message1 } |.

data result1 type string .
result = <keys_header>-MaterialDocument .
result1 = <keys_header>-MaterialDocumentYear.
 endif .
    COMMIT ENTITIES END.


********************************************DATA End Bapi 543 And 101 Movmnt ***************

IF result IS NOT INITIAL AND result1 IS NOT INITIAL.
      CONCATENATE 'Matterial Document' result  INTO json SEPARATED BY ' '.

     ELSE .
    json   =   result.

ENDIF.

  DATA WAItem TYPE zmm_grey_receipt .
IF result IS NOT INITIAL AND result1 IS NOT INITIAL .

LOOP AT respo-tabledataarray INTO DATA(WA_TAA) WHERE movtype = '101'.
    WAItem-descrption     =    WA_TAA-descrption .
    WAItem-grossweight      =   WA_TAA-grossweight .
    WAItem-itemcode         =   WA_TAA-itemcode   .
    WAItem-loom             = WA_TAA-loom  .
    WAItem-movtype          =         WA_TAA-movtype  .
    WAItem-netweight        =          WA_TAA-netweight .
    WAItem-partychlaan      =           WA_TAA-partychlaan.
    WAItem-permtravgweight  =              WA_TAA-permtravgweight .
    WAItem-pick             =  WA_TAA-pick .
    WAItem-piecenumber      =          WA_TAA-piecenumber.
    WAItem-po               =  WA_TAA-po.
    WAItem-poitem           =      WA_TAA-poitem .
    WAItem-qtylength        =         WA_TAA-qtylength.
    WAItem-salesorder       =         |{ WA_TAA-salesorder ALPHA = IN }|.
    WAItem-setnumber        =         WA_TAA-setnumber.
    WAItem-sno              =   WA_TAA-sno.
    WAItem-solineitem       =         |{ WA_TAA-solineitem ALPHA = IN }|.
    WAItem-supplier         =        WA_TAA-supplier.
    WAItem-suppliername     =            WA_TAA-suppliername.
    WAItem-tareweight       =          WA_TAA-tareweight.
    WAItem-matdocument      =   result.
    WAItem-matdocumentyear  = result1 .
    WAItem-partybeam       =  WA_TAA-partybeam .
    WAItem-internalbatch   = WA_TAA-finishroll .


 MODIFY zmm_grey_receipt FROM @WAItem  .
ENDLOOP.
 DATA TABRESULT1 TYPE STRING.
     IF sy-subrc IS INITIAL.
          TABRESULT1 =  ' Data Saved!! ' .
        ELSE.
          TABRESULT1 = 'Error in saving data!!' .
        ENDIF.

      COMMIT WORK AND WAIT.


  DATA WAItem543 TYPE zmm_grey_rec_453 .

 LOOP AT respo-tabledataarray1 INTO DATA(WA_TA1) .

 WAItem543-solineitem  =    |{ WA_TA1-solineitem ALPHA = IN }|.
 WAItem543-descrption   =    WA_TA1-descrption .
 WAItem543-itemcode     =    WA_TA1-itemcode .
 WAItem543-itemok       =    WA_TA1-itemok .
 WAItem543-movtype      =    WA_TA1-movtype .
 WAItem543-po          =    WA_TA1-po.
 WAItem543-poitem       =    WA_TA1-poitem.
 WAItem543-qtytlength    =    WA_TA1-qtytlength.
 WAItem543-remainingqty   =    WA_TA1-remainingqty.
 WAItem543-remark       =    WA_TA1-remark .
 WAItem543-reqqty        =    WA_TA1-reqqty .
 WAItem543-salesoder     =   |{ WA_TA1-salesoder ALPHA = IN }|.
 WAItem543-setnumber     =    WA_TA1-setnumber .
 WAItem543-sno          =    WA_TA1-sno.
 WAItem543-matdocument      =   result.
 WAItem543-matdocumentyear  = result1 .


 MODIFY zmm_grey_rec_453 FROM @WAItem543  .
 ENDLOOP.

 COMMIT WORK AND WAIT.
ENDIF.


response->set_text( json  ).
ENDIF.
ENDIF.
  endmethod.
ENDCLASS.
