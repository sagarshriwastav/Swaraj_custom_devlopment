CLASS zcl_sd_bil_data_transfer DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_badi_interface .
    INTERFACES if_sd_bil_data_transfer .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SD_BIL_DATA_TRANSFER IMPLEMENTATION.


  METHOD if_sd_bil_data_transfer~change_data.
*      Mandatory step for all implementations:
*   Copy the importing parameters to the changing parameters.
    MOVE-CORRESPONDING bil_doc TO bil_doc_res.
    MOVE-CORRESPONDING bil_doc_item TO bil_doc_item_res.
    MOVE-CORRESPONDING bil_doc_item_contr TO bil_doc_item_contr_res.

*   Example field manipulation of billing document header field:
*   Here we're replacing the billing document date with the current date in time zone UTC.
    GET TIME STAMP FIELD DATA(ts).
    CONVERT TIME STAMP ts TIME ZONE 'UTC' INTO DATE bil_doc_res-billingdocumentdate.

*    IF bil_doc_item-salesdocumentitemcategory = 'CB99' or  bil_doc_item-salesdocumentitemcategory = 'CB98'  .
*      billingdocumentitemisrejected = abap_true.
*    ENDIF .
*
*
*    IF bil_doc_item-batch is not initial .
*    IF bil_doc_item-salesdocumentitemcategory = 'JNLN'
*              AND bil_doc_item-higherlvlitmofbatspltitm IS NOT INITIAL .
*      billingdocumentitemisrejected = abap_true.
*    ENDIF .
*    ENDIF.
*
*    IF bil_doc_item-salesdocumentitemcategory = 'NLN'
*     AND bil_doc_item-higherlvlitmofbatspltitm IS NOT INITIAL  .
*      billingdocumentitemisrejected = abap_true.
*    ENDIF .


    IF bil_doc_item-salesdocumentitemcategory = 'CB99' .
      billingdocumentitemisrejected = abap_true.
    ENDIF .

       IF bil_doc_item-batch is not initial.
       IF bil_doc_item-salesdocumentitemcategory = 'JNLN'
                    AND bil_doc_item-higherlvlitmofbatspltitm IS NOT INITIAL .
      billingdocumentitemisrejected = abap_true.
    ENDIF .
    ENDIF.

           IF bil_doc_item-salesdocumentitemcategory = 'NLN'
                      AND bil_doc_item-higherlvlitmofbatspltitm IS NOT INITIAL  .
      billingdocumentitemisrejected = abap_true.
    ENDIF .



*    bil_doc_res-yy1_ackno_bdh = bil_doc-distributionchannel.
*   Example field manipulation of billing document item:
*   Here we're setting the item text of the billing document item.
*    bil_doc_item_res-documentitemtext = 'This is an example text'.

*   Example field manipulation of split-relevant (header) fields of the billing document:
*   Here we're clearing the region field from the billing document.
*    bil_doc_clear_flds_f_split-regionistobedeleted = abap_true.

*   If you notice a problem with the data, you can skip the processing of the current item by setting:
*   billingdocumentitemisrejected   = abap_true
*   and passing a short information text that contains the reason for rejection to
*   billgdocitmrejectionreasontext.
*   For example:
*   CONCATENATE bil_doc_item-referencesddocument  bil_doc_item-referencesddocumentitem INTO Data(lv_reason).
*   billgdocitmrejectionreasontext = lv_reason.

























  ENDMETHOD.
ENDCLASS.
