class ZCL_PP_SELVEDGE_HTTP definition
  public
  create public .
********************CREATED GAJENDRA SINGH SHEKHAWAT*************************************************************
public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_PP_SELVEDGE_HTTP IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

    DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).


    DATA(body)  = request->get_text(  )  .


    DATA respo  TYPE zpp_selvedge .
   DATA TypeMethod TYPE C LENGTH 20 .
   DATA WA_zpp_selvedge_tab TYPE zpp_selvedge_tab.


     xco_cp_json=>data->from_string( body )->write_to( REF #( respo ) ).

      TypeMethod = req[ 2 ]-value.

      IF  TypeMethod = 'create' .

       LOOP AT respo-tabledata ASSIGNING FIELD-SYMBOL(<FS>) .

       WA_zpp_selvedge_tab-srno     =    <FS>-srno .
       WA_zpp_selvedge_tab-selvedge =    <FS>-selvedge .
       WA_zpp_selvedge_tab-plant   =    <FS>-plant .
       WA_zpp_selvedge_tab-orderno  =    |{ <FS>-orderno ALPHA = IN }|.
       WA_zpp_selvedge_tab-material  =    <FS>-material .
       WA_zpp_selvedge_tab-materialdesc  =    <FS>-materialdesc .
       WA_zpp_selvedge_tab-beamno    =    <FS>-beamno .
       WA_zpp_selvedge_tab-remark    = <FS>-remark .

   MODIFY zpp_selvedge_tab FROM @WA_zpp_selvedge_tab .

       COMMIT WORK AND WAIT.
     ENDLOOP .

     IF sy-subrc IS INITIAL.
          DATA(TABRESULT) =  ' Data Saved Successfully !' .
        ELSE.
          TABRESULT = 'Error in saving data!!' .
        ENDIF.
     DATA JSON TYPE STRING.
      JSON =  TABRESULT .


      ELSEIF TypeMethod = 'Delete' .

  LOOP AT respo-tabledata ASSIGNING FIELD-SYMBOL(<FS1>) .
  DATA ORDER TYPE C LENGTH 12 .
  ORDER = |{ <FS1>-orderno ALPHA = IN  }| .

   DELETE FROM zpp_selvedge_tab WHERE  beamno = @<FS1>-beamno AND orderno = @order
                                    AND plant  = @<FS1>-plant
                                    AND selvedge = @<FS1>-selvedge .

     COMMIT WORK AND WAIT.
CLEAR : ORDER .
ENDLOOP.

 IF sy-subrc IS INITIAL.
          TABRESULT =  ' Data Delete Successfully !' .
        ELSE.
          TABRESULT = 'Error in saving data!!' .
        ENDIF.


      JSON =  TABRESULT .

      ENDIF.

    response->set_text( JSON  ).

  endmethod.
ENDCLASS.
