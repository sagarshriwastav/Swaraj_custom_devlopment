class ZCL_PACK_311_BAPI_CANCEL definition
  public
  create public .

public section.

TYPES : BEGIN OF it,
        material TYPE char18,
        matdocyear TYPE numc4,
        candate TYPE dats,
        END OF it.

   INTERFACES if_oo_adt_classrun .
  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_PACK_311_BAPI_CANCEL IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

    DATA(req) = request->get_form_fields(  ).

    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).

   data: materialDocument TYPE char18,
        matdocyear TYPE numc4,
        candate TYPE dats.

         materialDocument = req[ 2 ]-value.
         matdocyear = req[ 3 ]-value.
         candate = req[ 4 ]-value.

   SELECT  SINGLE cancelflag FROM zpackhdr WHERE mat_doc = @materialDocument AND mat_docyear = @matdocyear INTO @DATA(CHEAKMAT).

   IF CHEAKMAT IS NOT INITIAL .

   DATA(result1) = 'Alreday Cancel' .

   response->set_text( | Material document { result1 }| ) .
   ELSE.


*    DATA(body)  = request->get_text(  )  .

      DATA respo  TYPE it." ZPP_DYEC .

*        xco_cp_json=>data->from_string( body )->write_to( REF #( respo ) ).


*Declare derived type for authorization request
DATA: request_ga TYPE STRUCTURE FOR PERMISSIONS REQUEST  i_materialdocumenttp\\MaterialDocument .

*Activate check for create operation
request_ga-%delete = if_abap_behv=>mk-on.

*Perform authorization request
GET PERMISSIONS ONLY GLOBAL AUTHORIZATION ENTITY  i_materialdocumenttp\\MaterialDocument
  REQUEST request_ga
RESULT DATA(result)
FAILED DATA(failed)
REPORTED DATA(reported).






DATA: lt_cancel_header TYPE TABLE FOR ACTION IMPORT i_materialdocumenttp\\MaterialDocument~Cancel.

lt_cancel_header = VALUE #( ( %key-MaterialDocument = materialDocument %key-MaterialDocumentYear = matdocyear ) ).
MODIFY ENTITY i_materialdocumenttp\\MaterialDocument
 EXECUTE Cancel FROM lt_cancel_header
RESULT DATA(result3)
MAPPED DATA(mapped3)
FAILED DATA(failed3)
REPORTED DATA(reported3).


COMMIT ENTITIES BEGIN
  RESPONSE OF i_materialdocumenttp
         FAILED DATA(commit_failed3)
         REPORTED DATA(commit_reported3).

           LOOP AT  reported3-materialdocument ASSIGNING FIELD-SYMBOL(<data>).

          DATA(msz) =  <data>-%msg  .

          DATA(mszty) = sy-msgty .
          DATA(msz_1)  = | { sy-msgv1 } { sy-msgv2 }  { sy-msgv3 } { sy-msgv4 } Message Type- { sy-msgty } Message No { sy-msgno }  |  .

        ENDLOOP .



        LOOP AT result3 ASSIGNING FIELD-SYMBOL(<keys_header>).
          IF mszty = 'E' .
            EXIT .
          ENDIF .

        ENDLOOP.



        COMMIT ENTITIES END.



          IF  mszty = 'E' .

          result1 = |ERROR { msz_1 } |.

        ELSE .
          DATA(grn)  = <keys_header>-materialdocument .

          result1 = <keys_header>-materialdocument .

          if <keys_header>-materialdocumenT IS NOT INITIAL.
          UPDATE zpackhdr SET cancelflag = 'X'
            WHERE mat_doc = @materialDocument .
          UPDATE zpackhdr_D SET cancelflag = 'X'
            WHERE mat_doc = @materialDocument .
           ENDIF.


        ENDIF .



              response->set_text( |{ 'Cancel'  }   Material document { result1 }| ) .

              ENDIF.


  ENDMETHOD.


    METHOD IF_OO_ADT_CLASSRUN~MAIN.

*  call method   IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST( request = ' ' )  .

  ENDMETHOD.
ENDCLASS.
