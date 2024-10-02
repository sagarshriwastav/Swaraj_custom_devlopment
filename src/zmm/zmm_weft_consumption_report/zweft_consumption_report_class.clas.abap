CLASS zweft_consumption_report_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.


    DATA:wa_final TYPE ZWEFT_CONSUMPTION_FINAL_CDS,
         it_final TYPE TABLE OF ZWEFT_CONSUMPTION_FINAL_CDS.


* INTERFACES if_oo_adt_classrun.
 INTERFACES if_rap_query_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZWEFT_CONSUMPTION_REPORT_CLASS IMPLEMENTATION.


  METHOD if_rap_query_provider~select.


    DATA: lt_response TYPE TABLE OF ZWEFT_CONSUMPTION_FINAL_CDS.
    DATA:lt_current_output TYPE TABLE OF ZWEFT_CONSUMPTION_FINAL_CDS.
    DATA:wa1 TYPE ZWEFT_CONSUMPTION_FINAL_CDS.

    DATA(lt_clause)        = io_request->get_filter( )->get_as_sql_string( ).
    DATA(lv_top)           = io_request->get_paging( )->get_page_size( ).
    DATA(lv_skip)          = io_request->get_paging( )->get_offset( ).
    DATA(lt_fields)        = io_request->get_requested_elements( ).
    DATA(lt_sort)          = io_request->get_sort_elements( ).
    DATA(lt_filter)        = io_request->get_filter( )->get_as_sql_string( ).
    DATA(get_aggregation)        = io_request->get_aggregation( )."get_filter( )->get_as_sql_string( ).


    TRY.
        DATA(lt_filter_cond) = io_request->get_filter( )->get_as_ranges( ).
      CATCH cx_rap_query_filter_no_range INTO DATA(lx_no_sel_option).
    ENDTRY.


    DATA(Plant)  =  VALUE #( lt_filter_cond[ name =  'PLANT'  ]-range OPTIONAL ).
    DATA(Batch)       =  VALUE #( lt_filter_cond[ name =  'BATCH'  ]-range OPTIONAL ).
    DATA(PostingDate)     =  VALUE #( lt_filter_cond[ name =  'CONSUMPTION DATE'  ]-range OPTIONAL ).
    DATA(PurchaseOrder)     =  VALUE #( lt_filter_cond[ name =  'PURCHASE ORDER'  ]-range OPTIONAL ).
    DATA(Supplier)     =  VALUE #( lt_filter_cond[ name =  'PARTY'  ]-range OPTIONAL ).


    SELECT FROM I_MaterialDocumentItem_2  AS a
    left outer join I_ProductDescription_2 as b on ( b~Product = a~Material and b~Language = 'E' )
     left outer join I_Supplier as c on ( c~Supplier = a~Supplier )
     left outer join I_MaterialDocumentHeader_2 as d on ( d~MaterialDocument = a~MaterialDocument
                                                         and d~MaterialDocumentYear = a~MaterialDocumentYear )
     left outer join I_PurchaseOrderItemAPI01 as e on ( e~PurchaseOrder = a~PurchaseOrder
                                                       and e~PurchaseOrderItem = a~PurchaseOrderItem )
     left outer join I_Product as f on ( f~Product = a~Material )
     left outer join I_ProductDescription_2 as h on ( h~Product = e~Material and h~Language = 'E' )


    FIELDS a~Batch,
        a~MaterialDocument,
        a~MaterialDocumentItem,
        a~PurchaseOrder,
        a~PurchaseOrderItem,
        a~Material,
        a~Plant,
        a~PostingDate,
        a~DocumentDate,
        a~Supplier,
        d~MaterialDocumentHeaderText,
        b~ProductDescription,
        c~SupplierName,
        e~Material as material_e,
        a~MaterialBaseUnit,
        a~QuantityInBaseUnit as QuantityInBaseUnit,
        a~CompanyCodeCurrency,
        a~TotalGoodsMvtAmtInCCCrcy as TotalGoodsMvtAmtInCCCrcy,
        h~ProductDescription AS ProductDescription_h

  where a~GoodsMovementIsCancelled = ''
    and a~GoodsMovementType = '543'
    and f~IndustryStandardName = 'E'
    and a~InventorySpecialStockType = 'F'
    and a~Plant = '1200'
    and a~Batch in @batch

*  GROUP BY a~Batch,
*        a~MaterialDocument,
*        a~MaterialDocumentItem,
*        a~PurchaseOrder,
*        a~PurchaseOrderItem,
*        a~Material,
*        a~Plant,
*        a~PostingDate,
*        a~DocumentDate,
*        a~Supplier,
*        d~MaterialDocumentHeaderText,
*        b~ProductDescription,
*        c~SupplierName,
*        e~Material ,
*        a~MaterialBaseUnit,
*        a~CompanyCodeCurrency

   INTO TABLE @DATA(i_data) .

