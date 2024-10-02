CLASS LHC_RAP_TDAT_CTS DEFINITION FINAL.
  PUBLIC SECTION.
    CLASS-METHODS:
      GET
        RETURNING
          VALUE(RESULT) TYPE REF TO IF_MBC_CP_RAP_TABLE_CTS.

ENDCLASS.

CLASS LHC_RAP_TDAT_CTS IMPLEMENTATION.
  METHOD GET.
    result = mbc_cp_api=>rap_table_cts( table_entity_relations = VALUE #(
                                         ( entity = 'ZpackScreenOPRAT_T_' table = 'ZDENIM_OPRAT_TAB' )
                                       ) ) ##NO_TEXT.
  ENDMETHOD.
ENDCLASS.
CLASS LHC_ZI_ZPACKDSCREENOP_1 DEFINITION FINAL INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_INSTANCE_FEATURES FOR INSTANCE FEATURES
        IMPORTING
          KEYS REQUEST requested_features FOR ZpackdScreenTab121
        RESULT result,
      SELECTCUSTOMIZINGTRANSPTREQ FOR MODIFY
        IMPORTING
          KEYS FOR ACTION ZpackdScreenTab121~SelectCustomizingTransptReq
        RESULT result,
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR ZpackdScreenTab121
        RESULT result.
ENDCLASS.

CLASS LHC_ZI_ZPACKDSCREENOP_1 IMPLEMENTATION.
  METHOD GET_INSTANCE_FEATURES.
    DATA: selecttransport_flag TYPE abp_behv_flag VALUE if_abap_behv=>fc-o-enabled,
          edit_flag            TYPE abp_behv_flag VALUE if_abap_behv=>fc-o-enabled.

    IF cl_bcfg_cd_reuse_api_factory=>get_cust_obj_service_instance(
        iv_objectname = 'ZDENIM_OPRAT_TAB'
        iv_objecttype = cl_bcfg_cd_reuse_api_factory=>simple_table )->is_editable( ) = abap_false.
      edit_flag = if_abap_behv=>fc-o-disabled.
    ENDIF.
    DATA(transport_service) = cl_bcfg_cd_reuse_api_factory=>get_transport_service_instance(
                                iv_objectname = 'ZDENIM_OPRAT_TAB'
                                iv_objecttype = cl_bcfg_cd_reuse_api_factory=>simple_table ).
    IF transport_service->is_transport_allowed( ) = abap_false.
      selecttransport_flag = if_abap_behv=>fc-o-disabled.
    ENDIF.
    READ ENTITIES OF ZI_ZpackdScreenOP_1 IN LOCAL MODE
    ENTITY ZpackdScreenTab121
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(all).
    IF all[ 1 ]-%IS_DRAFT = if_abap_behv=>mk-off.
      selecttransport_flag = if_abap_behv=>fc-o-disabled.
    ENDIF.
    result = VALUE #( (
               %TKY = all[ 1 ]-%TKY
               %ACTION-edit = edit_flag
               %ASSOC-_ZpackScreenOPRAT_T_ = edit_flag
               %ACTION-SelectCustomizingTransptReq = selecttransport_flag ) ).
  ENDMETHOD.
  METHOD SELECTCUSTOMIZINGTRANSPTREQ.
    MODIFY ENTITIES OF ZI_ZpackdScreenOP_1 IN LOCAL MODE
      ENTITY ZpackdScreenTab121
        UPDATE FIELDS ( TransportRequestID HideTransport )
        WITH VALUE #( FOR key IN keys
                        ( %TKY               = key-%TKY
                          TransportRequestID = key-%PARAM-transportrequestid
                          HideTransport      = abap_false ) ).

    READ ENTITIES OF ZI_ZpackdScreenOP_1 IN LOCAL MODE
      ENTITY ZpackdScreenTab121
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(entities).
    result = VALUE #( FOR entity IN entities
                        ( %TKY   = entity-%TKY
                          %PARAM = entity ) ).
  ENDMETHOD.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
    AUTHORITY-CHECK OBJECT 'S_TABU_NAM' ID 'TABLE' FIELD 'ZI_ZPOPRAT_T_DABLE' ID 'ACTVT' FIELD '02'.
    DATA(is_authorized) = COND #( WHEN sy-subrc = 0 THEN if_abap_behv=>auth-allowed
                                  ELSE if_abap_behv=>auth-unauthorized ).
    result-%UPDATE      = is_authorized.
    result-%ACTION-Edit = is_authorized.
    result-%ACTION-SelectCustomizingTransptReq = is_authorized.
  ENDMETHOD.
