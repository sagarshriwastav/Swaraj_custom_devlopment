class ZCL_PP_SORTMASTER_HTTP definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_PP_SORTMASTER_HTTP IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

            data zpp_sortmaster type zpp_sortmaster .

      DATA(req) = request->get_form_fields(  ).
    response->set_header_field( i_name = 'Access-Control-Allow-Origin' i_value = '*' ).
    response->set_header_field( i_name = 'Access-Control-Allow-Credentials' i_value = 'true' ).

            DATA variable TYPE char8.
        DATA variable1 TYPE CHAR10.

*        variable = req[ 2 ]-NAME.
*        variable1 = req[ 2 ]-value.

    DATA(body)  = request->get_text(  )  .


    DATA respo  TYPE zpp_sortmaster_structure .

     xco_cp_json=>data->from_string( body )->write_to( REF #( respo ) ).

     LOOP AT   respo-tabledata ASSIGNING FIELD-SYMBOL(<FS2>)  .

*     SELECT SINGLE * FROM zpp_sortmaster WHERE material = @<FS2>-material AND PLANT = @<FS2>-plant
*     INTO @DATA(CHEACK).
*     IF  sy-subrc IS INITIAL.
*          DATA(TABRESULT) =  ' Material Already Saved' .
*          EXIT.
*        ELSE.
     zpp_sortmaster-material = <FS2>-material.
     zpp_sortmaster-plant = <FS2>-plant.
     zpp_sortmaster-Dyeingsort = <FS2>-Dyeingsort.
     zpp_sortmaster-PDNO = <FS2>-PDNO.
     zpp_sortmaster-pdcode      =   <FS2>-pdcode .
     zpp_sortmaster-mattype  =  <FS2>-mattype .
     zpp_sortmaster-reed   =  <FS2>-reed.
     zpp_sortmaster-dent   =  <FS2>-dent .
     zpp_sortmaster-epi         =  <FS2>-epi .
     zpp_sortmaster-warpcount1      =  <FS2>-warpcount1 .
     zpp_sortmaster-warptype1       =  <FS2>-warptype1 .
     zpp_sortmaster-Warptypedesc1   =  <FS2>-Warptypedesc1 .
     zpp_sortmaster-ratiowarpper1    =  <FS2>-ratiowarpper1 .
     zpp_sortmaster-warpcount2        =  <FS2>-warpcount2 .
     zpp_sortmaster-warptype2          =  <FS2>-warptype2 .
     zpp_sortmaster-Warptypedesc2    =  <FS2>-Warptypedesc2.
     zpp_sortmaster-ratiowarpper2    =  <FS2>-ratiowarpper2 .
     zpp_sortmaster-warpcount3       =  <FS2>-warpcount3 .
     zpp_sortmaster-warptype3        =  <FS2>-warptype3 .
     zpp_sortmaster-Warptypedesc3     =  <FS2>-Warptypedesc3 .
     zpp_sortmaster-ratiowarpper3    =  <FS2>-ratiowarpper3 .
     zpp_sortmaster-weftcount1      =  <FS2>-weftcount1.
     zpp_sortmaster-wefttype1      =  <FS2>-wefttype1 .
     zpp_sortmaster-wefttypedesc1    =  <FS2>-wefttypedesc1 .
     zpp_sortmaster-ratioweftper1    =  <FS2>-ratioweftper1 .
     zpp_sortmaster-weftcount2   =  <FS2>-weftcount2 .
     zpp_sortmaster-wefttype2    =  <FS2>-wefttype2 .
     zpp_sortmaster-wefttypedesc2   =  <FS2>-wefttypedesc2 .
     zpp_sortmaster-ratioweftper2    =  <FS2>-ratioweftper2 .
     zpp_sortmaster-weftcount3     =  <FS2>-weftcount3 .
     zpp_sortmaster-wefttype3      =  <FS2>-wefttype3.
     zpp_sortmaster-wefttypedesc3   =  <FS2>-wefttypedesc3 .
     zpp_sortmaster-ratioweftper3     =  <FS2>-ratioweftper3 .
     zpp_sortmaster-weftcount4      =  <FS2>-weftcount4 .
     zpp_sortmaster-wefttype4     =  <FS2>-wefttype4 .
     zpp_sortmaster-wefttypedesc4   =  <FS2>-wefttypedesc4 .
     zpp_sortmaster-ratioweftper4  =  <FS2>-ratioweftper4 .
     zpp_sortmaster-pick     =  <FS2>-pick.
     zpp_sortmaster-reedspace   =  <FS2>-reedspace.
     zpp_sortmaster-extraends   =  <FS2>-extraends.
     zpp_sortmaster-totalends    =  <FS2>-totalends.
     zpp_sortmaster-dyeingshade   = <FS2>-DyeingShade.
     zpp_sortmaster-shadepercen   = <FS2>-Shadepercen.
     zpp_sortmaster-Shadepercen2   = <FS2>-Shadepercen2.
     zpp_sortmaster-Shadepercen3   = <FS2>-Shadepercen3.
     zpp_sortmaster-weave         =  <FS2>-weave .
     zpp_sortmaster-design     =  <FS2>-design .
     zpp_sortmaster-processroute   = <FS2>-Processroute.
     zpp_sortmaster-remark     =  <FS2>-remark1.
     zpp_sortmaster-shrinkage      = <FS2>-Shrinkage.
     zpp_sortmaster-greiegewidthinch    =  <FS2>-greiegewidthinch .
     zpp_sortmaster-stdwidthinch    =  <FS2>-stdwidthinch .
     zpp_sortmaster-stdwidthcms      =  <FS2>-stdwidthcms .
     zpp_sortmaster-stdweight       =  <FS2>-stdweight.
     zpp_sortmaster-weight           =  <FS2>-stdweight.
     zpp_sortmaster-finwd            =  <FS2>-stdwidthcms .
     zpp_sortmaster-tareweight      = <FS2>-tareweight.
     zpp_sortmaster-remark2        =  <FS2>-remark2 .
     zpp_sortmaster-samplingweight     =  <FS2>-washweight .
     zpp_sortmaster-washweight             =  <FS2>-washweight .
     zpp_sortmaster-stretch               =  <FS2>-stretch.
     zpp_sortmaster-warpshrinkageperc       =  <FS2>-warpshrinperce .
     zpp_sortmaster-weftshrinkageperc     =  <FS2>-weftshrinperce .
     zpp_sortmaster-greypotentialwarpperc   =  <FS2>-greypotentialwarpper .
     zpp_sortmaster-sort               =  <FS2>-sort.
     zpp_sortmaster-finishtype          =  <FS2>-finishtype .
     zpp_sortmaster-blend             =  <FS2>-blend .
     zpp_sortmaster-loomtype         =  <FS2>-loomtype .
     zpp_sortmaster-compostion    =  <FS2>-compostion .
     zpp_sortmaster-fepi        =  <FS2>-fepi .
     zpp_sortmaster-fppi      =  <FS2>-fppi .
     zpp_sortmaster-gsm      =   <FS2>-gsm .
     zpp_sortmaster-stdweighttolerance      =   <FS2>-stdweighttolerance .
     zpp_sortmaster-stretchpertolerance      =   <FS2>-stretchpertolerance .
     zpp_sortmaster-wapshirnakgeperfrom      =   <FS2>-wapshirnakgeperfrom .
     zpp_sortmaster-stdwidthinchtolerance    =   <FS2>-stdwidthinchtolerance .




          modify  zpp_sortmaster from @zpp_sortmaster  .
*          ENDIF.

     ENDLOOP .
            IF sy-subrc IS INITIAL.
         DATA(TABRESULT) =  ' Data Saved!! ' .
        ELSE.
          TABRESULT = 'Error in saving data!!' .
        ENDIF.

      COMMIT WORK AND WAIT.

  DATA JSON TYPE STRING.
         CONCATENATE  TABRESULT 'TABLE zpp_sortmaster' INTO json SEPARATED BY ' '.

      response->set_text( json ).


  endmethod.
ENDCLASS.
