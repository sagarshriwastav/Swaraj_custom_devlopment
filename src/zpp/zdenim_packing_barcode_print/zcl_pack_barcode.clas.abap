class ZCL_PACK_BARCODE definition
public
create public .
public section.
********************CREATED GAJENDRA SINGH SHEKHAWAT*************************************************************
INTERFACES if_oo_adt_classrun .
interfaces IF_HTTP_SERVICE_EXTENSION .

protected section.
private section.

ENDCLASS.



CLASS ZCL_PACK_BARCODE IMPLEMENTATION.


 method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.
   DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).
*    response->set_status( i_reason = 'SUSCESSFULL'  i_code = 2 ).

 data plant type string.
 data date  type string.
 data date1  type string.
 data material type matnr.
 data material1 type matnr.
 data rollno type string.
 data rollno1 type string.
 data foliono TYPE string.
 data foliono1 TYPE string.
 data grade TYPE string.
 data grade1 TYPE string.
 data materialdocno TYPE string.
 data materialdocno1 TYPE string.
 data partysort1 TYPE string.
 data dispatch TYPE string.


plant = value #( req[ name = 'plant' ]-value optional ) .
date = value #( req[ name = 'date' ]-value optional ) .
date1 = value #( req[ name = 'date1' ]-value optional ) .
material = value #( req[ name = 'material' ]-value optional ) .
material1 = value #( req[ name = 'material1' ]-value optional ) .
rollno = value #( req[ name = 'rollno' ]-value optional ) .
rollno1 = value #( req[ name = 'rollno1' ]-value optional ) .
foliono = value #( req[ name = 'foliono' ]-value optional ) .
foliono1 = value #( req[ name = 'foliono1' ]-value optional ) .
grade = value #( req[ name = 'grade' ]-value optional ) .
grade1 = value #( req[ name = 'grade1' ]-value optional ) .
materialdocno = value #( req[ name = 'materialdocno' ]-value optional ) .
materialdocno1 = value #( req[ name = 'materialdocno1' ]-value optional ) .
partysort1 = value #( req[ name = 'partysort' ]-value optional ) .
dispatch = value #( req[ name = 'dispatch' ]-value optional ) .

data msz type string .

if partysort1 is not INITIAL.

IF SY-uname = 'CB9980000015' OR SY-uname = 'CB9980000014' OR SY-uname = 'CB9980000000' OR SY-uname = 'CB9980000090'.

DATA(pdf1) = zclpack_hdr_def=>read_posts( plant = plant
                                          date = date
                                          date1 = date1
                                          material = material
                                          material1 = material1
                                          rollno = rollno
                                          rollno1 = rollno1
                                          foliono = foliono
                                          foliono1 = foliono1
                                          grade = grade
                                          grade1 = grade1
                                          materialdocno = materialdocno
                                          materialdocno1 = materialdocno1
                                          partysort1     =    partysort1
                                           ).
                                          response->set_text( pdf1 ).


ELSE .

 select * from  ZPACK_HDR_DEF as a
 LEFT OUTER JOIN  YP01 AS B ON ( A~MatDoc =  B~materialdoc AND A~RecBatch = B~rollno AND A~Plant = B~plant )
 where A~plant = @plant and A~RecBatch BETWEEN @rollno and @rollno1
 into table @DATA(it) .

IF SY-SUBRC = 0 .

LOOP AT it INTO DATA(WA_IT) .
IF WA_IT-b-flag = 'X' .
 msz  = |ERROR Sticker Already printed against  { WA_IT-a-RecBatch  } |   .
response->set_text( msz ).
EXIT .
ENDIF.
ENDLOOP.

IF msz IS INITIAL .
        pdf1 = zclpack_hdr_def=>read_posts( plant = plant
                                          date = date
                                          date1 = date1
                                          material = material
                                          material1 = material1
                                          rollno = rollno
                                          rollno1 = rollno1
                                          foliono = foliono
                                          foliono1 = foliono1
                                          grade = grade
                                          grade1 = grade1
                                          materialdocno = materialdocno
                                          materialdocno1 = materialdocno1
                                          partysort1     =    partysort1
                                         ).
                                          response->set_text( pdf1 ).
ENDIF.

ENDIF.
ENDIF.

ELSE .

IF dispatch is INITIAL .

       pdf1 = zclpack_hdr_def=>read_posts( plant = plant
                                          date = date
                                          date1 = date1
                                          material = material
                                          material1 = material1
                                          rollno = rollno
                                          rollno1 = rollno1
                                          foliono = foliono
                                          foliono1 = foliono1
                                          grade = grade
                                          grade1 = grade1
                                          materialdocno = materialdocno
                                          materialdocno1 = materialdocno1
                                          partysort1     =    partysort1

                                           ).
                                          response->set_text( pdf1 ).
     ELSE .

      pdf1 = zclpack_hdr_dispatch=>read_posts( plant = plant
                                          date = date
                                          date1 = date1
                                          material = material
                                          material1 = material1
                                          rollno = rollno
                                          rollno1 = rollno1
                                          foliono = foliono
                                          foliono1 = foliono1
                                          grade = grade
                                          grade1 = grade1
                                          materialdocno = materialdocno
                                          materialdocno1 = materialdocno1
                                          partysort1     =    partysort1
                                          dispatch = dispatch
                                           ).
                                          response->set_text( pdf1 ).
        ENDIF.



    ENDIF.
  endmethod.


 METHOD if_oo_adt_classrun~main.


  ENDMETHOD.
ENDCLASS.
