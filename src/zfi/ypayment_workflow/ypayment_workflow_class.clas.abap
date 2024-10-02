 CLASS ypayment_workflow_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_rap_query_provider.
   TYPES:BEGIN OF ty_final,
            companycode                TYPE i_operationalacctgdocitem-companycode,
            fiscalyear                 TYPE i_operationalacctgdocitem-fiscalyear,
            postingdate                TYPE i_operationalacctgdocitem-postingdate,
            supplier                   TYPE i_operationalacctgdocitem-supplier,
            accountingdocument         TYPE i_operationalacctgdocitem-accountingdocument,
            accountingdocumenttype     TYPE i_operationalacctgdocitem-accountingdocumenttype,
            clearingjournalentry       TYPE i_operationalacctgdocitem-clearingjournalentry,
            transactioncurrency        TYPE i_operationalacctgdocitem-transactioncurrency,
            amountinbalancetransaccrcy TYPE i_operationalacctgdocitem-amountincompanycodecurrency,
            paymentterms               TYPE i_operationalacctgdocitem-paymentterms,
            netduedate                 TYPE i_operationalacctgdocitem-netduedate,
            additionalcurrency1        TYPE i_operationalacctgdocitem-additionalcurrency1,
            assignmentreference        TYPE i_operationalacctgdocitem-assignmentreference,
            documentdate               TYPE i_operationalacctgdocitem-documentdate,
            specialglcode              TYPE i_operationalacctgdocitem-specialglcode,
            invoicereference           TYPE i_operationalacctgdocitem-invoicereference,
            suppliername               TYPE i_supplier-suppliername,
            supplieraccountgroup       TYPE i_supplier-supplieraccountgroup,
            documentreferenceid        TYPE i_journalentry-documentreferenceid,
*            supplieramounttot          TYPE supplieramounttot,
            accountgroupname           TYPE i_supplieraccountgrouptext-accountgroupname,
            request                    TYPE zfipayment_program-request,
            amt_0_30                   TYPE i_operationalacctgdocitem-amountincompanycodecurrency,
            amt_30_60                  TYPE i_operationalacctgdocitem-amountincompanycodecurrency,
            amt_60_90                  TYPE i_operationalacctgdocitem-amountincompanycodecurrency,
            amt_above_90               TYPE i_operationalacctgdocitem-amountincompanycodecurrency,
            overdue_by_days            TYPE int4,
            itemtext                 TYPE i_operationalacctgdocitem-DocumentItemText,
          END OF ty_final.

    DATA:it_final TYPE TABLE OF ty_final,
         wa_final TYPE ty_final.



  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS YPAYMENT_WORKFLOW_CLASS IMPLEMENTATION.


METHOD if_rap_query_provider~select.
*  METHOD if_oo_adt_classrun~main.


    DATA: lt_response TYPE TABLE OF ZPAYMENT_WORKFLOW_RESPONCE.
    DATA:lt_current_output TYPE TABLE OF zpayment_workflow_responce.
    DATA:wa1 TYPE zpayment_workflow_responce.

    DATA(lv_top)           = io_request->get_paging( )->get_page_size( ).
    DATA(lv_skip)          = io_request->get_paging( )->get_offset( ).
    DATA(lt_filter)        = io_request->get_filter( )->get_as_sql_string( ).
    DATA(lt_fields)        = io_request->get_requested_elements( ).
    DATA(lt_sort)          = io_request->get_sort_elements( ).
*    REPLACE ALL OCCURRENCES OF '=' IN lt_filter WITH '<>'.
*    REPLACE ALL OCCURRENCES OF 'AND' IN lt_filter WITH 'OR'.
*

    TRY.
        DATA(lt_filter_cond) = io_request->get_filter( )->get_as_ranges( ).
      CATCH cx_rap_query_filter_no_range INTO DATA(lx_no_sel_option).
    ENDTRY.

    DATA(companycode)             =  VALUE #( lt_filter_cond[ name   =  'COMPANYCODE'  ]-range OPTIONAL ).
    DATA(fiscalyear)             =  VALUE #( lt_filter_cond[ name   =  'FISCALYEAR'  ]-range OPTIONAL ).
    DATA(postingdate)           =  VALUE #( lt_filter_cond[ name   =  'POSTINGDATE'  ]-range OPTIONAL ).
    DATA(supplieraccountgroup)  =  VALUE #( lt_filter_cond[ name   =  'SUPPLIERACCOUNTGROUP'  ]-range OPTIONAL ).
    DATA(supplier)            =  VALUE #( lt_filter_cond[ name   =  'SUPPLIER'  ]-range OPTIONAL ).
    DATA(flag)            =  VALUE #( lt_filter_cond[ name   =  'FLAG'  ]-range OPTIONAL ).
    READ TABLE flag INTO DATA(w_flag) INDEX 1.
    SELECT a~companycode ,
           a~fiscalyear ,
           a~postingdate ,
            a~supplier ,
            a~accountingdocument ,
            a~accountingdocumenttype ,
            a~clearingjournalentry ,
            a~transactioncurrency ,
