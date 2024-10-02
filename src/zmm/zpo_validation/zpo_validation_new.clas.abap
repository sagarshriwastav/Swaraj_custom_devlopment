CLASS zpo_validation_new DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_badi_interface .
    INTERFACES if_ex_mmpur_final_check_po .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZPO_VALIDATION_NEW IMPLEMENTATION.


  METHOD if_ex_mmpur_final_check_po~check.
*         Structure for messages
    DATA: ls_message LIKE LINE OF messages.

*   The example implementation shows how it is prevented that the purchasing group can be changed once a purchase order
*   has been created

*   In create case no key for purchaseorder is stored in the database -> the check is not performed
    IF purchaseorder_db-purchaseorder IS NOT INITIAL.
*     In change case it is not allowed anymore to change the purchasing group
*     so the database value is compared with its current value
      IF purchaseorder_db-purchasinggroup <> purchaseorder-purchasinggroup.
*       If a translatable text for the message is needed please use code lists. For on how this can be done in the coding uncomment the lines commented
*       by an " and replace the CDS yy1_mm_po_ext fields by yours created in your code list. In the code list the message text and its translation is stored.
*       The text is then read implicitily by the used language if the translation is available in the code list
        "  SELECT SINGLE FROM yy1_mm_po_ext fields description WHERE code = '01' INTO @data(lv_message).
        "  IF sy-subrc = 0.
*       "      If the purchasing group is changed an error message is raised from a message class (transaction se91)
*       "      The error prevents a saving of the purchase order, i.e. the purchasing group can not be changed anymore
        "      ls_message-messagetype = 'E'.
        "      ls_message-messagevariable1 = lv_message.
        "      APPEND ls_message TO messages.
        "  ENDIF.
*       Here a non-translatable message is raised

*        ls_message-messagetype = 'E'.
*        ls_message-messagevariable1 = 'The purchasing group cannot be changed anymore'.
*        APPEND ls_message TO messages.
      ENDIF.
    ENDIF.

*    DATA hsncode TYPE i_productplantbasic-consumptiontaxctrlcode.

*      !purchaseorder              TYPE if_ex_mmpur_final_check_po=>b_mmpur_s_purchaseorder
*      !purchaseorder_db           TYPE if_ex_mmpur_final_check_po=>b_mmpur_s_purchaseorder
*      !purchaseorderitems         TYPE if_ex_mmpur_final_check_po=>b_mmpur_t_purchaseorderitem
*      !purchaseorderitems_db      TYPE if_ex_mmpur_final_check_po=>b_mmpur_t_purchaseorderitem
*      !purchaseorderschedulelines TYPE if_ex_mmpur_final_check_po=>b_mmpur_t_purchorderschedline
*      !purchaseorderaccounting    TYPE if_ex_mmpur_final_check_po=>b_mmpur_t_purordaccassignmt



    DATA(it_budget) = purchaseorderitems.
    LOOP AT  purchaseorderitems INTO DATA(w).
*      SELECT SINGLE consumptiontaxctrlcode FROM i_productplantbasic WITH PRIVILEGED ACCESS WHERE plant = @w-plant AND product = @w-material  INTO @data(hsncode).
*      IF w-accountassignmentcategory = 'P' OR  w-accountassignmentcategory = 'Q'.
*        READ TABLE purchaseorderaccounting INTO DATA(wa) WITH KEY purchaseorderitem = w-purchaseorderitem.
*        IF wa-wbselementinternalid IS NOT INITIAL.
*          SELECT SINGLE available_amt FROM ZPS_BUDGET_CDS
*           WHERE wbselementinternalid = @wa-wbselementinternalid
*           INTO @DATA(available_amt).
*          IF sy-subrc <> 0.
*            ls_message-messagetype = 'E'.
*            ls_message-messagevariable1 = 'WBS Element budget is not maintain'.
*            APPEND ls_message TO messages.
*          ELSEIF w-netpriceamount GT available_amt.
*            ls_message-messagetype = 'E'.
*            ls_message-messagevariable1 = 'WBS Element budget exceed'.
*            APPEND ls_message TO messages.
*          ENDIF.
*        ENDIF.
*      ENDIF.


  IF w-purchaseorder <> '' .

  SELECT SINGLE b~NetPriceAmount FROM I_MaterialDocumentItem_2 WITH PRIVILEGED ACCESS as a
  LEFT OUTER JOIN I_PurchaseOrderItemAPI01 WITH PRIVILEGED ACCESS as b ON ( b~PurchaseOrder = a~PurchaseOrder AND b~PurchaseOrderItem = a~PurchaseOrderItem )
  WHERE a~PurchaseOrder = @W-purchaseorder AND a~PurchaseOrderItem = @W-purchaseorderitem
  AND a~GoodsMovementType = '101' AND a~GoodsMovementIsCancelled = ''  INTO @DATA(NETPRIC).
  IF NETPRIC <> 0 AND NETPRIC <> W-netpriceamount .
   ls_message-messagetype = 'E'.
   ls_message-messagevariable1 = 'Price Change Not Allowed After GRN'.
    APPEND ls_message TO messages.
  ENDIF.

  ENDIF.
clear:NETPRIC.
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
