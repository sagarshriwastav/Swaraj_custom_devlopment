CLASS zdenim_packing_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_rap_query_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZDENIM_PACKING_CLASS IMPLEMENTATION.


METHOD if_rap_query_provider~select.
 IF io_request->is_data_requested( ).
      DATA: lt_response TYPE TABLE OF ZPP_DENIM_PACKING_CLASS_CDS.
      DATA:WA1 TYPE ZPP_DENIM_PACKING_CLASS_CDS.
      DATA(lv_top)           = io_request->get_paging( )->get_page_size( ).
      DATA(lv_skip)          = io_request->get_paging( )->get_offset( ).
      DATA(lt_clause)        = io_request->get_filter( )->get_as_sql_string( ).
      DATA(lt_fields)        = io_request->get_requested_elements( ).
      DATA(lt_sort)          = io_request->get_sort_elements( ).

      TRY.
          DATA(lt_filter_cond) = io_request->get_filter( )->get_as_ranges( ).
        CATCH cx_rap_query_filter_no_range INTO DATA(lx_no_sel_option).
      ENDTRY.

*      DATA(lr_material)  =  VALUE #( lt_filter_cond[ name   = 'MATERIAL' ]-range OPTIONAL ).

****Data retrival and business logics goes here*****

    SELECT A~plant ,
           A~posting_date,
           A~material_number,
           A~mat_doc,
           A~storage_location,
           A~receving_location,
           A~operator_name,
           A~pack_grade,
           A~re_grading,
           A~finish_width,
           A~no_of_tp,
           A~shift,
           A~folio_number,
           A~unit_field,
           A~gross_weight,
           A~net_weight,
           A~inspection_mc_no,
           A~roll_length,
           A~sales_order,
           A~so_item,
           A~remark1,
           A~remark2,
           A~flag,
           A~flag_quantity,
           A~flag_quantity_total,
           A~document_date,
           A~etime,
           A~user_name,
           A~cancelflag,
           A~created_by,
           A~created_at,
           A~last_changed_by,
           A~last_changed_at,
           A~rec_batch,
           B~batch,
           c~ftype,
           C~werks,
           C~matnr,
           C~charg,
           C~mblnr,
           C~bagno,
           C~baleno,
           C~budat,
           C~erdat,
           C~point,
           C~meter
     FROM zpackhdr AS a
     LEFT OUTER JOIN zpackhdr_d AS b ON ( B~plant = A~plant AND B~material_number = A~material_number
                                     AND   B~mat_document = A~mat_doc )
                                         LEFT OUTER JOIN zdnmfault AS  c ON ( C~bagno = A~rec_batch )
                                     WHERE A~plant = '1200'
                                     INTO TABLE @DATA(TAB)  .

    SORT tab by rec_batch ASCENDING.
    DELETE ADJACENT DUPLICATES FROM TAB COMPARING rec_batch .

    DATA lv_cntr TYPE sy-index.
    DATA lv_ft TYPE zdnmfault-ftype.

    LOOP AT tab INTO DATA(wa_tab) .
    MOVE-CORRESPONDING wa_tab to wa1.
    wa1-ftype = wa_tab-ftype .

    SELECT  ftype FROM  zdnmfault WHERE  bagno = @wa_tab-rec_batch INTO @datA(lv_ftpye) .
    lv_cntr = lv_cntr + 1.
    lv_ft = lv_ftpye .

    if wa1-ftype is  INITIAL .

    wa1-ftype  = lv_ft.
    ELSEIF    wa1-ftype is NOT INITIAL .
    CONCATENATE wa1-ftype '/' lv_ft INTO  wa1-ftype .

    ENDIF.
    ENDSELECT.

APPEND wa1 TO lt_response.
CLEAR : wa_tab, lv_ft,wa1.

    ENDLOOP.

      io_response->set_total_number_of_records( lines( lt_response ) ).
      io_response->set_data( lt_response ).

    ENDIF.
ENDMETHOD.
ENDCLASS.