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
                                         ( entity = 'ZpackdScreenTable' table = 'ZPACKFAULT' )
                                       ) ) ##NO_TEXT.
  ENDMETHOD.
ENDCLASS.
CLASS LHC_ZI_ZPACKDSCREENTABLE_S DEFINITION FINAL INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_INSTANCE_FEATURES FOR INSTANCE FEATURES
        IMPORTING
          KEYS REQUEST requested_features FOR ZpackdScreenTablAll
        RESULT result,
      SELECTCUSTOMIZINGTRANSPTREQ FOR MODIFY
        IMPORTING
          KEYS FOR ACTION ZpackdScreenTablAll~SelectCustomizingTransptReq
        RESULT result,
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR ZpackdScreenTablAll
        RESULT result.
ENDCLASS.

CLASS LHC_ZI_ZPACKDSCREENTABLE_S IMPLEMENTATION.
  METHOD GET_INSTANCE_FEATURES.
    DATA: selecttransport_flag TYPE abp_behv_flag VALUE if_abap_behv=>fc-o-enabled,
          edit_flag            TYPE abp_behv_flag VALUE if_abap_behv=>fc-o-enabled.

    IF cl_bcfg_cd_reuse_api_factory=>get_cust_obj_service_instance(
        iv_objectname = 'ZPACKFAULT'
        iv_objecttype = cl_bcfg_cd_reuse_api_factory=>simple_table )->is_editable( ) = abap_false.
      edit_flag = if_abap_behv=>fc-o-disabled.
    ENDIF.
    DATA(transport_service) = cl_bcfg_cd_reuse_api_factory=>get_transport_service_instance(
                                iv_objectname = 'ZPACKFAULT'
                                iv_objecttype = cl_bcfg_cd_reuse_api_factory=>simple_table ).
    IF transport_service->is_transport_allowed( ) = abap_false.
      selecttransport_flag = if_abap_behv=>fc-o-disabled.
    ENDIF.
    READ ENTITIES OF ZI_ZpackdScreenTable_S IN LOCAL MODE
    ENTITY ZpackdScreenTablAll
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(all).
    IF all[ 1 ]-%IS_DRAFT = if_abap_behv=>mk-off.
      selecttransport_flag = if_abap_behv=>fc-o-disabled.
    ENDIF.
    result = VALUE #( (
               %TKY = all[ 1 ]-%TKY
               %ACTION-edit = edit_flag
               %ASSOC-_ZpackdScreenTable = edit_flag
               %ACTION-SelectCustomizingTransptReq = selecttransport_flag ) ).
  ENDMETHOD.
  METHOD SELECTCUSTOMIZINGTRANSPTREQ.
    MODIFY ENTITIES OF ZI_ZpackdScreenTable_S IN LOCAL MODE
      ENTITY ZpackdScreenTablAll
        UPDATE FIELDS ( TransportRequestID HideTransport )
        WITH VALUE #( FOR key IN keys
                        ( %TKY               = key-%TKY
                          TransportRequestID = key-%PARAM-transportrequestid
                          HideTransport      = abap_false ) ).

    READ ENTITIES OF ZI_ZpackdScreenTable_S IN LOCAL MODE
      ENTITY ZpackdScreenTablAll
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(entities).
    result = VALUE #( FOR entity IN entities
                        ( %TKY   = entity-%TKY
                          %PARAM = entity ) ).
  ENDMETHOD.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
    AUTHORITY-CHECK OBJECT 'S_TABU_NAM' ID 'TABLE' FIELD 'ZI_ZPACKDSCREENTABLE' ID 'ACTVT' FIELD '02'.
    DATA(is_authorized) = COND #( WHEN sy-subrc = 0 THEN if_abap_behv=>auth-allowed
                                  ELSE if_abap_behv=>auth-unauthorized ).
    result-%UPDATE      = is_authorized.
    result-%ACTION-Edit = is_authorized.
    result-%ACTION-SelectCustomizingTransptReq = is_authorized.
  ENDMETHOD.
ENDCLASS.
CLASS LSC_ZI_ZPACKDSCREENTABLE_S DEFINITION FINAL INHERITING FROM CL_ABAP_BEHAVIOR_SAVER.
  PROTECTED SECTION.
    METHODS:
      SAVE_MODIFIED REDEFINITION,
      CLEANUP_FINALIZE REDEFINITION.
ENDCLASS.

CLASS LSC_ZI_ZPACKDSCREENTABLE_S IMPLEMENTATION.
  METHOD SAVE_MODIFIED.
    READ TABLE update-ZpackdScreenTablAll INDEX 1 INTO DATA(all).
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
CLASS LHC_ZI_ZPACKDSCREENTABLE DEFINITION FINAL INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      VALIDATETRANSPORTREQUEST FOR VALIDATE ON SAVE
        IMPORTING
          KEYS FOR ZpackdScreenTable~ValidateTransportRequest,
      GET_GLOBAL_FEATURES FOR GLOBAL FEATURES
        IMPORTING
          REQUEST REQUESTED_FEATURES FOR ZpackdScreenTable
        RESULT result,
      COPYZPACKDSCREENTABLE FOR MODIFY
        IMPORTING
          KEYS FOR ACTION ZpackdScreenTable~CopyZpackdScreenTable,
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR ZpackdScreenTable
        RESULT result,
      GET_INSTANCE_FEATURES FOR INSTANCE FEATURES
        IMPORTING
          KEYS REQUEST requested_features FOR ZpackdScreenTable
        RESULT result.
