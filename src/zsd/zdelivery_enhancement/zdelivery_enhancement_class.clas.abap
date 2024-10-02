CLASS zdelivery_enhancement_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_badi_interface .
    INTERFACES if_le_shp_delivery_fin_check .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZDELIVERY_ENHANCEMENT_CLASS IMPLEMENTATION.


  METHOD if_le_shp_delivery_fin_check~delivery_final_check.
*    DATA:w_MESSAGE LIKE MESSAGE.

    LOOP AT delivery_document_items_in INTO DATA(w_item) WHERE deliverydocumentitemcategory = 'TAN'.
      SELECT SINGLE *
      FROM i_salesdocumentitem WITH PRIVILEGED ACCESS
      WHERE salesdocument = @w_item-referencesddocument
        AND salesdocumentitem = @w_item-referencesddocumentitem
        INTO @DATA(i_sales).
      SELECT SUM( actualdeliveryquantity )
      FROM i_deliverydocumentitem WITH PRIVILEGED ACCESS
      WHERE referencesddocument     = @w_item-referencesddocument
        AND referencesddocumentitem = @w_item-referencesddocumentitem
        AND deliverydocument        <> @w_item-deliverydocument
        AND deliverydocumentitem    <> @w_item-deliverydocumentitem
        INTO @DATA(i_delivery).
      CLEAR: w_item-actualdeliveredqtyinbaseunit.
      LOOP AT delivery_document_items_in INTO DATA(w_item1)
      WHERE higherlvlitmofbatspltitm = w_item-deliverydocumentitem.
        w_item-actualdeliveredqtyinbaseunit =  w_item-actualdeliveredqtyinbaseunit
                                            +  w_item1-actualdeliveryquantity.
      ENDLOOP.
      i_sales-confddelivqtyinorderqtyunit = i_sales-confddelivqtyinorderqtyunit - i_delivery.
      IF i_sales-confddelivqtyinorderqtyunit LT w_item-actualdeliveredqtyinbaseunit.
        message-messagetype = 'E'.
        message-messagetext = 'Delivery Qty Eceeded'.
      ENDIF.
      EXIT.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
