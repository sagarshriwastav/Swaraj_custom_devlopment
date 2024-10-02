 class zcl_mm_yarn_consump_class_1200 definition
  public
  create public .

public section.

       TYPES:BEGIN OF ty_header ,
            material         TYPE i_materialstock-material,
            plant            TYPE i_materialstock-plant,
            BATCH            TYPE i_materialstock-Batch,
            materialbaseunit TYPE i_materialstock-materialbaseunit,
            Customer         TYPE i_materialstock-Customer,
            FebricMaterial   TYPE i_materialstock-material,
            PickOnFabric     TYPE zpc_headermaster-zppicks,
          ProductDescription TYPE I_ProductDescription-ProductDescription,                  "GAJENDRA//25/09/2023
          END OF ty_header.

    DATA:it_header TYPE TABLE OF ty_header,
         wa_header LIKE LINE OF it_header.

    TYPES:BEGIN OF ty_item ,
            material                        TYPE i_materialstock-material,
            plant                           TYPE i_materialstock-plant,
            Customer                        TYPE i_materialstock-Customer,
            BATCH                           TYPE i_materialstock-Batch,
            materialbaseunit                TYPE i_materialstock-materialbaseunit,
            LotNumber                       TYPE I_ClfnObjectCharcValForKeyDate-CharcValue,
            Millname                        TYPE ZI_ClfnCharcValueDesc_cds-CharcValueDescription,
            YarnCount                       TYPE i_materialstock-matlwrhsstkqtyinmatlbaseunit,
            QualityWt                       TYPE i_materialstock-matlwrhsstkqtyinmatlbaseunit,
            QualityWtCountTest              TYPE i_materialstock-matlwrhsstkqtyinmatlbaseunit,
            FebricMaterial                  TYPE i_materialstock-material,
            PickOnFabric                    TYPE zpc_headermaster-zppicks,
            REEDSPACE                       TYPE zpc_headermaster-zpreedspace,
            DisppatchedQty                  TYPE i_materialstock-matlwrhsstkqtyinmatlbaseunit,
            opening_stock                   TYPE i_materialstock-matlwrhsstkqtyinmatlbaseunit,
            YARNRECEIVED                    TYPE i_materialstock-matlwrhsstkqtyinmatlbaseunit,
            YARNRETURN                      TYPE i_materialstock-matlwrhsstkqtyinmatlbaseunit,
            CONSUMPTIONASPERBOM             TYPE i_materialstock-matlwrhsstkqtyinmatlbaseunit,
            CONSUMPTIONASPERYARNTESTING     TYPE i_materialstock-matlwrhsstkqtyinmatlbaseunit,
            DIFFERENCEBWACTUALANDCOUNTEST   TYPE i_materialstock-matlwrhsstkqtyinmatlbaseunit,
            WASTAGEASPERYARNTESTING         TYPE i_materialstock-matlwrhsstkqtyinmatlbaseunit,
            BALANCEYARN                     TYPE i_materialstock-matlwrhsstkqtyinmatlbaseunit,
            ProductDescription              TYPE I_ProductDescription-ProductDescription,                        "GAJENDRA

          END OF ty_item.

    DATA:it_item TYPE TABLE OF ty_item,
         wa_item LIKE LINE OF it_item,
         it_item1 TYPE TABLE OF ZMM_YARN_CONSUMP_RESPONSE_1200.

  INTERFACES if_rap_query_provider.
protected section.
private section.
ENDCLASS.



CLASS ZCL_MM_YARN_CONSUMP_CLASS_1200 IMPLEMENTATION.


 METHOD if_rap_query_provider~select.

