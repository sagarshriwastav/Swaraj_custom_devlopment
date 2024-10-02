class ZCL_PP_GREY_GRN_101_CANCEL definition
  public
  create public .

public section.
  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_PP_GREY_GRN_101_CANCEL IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.
  DATA(req) = request->get_form_fields(  ).
  DATA(body)  = request->get_text(  )  .
  DATA respo  TYPE zpp_denim_finishing_can .

     xco_cp_json=>data->from_string( body )->write_to( REF #( respo ) ).

      DATA: lt_cancel_header TYPE TABLE FOR ACTION IMPORT i_materialdocumenttp\\MaterialDocument~Cancel.
      DATA : GSS_materialdocument type char10 ,
             GSS_MaterialDocumentYear TYPE numc4.
             GSS_materialdocument = respo-datacan+0(10) .
             GSS_MaterialDocumentYear = respo-datacan+13(4).

SELECT SINGLE postingdate FROM zpp_grey_grn_tab WHERE materialdocument101 = @GSS_materialdocument AND materialdocumentyear101 = @gss_materialdocumentyear INTO @DATA(POSTINGD).
IF SY-subrc = 0 .
lt_cancel_header = VALUE #( ( %key-MaterialDocument = GSS_materialdocument %key-MaterialDocumentYear = GSS_MaterialDocumentYear
                               %param-PostingDate = POSTINGD ) ).
ELSE.
lt_cancel_header = VALUE #( ( %key-MaterialDocument = GSS_materialdocument %key-MaterialDocumentYear = GSS_MaterialDocumentYear
                                ) ).
ENDIF.
MODIFY ENTITY i_materialdocumenttp\\MaterialDocument
 EXECUTE Cancel FROM lt_cancel_header
RESULT DATA(result)
MAPPED DATA(mapped)
FAILED DATA(failed)
REPORTED DATA(reported).


COMMIT ENTITIES BEGIN
  RESPONSE OF i_materialdocumenttp
         FAILED DATA(commit_failed3)
         REPORTED DATA(commit_reported3).

           LOOP AT  reported-materialdocument ASSIGNING FIELD-SYMBOL(<data>).

          DATA(msz) =  <data>-%msg  .

          DATA(mszty) = sy-msgty .
          DATA(msz_1)  = | { sy-msgv1 } { sy-msgv2 }  { sy-msgv3 } { sy-msgv4 } Message Type- { sy-msgty } Message No { sy-msgno }  |  .

        ENDLOOP .

        LOOP AT result ASSIGNING FIELD-SYMBOL(<keys_header>).
          IF mszty = 'E' .
            EXIT .
          ENDIF .

        ENDLOOP.

        COMMIT ENTITIES END.

          IF  mszty = 'E' .

          DATA(result1) = |ERROR { msz_1 } |.

        ELSE .
          DATA(grn)  = <keys_header>-materialdocument .
          SELECT SINGLE error261 FROM zpp_grey_grn_tab WHERE materialdocument101 = @GSS_materialdocument AND materialdocumentyear101 = @gss_materialdocumentyear
          INTO @result1.
        ENDIF .



        "      response->set_text( |{ 'Cancel'  }   Material document { result1 }| ) .
        response->set_text( | Material document { result1 }| ) .

  endmethod.
ENDCLASS.
