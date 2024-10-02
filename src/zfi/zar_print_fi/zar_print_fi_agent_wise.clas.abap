CLASS zar_print_fi_agent_wise DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  INTERFACES if_oo_adt_classrun .

   TYPES : BEGIN OF ty,

              companycode   TYPE I_OperationalAcctgDocItem-CompanyCode,
              plant         TYPE I_Plant-Plant,
              division      TYPE  I_BillingDocument-Division,
              agaent        TYPE string,
              date          TYPE string,
              customername  TYPE string,
              billnumber    TYPE string,
              billdate      TYPE string,
              paymentterms  TYPE string,
              dayesinarrers TYPE string,
              invoiceamount TYPE I_BillingDocumentItem-NetAmount,
              amt0to30      TYPE I_BillingDocumentItem-NetAmount,
              amt31to45     TYPE I_BillingDocumentItem-NetAmount,
              amt46to60     TYPE I_BillingDocumentItem-NetAmount,
              amt61to90     TYPE I_BillingDocumentItem-NetAmount,
              amt90above    TYPE I_BillingDocumentItem-NetAmount,
              totalamount    TYPE I_BillingDocumentItem-NetAmount,

          END OF ty.


    DATA tab TYPE TABLE OF ty.

       CLASS-METHODS :
         read_posts
        IMPORTING VALUE(companycode)      TYPE string
                  VALUE(customer)         TYPE string
                  VALUE(postingfrom)      TYPE string
                  VALUE(postingto)        TYPE string
                  VALUE(profitcenter)     TYPE CHAR10
        RETURNING VALUE(result12) TYPE string
        RAISING   cx_static_check .

  PROTECTED SECTION.
  PRIVATE SECTION.

      CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
      CONSTANTS lc_template_name TYPE string VALUE 'AR_PRINT_FI/AR_PRINT_FI'.


ENDCLASS.



CLASS ZAR_PRINT_FI_AGENT_WISE IMPLEMENTATION.


       METHOD if_oo_adt_classrun~main.

       DATA(xml) =  read_posts( companycode = '' postingfrom = '' customer = '' postingto = '' profitcenter = ''  ) .

       ENDMETHOD.


  method read_posts .



    DATA lv_xml   TYPE string.
    DATA XSML     TYPE STRING.
    DATA dateFrom TYPE string.
    DATA dateto   TYPE string.
    DATA gv4      TYPE string .
    DATA gv5      TYPE string .
    DATA gv6      TYPE string .
    DATA Customer1 TYPE N LENGTH 10.
   Customer1 =    |{ Customer ALPHA = IN }| .
IF postingfrom <> ''.

    gv6 = postingfrom+0(4)  .
    gv5 = postingfrom+5(2)  .
    gv4 = postingfrom+8(2)  .
    CONCATENATE gv6 gv5 gv4  INTO dateFrom.

ENDIF.

*      DATA gv1 TYPE string .
*      DATA gv2 TYPE string .
*      DATA gv3 TYPE string .
*
*IF postingto <> ''.
*    gv3 = postingto+6(4)  .
*    gv2 = postingto+3(2)  .
*    gv1 = postingto+0(2)  .
* CONCATENATE gv3 gv2 gv1   INTO dateto.
*
*ENDIF.


IF dateFrom = ''.
dateFrom  = cl_abap_context_info=>get_system_date( ) .
ENDIF.

dateto  = cl_abap_context_info=>get_system_date( ) .

IF profitcenter <> '' AND customer <> '' AND postingfrom <> '' .

 SELECT * FROM ZFI_AR_REPORT_AGENT_CDS_FIN( p_comp = @companycode ,p_posting1 = @dateto  ) WITH PRIVILEGED ACCESS
 WHERE Supplier = @Customer1 AND ProfitCenter = @profitcenter AND PostingDate <= @dateFrom
 AND CompanyCode = @companycode  INTO TABLE @DATA(i_data).

