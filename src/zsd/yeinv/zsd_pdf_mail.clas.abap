 CLASS zsd_pdf_mail DEFINITION
 PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
    CLASS-METHODS
      read_data
        IMPORTING INVOICE        TYPE string OPTIONAL
                  INVOICE1       TYPE string  OPTIONAL
        RETURNING VALUE(result12) TYPE string
        RAISING   cx_static_check .

    CLASS-DATA: lx_bcs_mail TYPE REF TO cx_bcs_mail.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZSD_PDF_MAIL IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  data i type i .
  select * from I_BillingDocument WITH PRIVILEGED ACCESS WHERE BillingDocument = '9122410053'   ORDER BY BillingDocument DESCENDING  into table @data(tab)  up to 1 rows .

 loop at tab ASSIGNING FIELD-SYMBOL(<fs>) .
  i = 1 + I .
  READ_DATA( invoice = conv #(   <fs>-BillingDocument )  invoice1 = conv #(   <fs>-BillingDocument )   )
 .
endloop .
*    DATA(config_instance) = cl_bcs_mail_system_config=>create_instance( ).
*        "Add allowed domains
*    TRY.
**    DATA(config_instance) = cl_bcs_mail_system_config=>create_instance( ).
**    DATA recipient_domains TYPE cl_bcs_mail_system_config=>tyt_recipient_domains.
**    DATA sender_domains TYPE cl_bcs_mail_system_config=>tyt_sender_domains.
**    recipient_domains = VALUE #( ( 'novelveritas.com' ) ).
***    recipient_domains = VALUE #( ( 'gmail.com' ) ).
**    sender_domains = VALUE #( ( 'rajasthanbarytes.com' ) ).
*    "Add allowed domains
*      CATCH cx_bcs_mail_config INTO DATA(write_error).
*        "handle exception
*    ENDTRY.
 ENDMETHOD.


 METHOD read_data.

     TYPES : BEGIN OF it_solisti1 ,
              line TYPE c LENGTH 255,
            END OF it_solisti1.

    DATA : i_objtx  TYPE STANDARD TABLE OF it_solisti1,
           i_objtxt TYPE it_solisti1,
          CUST_NAME TYPE STRING,
                 lv TYPE string,
                lv1 TYPE string,
                round       TYPE string,
           pdf_xstring TYPE xstring,
            mail_id(512) TYPE C,
            indctr  TYPE C.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  SELECT SINGLE * FROM I_BillingDocument  WITH PRIVILEGED ACCESS AS A LEFT OUTER JOIN
                       I_CUSTOMER  WITH PRIVILEGED ACCESS AS B ON ( A~SoldToParty = B~Customer )
                       WHERE A~BillingDocument = @invoice INTO @DATA(CUST).
                       CUST_NAME = CUST-b-CustomerName.
 SELECT SINGLE * FROM Zcust_Mail_ID  WHERE AddressID = @CUST-B-AddressID INTO @DATA(MAIL).
                       MAIL_ID = MAIL-EmailAddress.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
select ReferenceSDDocument from I_BillingDocumentItem WITH PRIVILEGED ACCESS
          WHERE BillingDocument = @invoice INTO TABLE @DATA(deli).

 DATA(l_merger) = cl_rspo_pdf_merger=>create_instance( ).

 loop at deli ASSIGNING FIELD-SYMBOL(<fss>)  .
        TRY.
           data(pdf11) = zsd_domestic_packinglist=>read_posts( variable = conv #( <fss>-ReferenceSDDocument )  variable1 = conv #( <fss>-ReferenceSDDocument ) ).
          CATCH cx_static_check.
            "handle exception
        ENDTRY.

         pdf_xstring = xco_cp=>string( pdf11 )->as_xstring( xco_cp_binary=>text_encoding->base64 )->value.
        l_merger->add_document( pdf_xstring ).
 endloop .



  TRY .
        DATA(l_poczone_pdf) = l_merger->merge_documents( ).
      CATCH cx_rspo_pdf_merger INTO DATA(l_exception).
        " Add a useful error handling here
    ENDTRY.




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    data pdf2 type xstring .
    data(pdf21) = zsd_dom_form=>read_posts( variable = invoice  ) .
         pdf2   = xco_cp=>string( pdf21 )->as_xstring( xco_cp_binary=>text_encoding->base64 )->value.


    i_objtxt-line = '<HTML> <BODY>'.
    APPEND i_objtxt TO i_objtx.
    CLEAR : i_objtxt.

    CONCATENATE '<p style="font-family:Calibri;font-size:16;">' 'Dear <b>' cust_name '.' '</b>'  INTO i_objtxt-line.
    APPEND i_objtxt TO i_objtx.
    CLEAR : i_objtxt.


*    CONCATENATE '<p>' 'Please find below the Dispatch Detail of' '<b>' cust_name '.' '</b></p>' INTO i_objtxt-line SEPARATED BY space.
*    APPEND i_objtxt-line TO i_objtx.
*    CLEAR : i_objtxt .

*    i_objtxt-line = '</body> </html>'.
*    APPEND i_objtxt TO i_objtx.
*    CLEAR i_objtxt.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   SELECT SINGLE * FROM I_BillingDocumentBASIC WITH PRIVILEGED ACCESS WHERE BillingDocument =  @invoice INTO @DATA(billhead) .
   SELECT  * from  Yeinvoice_cdss WITH PRIVILEGED ACCESS  WHERE BillingDocument = @invoice INTO TABLE @DATA(it) .
*   SELECT SUM( BillingQuantity ) FROM Yeinvoice_cdss WHERE BillingDocument =  @invoice INTO @DATA(QUANTITY) .

    CONCATENATE '<p>' 'Please find attached the digital copy of your invoice and packing slip' '<b>' '.' '</b></p>' INTO i_objtxt-line SEPARATED BY space.
    APPEND i_objtxt-line TO i_objtx.
    CLEAR : i_objtxt .


   i_objtxt-line = '<table style="font-family:calibri;font-size:15;MARGIN:10px;"'.   " bordercolor="blue"'.
    APPEND i_objtxt TO i_objtx.
    CLEAR : i_objtxt.

    i_objtxt-line = 'cellspacing="0" cellpadding="1" width="100%" '.
    APPEND i_objtxt TO i_objtx.
    CLEAR : i_objtxt.

    i_objtxt-line = 'border="1"><tbody><tr>'.
    APPEND i_objtxt TO i_objtx.
    CLEAR : i_objtxt.

    i_objtxt-line = '<th bgcolor="#a3d4ba" width="20%"> Invoice Number </th>'.
    APPEND i_objtxt TO i_objtx.
    CLEAR : i_objtxt.


    i_objtxt-line = '<th bgcolor="#a3d4ba" width="20%"> Invoice Date </th>'.
    APPEND i_objtxt TO i_objtx.
    CLEAR : i_objtxt.


    i_objtxt-line = '<th bgcolor="#a3d4ba" width="20%"> Sales Order Number </th>'.
    APPEND i_objtxt TO i_objtx.
    CLEAR : i_objtxt.


    i_objtxt-line = '<th bgcolor="#a3d4ba" width="20%"> Sales Order Date </th>'.
    APPEND i_objtxt TO i_objtx.
    CLEAR : i_objtxt.


    i_objtxt-line = '<th bgcolor="#a3d4ba" width="20%"> Payment Due Date  </th>'.
    APPEND i_objtxt TO i_objtx.
    CLEAR : i_objtxt.

 DELETE ADJACENT DUPLICATES FROM  it COMPARING BillingDocument.
........................................................................................
  LOOP AT IT INTO DATA(WA).

  SELECT SINGLE * from I_SalesDocument WITH PRIVILEGED ACCESS WHERE SalesDocument = @wa-sddocu
          into @DATA(sal).
    SELECT SINGLE * from I_OperationalAcctgDocItem  WITH PRIVILEGED ACCESS WHERE OriginalReferenceDocument = @wa-BillingDocument
       and CompanyCode = @wa-CompanyCode and FiscalYear = @billhead-FiscalYear  and FinancialAccountType = 'D'  into @data(DATE).

     i_objtxt-line = '<tr align = "center">'.
    APPEND i_objtxt TO i_objtx.
    CLEAR : i_objtxt.

    CONCATENATE '<td><b>' wa-BillingDocument '</b></td>' INTO i_objtxt-line SEPARATED BY space.
    APPEND i_objtxt TO i_objtx.
    CLEAR : i_objtxt.

    CONCATENATE '<td>' wa-BillingDocumentDate+6(2) '/' wa-BillingDocumentDate+4(2) '/' wa-BillingDocumentDate+0(4) '</td>' INTO i_objtxt-line SEPARATED BY space.
    APPEND i_objtxt TO i_objtx.
    CLEAR : i_objtxt.

    CONCATENATE '<td>' sal-SalesDocument  '</td>' INTO i_objtxt-line SEPARATED BY space.
    APPEND i_objtxt TO i_objtx.
    CLEAR : i_objtxt.

*     DATA : bill_QTY TYPE string,
*           bill_UNIT TYPE string.
*       bill_QTY   = WA-BillingQuantity .
*       bill_UNIT  = WA-BillingQuantityUnit.
*       CONCATENATE bill_QTY  bill_UNIT INTO DATA(qty) SEPARATED BY space.

    CONCATENATE '<td>' sal-SalesDocumentDate+6(2) '/' sal-SalesDocumentDate+4(2) '/' sal-SalesDocumentDate+0(4)  '</td>' INTO i_objtxt-line SEPARATED BY space.
    APPEND i_objtxt TO i_objtx.
   CLEAR : i_objtxt.

    CONCATENATE '<td>' DATE-NetDueDate+6(2) '/' DATE-NetDueDate+4(2) '/' DATE-NetDueDate+0(4) '</td>' INTO i_objtxt-line SEPARATED BY space.
    APPEND i_objtxt TO i_objtx.
    CLEAR : i_objtxt.

*    i_objtxt-line = '<tr align = "center">'.
*    APPEND i_objtxt TO i_objtx.
*    CLEAR : i_objtxt.

ENDLOOP.



  i_objtxt-line = '</TABLE>'.
  APPEND i_OBJTXT TO i_OBJTX.
  CLEAR i_OBJTXT.



     CONCATENATE  '<p>'
     'Kindly check and acknowledge the recipt of the invoice and remit the payment by due date ' '.'


     '<br><b></b></p>'

     INTO i_objtxt-line SEPARATED BY space.
    APPEND i_objtxt-line TO i_objtx.
    CLEAR : i_objtxt .

    CONCATENATE  'NOTE - Remittance to be shared at :' '.'
     '<br>ar-ssl@swarajsuiting.com </p>'

     INTO i_objtxt-line SEPARATED BY space.
    APPEND i_objtxt-line TO i_objtx.
    CLEAR : i_objtxt .


    CONCATENATE '<P>'
     'In case of question or concerns, please contact :' '.'
     '<br>ar-ssl@swarajsuiting.com </p>'

     INTO i_objtxt-line SEPARATED BY space.
    APPEND i_objtxt-line TO i_objtx.
    CLEAR : i_objtxt .

     CONCATENATE '<P>'
     'Thanks And Best Regards,' ''
     '<br>AR Team' ''
     '<br>Swaraj Suiting Limited </p>'

     INTO i_objtxt-line SEPARATED BY space.
    APPEND i_objtxt-line TO i_objtx.
    CLEAR : i_objtxt .

       i_objtxt-line = '<p><b>****This is a system-generated email ****</b></p>'.
    APPEND i_objtxt-line TO i_objtx.
    CLEAR : i_objtxt .


        i_objtxt-line = '</body> </html>'.
    APPEND i_objtxt TO i_objtx.
    CLEAR i_objtxt.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

     DATA :
      v_lines_txt TYPE i,
      v_lines_bin TYPE i.

    v_lines_txt = lines( i_objtx ).

    LOOP  AT i_objtx INTO i_objtxt .
      IF lv = ''.
        lv = i_objtxt.
      ELSE.
        CONCATENATE lv i_objtxt INTO lv.
        CONDENSE lv .
      ENDIF.
    ENDLOOP.
    TRY.
            DATA(lo_mail) = cl_bcs_mail_message=>create_instance( ).
            lo_mail->set_sender( 'noreply@swarajsuiting.com' ) ."noreply@sudivaindia.com' )..




*        lo_mail->add_recipient( 'siddhant.katariya@novelveritas.com' ).

        lo_mail->add_recipient( MAIL_ID ).
        lo_mail->add_recipient( 'dispatch.denim@swarajsuiting.com' ).
        lo_mail->add_recipient( 'Nasir@swarajsuiting.com' ).
        lo_mail->add_recipient( 'pankaj.k@swarajsuiting.com' ).


**     ENDIF.

*            lo_mail->add_recipient( iv_address = 'noreply@sudivaindia.com' iv_copy = cl_bcs_mail_message=>cc ).
*            IF ccmail_id IS NOT INITIAL .
*              lo_mail->add_recipient( iv_address =  ccmail_id  iv_copy = cl_bcs_mail_message=>cc ).
*            ENDIF .
            DATA inv TYPE string .
            DATA sub(1024) TYPE c .
*          CONCATENATE invoice '.pdf' INTO inv.
*          CONCATENATE 'Tax Invoice' invoice'Out for Delivery' INTO sub SEPARATED BY space.

            lo_mail->set_subject( |Your E-Invoice Number. { invoice }| ).
            lo_mail->set_main( cl_bcs_mail_textpart=>create_instance(
            iv_content      = lv
            iv_content_type = 'text/html'
            ) ).

            lo_mail->add_attachment( cl_bcs_mail_binarypart=>create_instance(
              iv_content      =  pdf2
              iv_content_type = 'application/pdf'
              iv_filename     = |INVOICE.PDF|
             ) ).

           lo_mail->add_attachment( cl_bcs_mail_binarypart=>create_instance(
              iv_content      =  l_poczone_pdf
              iv_content_type = 'application/pdf'
              iv_filename     = |Packing.PDF|
             ) ).





            lo_mail->send( IMPORTING et_status = DATA(lt_status) ).
          CATCH cx_bcs_mail INTO lx_bcs_mail.
            DATA(msg2) = lx_bcs_mail->if_message~get_longtext(  ).
        ENDTRY.



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  ENDMETHOD.
ENDCLASS.
