CLASS zwbc_budget_report DEFINITION
*****************************************GAJENDRASINGHGUDHA***********
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

***********************************STARTSTY*******************************
    TYPES:BEGIN OF ty_item ,

***************A
            postingdate            TYPE  zi_supplierinvoiceapi01-postingdate,
            supplierinvoice        TYPE   zi_supplierinvoiceapi01-supplierinvoice,
            invoice_value          TYPE   zi_supplierinvoiceapi01-invoiceamtincocodecrcy,
    SupplierInvoiceIDByInvcgParty  TYPE   zi_supplierinvoiceapi01-SupplierInvoiceIDByInvcgParty,
            companycodecurrency    TYPE i_materialdocumentitem_2-companycodecurrency,


***************B
            materialdocument       TYPE    i_materialdocumentitem_2-materialdocument,
            postingdate1           TYPE   i_materialdocumentitem_2-postingdate,
            material               TYPE   i_materialdocumentitem_2-material,
            quantityinbaseunit     TYPE   i_materialdocumentitem_2-quantityinbaseunit,
            supplier               TYPE   i_materialdocumentitem_2-supplier,
            materialbaseunit       TYPE   i_materialdocumentitem_2-materialbaseunit,
            postingdate02          TYPE   i_materialdocumentitem_2-postingdate,
***************C
            suppliername           TYPE    i_supplier-suppliername,
*****************D
            productdescription     TYPE  i_productdescription_2-productdescription,
********************E
            purchaseorder          TYPE i_purchaseorderitemapi01-purchaseorder,
            purchaseorderitem      TYPE i_purchaseorderitemapi01-purchaseorderitem,
            netpriceamount         TYPE i_purchaseorderitemapi01-netpriceamount,
            purchaseorderitemtext  TYPE i_purchaseorderitemapi01-purchaseorderitemtext,
*************F
            wbselementinternalid   TYPE i_purordaccountassignmentapi01-wbselementinternalid_2,
*****************G
            wbselementinternalid02 TYPE  i_actualplanjournalentryitem-wbselementinternalid,
            wbselementexternalid   TYPE  i_actualplanjournalentryitem-wbselementexternalid,
            wbselementexternalid1  TYPE  zactual_plant_journal_iteam-wbselementexternalid,
***************h
        ProjectElementDescription  TYPE  I_EnterpriseProjectElement_2-ProjectElementDescription,








          END OF ty_item.

    CLASS-DATA:it_item TYPE TABLE OF ty_item,
               wa_item TYPE ty_item.

**********************************STYEND****************************************
********************************************
    INTERFACES if_rap_query_provider.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZWBC_BUDGET_REPORT IMPLEMENTATION.


  METHOD if_rap_query_provider~select.

    DATA:   lt_response TYPE TABLE OF zwbc_budget_cds.
    DATA:   wa1         TYPE zwbc_budget_cds.
    DATA:   lt_current_output TYPE TABLE OF zwbc_budget_cds.



    DATA(lv_top)           = io_request->get_paging( )->get_page_size( ).
    DATA(lv_skip)          = io_request->get_paging( )->get_offset( ).
    DATA(lt_clause)        = io_request->get_filter( )->get_as_sql_string( ).
    DATA(lt_fields)        = io_request->get_requested_elements( ).
    DATA(lt_sort)          = io_request->get_sort_elements( ).
    DATA(get_agge)         = io_request->get_aggregation(  ) .
    DATA(get_agge1)         = io_request->get_aggregation(  )->co_standard_aggregation_method .



    TRY.
        DATA(lt_filter_cond) = io_request->get_filter( )->get_as_ranges( ).
      CATCH cx_rap_query_filter_no_range INTO DATA(lx_no_sel_option).
    ENDTRY.

**************SELICATION SCREEN********************
    DATA(lr_podate)         =  VALUE #( lt_filter_cond[ name   = 'POSTINGDATE' ]-range OPTIONAL ).
    DATA(lr_material)         =  VALUE #( lt_filter_cond[ name   = 'MATERIAL' ]-range OPTIONAL ).
    DATA(lr_wbc)         =  VALUE #( lt_filter_cond[ name   = 'WBSELEMENTINTERNALID' ]-range OPTIONAL ).
    DATA(lr_materialdoc)         =  VALUE #( lt_filter_cond[ name   = 'MATERIALDOCUMENT' ]-range OPTIONAL ).
    DATA(lr_supplierinvoice)         =  VALUE #( lt_filter_cond[ name   = 'SUPPLIERINVOICE' ]-range OPTIONAL ).
    DATA(lr_po)         =  VALUE #( lt_filter_cond[ name   = 'PURCHASEORDER' ]-range OPTIONAL ).
