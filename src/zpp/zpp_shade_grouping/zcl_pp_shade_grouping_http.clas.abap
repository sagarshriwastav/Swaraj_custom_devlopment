class ZCL_PP_SHADE_GROUPING_HTTP definition
  public
  create public .
********************CREATED GAJENDRA SINGH SHEKHAWAT*************************************************************
public section.



  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_PP_SHADE_GROUPING_HTTP IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

  TYPES : BEGIN OF IT,
          plant TYPE C LENGTH 4,
          material TYPE C LENGTH 40,
          rollno  TYPE C LENGTH 10,
          follono TYPE C LENGTH 10,
          shgrp   TYPE C LENGTH 6,
          materialdesc  TYPE C LENGTH 60,
          END OF IT.
          data zpp_dnmshade type zpp_dnmshade .

      DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).

        DATA variable TYPE char8.
        DATA variable1 TYPE CHAR10.

        variable = req[ 2 ]-NAME.
        variable1 = req[ 2 ]-value.

    DATA(body)  = request->get_text(  )  .

    DATA respo  TYPE zpp_shade_structure .

     xco_cp_json=>data->from_string( body )->write_to( REF #( respo ) ).



     IF variable1 = 'add' .



     LOOP AT   respo-tabledataarray ASSIGNING FIELD-SYMBOL(<FS2>)  .
     zpp_dnmshade-plant = <FS2>-plant.
     zpp_dnmshade-material = <FS2>-material .
     zpp_dnmshade-rollno  = <FS2>-rollno.
     zpp_dnmshade-follono = <FS2>-follono.
     zpp_dnmshade-shgrp   = <FS2>-shgrp.
     zpp_dnmshade-materialdesc = <FS2>-materialdesc.
     zpp_dnmshade-unShade   = <FS2>-unShade.
     zpp_dnmshade-dmreason   = <FS2>-dmreason.
     zpp_dnmshade-devationtype   = <FS2>-devationtype.
     zpp_dnmshade-foliodate   = <FS2>-foliodate.
     zpp_dnmshade-blend  = <FS2>-blend.
     zpp_dnmshade-partysort  = <FS2>-partysort.
     zpp_dnmshade-piecno  = <FS2>-piecno.
     zpp_dnmshade-trollyno  = <FS2>-trollyno.
     zpp_dnmshade-setcode  = <FS2>-setcode.
     zpp_dnmshade-grade  = <FS2>-grade.
     zpp_dnmshade-mtr  = <FS2>-mtr.
     zpp_dnmshade-partsdetail  = <FS2>-partsdetail.
     zpp_dnmshade-stdwidth  = <FS2>-stdwidth.
     zpp_dnmshade-actwidth  = <FS2>-actwidth.
     zpp_dnmshade-stdweightoz  = <FS2>-stdweightoz.
     zpp_dnmshade-oz  = <FS2>-oz.
     zpp_dnmshade-deingshade  = <FS2>-deingshade.
     zpp_dnmshade-four_points  = <FS2>-four_points.
     zpp_dnmshade-totalpoints  = <FS2>-totalpoints.
     zpp_dnmshade-grossweigth  = <FS2>-grossweigth.
     zpp_dnmshade-netweigth  = <FS2>-netweigth.
     zpp_dnmshade-stdgplm  = <FS2>-stdgplm.
     zpp_dnmshade-location  = <FS2>-location.
     zpp_dnmshade-gplm  = <FS2>-gplm.
     zpp_dnmshade-mergedroll  = <FS2>-mergedroll.
     zpp_dnmshade-salesorder  = <FS2>-salesorder.
     zpp_dnmshade-salesordertem  = <FS2>-salesordertem.
     zpp_dnmshade-sodate  = <FS2>-sodate.
     zpp_dnmshade-partyname  = <FS2>-partyname.
     zpp_dnmshade-customername  = <FS2>-customername.
     zpp_dnmshade-rolltype  = <FS2>-rolltype.
     zpp_dnmshade-loomtype  = <FS2>-loomtype.
     zpp_dnmshade-weavetype  = <FS2>-weavetype.
     zpp_dnmshade-rollpackop  = <FS2>-rollpackop.
     zpp_dnmshade-finishoper  = <FS2>-finishoper.
     zpp_dnmshade-creationdate = SY-DATUM.
     zpp_dnmshade-creationtime = SY-uzeit.



     modify  zpp_dnmshade from @zpp_dnmshade  .
         COMMIT WORK AND WAIT.
     ENDLOOP .

 IF sy-subrc IS  INITIAL.



          DATA(TABRESULT) =  ' Data Saved Successfully !' .
        ELSE.
          TABRESULT = 'Error in saving data!!' .
        ENDIF.

      ELSEIF variable1 = 'change' .

           LOOP AT   respo-tabledataarray ASSIGNING FIELD-SYMBOL(<FS>)  .

              UPDATE zpp_dnmshade SET shgrp = @<FS>-shgrp , unShade = @<FS>-unShade
              , dmreason = @<FS>-dmreason  , devationtype = @<FS>-devationtype
            WHERE material = @<FS>-material AND rollno  = @<FS>-rollno
            AND follono = @<FS>-follono.
      COMMIT WORK AND WAIT.
     ENDLOOP .
      IF sy-subrc is  INITIAL.

          TABRESULT =  ' Data Saved Successfully !' .
        ELSE.
          TABRESULT = 'Error in saving data!!' .
        ENDIF.


*     IF SY-subrc IS INITIAL .
*     DATA(RESULT) = '124' .
*     ENDIF.
ENDIF .
  DATA JSON TYPE STRING.
         CONCATENATE  TABRESULT ' ' INTO json SEPARATED BY ' '.

      response->set_text( json ).

  endmethod.
ENDCLASS.
