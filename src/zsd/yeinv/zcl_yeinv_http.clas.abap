class ZCL_YEINV_HTTP definition
  public
  create public .

public section.
class-data : pdf2 type string ,
 pdf_xstring TYPE xSTRING.
  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_YEINV_HTTP IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.
  DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).

data irn1 type string .
data eway type string .
data invoice type string .
data invoice1 type string .
data invoicegs type zchar10 .
data invoice2 type string .
data invoiceto type string .
data year type string .
data transpoter_name type string .
DATA IRNGENRATE TYPE STRING .
DATA Eway_generate TYPE STRING .
DATA form_generate TYPE STRING .
DATA Eway_Cancellation TYPE STRING .
DATA Irn_Cancellation TYPE STRING .
DATA Vehiclenumber TYPE STRING .
DATA transportdoc TYPE STRING .
DATA transportid TYPE STRING .
DATA JSON TYPE STRING .
DATA remark TYPE STRING .


data irn_name type string .
data eway_name type string .
data param type string .
data DISTANCE type string .
DATA transporterprint TYPE STRING .
DATA companycode TYPE STRING .
DATA companycode4 TYPE zchar4 .

invoice1 = value #( req[ name = 'invoice' ]-value optional ) .
invoiceto = value #( req[ name = 'invoiceto' ]-value optional ) .
invoiceGs = value #( req[ name = 'invoice' ]-value optional ) .
year = value #( req[ name = 'year' ]-value optional ) .
IRNGENRATE = value #( req[ name = 'irn' ]-value optional ) .
Eway_generate = value #( req[ name = 'eway' ]-value optional ) .
Form_generate = value #( req[ name = 'form' ]-value optional ) .
Transpoter_name = value #( req[ name = 'transporter' ]-value optional ) .
DISTANCE = value #( req[ name = 'distance' ]-value optional ) .
Eway_Cancellation = value #( req[ name = 'caneway' ]-value optional ) .
Irn_Cancellation = value #( req[ name = 'canirn' ]-value optional ) .
Vehiclenumber = value #( req[ name = 'vehiclenumber' ]-value optional ) .
Transportid  =  value #( req[ name = 'transportid' ]-value optional ) .
Transportdoc =  value #( req[ name = 'transportdoc' ]-value optional ) .
JSON =  value #( req[ name = 'json' ]-value optional ) .
transporterprint =  value #( req[ name = 'transporter' ]-value optional ) .
companycode =  value #( req[ name = 'companycode' ]-value optional ) .
companycode4 =  value #( req[ name = 'companycode' ]-value optional ) .
remark =  value #( req[ name = 'remark' ]-value optional ) .


data(invtype) =  value #( req[ name = 'invoicetype' ]-value optional ) .  "Finance Invoice  or Sales Invoice

     DATA VAR1 TYPE ZCHAR10.
     DATA VARto TYPE ZCHAR10.
     DATA VARGS TYPE ZCHAR10.

        VAR1 = invoice1.
        VAR1 =   |{ |{ VAR1 ALPHA = OUT }| ALPHA = IN }| .
        invoice1 = VAR1.
        VARto = invoiceto.
        VARto =   |{ |{ VARto ALPHA = OUT }| ALPHA = IN }| .
        invoiceto = VARto.

        VARGS = invoiceGs .
        VARGS =   |{ |{ VARGS ALPHA = OUT }| ALPHA = IN }| .
        invoiceGs =  VARGS.


  SELECT SINGLE BillingDocumentIsCancelled , AccountingDocument ,DistributionChannel FROM I_BillingDocument WHERE BillingDocument = @invoice1 AND CompanyCode = @companycode INTO @DATA(CancelBill) .

if  ( IRNGENRATE = 'X'  AND Eway_generate = 'X' )  .

if invtype = 'Sales Invoice'.
DATA REVIEW TYPE STRING.
SELECT * FROM I_BillingDocumentItem WITH PRIVILEGED ACCESS
 WHERE BillingDocument = @invoice1 AND CompanyCode = @companycode INTO TABLE @DATA(BILLDATA) .
 if CancelBill-DistributionChannel <> '02' .
