class ZCL_PP_APPROVAL_SERVICE definition
  public
  create public .
********************CREATED GAJENDRA SINGH SHEKHAWAT*************************************************************
public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_PP_APPROVAL_SERVICE IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

   DATA(req) = request->get_form_fields(  ).
       response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).

      DATA(body)  = request->get_text(  )  .

     DATA respo TYPE zpp_approval_str .

     xco_cp_json=>data->from_string( body )->write_to( REF #( respo ) ).

     DATA wa TYPE  zpp_approval_tab .

*     LOOP AT respo ASSIGNING FIELD-SYMBOL(<gs>) .


     if respo-warpingentry is NOT INITIAL .
     wa-postingdate = sy-datum.
     wa-programno   = '01'.
     wa-setnumber = respo-warpingentry.
     MODIFY zpp_approval_tab FROM @wa  .
     CLEAR : wa .
     ENDIF.

     IF respo-dyeigentry is NOT INITIAL.
     wa-postingdate = sy-datum.
     wa-programno   = '02'.
     wa-setnumber = respo-dyeigentry.
     MODIFY zpp_approval_tab FROM @wa  .
     CLEAR : wa .
     ENDIF.

     IF respo-greigereceipt is NOT INITIAL.
     wa-postingdate = sy-datum.
     wa-programno   = '03'.
     wa-setnumber = respo-greigereceipt.
     MODIFY zpp_approval_tab FROM @wa  .
     CLEAR : wa .
     ENDIF.

     IF respo-finishingentry is NOT INITIAL.
     wa-postingdate = sy-datum.
     wa-programno   = '04'.
     wa-setnumber = respo-finishingentry.
     MODIFY zpp_approval_tab FROM @wa  .
     CLEAR : wa .
     ENDIF.

     IF respo-inspectionentry is NOT INITIAL.
     wa-postingdate = sy-datum.
     wa-programno   = '05'.
     wa-setnumber = respo-inspectionentry.
     MODIFY zpp_approval_tab FROM @wa  .
     CLEAR : wa .
     ENDIF.

      if respo-SetNumberChange is NOT INITIAL .
     wa-postingdate = sy-datum.
     wa-programno   = '06'.
     wa-setnumber = respo-SetNumberChange.
     MODIFY zpp_approval_tab FROM @wa  .
     CLEAR : wa .
     ENDIF.


     if respo-DyeingEntryAfterTeco is NOT INITIAL .
     wa-postingdate = sy-datum.
     wa-programno   = '07'.
     wa-setnumber = respo-DyeingEntryAfterTeco.
     MODIFY zpp_approval_tab FROM @wa  .
     CLEAR : wa .
     ENDIF.

     if respo-FinishingEntryAfterTeco is NOT INITIAL .
     wa-postingdate = sy-datum.
     wa-programno   = '08'.
     wa-setnumber = respo-FinishingEntryAfterTeco.
     MODIFY zpp_approval_tab FROM @wa  .
     CLEAR : wa .
     ENDIF.

      DATA TABRESULT TYPE STRING.
      IF sy-subrc IS INITIAL.
          TABRESULT =  ' Data Saved!! ' .
      ELSE.
          TABRESULT = 'Error in saving data!!' .
      ENDIF.

      COMMIT WORK AND WAIT.

   response->set_text( TABRESULT  ).

  endmethod.
ENDCLASS.