ENDCLASS.
CLASS LSC_ZI_ZPACKDSCREENOP_1 DEFINITION FINAL INHERITING FROM CL_ABAP_BEHAVIOR_SAVER.
  PROTECTED SECTION.
    METHODS:
      SAVE_MODIFIED REDEFINITION,
      CLEANUP_FINALIZE REDEFINITION.
ENDCLASS.

CLASS LSC_ZI_ZPACKDSCREENOP_1 IMPLEMENTATION.
  METHOD SAVE_MODIFIED.
    READ TABLE update-ZpackdScreenTab121 INDEX 1 INTO DATA(all).
    IF all-TransportRequestID IS NOT INITIAL.
      lhc_rap_tdat_cts=>get( )->record_changes(
                                  transport_request = all-TransportRequestID
                                  create            = REF #( create )
                                  update            = REF #( update )
                                  delete            = REF #( delete ) ).
    ENDIF.
  ENDMETHOD.
  METHOD CLEANUP_FINALIZE ##NEEDED.
  ENDMETHOD.
ENDCLASS.
CLASS LHC_ZI_ZPOPRAT_T_DABLE DEFINITION FINAL INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      VALIDATETRANSPORTREQUEST FOR VALIDATE ON SAVE
        IMPORTING
          KEYS FOR ZpackScreenOPRAT_T_~ValidateTransportRequest,
      GET_GLOBAL_FEATURES FOR GLOBAL FEATURES
        IMPORTING
          REQUEST REQUESTED_FEATURES FOR ZpackScreenOPRAT_T_
        RESULT result,
      COPYZPACKSCREENOPRAT_T_ FOR MODIFY
        IMPORTING
          KEYS FOR ACTION ZpackScreenOPRAT_T_~CopyZpackScreenOPRAT_T_,
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR ZpackScreenOPRAT_T_
        RESULT result,
      GET_INSTANCE_FEATURES FOR INSTANCE FEATURES
        IMPORTING
          KEYS REQUEST requested_features FOR ZpackScreenOPRAT_T_
        RESULT result.
ENDCLASS.

CLASS LHC_ZI_ZPOPRAT_T_DABLE IMPLEMENTATION.
  METHOD VALIDATETRANSPORTREQUEST.
    DATA change TYPE REQUEST FOR CHANGE ZI_ZpackdScreenOP_1.
    SELECT SINGLE TransportRequestID
      FROM ZDENIM_OPRA_D_S1
      WHERE SingletonID = 1
      INTO @DATA(TransportRequestID).
    lhc_rap_tdat_cts=>get( )->validate_changes(
                                transport_request = TransportRequestID
                                table             = 'ZDENIM_OPRAT_TAB'
                                keys              = REF #( keys )
                                reported          = REF #( reported )
                                failed            = REF #( failed )
                                change            = REF #( change-ZpackScreenOPRAT_T_ ) ).
  ENDMETHOD.
  METHOD GET_GLOBAL_FEATURES.
    DATA edit_flag TYPE abp_behv_flag VALUE if_abap_behv=>fc-o-enabled.
    IF cl_bcfg_cd_reuse_api_factory=>get_cust_obj_service_instance(
         iv_objectname = 'ZDENIM_OPRAT_TAB'
         iv_objecttype = cl_bcfg_cd_reuse_api_factory=>simple_table )->is_editable( ) = abap_false.
      edit_flag = if_abap_behv=>fc-o-disabled.
    ENDIF.
    result-%UPDATE = edit_flag.
    result-%DELETE = edit_flag.
  ENDMETHOD.
  METHOD COPYZPACKSCREENOPRAT_T_.
    DATA new_ZpackScreenOPRAT_T_ TYPE TABLE FOR CREATE ZI_ZpackdScreenOP_1\_ZpackScreenOPRAT_T_.

    READ ENTITIES OF ZI_ZpackdScreenOP_1 IN LOCAL MODE
      ENTITY ZpackScreenOPRAT_T_
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(ref_ZpackScreenOPRAT_T_)
      FAILED DATA(read_failed).

    LOOP AT ref_ZpackScreenOPRAT_T_ ASSIGNING FIELD-SYMBOL(<ref_ZpackScreenOPRAT_T_>).
      DATA(key) = keys[ KEY draft %TKY = <ref_ZpackScreenOPRAT_T_>-%TKY ].
      DATA(key_cid) = key-%CID.
      APPEND VALUE #(
        %TKY-SingletonID = 1
        %IS_DRAFT = <ref_ZpackScreenOPRAT_T_>-%IS_DRAFT
        %TARGET = VALUE #( (
          %CID = key_cid
          %IS_DRAFT = <ref_ZpackScreenOPRAT_T_>-%IS_DRAFT
          %DATA = CORRESPONDING #( <ref_ZpackScreenOPRAT_T_> EXCEPT
            Bukrs
            LastChangedAt
            LocalCreatedAt
            LocalCreatedBy
            LocalLastChangedAt
            LocalLastChangedBy
            Plant
            SingletonID
        ) ) )
      ) TO new_ZpackScreenOPRAT_T_ ASSIGNING FIELD-SYMBOL(<new_ZpackScreenOPRAT_T_>).
      <new_ZpackScreenOPRAT_T_>-%TARGET[ 1 ]-Bukrs = key-%PARAM-Bukrs.
      <new_ZpackScreenOPRAT_T_>-%TARGET[ 1 ]-Plant = key-%PARAM-Plant.
    ENDLOOP.

    MODIFY ENTITIES OF ZI_ZpackdScreenOP_1 IN LOCAL MODE
      ENTITY ZpackdScreenTab121 CREATE BY \_ZpackScreenOPRAT_T_
      FIELDS (
               Bukrs
               Plant
               Empcode
               Empname
               Deptname
               Cancel
             ) WITH new_ZpackScreenOPRAT_T_
      MAPPED DATA(mapped_create)
      FAILED failed
      REPORTED reported.

    mapped-ZpackScreenOPRAT_T_ = mapped_create-ZpackScreenOPRAT_T_.
    INSERT LINES OF read_failed-ZpackScreenOPRAT_T_ INTO TABLE failed-ZpackScreenOPRAT_T_.

    reported-ZpackScreenOPRAT_T_ = VALUE #( FOR created IN mapped-ZpackScreenOPRAT_T_ (
                                               %CID = created-%CID
                                               %ACTION-CopyZpackScreenOPRAT_T_ = if_abap_behv=>mk-on
                                               %MSG = mbc_cp_api=>message( )->get_item_copied( )
                                               %PATH-ZpackdScreenTab121-%IS_DRAFT = created-%IS_DRAFT
                                               %PATH-ZpackdScreenTab121-SingletonID = 1 ) ).
  ENDMETHOD.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
    AUTHORITY-CHECK OBJECT 'S_TABU_NAM' ID 'TABLE' FIELD 'ZI_ZPOPRAT_T_DABLE' ID 'ACTVT' FIELD '02'.
    DATA(is_authorized) = COND #( WHEN sy-subrc = 0 THEN if_abap_behv=>auth-allowed
                                  ELSE if_abap_behv=>auth-unauthorized ).
    result-%ACTION-CopyZpackScreenOPRAT_T_ = is_authorized.
  ENDMETHOD.
  METHOD GET_INSTANCE_FEATURES.
    result = VALUE #( FOR row IN keys ( %TKY = row-%TKY
                                        %ACTION-CopyZpackScreenOPRAT_T_ = COND #( WHEN row-%IS_DRAFT = if_abap_behv=>mk-off THEN if_abap_behv=>fc-o-disabled ELSE if_abap_behv=>fc-o-enabled )
   ) ).
  ENDMETHOD.
ENDCLASS.