DATA: lt_response TYPE TABLE OF ZMM_YARN_CONSUMP_RESPONSE_1200 .
      DATA:wa1 TYPE ZMM_YARN_CONSUMP_RESPONSE_1200.
    DATA:lt_current_output TYPE TABLE OF ZMM_YARN_CONSUMP_RESPONSE_1200 .




    DATA(lv_top)           = io_request->get_paging( )->get_page_size( ).
    DATA(lv_skip)          = io_request->get_paging( )->get_offset( ).
    DATA(lt_clause)        = io_request->get_filter( )->get_as_sql_string( ).
    DATA(lt_fields)        = io_request->get_requested_elements( ).
    DATA(lt_sort)          = io_request->get_sort_elements( ).


    TRY.
        DATA(lt_filter_cond) = io_request->get_filter( )->get_as_ranges( ).
      CATCH cx_rap_query_filter_no_range INTO DATA(lx_no_sel_option).
    ENDTRY.

    DATA(lr_material)  =  VALUE #( lt_filter_cond[ name   =  'MATERIAL'  ]-range OPTIONAL ).
    DATA(lr_plant)  =  VALUE #( lt_filter_cond[ name   = 'PLANT' ]-range OPTIONAL ).
*    DATA(lr_postingdate)  =  VALUE #( lt_filter_cond[ name   = 'POSTINGDATE' ]-range OPTIONAL ).
    DATA(lr_from_date)  =  VALUE #( lt_filter_cond[ name   = 'FROM_DATE' ]-range OPTIONAL ).
    DATA(lr_to_date)  =  VALUE #( lt_filter_cond[ name   = 'TO_DATE' ]-range OPTIONAL ).
    DATA(lr_Customer)  =  VALUE #( lt_filter_cond[ name   = 'CUSTOMER' ]-range OPTIONAL ).
    DATA(lr_Batch)  =  VALUE #( lt_filter_cond[ name   = 'BATCH' ]-range OPTIONAL ).


    DATA:from_date TYPE i_materialstock-matldoclatestpostgdate,
         to_date   TYPE i_materialstock-matldoclatestpostgdate.


if lr_from_date[] is NOT INITIAL.
READ table lr_from_date into data(from_date1) INDEX 1.
from_date = from_date1-low .
from_date = from_date - 1.
ENDIF .

if lr_to_date[] is NOT INITIAL.
READ table lr_to_date into data(to_date1) INDEX 1.
to_date = to_date1-low.
ENDIF .

    SELECT material,
           plant,
           Batch,
           ProductDescription,
           Supplier as Customer,
           SUM( OpeningBalance ) AS matlwrhsstkqtyinmatlbaseunit
      FROM ZMM_WEFT_YARN_CONS_OPEN2_1200(  P_KeyDate = @from_date ) AS A  "YPP_STOCK_CDS_OPEN
      LEFT OUTER JOIN I_ProductDescription AS B ON (  B~Product = A~material and B~Language = 'E')
      WHERE plant in @lr_plant
       and  Material in @lr_material
       AND  a~Batch IN @lr_batch
       AND  a~Supplier IN @lr_Customer
      GROUP BY  material,
                plant,
                Batch,
                Supplier,
                ProductDescription
      INTO TABLE @DATA(i_opening).

