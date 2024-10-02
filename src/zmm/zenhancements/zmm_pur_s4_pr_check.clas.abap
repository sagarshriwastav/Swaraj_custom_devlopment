CLASS zmm_pur_s4_pr_check DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_badi_interface .
    INTERFACES if_mm_pur_s4_pr_check .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZMM_PUR_S4_PR_CHECK IMPLEMENTATION.


  METHOD if_mm_pur_s4_pr_check~check.


LOOP AT purchaserequisitionitem_table INTO DATA(ls_item).

*select single ValuationClass from I_ProductValuationBasic WITH PRIVILEGED ACCESS where product = @ls_item-material  into @data(ValuationClass).

*IF ls_item-PurchaseRequisitionType = 'ZFAB'.
*if ( ValuationClass = '3014' or
*ValuationClass = '3015' or
*ValuationClass = '3016' or
*ValuationClass = '3017').
*else.
*APPEND VALUE #( messagetype = 'E'
*
*messageid = 'YMSZ1'
*
*messagenumber = '001'
*) TO messages.
*
*purchaserequisitionhaserror = abap_true.
*endif.
*RETURN.
*endif.

*
*SELECT SINGLE PurchaseRequisitionType FROM I_PURCHASEREQUISITIONAPI01 WHERE PurchaseRequisition = @ls_item-purchaserequisition
*INTO @DATA(PR).
**
*IF ls_item-PurchaseRequisitionType = 'ZSTR'.
**
**DATA: LEN TYPE C.
** LEN = ls_item-material+0(6)..
** DATA(YARN) = LEN+0(1).
*IF ls_item-material LIKE 'Y%' .
*
**IF YARN = 'S'.
*ELSE.
*APPEND VALUE #( messagetype = 'E'
*messageid = 'YMSZ1'
*
*messagenumber = '004'
*
*) TO messages.
*purchaserequisitionhaserror = abap_true.
*ENDIF.
*RETURN.
*endif.

******************************************
*IF ls_item-PurchaseRequisitionType = 'ZYRN'.
*
*DATA: LEN1 TYPE C.
* LEN1 = ls_item-material+0(6)..
* DATA(YARN1) = LEN1+0(1).
*
*IF YARN1 = 'Y'.
*ELSE.
*APPEND VALUE #( messagetype = 'E'
*messageid = 'YMSZ1'
*
*messagenumber = '003'
*
*) TO messages.
*purchaserequisitionhaserror = abap_true.
*ENDIF.
*RETURN.
*endif.
*

ENDLOOP.
ENDMETHOD.
ENDCLASS.
