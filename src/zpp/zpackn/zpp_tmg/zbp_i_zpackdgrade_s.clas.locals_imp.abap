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
                                         ( entity = 'ZpackdGRADTable' table = 'ZWEAV_GRAD_TAB' )
                                       ) ) ##NO_TEXT.
  ENDMETHOD.
ENDCLASS.
CLASS LHC_ZI_ZPACKDSCREENGRAD_S DEFINITION FINAL INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_INSTANCE_FEATURES FOR INSTANCE FEATURES
        IMPORTING
          KEYS REQUEST requested_features FOR ZpackdScreeGRAD
        RESULT result,
      SELECTCUSTOMIZINGTRANSPTREQ FOR MODIFY
        IMPORTING
          KEYS FOR ACTION ZpackdScreeGRAD~SelectCustomizingTransptReq
        RESULT result,
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR ZpackdScreeGRAD
        RESULT result.
ENDCLASS.

CLASS LHC_ZI_ZPACKDSCREENGRAD_S IMPLEMENTATION.
  METHOD GET_INSTANCE_FEATURES.
    DATA: selecttransport_flag TYPE abp_behv_flag VALUE if_abap_behv=>fc-o-enabled,
          edit_flag            TYPE abp_behv_flag VALUE if_abap_behv=>fc-o-enabled.

    IF cl_bcfg_cd_reuse_api_factory=>get_cust_obj_service_instance(
        iv_objectname = 'ZWEAV_GRAD_TAB'
        iv_objecttype = cl_bcfg_cd_reuse_api_factory=>simple_table )->is_editable( ) = abap_false.
      edit_flag = if_abap_behv=>fc-o-disabled.
    ENDIF.
    DATA(transport_service) = cl_bcfg_cd_reuse_api_factory=>get_transport_service_instance(
                                iv_objectname = 'ZWEAV_GRAD_TAB'
                                iv_objecttype = cl_bcfg_cd_reuse_api_factory=>simple_table ).
    IF transport_service->is_transport_allowed( ) = abap_false.
      selecttransport_flag = if_abap_behv=>fc-o-disabled.
    ENDIF.
    READ ENTITIES OF ZI_ZpackdScreenGRAD_S IN LOCAL MODE
    ENTITY ZpackdScreeGRAD
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(all).
    IF all[ 1 ]-%IS_DRAFT = if_abap_behv=>mk-off.
      selecttransport_flag = if_abap_behv=>fc-o-disabled.
    ENDIF.
    result = VALUE #( (
               %TKY = all[ 1 ]-%TKY
               %ACTION-edit = edit_flag
               %ASSOC-_ZpackdGRADTable = edit_flag
               %ACTION-SelectCustomizingTransptReq = selecttransport_flag ) ).
  ENDMETHOD.
  METHOD SELECTCUSTOMIZINGTRANSPTREQ.
    MODIFY ENTITIES OF ZI_ZpackdScreenGRAD_S IN LOCAL MODE
      ENTITY ZpackdScreeGRAD
        UPDATE FIELDS ( TransportRequestID HideTransport )
        WITH VALUE #( FOR key IN keys
                        ( %TKY               = key-%TKY
                          TransportRequestID = key-%PARAM-transportrequestid
                          HideTransport      = abap_false ) ).

    READ ENTITIES OF ZI_ZpackdScreenGRAD_S IN LOCAL MODE
      ENTITY ZpackdScreeGRAD
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(entities).
    result = VALUE #( FOR entity IN entities
                        ( %TKY   = entity-%TKY
                          %PARAM = entity ) ).
  ENDMETHOD.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
    AUTHORITY-CHECK OBJECT 'S_TABU_NAM' ID 'TABLE' FIELD 'ZI_ZGRADSCREENTABLE' ID 'ACTVT' FIELD '02'.
    DATA(is_authorized) = COND #( WHEN sy-subrc = 0 THEN if_abap_behv=>auth-allowed
                                  ELSE if_abap_behv=>auth-unauthorized ).
    result-%UPDATE      = is_authorized.
    result-%ACTION-Edit = is_authorized.
    result-%ACTION-SelectCustomizingTransptReq = is_authorized.
  ENDMETHOD.
ENDCLASS.
CLASS LSC_ZI_ZPACKDSCREENGRAD_S DEFINITION FINAL INHERITING FROM CL_ABAP_BEHAVIOR_SAVER.
  PROTECTED SECTION.
    METHODS:
      SAVE_MODIFIED REDEFINITION,
      CLEANUP_FINALIZE REDEFINITION.
ENDCLASS.

CLASS LSC_ZI_ZPACKDSCREENGRAD_S IMPLEMENTATION.
  METHOD SAVE_MODIFIED.
    READ TABLE update-ZpackdScreeGRAD INDEX 1 INTO DATA(all).
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
CLASS LHC_ZI_ZGRADSCREENTABLE DEFINITION FINAL INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      VALIDATETRANSPORTREQUEST FOR VALIDATE ON SAVE
        IMPORTING
          KEYS FOR ZpackdGRADTable~ValidateTransportRequest,
      GET_GLOBAL_FEATURES FOR GLOBAL FEATURES
        IMPORTING
          REQUEST REQUESTED_FEATURES FOR ZpackdGRADTable
        RESULT result,
      COPYZPACKDGRADTABLE FOR MODIFY
        IMPORTING
          KEYS FOR ACTION ZpackdGRADTable~CopyZpackdGRADTable,
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR ZpackdGRADTable
        RESULT result,
      GET_INSTANCE_FEATURES FOR INSTANCE FEATURES
        IMPORTING
          KEYS REQUEST requested_features FOR ZpackdGRADTable
        RESULT result.