ELSEIF profitcenter = '' AND customer = '' AND postingfrom = '' .

 SELECT * FROM ZFI_AR_REPORT_AGENT_CDS_FIN( p_comp = @companycode ,p_posting1 = @dateto  ) WITH PRIVILEGED ACCESS
 WHERE CompanyCode = @companycode  INTO TABLE @i_data.

ELSEIF profitcenter <> '' AND customer <> '' AND postingfrom = '' .

 SELECT * FROM ZFI_AR_REPORT_AGENT_CDS_FIN( p_comp = @companycode ,p_posting1 = @dateto  ) WITH PRIVILEGED ACCESS
 WHERE Supplier = @Customer1 AND ProfitCenter = @profitcenter AND CompanyCode = @companycode INTO TABLE @i_data.

 ELSEIF profitcenter <> '' AND customer = '' AND postingfrom = '' .

 SELECT * FROM ZFI_AR_REPORT_AGENT_CDS_FIN( p_comp = @companycode ,p_posting1 = @dateto  ) WITH PRIVILEGED ACCESS
 WHERE ProfitCenter = @profitcenter AND CompanyCode = @companycode INTO TABLE @i_data.

 ELSEIF customer <> '' AND postingfrom = '' AND profitcenter = '' .

 SELECT * FROM ZFI_AR_REPORT_AGENT_CDS_FIN( p_comp = @companycode ,p_posting1 = @dateto  ) WITH PRIVILEGED ACCESS
 WHERE Supplier = @Customer1 AND CompanyCode = @companycode INTO TABLE @i_data.

 ELSEIF profitcenter <> '' AND postingfrom <> '' AND customer = ''.

 SELECT * FROM ZFI_AR_REPORT_AGENT_CDS_FIN( p_comp = @companycode ,p_posting1 = @dateto  ) WITH PRIVILEGED ACCESS
 WHERE ProfitCenter = @profitcenter AND PostingDate <= @dateFrom  AND CompanyCode = @companycode  INTO TABLE @i_data.

  ELSEIF customer <> '' AND postingfrom <> '' AND profitcenter = ''.

 SELECT * FROM ZFI_AR_REPORT_AGENT_CDS_FIN( p_comp = @companycode ,p_posting1 = @dateto  ) WITH PRIVILEGED ACCESS
 WHERE Supplier = @Customer1 AND PostingDate <= @dateFrom AND CompanyCode = @companycode INTO TABLE @i_data.

   ELSEIF  postingfrom <> '' AND customer = '' AND profitcenter = ''.

 SELECT * FROM ZFI_AR_REPORT_AGENT_CDS_FIN( p_comp = @companycode ,p_posting1 = @dateto  ) WITH PRIVILEGED ACCESS
 WHERE PostingDate <= @dateFrom  AND CompanyCode = @companycode INTO TABLE @i_data.

ENDIF.
READ TABLE i_data into data(wa_head) INDEX 1.

DATA COMPANYCODENAME TYPE STRING .
IF companycode = '1000' .
COMPANYCODENAME = 'SWARAJ SUITING LIMITED- AR REPORT- MANAGEMENT' .
ELSEIF companycode = '2000' .
COMPANYCODENAME = 'MODWAY SUITING PRIVATE LIMITED- AR REPORT- MANAGEMENT' .
ENDIF.

      lv_xml =

         |<form1>| &&
         |<Subform1>| &&
         |<CompanyName>{ COMPANYCODENAME }</CompanyName>| &&
         |<headersubform>| &&
         |<companycode>{ companycode }</companycode>| &&
      "   |<Ajentname>Si manu vacuas</Ajentname>| &&
         |<Date>{ wa_head-sydatum+6(2) }-{ wa_head-sydatum+4(2) }-{ wa_head-sydatum+0(4) }</Date>| &&
         |</headersubform>| .


SORT I_DATA  BY Supplier Customer ASCENDING  .