*            @Semantics.amount.currencyCode: 'TransactionCurrency'
            a~amountincompanycodecurrency ,
            a~paymentterms ,
            a~netduedate ,
            a~additionalcurrency1 ,
            a~assignmentreference ,
            a~documentdate,
            a~invoicereference,
            a~specialglcode,
            b~suppliername,
            b~supplieraccountgroup,
            c~documentreferenceid,
*            @Semantics.amount.currencyCode: 'TransactionCurrency'
            d~amt AS supplieramounttot ,
            e~accountgroupname,
            f~request,
            a~DocumentItemText
     FROM i_operationalacctgdocitem AS a
       INNER JOIN i_supplier AS b ON ( b~supplier = a~supplier )
       LEFT OUTER JOIN i_journalentry         AS c ON ( c~accountingdocument = a~accountingdocument
                                                   AND  c~companycode = a~companycode
                                                   AND  c~fiscalyear = a~fiscalyear )
       LEFT OUTER JOIN zsupp_tot              AS d ON ( d~supplier = a~supplier
                                                   AND  d~companycode = a~companycode )
       INNER JOIN i_supplieraccountgrouptext  AS e ON ( e~supplieraccountgroup = b~supplieraccountgroup
                                                   AND  e~language = 'E' )
       LEFT OUTER JOIN zfipayment_program     AS f ON ( f~accountingdocument = a~accountingdocument
                                                   AND  f~companycode = a~companycode
                                                   AND  f~finyear = a~fiscalyear
                                                   AND  f~supplier = a~supplier )
     WHERE