ENDCLASS.

CLASS LHC_ZI_ZGRADSCREENTABLE IMPLEMENTATION.
  METHOD VALIDATETRANSPORTREQUEST.
    DATA change TYPE REQUEST FOR CHANGE ZI_ZpackdScreenGRAD_S.
    SELECT SINGLE TransportRequestID
      FROM ZWEAV_GRAD_T_D_S
      WHERE SingletonID = 1
      INTO @DATA(TransportRequestID).
    lhc_rap_tdat_cts=>get( )->validate_changes(
                                transport_request = TransportRequestID
                                table             = 'ZWEAV_GRAD_TAB'
                                keys              = REF #( keys )
                                reported          = REF #( reported )
                                failed            = REF #( failed )
                                change            = REF #( change-ZpackdGRADTable ) ).
  ENDMETHOD.
  METHOD GET_GLOBAL_FEATURES.
    DATA edit_flag TYPE abp_behv_flag VALUE if_abap_behv=>fc-o-enabled.
    IF cl_bcfg_cd_reuse_api_factory=>get_cust_obj_service_instance(
         iv_objectname = 'ZWEAV_GRAD_TAB'
         iv_objecttype = cl_bcfg_cd_reuse_api_factory=>simple_table )->is_editable( ) = abap_false.
      edit_flag = if_abap_behv=>fc-o-disabled.
    ENDIF.
    result-%UPDATE = edit_flag.
    result-%DELETE = edit_flag.
  ENDMETHOD.
  METHOD COPYZPACKDGRADTABLE.
    DATA new_ZpackdGRADTable TYPE TABLE FOR CREATE ZI_ZpackdScreenGRAD_S\_ZpackdGRADTable.

    READ ENTITIES OF ZI_ZpackdScreenGRAD_S IN LOCAL MODE
      ENTITY ZpackdGRADTable
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(ref_ZpackdGRADTable)
      FAILED DATA(read_failed).

    LOOP AT ref_ZpackdGRADTable ASSIGNING FIELD-SYMBOL(<ref_ZpackdGRADTable>).
      DATA(key) = keys[ KEY draft %TKY = <ref_ZpackdGRADTable>-%TKY ].
      DATA(key_cid) = key-%CID.
      APPEND VALUE #(
        %TKY-SingletonID = 1
        %IS_DRAFT = <ref_ZpackdGRADTable>-%IS_DRAFT
        %TARGET = VALUE #( (
          %CID = key_cid
          %IS_DRAFT = <ref_ZpackdGRADTable>-%IS_DRAFT
          %DATA = CORRESPONDING #( <ref_ZpackdGRADTable> EXCEPT
            Grade
            LastChangedAt
            LocalCreatedAt
            LocalCreatedBy
            LocalLastChangedAt
            LocalLastChangedBy
            Prctr
            SingletonID
            Werks
        ) ) )
      ) TO new_ZpackdGRADTable ASSIGNING FIELD-SYMBOL(<new_ZpackdGRADTable>).
      <new_ZpackdGRADTable>-%TARGET[ 1 ]-Werks = key-%PARAM-Werks.
      <new_ZpackdGRADTable>-%TARGET[ 1 ]-Prctr = key-%PARAM-Prctr.
      <new_ZpackdGRADTable>-%TARGET[ 1 ]-Grade = key-%PARAM-Grade.
    ENDLOOP.

    MODIFY ENTITIES OF ZI_ZpackdScreenGRAD_S IN LOCAL MODE
      ENTITY ZpackdScreeGRAD CREATE BY \_ZpackdGRADTable
      FIELDS (
               Werks
               Prctr
               Grade
               Zdesc
               Zsnro
             ) WITH new_ZpackdGRADTable
      MAPPED DATA(mapped_create)
      FAILED failed
      REPORTED reported.

    mapped-ZpackdGRADTable = mapped_create-ZpackdGRADTable.
    INSERT LINES OF read_failed-ZpackdGRADTable INTO TABLE failed-ZpackdGRADTable.

    reported-ZpackdGRADTable = VALUE #( FOR created IN mapped-ZpackdGRADTable (
                                               %CID = created-%CID
                                               %ACTION-CopyZpackdGRADTable = if_abap_behv=>mk-on
                                               %MSG = mbc_cp_api=>message( )->get_item_copied( )
                                               %PATH-ZpackdScreeGRAD-%IS_DRAFT = created-%IS_DRAFT
                                               %PATH-ZpackdScreeGRAD-SingletonID = 1 ) ).
  ENDMETHOD.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
    AUTHORITY-CHECK OBJECT 'S_TABU_NAM' ID 'TABLE' FIELD 'ZI_ZGRADSCREENTABLE' ID 'ACTVT' FIELD '02'.
    DATA(is_authorized) = COND #( WHEN sy-subrc = 0 THEN if_abap_behv=>auth-allowed
                                  ELSE if_abap_behv=>auth-unauthorized ).
    result-%ACTION-CopyZpackdGRADTable = is_authorized.
  ENDMETHOD.
  METHOD GET_INSTANCE_FEATURES.
    result = VALUE #( FOR row IN keys ( %TKY = row-%TKY
                                        %ACTION-CopyZpackdGRADTable = COND #( WHEN row-%IS_DRAFT = if_abap_behv=>mk-off THEN if_abap_behv=>fc-o-disabled ELSE if_abap_behv=>fc-o-enabled )
   ) ).
  ENDMETHOD.
ENDCLASS.
