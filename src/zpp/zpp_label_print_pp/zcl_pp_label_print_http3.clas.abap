class ZCL_PP_LABEL_PRINT_HTTP3 definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_PP_LABEL_PRINT_HTTP3 IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.


  DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).
*    response->set_status( i_reason = 'SUSCESSFULL'  i_code = 2 ).
data : packing type string .

*packing = req[ 2 ]-name .

*if packing = 'packing_label' .

data plant type string .
data order type string .
data lotno type string .
data batch type string .
data printtype type string .






   types: BEGIN OF struct,
        error TYPE string,
        xml_data     TYPE string,
        form_type    TYPE string,
        form_locale  TYPE string,
        tagged_pdf   TYPE string,
        embed_font   TYPE string,
      END OF struct.


plant = value #( req[ name = 'plant' ]-value optional ) .
order = value #( req[ name = 'order' ]-value optional ) .
lotno = value #( req[ name = 'materialno' ]-value optional ) .
batch = value #( req[ name = 'batchno' ]-value optional ) .
printtype = value #( req[ name = 'selection' ]-value optional ) .
select * from  ZIPP_PACKING_LABEL as a
    inner join I_ProductDescription as b on ( b~product = a~Material ) where MaterialDocument  = @lotno

 INTO
TABLE @DATA(IT) .
if sy-subrc <>  0 .
   data msz type string .
    msz  = 'ERROR Please select a Valid Role'   .



response->set_text( msz ).

elseif sy-subrc = 0 .
data(line)  = lines( IT )  .


if line gt 20 .
*
msz  = |ERROR Please Input correct Lot, { lotno  } exceeds 20 labels    |   .
response->set_text( msz ).

else .


IF SY-uname = 'CB9980000144' OR SY-uname = 'CB9980000000' .
 DATA(pdf2) = ycl_packing_label_abap=>read_posts(  PLANT = plant  lot_no  = lotno   order = order   batch = batch
  printtype = printtype  ) .
response->set_text( pdf2 ) .


ELSE .

SELECT SINGLE * FROM ZIPP_PACKING_LABEL AS A INNER JOIN YP01 AS B ON ( A~MaterialDocument =  B~materialdoc )
WHERE a~MaterialDocument =    @lotno         INTO @DATA(RGR) .

IF SY-SUBRC = 0 .
 msz  = |ERROR Sticker Already printed against  { RGR-b-materialdoc  } |   .
response->set_text( msz ).
ELSE .
pdf2 = ycl_packing_label_abap=>read_posts(  PLANT = plant  lot_no  = lotno   order = order
batch = batch printtype = printtype ) .
response->set_text( pdf2 ).
endif .
ENDIF .

endif .




ENDIF .



  endmethod.
ENDCLASS.