*     (  a~accountingdocumenttype = 'RE' OR a~accountingdocumenttype = 'KR'  )
         a~financialaccounttype = 'K' AND a~clearingjournalentry = ''
       AND    b~supplieraccountgroup IN @supplieraccountgroup
       AND   a~companycode IN @companycode
       AND   a~postingdate IN @postingdate
       AND   a~fiscalyear  IN @fiscalyear
       AND   a~supplier    IN @supplier
     INTO TABLE @DATA(i_data).

  SORT i_data BY  CompanyCode accountingdocument .
  DELETE ADJACENT DUPLICATES FROM i_data COMPARING CompanyCode Supplier accountingdocument .

    LOOP AT i_data INTO DATA(w_data).

      DATA(days) = sy-datum - w_data-postingdate.
      wa_final-amountinbalancetransaccrcy = w_data-amountincompanycodecurrency.
      IF days BETWEEN 0 AND 30.
        wa_final-amt_0_30 = w_data-amountincompanycodecurrency.
      ELSEIF days BETWEEN 31 AND 60.
        wa_final-amt_30_60 = w_data-amountincompanycodecurrency.
      ELSEIF days BETWEEN 61 AND 90.
        wa_final-amt_60_90 = w_data-amountincompanycodecurrency.
      ELSEIF days GT 90.
        wa_final-amt_above_90 = w_data-amountincompanycodecurrency.
      ENDIF.
      wa_final-request   =   w_data-request.
      wa_final-specialglcode   =   w_data-specialglcode.
      wa_final-invoicereference  = w_data-invoicereference.
      wa_final-companycode                = w_data-companycode               .
      wa_final-overdue_by_days            = sy-datum - w_data-netduedate                .
      wa_final-fiscalyear                 = w_data-fiscalyear                .
      wa_final-postingdate                = w_data-postingdate               .
      wa_final-supplier                   = w_data-supplier                  .
      wa_final-accountingdocument         = w_data-accountingdocument        .
      wa_final-accountingdocumenttype     = w_data-accountingdocumenttype    .
      wa_final-clearingjournalentry       = w_data-clearingjournalentry      .
      wa_final-transactioncurrency        = w_data-transactioncurrency       .
      wa_final-paymentterms               = w_data-paymentterms              .
      wa_final-netduedate                 = w_data-netduedate                .
      wa_final-additionalcurrency1        = w_data-additionalcurrency1       .
      wa_final-assignmentreference        = w_data-assignmentreference       .
      wa_final-documentdate               = w_data-documentdate              .
      wa_final-suppliername               = w_data-suppliername              .
      wa_final-supplieraccountgroup       = w_data-supplieraccountgroup      .
      wa_final-documentreferenceid        = w_data-documentreferenceid       .
      wa_final-accountgroupname           = w_data-accountgroupname          .
      wa_final-invoicereference           = w_data-invoicereference          .
      wa_final-specialglcode              = w_data-specialglcode             .
      wa_final-itemtext                   = w_data-DocumentItemText          .

      IF w_flag-low = 'Group'.
        READ TABLE it_final ASSIGNING FIELD-SYMBOL(<fs>) WITH KEY itemtext = w_data-DocumentItemText "supplieraccountgroup = w_data-supplieraccountgroup
                                                                  companycode          = w_data-companycode
                                                                  fiscalyear           = w_data-fiscalyear.
        IF sy-subrc = 0.
          <fs>-amountinbalancetransaccrcy = <fs>-amountinbalancetransaccrcy + w_data-amountincompanycodecurrency.
          <fs>-amt_0_30     = <fs>-amt_0_30     + wa_final-amt_0_30    .
          <fs>-amt_30_60    = <fs>-amt_30_60    + wa_final-amt_30_60   .
          <fs>-amt_60_90    = <fs>-amt_60_90    + wa_final-amt_60_90   .
          <fs>-amt_above_90 = <fs>-amt_above_90 + wa_final-amt_above_90.
        ELSE.

          APPEND wa_final TO it_final.
          CLEAR wa_final.

        ENDIF.
      ELSEIF w_flag-low = 'Supplier'.
        READ TABLE it_final ASSIGNING <fs> WITH KEY itemtext = w_data-DocumentItemText " supplieraccountgroup = w_data-supplieraccountgroup
                                                    companycode          = w_data-companycode
                                                    supplier             = w_data-supplier
                                                    fiscalyear           = w_data-fiscalyear.
        IF sy-subrc = 0.
          <fs>-amountinbalancetransaccrcy = <fs>-amountinbalancetransaccrcy + w_data-amountincompanycodecurrency.
          <fs>-amt_0_30     = <fs>-amt_0_30     + wa_final-amt_0_30    .
          <fs>-amt_30_60    = <fs>-amt_30_60    + wa_final-amt_30_60   .
          <fs>-amt_60_90    = <fs>-amt_60_90    + wa_final-amt_60_90   .
          <fs>-amt_above_90 = <fs>-amt_above_90 + wa_final-amt_above_90.
        ELSE.

          APPEND wa_final TO it_final.
          CLEAR wa_final.

        ENDIF.
      ELSEIF w_flag-low = 'Details'.
        READ TABLE it_final ASSIGNING <fs> WITH KEY itemtext = w_data-DocumentItemText " supplieraccountgroup = w_data-supplieraccountgroup
                                                    companycode          = w_data-companycode
                                                    supplier             = w_data-supplier
                                                    accountingdocument   = w_data-accountingdocument
                                                    fiscalyear           = w_data-fiscalyear.
        IF sy-subrc = 0.
          <fs>-amountinbalancetransaccrcy = <fs>-amountinbalancetransaccrcy + w_data-amountincompanycodecurrency.
          <fs>-amt_0_30     = <fs>-amt_0_30     + wa_final-amt_0_30    .
          <fs>-amt_30_60    = <fs>-amt_30_60    + wa_final-amt_30_60   .
          <fs>-amt_60_90    = <fs>-amt_60_90    + wa_final-amt_60_90   .
          <fs>-amt_above_90 = <fs>-amt_above_90 + wa_final-amt_above_90.
        ELSE.

          APPEND wa_final TO it_final.
          CLEAR wa_final.

        ENDIF.
      ENDIF.

      CLEAR wa_final.
    ENDLOOP.

*    delete it_final WHERE supplieraccountgroup <> 'ZAAO' .
*    delete it_final WHERE companycode <> '2000'.
    MOVE-CORRESPONDING it_final TO lt_response.

    TRY.
        """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*_Paging implementation
        IF lv_top < 0  .
          lv_top = lv_top * -1 .
        ENDIF.
        DATA(lv_start) = lv_skip + 1.
        DATA(lv_end)   = lv_top + lv_skip.
        APPEND LINES OF lt_response FROM lv_start TO lv_end TO lt_current_output.

        io_response->set_total_number_of_records( lines( lt_current_output ) ).
        io_response->set_data( lt_current_output ).

      CATCH cx_root INTO DATA(lv_exception).
        DATA(lv_exception_message) = cl_message_helper=>get_latest_t100_exception( lv_exception )->if_message~get_longtext( ).
    ENDTRY.


  ENDMETHOD.
ENDCLASS.