DATA(IT)  = i_data[].
DATA(IT1)  = i_data[].

DELETE ADJACENT DUPLICATES FROM i_data COMPARING Supplier Customer.
SORT IT1  BY Supplier ASCENDING  .
DELETE ADJACENT DUPLICATES FROM IT1 COMPARING Supplier .

SORT IT1  BY SupplierName ASCENDING  .

LOOP AT IT1 INTO DATA(wa_agent) .


      lv_xml = lv_xml &&
      |<Table1>| &&
      |<Ajentname>{ wa_agent-SupplierName }</Ajentname>| .

DATA CUSTOMER23 TYPE C LENGTH 10.
DATA CUSTOMER233 TYPE C LENGTH 10.

LOOP AT i_data INTO DATA(wa_item) WHERE Supplier = wa_agent-Supplier .

 LOOP AT IT INTO DATA(wa_IT) WHERE Customer =  wa_item-Customer AND Supplier = wa_item-Supplier.

 SELECT SINGLE * FROM i_billingdocumentbasic WHERE billingdocument =  @wa_IT-OriginalReferenceDocument+0(10)  INTO @DATA(billhead) .
 SELECT SINGLE * FROM i_paymenttermstext WHERE paymentterms = @billhead-customerpaymentterms AND language = 'E' INTO @DATA(terms) .

      DATA terms1 TYPE string .
      IF terms-paymenttermsname <> '' .
        terms1 = terms-paymenttermsname  .
      ELSE.
      terms1 = terms-PaymentTermsDescription  .
      ENDIF.

      lv_xml = lv_xml &&
      |<TableRow>| &&
      |<customername>{ wa_IT-CustomerName }</customername>| &&
      |<billnumber>{ wa_IT-OriginalReferenceDocument+0(10) }</billnumber>| &&
      |<billdate>{ wa_IT-BillingDocumentDate+6(2) }-{ wa_IT-BillingDocumentDate+4(2) }-{ wa_IT-BillingDocumentDate+0(4) }</billdate>| &&
      |<paymentterm>{ terms1 }</paymentterm>| &&
      |<daysarrears>{ wa_it-daysarra }</daysarrears>| &&
      |<thirtydays>{ wa_IT-amt030 }</thirtydays>| &&
      |<fourtyfivedays>{ wa_IT-amt045 }</fourtyfivedays>| &&
      |<sixtydays>{ wa_IT-amt060 }</sixtydays>| &&
      |<nintydays>{ wa_IT-amt090 }</nintydays>| &&
      |<Aboveninty>{ wa_IT-amt90above }</Aboveninty>| &&
      |<totalamount>{ wa_IT-Amount }</totalamount>| &&
      |<totalnumberbill>{ wa_it-totalnumberbill }</totalnumberbill>| &&
      |</TableRow>| .

 clear:wa_IT,terms1,terms,billhead.
 ENDLOOP.

SELECT SINGLE  sum( AmountInCompanyCodeCurrency ) FROM I_OperationalAcctgDocItem WHERE Customer = @wa_item-Customer AND AccountingDocumentType = 'DZ'
 AND ClearingAccountingDocument = '' AND CompanyCode = @companycode INTO @DATA(ONACCOUNTAMT).

IF ONACCOUNTAMT <> 0.
 lv_xml = lv_xml &&
      |<TableRow>| &&
      |<customername> On Account Amount </customername>| &&
      |<billnumber></billnumber>| &&
      |<billdate></billdate>| &&
      |<paymentterm></paymentterm>| &&
      |<daysarrears></daysarrears>| &&
      |<thirtydays></thirtydays>| &&
      |<fourtyfivedays></fourtyfivedays>| &&
      |<sixtydays></sixtydays>| &&
      |<nintydays></nintydays>| &&
      |<Aboveninty></Aboveninty>| &&
      |<totalamount>{ ONACCOUNTAMT }</totalamount>| &&
      |<totalnumberbill></totalnumberbill>| &&
      |</TableRow>| .