*************************************************************************************
IF SY-SYSID = 'XMV'.
   SELECT  a~material,
           a~plant,
           a~BATCH,
           a~Supplier as Customer,
           a~materialbaseunit,
           h~CharcValueDescription AS Millname,
           i~CharcValue  as LotNumber,
           a~FabricMaterial   as FebricMaterial,
           j~YY1_ReedSpaceFor_Po_PDI as REEDSPACE,
           a~YARNRECEIVED,
           a~Dispatch_Qty AS DisppatchedQty,
           a~YARNRETURN,
           a~ProductDescription,
           K~ZRESULT as YarnCount,
           Pick~pick  as PickOnFabric
        FROM ZMM_YARN_CONSUMPTION_CDS3_1200( p_posting = @from_date , p_posting1 = @to_date ) as a
        left outer join I_BatchDistinct as n on ( N~Batch = A~Batch and N~Material = a~Material )
        LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as p on ( p~ClassType = '023' and p~ClfnObjectTable = 'MCH1'
                   and p~ClfnObjectInternalID = n~ClfnObjectInternalID and p~CharcInternalID = '0000000819' )
        LEFT OUTER JOIN ZI_ClfnCharcValueDesc_cds as h on ( h~mil = p~CharcValue and h~CharcInternalID = '0000000819' and h~Language = 'E' )
        LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as i on ( i~ClassType = '023' and i~ClfnObjectTable = 'MCH1'
                and i~ClfnObjectInternalID = n~ClfnObjectInternalID and i~CharcInternalID = '0000000818' )
       LEFT OUTER JOIN I_PurchaseOrderItemAPI01 as J ON ( j~PurchaseOrder = a~PurchaseOrder AND J~PurchaseOrderItem = a~PurchaseOrderItem )
       LEFT OUTER JOIN zpp_yarn_testtem as K ON ( K~partybillnumber = a~ReferenceDocument
                                                   AND K~parmeters = 'Actual Count' )
       LEFT OUTER JOIN zyarn_con_tmg as Pick ON (  Pick~fabric = a~FabricMaterial AND pick~yarn = a~Material )
        WHERE  A~plant in @lr_plant
        AND    a~Material IN @lr_material
        AND    a~Batch IN @lr_batch
        AND   a~Supplier IN @lr_Customer
        GROUP BY   a~plant,
                   a~material,
                   a~BATCH,
                   a~Supplier,
                   a~materialbaseunit,
                   a~YARNRECEIVED,
                   a~YARNRETURN,
                   a~ProductDescription,
                   h~CharcValueDescription,
                   i~CharcValue,
                   a~FabricMaterial ,
                   j~YY1_ReedSpaceFor_Po_PDI,
                   a~Dispatch_Qty,
                   K~ZRESULT,
                   Pick~Pick
                   INTO TABLE @DATA(i_data).
ELSE .

    SELECT  a~material,
           a~plant,
           a~BATCH,
           a~Supplier as Customer,
           a~materialbaseunit,
           h~CharcValueDescription AS Millname,
           i~CharcValue  as LotNumber,
           a~FabricMaterial   as FebricMaterial,
           j~YY1_ReedSpaceFor_Po_PDI as REEDSPACE,
           a~YARNRECEIVED,
           a~Dispatch_Qty AS DisppatchedQty,
           a~YARNRETURN,
           a~ProductDescription,
           K~ZRESULT as YarnCount,
           Pick~pick  as PickOnFabric
        FROM ZMM_YARN_CONSUMPTION_CDS3_1200( p_posting = @from_date , p_posting1 = @to_date ) as a
        left outer join I_BatchDistinct as n on ( N~Batch = A~Batch and N~Material = a~Material )
        LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as p on ( p~ClassType = '023' and p~ClfnObjectTable = 'MCH1'
                   and p~ClfnObjectInternalID = n~ClfnObjectInternalID and p~CharcInternalID = '0000000807' )
        LEFT OUTER JOIN ZI_ClfnCharcValueDesc_cds as h on ( h~mil = p~CharcValue and h~CharcInternalID = '0000000807' and h~Language = 'E' )
        LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as i on ( i~ClassType = '023' and i~ClfnObjectTable = 'MCH1'
                and i~ClfnObjectInternalID = n~ClfnObjectInternalID and i~CharcInternalID = '0000000806' )
       LEFT OUTER JOIN I_PurchaseOrderItemAPI01 as J ON ( j~PurchaseOrder = a~PurchaseOrder AND J~PurchaseOrderItem = a~PurchaseOrderItem )
        LEFT OUTER JOIN zpp_yarn_testtem as K ON ( K~partybillnumber = a~ReferenceDocument
                                                   AND K~parmeters = 'Actual Count' )
       LEFT OUTER JOIN zyarn_con_tmg as Pick ON (  Pick~fabric = a~FabricMaterial AND pick~yarn = a~Material )
        WHERE  A~plant in @lr_plant
        AND    a~Material IN @lr_material
        AND    a~Batch IN @lr_batch
        AND    a~Supplier IN @lr_Customer
        GROUP BY   a~plant,
                   a~material,
                   a~BATCH,
                   a~Supplier,
                   a~materialbaseunit,
                   a~YARNRECEIVED,
                   a~YARNRETURN,
                   a~ProductDescription,
                   h~CharcValueDescription,
                   i~CharcValue,
                   a~FabricMaterial ,
                   j~YY1_ReedSpaceFor_Po_PDI,
                   a~Dispatch_Qty,
                   K~ZRESULT,
                   Pick~Pick
                   INTO TABLE @i_data.