*     SORT i_data BY  batch .
*     DELETE ADJACENT DUPLICATES FROM i_data COMPARING PurchaseOrder PurchaseOrderItem .

    LOOP AT i_data INTO DATA(w_data).

      wa_final-Material                    = w_data-Material                  .
      wa_final-ProductDescription          = w_data-ProductDescription        .
      wa_final-Plant                       = w_data-Plant                     .
      wa_final-Batch                       = w_data-Batch                     .
      wa_final-QuantityInBaseUnit          = w_data-QuantityInBaseUnit        .
     wa_final-TotalGoodsMvtAmtInCCCrcy    = w_data-TotalGoodsMvtAmtInCCCrcy  .
      wa_final-PostingDate                 = w_data-PostingDate               .
      wa_final-DocumentDate                = w_data-DocumentDate              .
      wa_final-PurchaseOrder               = w_data-PurchaseOrder             .
      wa_final-PurchaseOrderItem           = w_data-PurchaseOrderItem         .
      wa_final-Supplier                    = w_data-Supplier                  .
      wa_final-SupplierName                = w_data-SupplierName              .
      wa_final-MaterialDocumentHeaderText  = w_data-MaterialDocumentHeaderText.
      wa_final-material_e                  = w_data-material_e                .
*      wa_final-MaterialBaseUnit            = w_data-MaterialBaseUnit          .
      wa_final-MaterialDocument            = w_data-MaterialDocument          .
      wa_final-MaterialDocumentItem            = w_data-MaterialDocumentItem          .
*      wa_final-CompanyCodeCurrency         = w_data-CompanyCodeCurrency       .
      wa_final-Productdescription_h         = w_data-productdescription_h       .

      APPEND wa_final TO it_final.
      CLEAR:wa_final.

    ENDLOOP.

    MOVE-CORRESPONDING it_final TO lt_response.
*IF io_request->is_data_requested( ). """""" PREM SINGH
    TRY.

        DATA(lv_offset) = io_request->get_paging( )->get_offset( ).
        DATA(lv_page_size) = io_request->get_paging( )->get_page_size( ).
        DATA(lv_max_rows) = COND #( WHEN lv_page_size = if_rap_query_paging=>page_size_unlimited
                                    THEN 0
                                    ELSE lv_page_size ).
        " sorting
        DATA(sort_elements) = io_request->get_sort_elements( ).
        DATA(lt_sort_criteria) = VALUE string_table(
            FOR sort_element IN sort_elements
            ( sort_element-element_name && COND #( WHEN sort_element-descending = abap_true
                                                   THEN ` descending`
                                                   ELSE ` ascending` ) ) ).

        DATA lv_sort_string TYPE string .
        lv_sort_string  = COND #( WHEN lt_sort_criteria IS INITIAL
                                  THEN '                                   '
                                  ELSE concat_lines_of( table = lt_sort_criteria sep = `, ` ) ).
        " requested elements
        DATA(lt_req_elements) = io_request->get_requested_elements( ).
        " aggregate
        DATA(lt_aggr_element) = io_request->get_aggregation( )->get_aggregated_elements( ).

        IF lt_aggr_element IS NOT INITIAL.
          LOOP AT lt_aggr_element ASSIGNING FIELD-SYMBOL(<fs_aggr_element>).
            DELETE lt_req_elements WHERE table_line = <fs_aggr_element>-result_element.
            DATA(lv_aggregation) = |{ <fs_aggr_element>-aggregation_method }( { <fs_aggr_element>-input_element } ) as { <fs_aggr_element>-result_element }|.
            APPEND lv_aggregation TO lt_req_elements.
          ENDLOOP.
        ENDIF.
        DATA(lv_req_elements) = concat_lines_of( table = lt_req_elements
                                                 sep   = `, ` ).
        " grouping
        DATA(lt_grouped_element) = io_request->get_aggregation( )->get_grouped_elements( ).
        DATA(lv_grouping) = concat_lines_of( table = lt_grouped_element
                                             sep   = `, ` ).
*        DATA(lv_search) = io_request->get_search_expression( ).
*        DATA(lv_search_sql) = |DESCRIPTION LIKE '%{ cl_abap_dyn_prg=>escape_quotes( lv_search ) }%'|.
*
*        IF lt_clause IS INITIAL.
*          lt_clause = lv_search_sql.
*        ELSE.
*          lt_clause = |( { lt_clause } AND { lv_search_sql } )|.
*        ENDIF.


          IF lv_sort_string IS INITIAL.
          if lv_grouping is not INITIAL .
            lv_sort_string = lv_grouping .
          else .
*          lv_sort_string  = lv_req_elements .
          lv_sort_string  = 'BATCH' .
*          Material_document
          endif .
        endif .
*        TRY.


          SELECT (lv_req_elements) FROM @lt_response AS a
                                              WHERE (lt_clause)
                                              GROUP BY (lv_grouping)
                                              ORDER BY (lv_sort_string)
                                              INTO CORRESPONDING FIELDS OF TABLE @lt_current_output
                                              OFFSET @lv_offset
                                               UP TO @lv_max_rows ROWS.

*          CATCH cx_sy_dynamic_osql_semantics.
*        ENDTRY.
        IF io_request->is_total_numb_of_rec_requested(  ).
          io_response->set_total_number_of_records( lines( lt_response ) ).
        ENDIF.

        IF io_request->is_data_requested(  ).
          io_response->set_data( lt_current_output ).
        ENDIF.

      CATCH cx_root INTO DATA(lv_exception).
*        DATA(lv_exception_message) = cl_message_helper=>get_latest_t100_exception( lv_exception )->if_message~get_longtext( ).
    ENDTRY.


  ENDMETHOD.
ENDCLASS.
