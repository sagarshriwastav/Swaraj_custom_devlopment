CLASS ygstr_recon_pur DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES  if_oo_adt_classrun.

    CLASS-DATA : access_token TYPE string .
    CLASS-DATA  : zgst_recon_data TYPE zgst_recon_data .

    TYPES:
      BEGIN OF post_s,
        user_id TYPE i,
        id      TYPE i,
        title   TYPE string,
        body    TYPE string,
      END OF post_s,

      BEGIN OF post_without_id_s,
        user_id TYPE i,
        title   TYPE string,
        body    TYPE string,
      END OF post_without_id_s.

    CLASS-METHODS :

      create_client

        IMPORTING url           TYPE string
        RETURNING VALUE(result) TYPE REF TO if_web_http_client
        RAISING   cx_static_check ,

      gstr_pur
        IMPORTING vbeln1              TYPE string OPTIONAL
                  datefrom            TYPE string
                  dateto              TYPE string
                  companycode         TYPE string
                  gstno               TYPE string
        RETURNING VALUE(gstrecon_pur) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS YGSTR_RECON_PUR IMPLEMENTATION.


          METHOD create_client.
            DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
            result = cl_web_http_client_manager=>create_by_http_destination( dest ).
          ENDMETHOD.


  METHOD gstr_pur.

    FIELD-SYMBOLS:
      <datax>  TYPE data,
      <datay>  TYPE data,
      <dataz>  TYPE data,
      <data2>  TYPE data,
      <data3>  TYPE any,
      <field>  TYPE any,
      <field1> TYPE any,
      <field2> TYPE any.

    DATA  gstinstats           TYPE string .
    DATA  gstin                TYPE string .
    DATA  totaldocumentcount   TYPE string .
    DATA  validrows            TYPE string .
    DATA  invalidrows          TYPE string .
    DATA  jsonrecorderrors     TYPE string .
    DATA  recordindex          TYPE string .
    DATA  externalid           TYPE string .
    DATA  externallineitemid   TYPE string .
    DATA  recorderrors         TYPE string .
    DATA  errorid              TYPE string .
    DATA  errormessage         TYPE string .
    DATA: lr_str TYPE REF TO data.

    DATA gv_from TYPE string .
    DATA gv1 TYPE string .
    DATA gv2 TYPE string .
    DATA gv3 TYPE string .

    gv3 = datefrom+6(4)  .
    gv2 = datefrom+3(2)  .
    gv1 = datefrom+0(2)  .

    CONCATENATE gv3  gv2  gv1 INTO gv_from .

    DATA gv_to TYPE string .
    DATA gv4 TYPE string .
    DATA gv5 TYPE string .
    DATA gv6 TYPE string .

    gv6 = dateto+6(4)  .
    gv5 = dateto+3(2)  .
    gv4 = dateto+0(2)  .

    CONCATENATE gv6  gv5  gv4 INTO gv_to .

    DATA: b_place TYPE string.

    IF gstno      = '08AAHCS2781A1ZH' .
      b_place     = '1010' .
    ELSEIF gstno  = '23AAHCS2781A1ZP' .
      b_place     = '1020' .
      ELSEIF gstno  = '08AABCM5293P1ZT' .
      b_place     = '2010' .
    ENDIF.


    SELECT * FROM YGSTR2_RECON WHERE PostingDate GE @gv_from AND  PostingDate LE @gv_to
             AND CompanyCode = @companycode AND businessplace = @b_place  " AND GLAccount <> '350001410'
             INTO TABLE @DATA(gstr2) .