ENDIF.
**************************************************************************

 LOOP  AT i_opening INTO DATA(w_opening_gs).
      MOVE-CORRESPONDING w_opening_gs TO wa_header.
      APPEND wa_header TO it_header.
      CLEAR wa_header.
    ENDLOOP.

    LOOP AT i_data INTO DATA(w_data).
      MOVE-CORRESPONDING w_data TO wa_header.
      APPEND wa_header TO it_header.
      CLEAR wa_header.
    ENDLOOP.

    SORT it_header BY material plant batch customer febricmaterial pickonfabric.
    DELETE ADJACENT DUPLICATES FROM it_header COMPARING material plant batch customer febricmaterial pickonfabric.

 SORT  i_data ASCENDING BY Material Batch Plant Customer febricmaterial pickonfabric.
 DELETE ADJACENT DUPLICATES FROM i_data COMPARING Material Batch Plant Customer febricmaterial pickonfabric.

    LOOP AT it_header INTO data(wa_header).

      wa_item-material                          = wa_header-material .
      wa_item-plant                             = wa_header-plant   .
      wa_item-batch                             = wa_header-batch .
      wa_item-materialbaseunit                  = wa_header-materialbaseunit.
      wa_item-customer                          =  wa_header-Customer.
      wa_item-ProductDescription                =  wa_header-ProductDescription .

         DATA supplier1 TYPE c LENGTH 10.
      supplier1  = |{ wa_header-Customer ALPHA = IN }|  .

      READ  TABLE i_opening INTO DATA(w_opening) WITH KEY material        = wa_header-material
                                                          plant           = wa_header-plant
                                                          Batch           =  wa_header-Batch
                                                          Customer        =  wa_header-Customer.
      IF sy-subrc = 0.
        wa_item-opening_stock                  = w_opening-matlwrhsstkqtyinmatlbaseunit.
      ENDIF .

      LOOP AT i_data INTO DATA(wa_i_data) WHERE material         = wa_header-material
                                             AND plant           = wa_header-plant
                                             AND BATCH           = wa_header-batch
                                             AND customer        = wa_header-customer
                                             AND febricmaterial  = wa_header-febricmaterial
                                             AND pickonfabric    = wa_header-pickonfabric .

      SELECT SINGLE denier FROM zyarnco_rep_tmg WHERE material = @wa_i_data-material INTO @DATA(DENIR) .
      DATA QualityWtCountTestACT     TYPE p DECIMALS 3.
      DATA QualityWtCountTestACTCONS TYPE p DECIMALS 3.


     IF DENIR IS NOT INITIAL .

      QualityWtCountTestACT           =  ( ( ( wa_i_data-pickonfabric * wa_i_data-reedspace * 60 / 100 ) / ( ( DENIR ) ) )  / 1000 ).

    ENDIF.

      IF wa_i_data-pickonfabric <> 0 AND wa_i_data-pickonfabric <> 0.
     IF DENIR IS NOT INITIAL .
     QualityWtCountTestACT           =  ( ( ( wa_i_data-pickonfabric * wa_i_data-reedspace * 60 / 100 ) / ( ( 5315 /  DENIR ) ) )  / 1000 ).
    ENDIF.
     IF  wa_i_data-yarncount <> 0 AND  wa_i_data-yarncount IS NOT INITIAL .
    QualityWtCountTestACTCONS        =   ( ( ( wa_i_data-pickonfabric * wa_i_data-reedspace * 60 / 100 ) / ( ( 5315 /  wa_i_data-yarncount ) ) ) / 1000 ).
    ENDIF.

     wa_item-QualityWt                        =  QualityWtCountTestACT .
     wa_item-QualityWtCountTest               =  QualityWtCountTestACTCONS.
    ENDIF.

      wa_item-yarncount                        = wa_i_data-yarncount.
      wa_item-FebricMaterial                   = wa_i_data-febricmaterial.
      wa_item-PickOnFabric                     = wa_i_data-pickonfabric.
      wa_item-REEDSPACE                        = wa_i_data-reedspace.
      wa_item-millname                         = wa_i_data-millname .
      wa_item-lotnumber                        = wa_i_data-lotnumber .
      wa_item-DisppatchedQty                   = wa_i_data-disppatchedqty.

    .
      wa_item-YARNRECEIVED                     =  wa_i_data-yarnreceived .
      wa_item-YARNRETURN                       =  wa_i_data-yarnreturn .

     DATA(CONSUMPTIONASPERBOM)                =  wa_i_data-disppatchedqty * QualityWtCountTestACT .
     wa_item-CONSUMPTIONASPERBOM              =  CONSUMPTIONASPERBOM .

      DATA(CONSUMPTIONASPERYARNTESTING)        =  wa_i_data-disppatchedqty * QualityWtCountTestACTCONS  .
      wa_item-CONSUMPTIONASPERYARNTESTING      =  CONSUMPTIONASPERYARNTESTING.

      DATA(DIFFERENCEBWACTUALANDCOUNTEST)      =  CONSUMPTIONASPERBOM - CONSUMPTIONASPERYARNTESTING .
      wa_item-DIFFERENCEBWACTUALANDCOUNTEST    =  DIFFERENCEBWACTUALANDCOUNTEST.

    IF CONSUMPTIONASPERYARNTESTING <> 0 AND CONSUMPTIONASPERYARNTESTING IS NOT INITIAL .
      DATA(WASTAGEASPERYARNTESTING)            =  ( ( CONSUMPTIONASPERYARNTESTING ) * 35 / 1000 ).
      wa_item-WASTAGEASPERYARNTESTING          =  WASTAGEASPERYARNTESTING.
      ENDIF.

      ENDLOOP.
  .

      wa_item-BALANCEYARN                      =  w_opening-matlwrhsstkqtyinmatlbaseunit + wa_i_data-yarnreceived - ( wa_i_data-yarnreturn + CONSUMPTIONASPERYARNTESTING  +  WASTAGEASPERYARNTESTING ).


    APPEND wa_item TO it_item.
    CLEAR : wa_item ,supplier1.

    ENDLOOP.


   LOOP AT it_item INTO DATA(wa_item).
   MOVE-CORRESPONDING wa_item TO wa1.
   APPEND wa1 TO it_item1.
   CLEAR wa1.
   ENDLOOP.


    TRY.
 """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*_Paging implementation

        IF lv_top < 0  .
          lv_top = lv_top * -1 .
        ENDIF.
        DATA(lv_start) = lv_skip + 1.
        DATA(lv_end)   = lv_top + lv_skip.
        APPEND LINES OF it_item1 FROM lv_start TO lv_end TO lt_current_output.

     "   io_response->set_total_number_of_records( lines( lt_current_output ) ).
     "   io_response->set_data( lt_current_output ).


   IF io_request->is_total_numb_of_rec_requested(  ).
      io_response->set_total_number_of_records( lines( it_item1 ) ).
    ENDIF.

    IF io_request->is_data_requested(  ).
      io_response->set_data( lt_current_output ).
    ENDIF.

      CATCH cx_root INTO DATA(lv_exception).
        DATA(lv_exception_message) = cl_message_helper=>get_latest_t100_exception( lv_exception )->if_message~get_longtext( ).
    ENDTRY.

  endmethod.
ENDCLASS.