LOOP AT BILLDATA INTO DATA(WA_BILLDTA) .

SELECT SINGLE conditionbaseamount FROM i_billingdocumentitemprcgelmnt WITH PRIVILEGED ACCESS WHERE billingdocument = @WA_BILLDTA-billingdocument
                                          AND billingdocumentitem = @WA_BILLDTA-billingdocumentitem  AND
conditionbaseamount IS NOT INITIAL AND  conditiontype IN ( 'JOIG' ,'JOCG' ,'JOSG' ) INTO  @DATA(GST) .
IF GST = 0 .
REVIEW = 'Error: Please Maintain GST.' &&  WA_BILLDTA-BillingDocumentItem .
EXIT.
ENDIF.
CLEAR:GST,WA_BILLDTA.
ENDLOOP.
ENDIF.
**********************************************************************************************
IF REVIEW = ' ' .
 IF CancelBill-BillingDocumentIsCancelled <> 'X' AND CancelBill-AccountingDocument <> '' .
*******************************************GST CHECK ***************************************

REVIEW  =  yeinvoice_te=>get_table_fields(       invoice = invoice1
                                                    companycode = companycode4
                                                    irngenrate = IRNGENRATE
                                                 Eway_generate = Eway_generate
                                                      distance = DISTANCE
                                                   Transportid = Transportid
                                                  transportdoc = Transportdoc
                                                    Vehiclenumber = Vehiclenumber
                                                transpoter_name =  transpoter_name   ) .

 ELSEIF CancelBill-BillingDocumentIsCancelled = 'X'  OR CancelBill-AccountingDocument = ''.

  IF CancelBill-BillingDocumentIsCancelled = 'X' .
     REVIEW =    |This Bill Is { invoice1  } **** Cancel  | .
  ELSEIF   CancelBill-AccountingDocument = '' .
   REVIEW =    |This Bill { invoice1  } Against Not Accounting Hit. Please Bill Accounting Check**** | .
  ENDIF.

ENDIF.
ENDIF.
endif .



if invtype = 'Finance Invoice' .
REVIEW = zfi_e_invoice=>get_table_fields( invoice = invoice1 year = year irngenrate = IRNGENRATE  companycode = companycode  ) .
endif .

response->set_text( review  ).

ELSEIF ( IRNGENRATE = 'X' AND Eway_generate NE 'X' ) .
response->set_text( |IRN GENERATION REQUEST FOR  { invoice1  } **** DENIED  |  ).
elseIF  Form_generate EQ 'X' .


if invtype = 'Sales Invoice'.

    invoice1 = invoice1 .
    invoiceto = invoiceto.
    if invoiceto is INITIAL AND invoice1 is NOT INITIAL.
    invoiceto = invoice1 .
    endif .

select * from I_BillingDocumentBasic where BillingDocument BETWEEN @invoice1 and @invoiceto  AND CompanyCode = @companycode into table  @data(billhead)  .
SORT billhead  BY BillingDocument .
if sy-subrc = 0 .

if lines( billhead ) le 10 .
DATA(l_merger) = cl_rspo_pdf_merger=>create_instance( ).

loop at billhead INTO data(invdata)  .
*احصل على بيانات pdf11 الخاصة بنا بتنسيق base64
select single * from I_DeliveryDocument where DeliveryDocument = @invdata-BillingDocument  into @data(deli)  .
SELECT SINGLE PLANT FROM I_BillingDocumentItem WHERE BillingDocument = @invdata-BillingDocument AND CompanyCode = @companycode INTO @DATA(plant).

invoice   =  invdata-BillingDocument .
if invdata-BillingDocument is not INITIAL.

IF ( plant = '2100' AND invdata-DistributionChannel <> '01' ) OR plant = '2200' .

data(pdf2) = zsd_dom_modway_form=>read_posts( variable = invoice  remark = remark ) .
ELSE .