*******************************************

    SELECT  * FROM  zi_supplierinvoiceapi01 AS a
             LEFT OUTER JOIN i_materialdocumentitem_2 AS b ON (  b~materialdocument = a~referencedocument AND b~materialdocumentitem = a~referencedocumentitem
                                AND b~goodsmovementtype = '101'  AND b~goodsmovementiscancelled = ''  AND b~purchaseorderitem = a~purchaseorderitem AND b~purchaseorder = a~purchaseorder )
              LEFT OUTER JOIN  i_supplier  AS c ON ( c~supplier = b~supplier    )
             LEFT OUTER JOIN  i_productdescription_2 AS d ON (  d~product = b~material AND d~language = 'E'  )
             LEFT OUTER JOIN i_purchaseorderitemapi01 AS e ON (  e~purchaseorder = b~purchaseorder AND e~purchaseorderitem = b~purchaseorderitem )
             LEFT  OUTER JOIN   i_purordaccountassignmentapi01 AS f ON (   f~purchaseorder = e~purchaseorder AND f~purchaseorderitem = e~purchaseorderitem )
             LEFT OUTER JOIN zactual_plant_journal_iteam AS g ON ( g~wbselementinternalid = f~wbselementinternalid_2  )
             left OUTER JOIN I_EnterpriseProjectElement_2 as h on ( h~WBSElementInternalID = f~WBSElementInternalID_2    )
              WHERE   a~postingdate IN @lr_podate
              AND     b~material IN @lr_material
              AND   f~wbselementinternalid_2 IN @lr_wbc
              AND   b~materialdocument IN @lr_materialdoc
              AND   a~supplierinvoice IN @lr_supplierinvoice
              AND   e~purchaseorder IN @lr_po
             AND f~wbselementinternalid_2 <> ' '
*             and b~AccountAssignmentCategory = 'P'
              INTO TABLE @DATA(ittab).

*    SORT ittab BY     E-purchaseorder.
*   DELETE ADJACENT DUPLICATES FROM ittab COMPARING  E-purchaseorder.

    LOOP AT ittab INTO DATA(wa).
      MOVE-CORRESPONDING wa TO wa1.

      wa1-invoiceamtincocodecrcy   = wa-a-invoiceamtincocodecrcy.
      wa1-postingdate  = wa-a-postingdate.
      wa1-supplierinvoice  = wa-a-supplierinvoice.
      wa1-SupplierInvoiceIDByInvcgParty  = wa-a-SupplierInvoiceIDByInvcgParty.
      wa1-materialdocument  = wa-b-materialdocument.
      wa1-postingdate  = wa-b-postingdate.
      wa1-material  = wa-b-material.
      wa1-quantityinentryunit   = wa-b-quantityinentryunit.
      wa1-materialbaseunit    =   wa-b-materialbaseunit.
      wa1-postingdate02    =   wa-b-postingdate.
      wa1-supplier = wa-b-supplier.
      wa1-suppliername  = wa-c-suppliername.
*      wa1-productdescription  =  wa-d-productdescription.
      wa1-purchaseorderitemtext  =  wa-e-purchaseorderitemtext.
      wa1-purchaseorder  = wa-e-purchaseorder.
      wa1-purchaseorderitem  = wa-e-purchaseorderitem.
      wa1-netpriceamount  = wa-e-netpriceamount.
      wa1-wbselementinternalid_2 = wa-f-wbselementinternalid_2.
      wa1-companycodecurrency      = wa-b-companycodecurrency.
*      wa1-wbselementinternalid =     wa-g-wbselementinternalid.
      wa1-wbselementexternalid  =     wa-g-wbselementexternalid.
      WA1-ProjectElementDescription = WA-h-ProjectElementDescription.



      APPEND wa1 TO  lt_response.
      CLEAR : wa,wa1.

    ENDLOOP.


    DATA:lv_sort_string TYPE string.