ENDIF.
 SELECT SINGLE FROM @IT AS a FIELDS
          SUM( amt030 ) AS amt030,
          SUM( amt045 ) AS amt045,
          SUM( amt060 ) AS amt060,
          SUM( amt090 ) AS amt090,
          SUM( amt90above ) AS amt90above,
          SUM( Amount ) AS totAmount
          WHERE Customer = @wa_item-Customer
          INTO  @DATA(amt_Subtot).

 DATA SUBTOTALAMT TYPE I_OperationalAcctgDocItem-AmountInCompanyCodeCurrency.
 DATA TOTONACCOUNTAMT TYPE I_OperationalAcctgDocItem-AmountInCompanyCodeCurrency.

 SUBTOTALAMT = amt_Subtot-totAmount + ONACCOUNTAMT.

      lv_xml = lv_xml &&
      |<TableRow>| &&
      |<customername> Sub Total Party </customername>| &&
      |<billnumber></billnumber>| &&
      |<billdate></billdate>| &&
      |<paymentterm></paymentterm>| &&
      |<daysarrears></daysarrears>| &&
      |<thirtydays>{ amt_Subtot-amt030 }</thirtydays>| &&
      |<fourtyfivedays>{ amt_Subtot-amt045 }</fourtyfivedays>| &&
      |<sixtydays>{ amt_Subtot-amt060 }</sixtydays>| &&
      |<nintydays>{ amt_Subtot-amt090 }</nintydays>| &&
      |<Aboveninty>{ amt_Subtot-amt90above }</Aboveninty>| &&
      |<totalamount>{ SUBTOTALAMT }</totalamount>| &&
      |<totalnumberbill></totalnumberbill>| &&
      |</TableRow>| .

 TOTONACCOUNTAMT = TOTONACCOUNTAMT + ONACCOUNTAMT.
 clear:wa_item,ONACCOUNTAMT,SUBTOTALAMT,amt_Subtot.
  ENDLOOP.

   SELECT SINGLE FROM @IT AS a FIELDS
          SUM( amt030 ) AS amt030,
          SUM( amt045 ) AS amt045,
          SUM( amt060 ) AS amt060,
          SUM( amt090 ) AS amt090,
          SUM( amt90above ) AS amt90above,
          SUM( Amount ) AS totAmount
          WHERE Supplier = @wa_agent-Supplier
          INTO  @DATA(amt_tot).

 DATA TOTTOTALAMT TYPE I_OperationalAcctgDocItem-AmountInCompanyCodeCurrency.
 TOTTOTALAMT  = amt_tot-totamount + TOTONACCOUNTAMT.
      lv_xml = lv_xml &&
      |<TotalSubform>| &&
      |<totalthirtydays>{ amt_tot-amt030 }</totalthirtydays>| &&
      |<totalfourtyfive>{ amt_tot-amt045 }</totalfourtyfive>| &&
      |<totalsixtydays>{ amt_tot-amt060 }</totalsixtydays>| &&
      |<totalnintydays>{ amt_tot-amt090 }</totalnintydays>| &&
      |<totalaboveninty>{ amt_tot-amt90above }</totalaboveninty>| &&
      |<subtotalamount>{ TOTTOTALAMT }</subtotalamount>| &&
      |<subtotalnumber></subtotalnumber>| &&
      |</TotalSubform>| .

  lv_xml = lv_xml &&
      |</Table1>| .

clear:amt_tot,wa_agent.
ENDLOOP.

      lv_xml = lv_xml &&

      |</Subform1>| &&
      |</form1>| .


    CALL METHOD ycl_test_adobe=>getpdf(
    EXPORTING
         xmldata  = LV_XML
         template = lc_template_name
    RECEIVING
         result   = result12 ).

   ENDMETHOD.
ENDCLASS.
