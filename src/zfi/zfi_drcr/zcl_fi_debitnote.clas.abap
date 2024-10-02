class ZCL_FI_DEBITNOTE definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_FI_DEBITNOTE IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

   DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).






data(comcode) = value #( req[ name = 'comcode' ]-value optional ) .
data(docnum) = value #( req[ name = 'docnum' ]-value optional ) .
data(year) = value #( req[ name = 'year' ]-value optional ) .
data(plant) = value #( req[ name = 'plant' ]-value optional ) .
*data() = value #( req[ name = 'transporter' ]-value optional ) .


SELECT SINGLE * FROM I_OPERATIONALACCTGDOCITEM  WITH PRIVILEGED ACCESS WHERE accountingdocument = @docnum and FiscalYear = @year
AND CompanyCode = @comcode INTO @DATA(DOCT)  .

 IF DOCT-AccountingDocumentType EQ 'ZA'  .

 DATA(pdf2) = zfi_drcr_note=>read_posts( comcode = comcode date = ' '
 docno = docnum plant = plant year = year   ) .

ELSEIF DOCT-AccountingDocumentType EQ 'RE'  .

 pdf2 = zclfi_pur_doc=>read_posts( comcode = comcode date = ' '
 docno = docnum plant = plant year = year   ) .

ELSEIF  DOCT-AccountingDocumentType EQ 'KG' OR  DOCT-AccountingDocumentType EQ 'KC'
        OR  DOCT-AccountingDocumentType EQ 'DG' OR  DOCT-AccountingDocumentType EQ 'RK'   OR  DOCT-AccountingDocumentType EQ 'DD' .

 pdf2 = zclfi_drcr_fin=>read_posts( comcode = comcode date = ' '
 docno = docnum plant = plant year = year   ) .

ELSEIF  DOCT-AccountingDocumentType EQ 'DC'  .

 pdf2 = zfi_dc_debit_credit=>read_posts( comcode = comcode date = ' '
 docno = docnum plant = plant year = year   ) .

ENDIF.

response->set_text( pdf2 ).

  endmethod.
ENDCLASS.
