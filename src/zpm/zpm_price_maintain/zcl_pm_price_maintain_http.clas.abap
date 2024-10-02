class ZCL_PM_PRICE_MAINTAIN_HTTP definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_PM_PRICE_MAINTAIN_HTTP IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

     DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).


    DATA(body)  = request->get_text(  )  .

    DATA respo  TYPE zpm_price_maintain_str .
    DATA WA_TAB  TYPE  zpm_price_mainta.
    DATA TABRESULT TYPE STRING .
    DATA ZDATE1 TYPE C LENGTH 6 .

    xco_cp_json=>data->from_string( body )->write_to( REF #( respo ) ).

    LOOP AT   respo-atablearr1 INTO DATA(WA) .
     REPLACE ALL OCCURRENCES OF '-' IN  WA-date WITH '' .
     CONDENSE WA-date .
    CONCATENATE WA-date+2(4) WA-date+0(2) INTO ZDATE1.
    WA_TAB-zdate            =   ZDATE1 .
    WA_TAB-steamprice       =   WA-steamprice .
    WA_TAB-freshwaterprice  =   WA-freshwaterprice.
    WA_TAB-electricityprice =   WA-electricityprice .
    WA_TAB-transactioncurrency = 'INR' .

   MODIFY zpm_price_mainta FROM @WA_TAB.

    ENDLOOP.

     IF sy-subrc IS INITIAL.
          TABRESULT =  ' Data Saved!! ' .
        ELSE.
          TABRESULT = 'Error in saving data!!' .
        ENDIF.

      COMMIT WORK AND WAIT.

       response->set_text( TABRESULT  ).




  endmethod.
ENDCLASS.