*
    SELECT * FROM YJV_GSTR2_RECON WHERE PostingDate GE @gv_from  AND  PostingDate LE @gv_to
             AND companycode = @companycode AND businessplace = @b_place " AND GLAccount <> '350001410'
             APPENDING CORRESPONDING FIELDS OF TABLE @gstr2 .


            SORT gstr2 ASCENDING BY fidocument fidocument.
            delete gstr2 WHERE IsReversed = 'X' .
            DELETE ADJACENT DUPLICATES FROM gstr2 COMPARING fidocument fidocumentitem taxcode.
            DATA(gstr_hdr) = gstr2[].
            DELETE ADJACENT DUPLICATES FROM gstr_hdr COMPARING fidocument .

            DATA(records) = lines( gstr_hdr ) .
            DATA total   TYPE i .
            DATA success TYPE i .
            DATA fail    TYPE i .
            DATA rcm     TYPE c .
            DATA tot_sum       TYPE string.
            DATA total_amt     TYPE string.
            DATA gst_cs_rate   TYPE zdec1.
            DATA gst_igst_rate TYPE zdec1..

            DATA: fidocument TYPE c LENGTH 10.
            DATA bracketo TYPE string .
            DATA bracketc TYPE string .
            DATA lv_xml   TYPE string .
            DATA lv_xml13 TYPE string .
            DATA lv_xml14 TYPE string .
            bracketo  = '{' .
            bracketc  = '}' .

            CLEAR: success,fail,total.

            DATA(sep) = ',' .
            IF sy-tabix NE 1 .
              CLEAR sep .
            ENDIF .


            LOOP AT gstr_hdr INTO DATA(wa_hdr) WHERE IsReversed = ' ' .

              SELECT SINGLE * FROM i_regiontext WHERE region = @wa_hdr-state AND language = 'E' AND country = 'IN' INTO @DATA(state)  .
              IF state-region = '37' OR state-region = '28'.
                state-regionname = 'Andhra Pradesh'.
              ENDIF.

              DATA: fin_json TYPE string,
                    tabix    TYPE sy-tabix.


              DATA(gstr_COPY) = gstr2 .
              DELETE  gstr_COPY WHERE FiDocument <>  wa_hdr-FiDocument .

               CLEAR : tot_sum .

 LOOP AT gstr_COPY INTO DATA(WA_A) .
   tot_sum = tot_sum + WA_A-Gross_amount .
 ENDLOOP.

                IF tot_sum < 0.
                  tot_sum = tot_sum * -1.
                 ENDIF.



              fin_json =
               |{ bracketo }"userInputArgs" :{ bracketo }"templateId":"60e5613ff71f4a7aeca4336b","settings":{ bracketo }"ignoreHsnValidation":true{ bracketc }{ bracketc },| &&
               |"jsonRecords":[ | .

 LOOP AT gstr2 INTO DATA(iv) WHERE fidocument = wa_hdr-fidocument .

                tabix = sy-tabix.
                DATA gv TYPE string .
                DATA d1 TYPE string .
                DATA d2 TYPE string .
                DATA d3 TYPE string .

                d3 = iv-PostingDate+0(4)  .
                d2 = iv-PostingDate+4(2)  .
                d1 = iv-PostingDate+6(2)  .

                CONCATENATE d1 '/' d2 '/' d3 INTO gv .


                IF iv-baseunit = 'TO' .
                  DATA(unit)       =  'TON' .
                ELSEIF iv-baseunit = 'MTR' .
                  unit       =  'MTR' .
                ELSEIF iv-baseunit = 'KG' .
                  unit       =  'KGS' .
                ELSEIF iv-baseunit+0(3) = 'BAG' .
                  unit       =  'BAGS'.
                ELSE .
                  unit       =  'OTH'.
                ENDIF .

                IF iv-accountingdocumenttype = 'KR' OR
                   iv-accountingdocumenttype = 'KA' OR
                   iv-accountingdocumenttype = 'AA' OR
                   iv-accountingdocumenttype = 'SA' OR
                   iv-accountingdocumenttype = 'RE'.

                  DATA(doc_typ) = 'Invoice'.
                  ELSEIF iv-accountingdocumenttype = 'KG' OR
                         iv-accountingdocumenttype = 'ZA' OR
                         iv-accountingdocumenttype = 'RK'.    " DEBIT
                   doc_typ = 'D'.
                  ELSEIF iv-accountingdocumenttype = 'KC'.   "CREDIT
                   doc_typ = 'C'.
                  ENDIF.


                IF iv-taxcode = 'R1' OR
                   iv-taxcode = 'R2' OR
                   iv-taxcode = 'R3' OR
                   iv-taxcode = 'R4' OR
                   iv-taxcode = 'R5' OR
                   iv-taxcode = 'R6' OR
                   iv-taxcode = 'R7' OR
                   iv-taxcode = 'R8'  .
                    rcm = 'Y'.
                ELSE.
                  rcm = 'N'.
                ENDIF.

               if  iv-gstin = '0'.
                  iv-gstin = 'null'.
                endif.

 """"""""""""""""""""""""""""""""""""""""""""ND TaxCodes"""""""""""""""""""""""""""
           IF      iv-taxcode = 'ZA' OR
                   iv-taxcode = 'ZB' OR
                   iv-taxcode = 'ZC' OR
                   iv-taxcode = 'ZD' OR
                   iv-taxcode = 'Z1' OR
                   iv-taxcode = 'Z2' OR
                   iv-taxcode = 'Z3' OR
                   iv-taxcode = 'Z4' .

          if iv-InvoceValue < 0.
              iv-InvoceValue = iv-InvoceValue * -1.
              endif.
           if iv-Gross_amount < 0.
              iv-Gross_amount = iv-Gross_amount * -1.
              endif.
              DATA(ND) = 'INELIGIBLE'.
              ELSE.
                   ND  = 'INPUT'.
              Endif.
 """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

                IF iv-taxablevalue < 0.
                  iv-taxablevalue = iv-taxablevalue * -1.
                ENDIF.

                IF iv-Gross_amount < 0.
                  iv-Gross_amount = iv-Gross_amount * -1.
                ENDIF.

                 IF iv-InvoceValue < 0.
                  iv-InvoceValue = iv-InvoceValue * -1.
                ENDIF.

                IF iv-cgst < 0.
                  iv-cgst = iv-cgst * -1.
                ENDIF.

                IF iv-sgst < 0.
                  iv-sgst = iv-sgst * -1.
                ENDIF.

                IF iv-igst < 0.
                  iv-igst = iv-igst * -1.
                ENDIF.

                IF iv-sgst = '0.00' .
                   iv-sgst = iv-cgst.
                   ELSEIF iv-cgst = '0.00' .
                   iv-cgst = iv-sgst.
                   ENDIF.

*                gst_cs_rate = ( iv-cgst * 100 ) / iv-InvoceValue.
*                iv-taxrate = gst_cs_rate.
*                gst_igst_rate = ( iv-igst * 100 ) / iv-InvoceValue.

""""""""""""""""""""""""""""""""""FOR GST RATE"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
CLEAR: GST_CS_RATE, GST_IGST_RATE.
     SELECT SINGLE * FROM ytax_code2 WHERE taxcode = @IV-TaxCode  INTO @DATA(TAXRATE)  .

     IF IV-CGST IS NOT INITIAL.
        GST_CS_RATE = TAXRATE-gstrate / 2.
       ELSEIF IV-IGST IS NOT INITIAL.
              GST_IGST_RATE  = TAXRATE-gstrate.
                ENDIF.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


                IF tabix NE 1.
                  fin_json = fin_json && sep.
                ENDIF.

                fin_json = fin_json &&

                    |{ bracketo }"documentType":"{ doc_typ }","documentDate": "{ gv }" ,"documentNumber": "{ iv-documentreferenceid }","itcClaimType": "{ ND }", | &&
                    |"erpSource":"SAP","voucherNumber":"{ iv-documentreferenceid  }","voucherDate":"{ gv }",| &&
                    |"isBillOfSupply":"N","isReverseCharge":"{ rcm }","isDocumentCancelled":"N",| &&
                    |"supplierGstin":"{ iv-gstin }","supplierName":"{ iv-partyname }","supplierAddress":"{ iv-partyadd }","supplierState":"{ state-regionname }", | &&
                    |"customerGstin":"{ gstno }","placeOfSupply":"{ iv-placeofsupply }",| &&
                    | "itemDescription":"{ iv-fidocumentitem }","itemCategory":"G",| &&
                    |"hsnSacCode":"{ iv-hsncode }","itemQuantity":{ iv-quantity },"itemUnitCode":"{ unit }","itemUnitPrice":{ iv-taxrate },"itemDiscount":"0.00","itemTaxableAmount":{ iv-InvoceValue },| &&
                    |"cgstRate":{ GST_CS_RATE },"cgstAmount":{ iv-cgst },"sgstRate":{ GST_CS_RATE },"sgstAmount":{ iv-sgst },"igstRate":{ gst_igst_rate },"igstAmount":{ iv-igst },"cessRate":0,"cessAmount":0, | &&
                    |"documentTotalAmount":{ tot_sum } { bracketc } | .


              ENDLOOP.
              fin_json = fin_json && |]{ bracketc }|.

              DATA(status1)  =  ygstr_recon_api=>post_clear_tax( json =  fin_json gstin = |{ gstno }| fidocument = |{ iv-fidocument }| ) .

              DATA(lr_d1) = /ui2/cl_json=>generate( json = status1 ).
              IF lr_d1 IS BOUND.
              ASSIGN lr_d1->* TO <datax>.
              IF <datax> IS ASSIGNED .
              ASSIGN COMPONENT 'jsonRecordErrors' OF STRUCTURE <datax>  TO   <field>    .
              IF sy-subrc = 0 .
              ASSIGN <field>->* TO <data2>  .
              IF <data2> IS ASSIGNED .
              LOOP AT <data2> ASSIGNING FIELD-SYMBOL(<ls_data2>).
              ASSIGN COMPONENT 'RECORDERRORS' OF STRUCTURE <ls_data2> TO FIELD-SYMBOL(<fs>).
              IF <fs> IS ASSIGNED.
              ELSE.
              ASSIGN <ls_data2>->* TO FIELD-SYMBOL(<lt_fs>).
              IF <lt_fs> IS ASSIGNED.
              ASSIGN COMPONENT 'RECORDERRORS' OF STRUCTURE <lt_fs> TO FIELD-SYMBOL(<fs2>).
              IF <fs2> IS ASSIGNED.
              ASSIGN <fs2>->* TO FIELD-SYMBOL(<fs4>).
              IF <fs4> IS ASSIGNED.
              LOOP AT <fs4> ASSIGNING FIELD-SYMBOL(<fs5>).
              IF <fs5> IS ASSIGNED.
              ASSIGN COMPONENT 'ERRORMESSAGE' OF STRUCTURE <fs5> TO FIELD-SYMBOL(<fs6>).
              IF <fs6> IS ASSIGNED.
              ELSE.
              ASSIGN <fs5>->* TO FIELD-SYMBOL(<fs7>).
              IF <fs7> IS ASSIGNED.
              ASSIGN COMPONENT `ERRORMESSAGE` OF STRUCTURE <fs7>  TO   <field1>    .
              IF sy-subrc = 0 .
              ASSIGN <field1>->* TO <field1> .
              errormessage = <field1> .
              ENDIF.
              ENDIF.
              ENDIF.
              ENDIF.
              ENDLOOP.
              ENDIF.
              ENDIF.
              ENDIF.
              ENDIF.
              ENDLOOP.
              ENDIF.
              ENDIF.
              ENDIF.
              ENDIF.


              zgst_recon_data-templateid        =  '60e5613ff71f4a7aeca4336b' .
              zgst_recon_data-document_type     =  doc_typ .
              zgst_recon_data-documentdate      =  iv-PostingDate .
              zgst_recon_data-documentnumber    =  iv-fidocument.
              zgst_recon_data-taxcode           =  iv-TaxCode.
              zgst_recon_data-itemdescription   =  iv-fidocumentitem.
              zgst_recon_data-erpsource         =  'SAP' .
              zgst_recon_data-fiscalyear        =  IV-fiscalyear.
              zgst_recon_data-companycode       =  iv-companycode.
              zgst_recon_data-businessplace     =  iv-businessplace.
              zgst_recon_data-igstrate          =  gst_igst_rate.
              zgst_recon_data-igstamount        =  iv-igst.
              zgst_recon_data-cgstrate          =  iv-taxrate.
              zgst_recon_data-cgstamount        =  iv-cgst.
              zgst_recon_data-sgstrate          =  iv-taxrate.
              zgst_recon_data-sgstamount        =  iv-sgst.
              zgst_recon_data-itemtaxableamount =  iv-taxablevalue.
              zgst_recon_data-customer_gstin    =  gstno.
              zgst_recon_data-supp_gstin        =  iv-gstin.
              zgst_recon_data-supplier_name     =  iv-partyname.
              zgst_recon_data-supplier_address  =  iv-partyadd.
              zgst_recon_data-vouchernumber     =  iv-documentreferenceid  .
              zgst_recon_data-voucherdate       =  iv-PostingDate  .
              zgst_recon_data-error_message     =  errormessage .
              zgst_recon_data-report            =  'Purchase' .

              IF errormessage IS NOT INITIAL.
                zgst_recon_data-success_indctr = 'E' .
                fail = fail + 1.
              ELSE.
                zgst_recon_data-success_indctr = 'S' .
                success = success + 1.
              ENDIF.

              MODIFY zgst_recon_data FROM @zgst_recon_data .

              CLEAR : iv, errormessage, zgst_recon_data, gst_cs_rate, gst_igst_rate.
              DELETE gstr2 WHERE fidocument = wa_hdr-fidocument .

            ENDLOOP.

            IF gstno IS INITIAL.
            gstrecon_pur = | Business Place is missing | .
            else.
            gstrecon_pur = |Total { records } Documents, where { success } Documents Pushed Suscessfully and { fail } Failed | .
            endif.

 ENDMETHOD.


  METHOD if_oo_adt_classrun~main.

    DATA: vbeln1 TYPE string.
    TRY.
        DATA(return_data) = gstr_pur(  datefrom = '01/11/2022'  dateto = '30/11/2022' companycode = '1000' gstno = '08AAICR3451R1ZP' ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
