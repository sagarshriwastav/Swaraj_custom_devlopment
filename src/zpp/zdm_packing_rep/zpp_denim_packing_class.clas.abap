CLASS zpp_denim_packing_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

      INTERFACES if_oo_adt_classrun .

          CLASS-DATA : access_token TYPE string .
    CLASS-DATA : xml_file TYPE string .
    TYPES :
      BEGIN OF struct,
        xdp_template TYPE string,
        xml_data     TYPE string,
        form_type    TYPE string,
        form_locale  TYPE string,
        tagged_pdf   TYPE string,
        embed_font   TYPE string,

      END OF struct.

    CLASS-METHODS :

      create_client
        IMPORTING url           TYPE string
        RETURNING VALUE(result) TYPE REF TO if_web_http_client
        RAISING   cx_static_check ,
      read_posts
        IMPORTING VALUE(Fromdate) TYPE datn
                 VALUE(Todate) TYPE datn
        RETURNING  VALUE(result12)    TYPE STRING
        RAISING   cx_static_check .

******

   interfaces IF_HTTP_SERVICE_EXTENSION .

  PROTECTED SECTION.
  PRIVATE SECTION.

      CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
    CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
    CONSTANTS  lv2_url    TYPE string VALUE 'https://sagar.authentication.eu10.hana.ondemand.com/oauth/token'  .
*    CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
*    CONSTANTS lc_template_name TYPE string VALUE 'YMIS01/YMIS01'.
ENDCLASS.



CLASS ZPP_DENIM_PACKING_CLASS IMPLEMENTATION.


  METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).

  ENDMETHOD .


    METHOD if_oo_adt_classrun~main.


  DATA(test)  = read_posts(  Fromdate = '20221212'   Todate = '20221212'  ) .

  ENDMETHOD.


    METHOD read_posts .


    TYPES : BEGIN OF it ,
              plant             TYPE zpackhdr_d-plant,
              rec_batch         TYPE zpackhdr_d-rec_batch,
              batch             TYPE zpackhdr_d-rec_batch,
              ftype             TYPE string,
              posting_date      TYPE  zpackhdr-posting_date ,
              material_number   TYPE  zpackhdr-material_number ,
              mat_doc           TYPE  zpackhdr-mat_doc ,
              storage_location  TYPE  zpackhdr-storage_location ,
              receving_location TYPE  zpackhdr-receving_location ,
              operator_name     TYPE  zpackhdr-operator_name ,
              pack_grade        TYPE  zpackhdr-pack_grade ,
              re_grading        TYPE  zpackhdr-re_grading ,
              finish_width      TYPE  zpackhdr-finish_width ,
              no_of_tp          TYPE  zpackhdr-no_of_tp,
              shift             TYPE  zpackhdr-shift,
              folio_number      TYPE  zpackhdr-folio_number,
              unit_field        TYPE  zpackhdr-unit_field,
              gross_weight      TYPE  zpackhdr-gross_weight,
              net_weight        TYPE  zpackhdr-net_weight,
              inspection_mc_no  TYPE  zpackhdr-inspection_mc_no,
              roll_length       TYPE  zpackhdr-roll_length,
              sales_order       TYPE  zpackhdr-sales_order,
              so_item           TYPE  zpackhdr-so_item,
              remark1           TYPE  zpackhdr-remark1,
              remark2           TYPE  zpackhdr-remark2,
              flag              TYPE  zpackhdr-flag ,
              flag_quantity     TYPE  zpackhdr-flag_quantity ,
            flag_quantity_total TYPE  zpackhdr-flag_quantity_total ,
              document_date     TYPE  zpackhdr-document_date ,
              etime             TYPE  zpackhdr-etime ,
              user_name         TYPE  zpackhdr-user_name ,
              cancelflag        TYPE  zpackhdr-cancelflag ,
              created_by        TYPE  zpackhdr-created_by ,
              created_at        TYPE  zpackhdr-created_at ,
              last_changed_at   TYPE  zpackhdr-last_changed_at,
              last_changed_by   TYPE  zpackhdr-last_changed_by ,
              werks             TYPE zdnmfault-werks,
              matnr             TYPE zdnmfault-matnr,
              charg             TYPE zdnmfault-charg,
              mblnr             TYPE zdnmfault-mblnr,
              bagno             TYPE zdnmfault-bagno,
              baleno            TYPE zdnmfault-baleno,
              budat             TYPE zdnmfault-budat,
              erdat             TYPE zdnmfault-erdat,
              point             TYPE zdnmfault-point,
              meter             TYPE zdnmfault-meter,


            END OF it.

    DATA : it  TYPE  TABLE OF it,
           wa1 TYPE it.


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
*                                     AND A~posting_date >= @fromdate AND A~posting_date <= @Todate
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

APPEND wa1 TO it.
CLEAR : wa_tab, lv_ft,wa1.

    ENDLOOP.

***********

   DATA(json_writer) = cl_sxml_string_writer=>create(
                            type = if_sxml=>co_xt_json ).
    CALL TRANSFORMATION id SOURCE result = it
                           RESULT XML json_writer.
    DATA(jsonx) = json_writer->get_output( ).


    DATA: lv_json TYPE string.


    DATA :lv_xstring_var TYPE xstring,
          strc           TYPE string.

    DATA(lv_string) = xco_cp=>xstring( jsonx
      )->as_string( xco_cp_character=>code_page->utf_8
      )->value.





 result12 = lv_string .

    ENDMETHOD.
ENDCLASS.