if  transporterprint = 'X' .

 pdf2 = zsd_dom_tranporter_print=>read_posts( variable = invoice remark = remark ) .
else.

  pdf2 = ZSD_DOM_FORM=>read_posts( variable = invoice remark = remark ) .
ENDIF.
ENDIF.

elseif deli-DeliveryDocument is not INITIAL  .
pdf2 = zdiliveryprint=>read_posts( variable = invoice ) .
endif .
*نقوم بتحويل سلسلة Base64 الخاصة بنا إلى 'Xstri23
pdf_xstring = xco_cp=>string( pdf2 )->as_xstring( xco_cp_binary=>text_encoding->base64 )->value.
*نقوم الآن بدمج مستند الطباعة الخاص بنا في فئة الدمج
l_merger->add_document( pdf_xstring ).

clear : invoice.
clear : invdata.
ENDLOOP.

 TRY .
    DATA(l_poczone_PDF) = l_merger->merge_documents( ).
      CATCH cx_rspo_pdf_merger INTO DATA(l_exception).
        " Add a useful error handling here
    ENDTRY.
        DATA(response_final) = xco_cp=>xstring( l_poczone_PDF
      )->as_string( xco_cp_binary=>text_encoding->base64
      )->value .

      response->set_text( response_final ) .
else .

  response_final = | && 'Please Select Maximum 10 Document' && | .
  response->set_text( response_final ) .
ENDIF.
ENDIF.
endif .



if invtype = 'Finance Invoice'.


pdf2 = z_fb70_invoice=>read_posts( variable = invoice1 year = year ) .

response->set_text( pdf2  ).

endif .



*   ELSEIF  Irn_Cancellation = 'X' AND Eway_Cancellation = 'X'  .
*
*  if invtype = 'Sales Invoice'.
*

*  REVIEW  =  yeinvoice_te=>get_table_fields(       invoice = Eway_Cancellation
*                                                    irngenrate = IRNGENRATE
*                                                 Eway_generate = Eway_generate
*                                                      distance = DISTANCE
*                                                   Transportid = Transportid
*                                                  transportdoc = Transportdoc
*                                                    Vehiclenumber = Vehiclenumber
*                                                transpoter_name =  transpoter_name   ) .
* response->set_text( review  ).

   ELSEIF  Irn_Cancellation = 'X' AND Eway_Cancellation = 'X'  .

  if invtype = 'Sales Invoice'.

   DATA invvoice TYPE string .

  DATA(REVIEW1)  =  yeinvoice_te=>cancel_irn(    invVoice = invoiceGs companycode = companycode4
                                                     ) .
  DATA(REVIEW2)  =  yeinvoice_te=>cancel_irn2(   inVVoice = invoiceGs companycode = companycode4
                                                     ) .
 review1 = |PART 1{ REVIEW1 }   //// PART 2 { REVIEW2 }   |     .

 response->set_text( review1  ).




 ELSEIF invtype = 'Finance Invoice' .

  REVIEW1  =  zfi_e_invoice=>cancel_irn( invVoice = invoice1 companycode = companycode  year = year
                                                     ) .
   review1 = |PART 1{ REVIEW1 } | .
   response->set_text( review1  ).
* response->set_text( |IRN AND EWAY CANCELATION REQUEST FOR  { invoice1  } **** DENIED  |  ).

ENDIF.




*
*  ELSEIF Irn_Cancellation = 'X' .
*
*response->set_text( |IRN CANCELATION REQUEST FOR  { invoice1  } **** DENIED  |  ).
*
*ELSEIF Eway_Cancellation = 'X' .
*
*response->set_text( |EWAY CANCELATION REQUEST FOR  { invoice1  } **** DENIED  |  ).
*

elseif json = 'X'.

data(bing)  =  ycl_json4einv=>create_json( invoice = invoice1 )   .


response->set_text( bing ).


endif .


*response->set_text( 'Rishi' ).





  endmethod.
ENDCLASS.
