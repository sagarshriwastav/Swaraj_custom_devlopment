class ZCL_YEINV_HTTP1 definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_YEINV_HTTP1 IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.
  DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).

data chalanNumber type STRING.
data chalanNumber1 type STRING .
data year type string .
data vehicleNo type string .
data modeOfTransport type string .
data nameOfTransport type string .
data dispatchDate type string .
data dispatchTime type string .
data duration type string .
data radButton type string .
data Vehiclenumber type string .
data Modeoftrans type string .
data Nameoftrans type string .
data radButton1 type string .
data duration1 type string .
data distime type string .
data disdate type string .
DATA JSON TYPE STRING .
DATA selection type string.


chalanNumber1 = value #( req[ name = 'challannumber' ]-value optional ) .
year = value #( req[ name = 'year' ]-value optional ) .
Vehiclenumber = value #( req[ name = 'vehicleno' ]-value optional ) .
Modeoftrans = value #( req[ name = 'modeOfTransport' ]-value optional ) .
Nameoftrans = value #( req[ name = 'nameOfTransport' ]-value optional ) .
disdate = value #( req[ name = 'dispatchdate' ]-value optional ) .
distime = value #( req[ name = 'dispatchtime' ]-value optional ) .
duration1 = value #( req[ name = 'duration' ]-value optional ) .
radButton1 = value #( req[ name = 'radButton' ]-value optional ) .
selection =  value #( req[ name = 'selection' ]-value optional ) .

JSON =  value #( req[ name = 'json' ]-value optional ) .


data(pdf2) = zjobchallan_form=>read_posts( variable = chalanNumber1 "") .
year = year Vehiclenumber = Vehiclenumber Modeoftrans = Modeoftrans
 Nameoftrans = Nameoftrans disdate = disdate distime = distime duration1 = duration1 radButton1 = radButton1 selection = selection ) .

response->set_text( pdf2  ).

  endmethod.
ENDCLASS.
