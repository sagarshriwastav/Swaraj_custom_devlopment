CLASS zmis_report DEFINITION
**********************************<GAJENDRASINGH>********************************************
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:BEGIN OF ty_item ,
            plant                 TYPE  zpp_finishing-plant,
            zunit                 TYPE  zpp_finishing-zunit,
            setno                 TYPE  zpp_finishing-setno,
            setpeiceno            TYPE  zpp_finishing-setpeiceno,
            finishrollno          TYPE  zpp_finishing-finishrollno,
            actualmtr             TYPE  zpp_finishing-actualmtr,
            greigemtr             TYPE  zpp_finishing-greigemtr,
            finishmtr             TYPE  zpp_finishing-finishmtr,
            zorder                TYPE  zpp_dyeing1-zorder,
            length                TYPE  zpp_dyeing1-length,
            luom                  TYPE  zpp_dyeing1-luom,
            beamno                TYPE  zpp_dyeing1-beamno,
            partyname             TYPE  zpp_finishing-partyname,
            weaving_shrinkage(13) TYPE p  DECIMALS 2,
            finish_shrinkage  TYPE STRING ,



          END OF ty_item.

************************
*    TYPES : BEGIN OF  ty_item1,

*              weaving_shrinkage              TYPE c LENGTH 5,
*              finish_shrinkage               TYPE c LENGTH 5,
*              lv_total_finishmtr(13)         TYPE p DECIMALS 2,
*              lv_total_actualmtr(13)         TYPE p DECIMALS 2,
*              lv_total_length(13)            TYPE p DECIMALS 2,
*              lv_total_finish_shrinkage(13)  TYPE p DECIMALS 2,
*              lv_total_weaving_shrinkage(13) TYPE p DECIMALS 2,



*            END OF ty_item1.

*    DATA : it_item1 TYPE STANDARD TABLE OF ty_item1,
*           wa_item1 TYPE ty_item1.

**********************************

    CLASS-DATA:it_item TYPE TABLE OF ty_item,
               wa_item TYPE ty_item.
*               it_item1 TYPE TABLE OF zmis_cds.


    INTERFACES if_rap_query_provider.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZMIS_REPORT IMPLEMENTATION.


  METHOD if_rap_query_provider~select.

    DATA:   lt_response TYPE TABLE OF zmis_cds.
    DATA:   wa1         TYPE zmis_cds.
    DATA:   lt_current_output TYPE TABLE OF zmis_cds.

    DATA:  lv_total_finishmtr(13) TYPE p DECIMALS 2 .
    DATA : lv_total_actualmtr(13) TYPE p DECIMALS 2 .
    DATA:  lv_total_length(13)    TYPE p DECIMALS 2.
    data : lv_total_greigemtr(13) TYPE p DECIMALS 2 .

    DATA(lv_total_finish_shrinkage) = 100 - lv_total_finishmtr / lv_total_greigemtr * 100.
*    DATA(lv_total_weaving_shrinkage) = 100 - lv_total_actualmtr / lv_total_length * 100.

*    DATA:   lt_response1 TYPE TABLE OF zmis_cds.
*    DATA:   wa2         TYPE zmis_cds.


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

*    DATA(lr_plant)      =  VALUE #( lt_filter_cond[ name   = 'PLANT'  ]-range OPTIONAL ).
    DATA(lr_setno)         =  VALUE #( lt_filter_cond[ name   = 'SETNO' ]-range OPTIONAL ).
    DATA(lr_setpeiceno)         =  VALUE #( lt_filter_cond[ name   = 'SETPEICENO' ]-range OPTIONAL ).
*    DATA(lr_beamno)         =  VALUE #( lt_filter_cond[ name   = 'BEAMNO' ]-range OPTIONAL ).


    SELECT
    A~zunit,
    A~setno,
    A~setpeiceno,
    A~finishrollno,
    A~actualmtr,
    A~greigemtr,
    A~finishmtr,
    B~zorder,
    B~length,
    B~beamno,
    A~partyname,
    B~luom
     FROM zpp_finishing AS a
         LEFT OUTER  JOIN  zpp_dyeing1 AS b ON ( b~setno = a~setno  AND b~beamno = a~setpeiceno  )
*       WHERE a~plant IN @lr_plant
      WHERE   a~setno IN @lr_setno
        AND  a~setpeiceno IN @lr_setpeiceno
