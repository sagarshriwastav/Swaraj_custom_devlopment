CLASS zreservation_bapi DEFINITION
PUBLIC
FINAL
CREATE PUBLIC .
PUBLIC SECTION.
      INTERFACES if_oo_adt_classrun .
      METHODS  material_document12
      EXPORTING invoice       TYPE string
      RETURNING VALUE(result) TYPE string  .
PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS ZRESERVATION_BAPI IMPLEMENTATION.


METHOD if_oo_adt_classrun~main.
DATA(return_data) = material_document12(  ) .
ENDMETHOD.


     METHOD material_document12 .

      MODIFY ENTITIES OF i_reservationdocumenttp
             ENTITY reservationdocument
             CREATE FROM VALUE #( ( %cid                          = 'CID_001'
                                    goodsmovementtype             = '201'
                                    reservationdate               = sy-datum
                                    costcenter                    = '130000112'
                                    ResvnVerificationCompanyCode  = '1000'
                                    %control-goodsmovementtype                    = cl_abap_behv=>flag_changed
                                    %control-reservationdate                      = cl_abap_behv=>flag_changed
                                    %control-costcenter                           = cl_abap_behv=>flag_changed
                                    %control-ResvnVerificationCompanyCode         = cl_abap_behv=>flag_changed
                                ) )
             ENTITY reservationdocument
             CREATE BY \_reservationdocumentitemtp
             FROM VALUE #( (
                             %cid_ref = 'CID_001'
                             %target = VALUE #( ( %cid                           = 'CID_ITM_001'
                                                  plant                          = '1300'
                                                  product                        = 'ST000001'
                                                  storagelocation                = 'ST01'
                                                  ResvnItmRequiredQtyInEntryUnit = 1
                                                  entryunit                      = 'PC'
                                                  %control-plant                             = cl_abap_behv=>flag_changed
                                                  %control-product                           = cl_abap_behv=>flag_changed
                                                  %control-storagelocation                   = cl_abap_behv=>flag_changed
                                                  %control-ResvnItmRequiredQtyInEntryUnit    = cl_abap_behv=>flag_changed
                                                  %control-entryunit                         = cl_abap_behv=>flag_changed
                                              ) )


                         ) )
             MAPPED   DATA(ls_create_mapped)
             FAILED   DATA(ls_create_failed)
             REPORTED DATA(ls_create_reported).

             COMMIT ENTITIES BEGIN
     RESPONSE OF i_reservationdocumenttp
     FAILED DATA(commit_failed)
     REPORTED DATA(commit_reported).

     COMMIT ENTITIES END.

*     MODIFY ENTITIES OF i_reservationdocumenttp
*            ENTITY reservationdocument
*                CREATE FROM VALUE #( ( %cid                          = 'CID_001'
*     "                                  issuingorreceivingplant       = '1300'
*                            "           goodsmovementcode             = '02'
*                                       reservationdate               =  sy-datum
*                                       goodsmovementtype             = '201'
*                                       resvnverificationcompanycode  = '1000'
*      "                                 issuingorreceivingstorageloc = 'WST1'
*                                       %control-goodsmovementtype                    = cl_abap_behv=>flag_changed
*                                       %control-reservationdate                      = cl_abap_behv=>flag_changed
*                                       %control-resvnverificationcompanycode         = cl_abap_behv=>flag_changed
*                                       %control-issuingorreceivingstorageloc         = cl_abap_behv=>flag_changed
*                                       %control-issuingorreceivingplant              = cl_abap_behv=>flag_changed
*                                   ) )
*                ENTITY reservationdocument
*                CREATE BY \_reservationdocumentitemtp
*                FROM VALUE #( (
*                                %cid_ref = 'CID_001'
*                                %target = VALUE #( ( %cid                           = 'CID_ITM_001'
*                                                     plant                          = '1300'
*                                                     product                        = 'ST000001'
*                                                     storagelocation                = 'ST01'
*                                                     resvnitmrequiredqtyinentryunit = '1'
*                                                     entryunit                      = 'PC'
*                                                     matlcomprequirementdate        = sy-datum
*                                                     goodsmovementisallowed         = 'X'
*                                                     %control-plant                             = cl_abap_behv=>flag_changed
*                                                     %control-product                           = cl_abap_behv=>flag_changed
*                                                     %control-storagelocation                   = cl_abap_behv=>flag_changed
*                                                     %control-resvnitmrequiredqtyinentryunit    = cl_abap_behv=>flag_changed
*                                                     %control-entryunit                         = cl_abap_behv=>flag_changed
*                                                     %control-matlcomprequirementdate           = cl_abap_behv=>flag_changed
*                                                     %control-goodsmovementisallowed            = cl_abap_behv=>flag_changed
*                                                     ) )
*                            ) )
*                MAPPED   DATA(ls_create_mapped)
*                FAILED   DATA(ls_create_failed)
*                REPORTED DATA(ls_create_reported).

*         COMMIT ENTITIES BEGIN
*     RESPONSE OF i_reservationdocumenttp
*     FAILED DATA(commit_failed)
*     REPORTED DATA(commit_reported).
*
*     COMMIT ENTITIES END.

  ENDMETHOD.
ENDCLASS.
