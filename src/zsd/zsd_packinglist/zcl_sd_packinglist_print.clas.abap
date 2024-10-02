class ZCL_SD_PACKINGLIST_PRINT definition
  public
  create public .

public section.
class-data : pdf2 type string ,
 pdf_xstring TYPE xSTRING.
  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_SD_PACKINGLIST_PRINT IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.
  DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).

    data variable type STRING.
    data variable1 type STRING.

    variable = value #( req[ name = 'delverynofrom' ]-value optional ) .
    variable1 = value #( req[ name = 'delverynoto' ]-value optional ) .

    DATA VAR1 TYPE ZCHAR10.
     DATA VAR2 TYPE ZCHAR10.
        VAR1 = variable.
        VAR1 =   |{ VAR1  ALPHA = IN }| .
        VAR2 = variable1.
        VAR2 =   |{ VAR2  ALPHA = IN }| .

IF VAR1 IS NOT INITIAL AND VAR2 IS INITIAL .

VAR2 = VAR1 .

ENDIF.


select * from I_DeliveryDocument where DeliveryDocument BETWEEN @VAR1 and @VAR2  into table  @data(billhead)  .
SORT billhead  BY DeliveryDocument .

if sy-subrc = 0 .
if lines( billhead ) le 10 .

DATA(l_merger) = cl_rspo_pdf_merger=>create_instance( ).
loop at billhead INTO data(invdata)  .
clear : variable.
clear : variable1.
variable  =   invdata-DeliveryDocument .
variable1  =   invdata-DeliveryDocument .
*احصل على بيانات pdf11 الخاصة بنا بتنسيق base64
SELECT SINGLE B~OrganizationDivision FROM I_DeliveryDocumentItem as a
LEFT OUTER  JOIN I_SalesDocument as b ON (  b~SalesDocument = a~ReferenceSDDocument )
   where  a~DeliveryDocument = @invdata-DeliveryDocument INTO @DATA(Division) .
IF Division = '15' .
   data(pdf2) = zsd_domestic_packinglist_frc=>read_posts( variable = variable variable1 = variable1 ).

ELSE.
    pdf2 = zsd_domestic_packinglist=>read_posts( variable = variable variable1 = variable1 ).
ENDIF.
*نقوم بتحويل سلسلة Base64 الخاصة بنا إلى 'Xstri23
pdf_xstring = xco_cp=>string( pdf2 )->as_xstring( xco_cp_binary=>text_encoding->base64 )->value.
*نقوم الآن بدمج مستند الطباعة الخاص بنا في فئة الدمج
l_merger->add_document( pdf_xstring ).

clear : variable.
clear : variable1.
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

else .
  response_final = | && 'Please Select Maximum 10 Document' && | .
ENDIF.
response->set_text( response_final ) .
ENDIF.

  endmethod.
ENDCLASS.