*    IF io_request->is_data_requested( ).
**paging
    DATA(lv_offset) = io_request->get_paging( )->get_offset( ).
    DATA(lv_page_size) = io_request->get_paging( )->get_page_size( ).
    DATA(lv_max_rows) = COND #( WHEN lv_page_size = if_rap_query_paging=>page_size_unlimited
                                THEN 0 ELSE lv_page_size ).
**sorting
    DATA(sort_elements) = io_request->get_sort_elements( ).
    DATA(lt_sort_criteria) = VALUE string_table( FOR sort_element IN sort_elements
                                               ( sort_element-element_name && COND #( WHEN sort_element-descending = abap_true THEN ` descending`
                                                                                                                               ELSE ` ascending` ) ) ).
    lv_sort_string  = COND #( WHEN lt_sort_criteria IS INITIAL THEN '                                   '
                      ELSE concat_lines_of( table = lt_sort_criteria sep = `, ` ) ).
**requested elements
    DATA(lt_req_elements) = io_request->get_requested_elements( ).
**aggregate
    DATA(lt_aggr_element) = io_request->get_aggregation( )->get_aggregated_elements( ).

    IF lt_aggr_element IS NOT INITIAL.
      LOOP AT lt_aggr_element ASSIGNING FIELD-SYMBOL(<fs_aggr_element>).
        DELETE lt_req_elements WHERE table_line = <fs_aggr_element>-result_element.
        DATA(lv_aggregation) = |{ <fs_aggr_element>-aggregation_method }( { <fs_aggr_element>-input_element } ) as { <fs_aggr_element>-result_element }|.
        APPEND lv_aggregation TO lt_req_elements.
      ENDLOOP.
    ENDIF.
    DATA(lv_req_elements)  = concat_lines_of( table = lt_req_elements sep = `, ` ).
****grouping
    DATA(lt_grouped_element) = io_request->get_aggregation( )->get_grouped_elements( ).
    DATA(lv_grouping) = concat_lines_of(  table = lt_grouped_element sep = `, ` ).



*      IF lv_sort_string IS INITIAL .
*
*        SELECT (lv_req_elements) FROM    @lt_response AS a
**                          WHERE (lt_clause)
*                               GROUP BY (lv_grouping)
**                                       ORDER BY (lv_sort_string)
*                               INTO CORRESPONDING FIELDS OF TABLE @lt_current_output
**                                        OFFSET @lv_offset
*                               UP TO @lv_max_rows ROWS.
*
*      ELSE.
*
*        SELECT (lv_req_elements) FROM    @lt_response AS a
**                          WHERE (lt_clause)
*                              GROUP BY (lv_grouping)
*                                           ORDER BY (lv_sort_string)
*                              INTO CORRESPONDING FIELDS OF TABLE @lt_current_output
*                                            OFFSET @lv_offset
*                              UP TO @lv_max_rows ROWS.
*
*      ENDIF .

*    ENDIF .


    TRY.


        IF lv_sort_string IS INITIAL.
          IF lv_grouping IS NOT INITIAL .
            lv_sort_string = lv_grouping .
          ELSE .
            lv_sort_string  = 'PurchaseOrder' .
          ENDIF .
        ENDIF .

        SELECT (lv_req_elements) FROM @lt_response AS a
                                            WHERE (lt_clause)
                                            GROUP BY (lv_grouping)
                                            ORDER BY (lv_sort_string)
                                            INTO CORRESPONDING FIELDS OF TABLE @lt_current_output
                                            OFFSET @lv_offset
                                             UP TO @lv_max_rows ROWS.

        IF io_request->is_total_numb_of_rec_requested(  ).
          io_response->set_total_number_of_records( lines( lt_response ) ).
        ENDIF.

        IF io_request->is_data_requested(  ).
          io_response->set_data( lt_current_output ).
        ENDIF.

      CATCH cx_root INTO DATA(lv_exception).


        """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


*        io_response->set_total_number_of_records( lines( lt_current_output ) ).
*        io_response->set_data( lt_current_output ).
*
*      CATCH cx_root INTO DATA(lv_exception).
*        DATA(lv_exception_message) = cl_message_helper=>get_latest_t100_exception( lv_exception )->if_message~get_longtext( ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