ENDCLASS.

CLASS LHC_ZI_ZPACKDSCREENTABLE IMPLEMENTATION.
  METHOD VALIDATETRANSPORTREQUEST.
    DATA change TYPE REQUEST FOR CHANGE ZI_ZpackdScreenTable_S.
    SELECT SINGLE TransportRequestID
      FROM ZPACKFAULT_D_S
      WHERE SingletonID = 1
      INTO @DATA(TransportRequestID).
    lhc_rap_tdat_cts=>get( )->validate_changes(
                                transport_request = TransportRequestID
                                table             = 'ZPACKFAULT'
                                keys              = REF #( keys )
                                reported          = REF #( reported )
                                failed            = REF #( failed )
                                change            = REF #( change-ZpackdScreenTable ) ).
  ENDMETHOD.
  METHOD GET_GLOBAL_FEATURES.
    DATA edit_flag TYPE abp_behv_flag VALUE if_abap_behv=>fc-o-enabled.
    IF cl_bcfg_cd_reuse_api_factory=>get_cust_obj_service_instance(
         iv_objectname = 'ZPACKFAULT'
         iv_objecttype = cl_bcfg_cd_reuse_api_factory=>simple_table )->is_editable( ) = abap_false.
      edit_flag = if_abap_behv=>fc-o-disabled.
    ENDIF.
    result-%UPDATE = edit_flag.
    result-%DELETE = edit_flag.
  ENDMETHOD.
  METHOD COPYZPACKDSCREENTABLE.
    DATA new_ZpackdScreenTable TYPE TABLE FOR CREATE ZI_ZpackdScreenTable_S\_ZpackdScreenTable.

    READ ENTITIES OF ZI_ZpackdScreenTable_S IN LOCAL MODE
      ENTITY ZpackdScreenTable
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(ref_ZpackdScreenTable)
      FAILED DATA(read_failed).

    LOOP AT ref_ZpackdScreenTable ASSIGNING FIELD-SYMBOL(<ref_ZpackdScreenTable>).
      DATA(key) = keys[ KEY draft %TKY = <ref_ZpackdScreenTable>-%TKY ].
      DATA(key_cid) = key-%CID.
      APPEND VALUE #(
        %TKY-SingletonID = 1
        %IS_DRAFT = <ref_ZpackdScreenTable>-%IS_DRAFT
        %TARGET = VALUE #( (
          %CID = key_cid
          %IS_DRAFT = <ref_ZpackdScreenTable>-%IS_DRAFT
          %DATA = CORRESPONDING #( <ref_ZpackdScreenTable> EXCEPT
            Code
            LastChangedAt
            LocalCreatedAt
            LocalCreatedBy
            LocalLastChangedAt
            LocalLastChangedBy
            SingletonID
        ) ) )
      ) TO new_ZpackdScreenTable ASSIGNING FIELD-SYMBOL(<new_ZpackdScreenTable>).
      <new_ZpackdScreenTable>-%TARGET[ 1 ]-Code = key-%PARAM-Code.
    ENDLOOP.

    MODIFY ENTITIES OF ZI_ZpackdScreenTable_S IN LOCAL MODE
      ENTITY ZpackdScreenTablAll CREATE BY \_ZpackdScreenTable
      FIELDS (
               Code
               Description
               Farea
               Ftype
               Fname
               Deptno
               Zdept
             ) WITH new_ZpackdScreenTable
      MAPPED DATA(mapped_create)
      FAILED failed
      REPORTED reported.

    mapped-ZpackdScreenTable = mapped_create-ZpackdScreenTable.
    INSERT LINES OF read_failed-ZpackdScreenTable INTO TABLE failed-ZpackdScreenTable.

    reported-ZpackdScreenTable = VALUE #( FOR created IN mapped-ZpackdScreenTable (
                                               %CID = created-%CID
                                               %ACTION-CopyZpackdScreenTable = if_abap_behv=>mk-on
                                               %MSG = mbc_cp_api=>message( )->get_item_copied( )
                                               %PATH-ZpackdScreenTablAll-%IS_DRAFT = created-%IS_DRAFT
                                               %PATH-ZpackdScreenTablAll-SingletonID = 1 ) ).
  ENDMETHOD.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
    AUTHORITY-CHECK OBJECT 'S_TABU_NAM' ID 'TABLE' FIELD 'ZI_ZPACKDSCREENTABLE' ID 'ACTVT' FIELD '02'.
    DATA(is_authorized) = COND #( WHEN sy-subrc = 0 THEN if_abap_behv=>auth-allowed
                                  ELSE if_abap_behv=>auth-unauthorized ).
    result-%ACTION-CopyZpackdScreenTable = is_authorized.
  ENDMETHOD.
  METHOD GET_INSTANCE_FEATURES.
    result = VALUE #( FOR row IN keys ( %TKY = row-%TKY
                                        %ACTION-CopyZpackdScreenTable = COND #( WHEN row-%IS_DRAFT = if_abap_behv=>mk-off THEN if_abap_behv=>fc-o-disabled ELSE if_abap_behv=>fc-o-enabled )
   ) ).
  ENDMETHOD.
ENDCLASS.
