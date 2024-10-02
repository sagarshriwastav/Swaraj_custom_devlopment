class ZCL_MM_YARN_CONSUMPTION_HTTP definition
  public
  create public .

public section.


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
         it_item1 TYPE TABLE OF ZMM_YARN_CONSUMPTION_RESPONSE.

  INTERFACES if_rap_query_provider.
protected section.
private section.
ENDCLASS.



CLASS ZCL_MM_YARN_CONSUMPTION_HTTP IMPLEMENTATION.


 METHOD if_rap_query_provider~select.

DATA: lt_response TYPE TABLE OF ZMM_YARN_CONSUMPTION_RESPONSE .
      DATA:wa1 TYPE ZMM_YARN_CONSUMPTION_RESPONSE.
    DATA:lt_current_output TYPE TABLE OF ZMM_YARN_CONSUMPTION_RESPONSE .




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
    DATA(lr_Customer)  =  VALUE #( lt_filter_cond[ name   = 'Customer' ]-range OPTIONAL ).

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
           CUSTOMER,
           ProductDescription,
           SUM( OpeningBalance ) AS matlwrhsstkqtyinmatlbaseunit
      FROM ZMM_WEFT_YARN_CONSUMPTIO_OPEN2(  P_KeyDate = @from_date ) AS A  "YPP_STOCK_CDS_OPEN
      LEFT OUTER JOIN I_ProductDescription AS B ON (  B~Product = A~material and B~Language = 'E')
      WHERE plant in @lr_plant
       and  Material in @lr_material
      GROUP BY  material,
                plant,
                CUSTOMER,
                ProductDescription
      INTO TABLE @DATA(i_opening).

*************************************************************************************
   SELECT  a~material,
           a~plant,
           a~Customer,
           a~BATCH,
           a~materialbaseunit,
           h~CharcValueDescription AS Millname,
           i~CharcValue  as LotNumber,
           a~FabricMaterial   as FebricMaterial,
           J~ZPPICKS   as PickOnFabric,
           J~ZPREEDSPACE as REEDSPACE,
           a~YARNRECEIVED,
           a~Dispatc_QTY AS DisppatchedQty,
           a~YARNRETURN,
           a~ProductDescription
        FROM ZMM_YARN_CONSUMPTION_CDS3( p_posting = @from_date , p_posting1 = @to_date ) as a
        left outer join I_BatchDistinct as n on ( N~Batch = A~Batch and N~Material = a~Material )
        LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as p on ( p~ClassType = '023' and p~ClfnObjectTable = 'MCH1'
                   and p~ClfnObjectInternalID = n~ClfnObjectInternalID and p~CharcInternalID = '0000000819' )
        LEFT OUTER JOIN ZI_ClfnCharcValueDesc_cds as h on ( h~mil = p~CharcValue and h~CharcInternalID = '0000000819' and h~Language = 'E' )
        LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as i on ( i~ClassType = '023' and i~ClfnObjectTable = 'MCH1'
                and i~ClfnObjectInternalID = n~ClfnObjectInternalID and i~CharcInternalID = '0000000818' )
        LEFT OUTER JOIN zpc_headermaster_cds as J ON ( j~Zpqlycode = a~FabricMaterial AND J~Zpunit = a~Plant )
        WHERE  A~plant in @lr_plant
        AND    a~Customer IN @lr_customer
        AND    a~Material IN @lr_material
        GROUP BY   a~plant,
                   a~material,
                   a~BATCH,
                   a~materialbaseunit,
                   a~CUSTOMER,
                   a~YARNRECEIVED,
                   a~YARNRETURN,
                   a~ProductDescription,
                   h~CharcValueDescription,
                   i~CharcValue,
                   a~FabricMaterial ,
                   J~ZPPICKS,
                   J~ZPREEDSPACE,
                   a~Dispatc_QTY
                   INTO TABLE @DATA(i_data).

**************************************************************************
    LOOP AT i_data INTO data(wa_i_data).

      wa_item-material         = wa_i_data-material .
      wa_item-plant            = wa_i_data-plant   .
      wa_item-customer         = wa_i_data-customer.
      wa_item-batch            = wa_i_data-batch .
      wa_item-materialbaseunit = wa_i_data-materialbaseunit.
      wa_item-lotnumber        = wa_i_data-lotnumber.
      wa_item-Millname         = wa_i_data-millname .
      wa_item-YarnCount       =  ''.
      wa_item-QualityWt       =  ''.
      wa_item-QualityWtCountTest       =  ''.
      wa_item-FebricMaterial        = wa_i_data-febricmaterial.
      wa_item-PickOnFabric         = wa_i_data-pickonfabric.
      wa_item-REEDSPACE         = wa_i_data-reedspace.
      wa_item-DisppatchedQty         = wa_i_data-disppatchedqty.

      READ  TABLE i_opening INTO DATA(w_opening) WITH KEY material        = wa_i_data-material
                                                    plant           = wa_i_data-plant
                                                    Customer      =   wa_i_data-customer.

      IF sy-subrc = 0.
        wa_item-opening_stock = w_opening-matlwrhsstkqtyinmatlbaseunit.
      ENDIF.
      wa_item-YARNRECEIVED          = wa_i_data-yarnreceived .
      wa_item-YARNRETURN        = wa_i_data-yarnreturn .
      wa_item-CONSUMPTIONASPERBOM         =  ''.
      wa_item-CONSUMPTIONASPERYARNTESTING      =  ''.
      wa_item-DIFFERENCEBWACTUALANDCOUNTEST      =  ''.
      wa_item-WASTAGEASPERYARNTESTING      =  ''.
      wa_item-BALANCEYARN      =  ''.
      wa_item-ProductDescription         = wa_i_data-ProductDescription .

    APPEND wa_item TO it_item.
    CLEAR wa_item.
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

        io_response->set_total_number_of_records( lines( lt_current_output ) ).
        io_response->set_data( lt_current_output ).

      CATCH cx_root INTO DATA(lv_exception).
        DATA(lv_exception_message) = cl_message_helper=>get_latest_t100_exception( lv_exception )->if_message~get_longtext( ).
    ENDTRY.

  endmethod.
ENDCLASS.