*        AND  B~beamno IN @lr_beamno
*      AND a~finishrollno IN @lr_finishrollno
          INTO TABLE @DATA(ittab).

 SORT ittab BY      setno zunit partyname beamno length zorder  finishmtr greigemtr actualmtr finishrollno  setpeiceno  .
   DELETE ADJACENT DUPLICATES FROM ittab COMPARING   setno zunit partyname beamno length zorder  finishmtr greigemtr actualmtr finishrollno  setpeiceno  .      .


    DATA(reco) = lines( ittab ).
    LOOP AT ittab INTO DATA(wa).
      MOVE-CORRESPONDING wa TO wa1.

*      wa1-plant     =   wa-a-plant.
      wa1-zunit     =   wa-zunit.
      wa1-setno       =   wa-setno.
      wa1-setpeiceno     =      wa-setpeiceno .
      wa1-finishrollno      =      wa-finishrollno.
      wa1-actualmtr      =      wa-actualmtr .
      wa1-greigemtr    =    wa-greigemtr.
      wa1-finishmtr    =    wa-finishmtr.
      wa1-zorder    =    wa-zorder.
      wa1-length    =    wa-length.
      wa1-luom    =    wa-luom.
      wa1-beamno   =  wa-beamno.
      wa1-partyname   =  wa-partyname.
      lv_total_finishmtr = lv_total_finishmtr + wa-finishmtr.
      lv_total_actualmtr = lv_total_actualmtr + wa-actualmtr.
      lv_total_length =     lv_total_length + wa-length.
      lv_total_greigemtr = lv_total_greigemtr + wa-greigemtr.



*      IF reco = sy-tabix.
      TRY.
*          wa1-weaving_shrinkage = ( 100 - lv_total_actualmtr  ) / lv_total_length * ( 100 ).
*          wa1-weaving_shrinkage = 100 - wa-a-actualmtr / wa-b-length * 100.
*          wa1-finish_shrinkage =  (   wa-a-greigemtr /  wa-a-finishmtr * 100 ).



          wa1-finish_shrinkage =  100 -  (     wa-finishmtr /  wa-greigemtr  * 100  )  .

          IF wa1-finish_shrinkage < 0 .
            wa1-finish_shrinkage =  wa1-finish_shrinkage * -1.
            ENDIF.

          wa1-weaving_shrinkage =   100 -  (  wa-greigemtr /  wa-length  * 100 ) .

          IF wa1-weaving_shrinkage  < 0 .
            wa1-weaving_shrinkage =  wa1-weaving_shrinkage * -1.
            ENDIF.


        CATCH cx_sy_zerodivide.

      ENDTRY.

*      ENDIF.

      APPEND wa1 TO  lt_response.
      CLEAR : wa,wa1.

    ENDLOOP.





    IF io_request->is_data_requested( ).
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
      DATA(lv_sort_string)  = COND #( WHEN lt_sort_criteria IS INITIAL THEN '                                   '
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



      IF lv_sort_string IS INITIAL .

*    IF   lv_req_elements CS 'SUM( FINISH_SHRINKAGE )' AND  lt_aggr_element IS NOT INITIAL  .
*
*    REPLACE 'SUM( FINISH_SHRINKAGE )' IN lv_req_elements WITH  '100 - ( SUM( FINISHMTR / SUM() )  ) * 100'    .
*    ENDIF .


        SELECT (lv_req_elements) FROM    @lt_response AS a
*                          WHERE (lt_clause)
                               GROUP BY (lv_grouping)
*                                       ORDER BY (lv_sort_string)
                               INTO CORRESPONDING FIELDS OF TABLE @lt_current_output
*                                        OFFSET @lv_offset
                               UP TO @lv_max_rows ROWS.

      ELSE.

        SELECT (lv_req_elements) FROM    @lt_response AS a
*                          WHERE (lt_clause)
                              GROUP BY (lv_grouping)
                                           ORDER BY (lv_sort_string)
                              INTO CORRESPONDING FIELDS OF TABLE @lt_current_output
                                            OFFSET @lv_offset
                              UP TO @lv_max_rows ROWS.

      ENDIF .

    ENDIF .


    TRY.
        """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


        io_response->set_total_number_of_records( lines( lt_current_output ) ).
        io_response->set_data( lt_current_output ).

      CATCH cx_root INTO DATA(lv_exception).
        DATA(lv_exception_message) = cl_message_helper=>get_latest_t100_exception( lv_exception )->if_message~get_longtext( ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
