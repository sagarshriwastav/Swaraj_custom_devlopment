class zcl_gst_recon_swaraj definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_GST_RECON_SWARAJ IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.


  DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).

 DATA companycode type string.
 DATA datefrom    type string.
 DATA dateto      type string.
 DATA gstno       type string.
 DATA vbeln1      type string.
 DATA selection   type string.

companycode = value #( req[ name = 'companycode' ]-value optional ) .
datefrom = value #( req[ name = 'datefrom' ]-value optional ) .
dateto = value #( req[ name = 'dateto' ]-value optional ) .
gstno = value #( req[ name = 'gstno' ]-value optional ) .
vbeln1 = value #( req[ name = 'vbeln1' ]-value optional ) .
selection = value #( req[ name = 'selection' ]-value optional ) .

IF ( selection = 'Sales' ) .

DATA(REVIEW)  =  ygst_recon_class=>gst_recon( datefrom  = datefrom
                                              dateto  = dateto
                                         companycode  = companycode
                                           gstno = gstno
                                              vbeln1 = ''      ) .


  response->set_text( REVIEW ).

elseif ( selection = 'Purchase' ) .

DATA(PUR)  =  ygstr_recon_pur=>GSTR_PUR( datefrom  = datefrom
                                              dateto  = dateto
                                         companycode  = companycode
                                           gstno = gstno
                                              vbeln1 = ''      ) .
 response->set_text( PUR ).

EndIF.

  endmethod.
ENDCLASS.
