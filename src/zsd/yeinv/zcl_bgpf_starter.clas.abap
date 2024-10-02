CLASS zcl_bgpf_starter DEFINITION
    PUBLIC
*    INHERITING FROM cl_demo_classrun
    CREATE PUBLIC.

    PUBLIC SECTION.

       class-METHODS main
       IMPORTING VALUE(IV_DATA)   TYPE STRING OPTIONAL.

    PROTECTED SECTION.
    PRIVATE SECTION.

ENDCLASS.



CLASS ZCL_BGPF_STARTER IMPLEMENTATION.


    METHOD main.
        DATA lo_operation       TYPE REF TO if_bgmc_op_single.
        DATA lo_process         TYPE REF TO if_bgmc_process_single_op.
        DATA lo_process_factory TYPE REF TO if_bgmc_process_factory.
        DATA lx_bgmc            TYPE REF TO cx_bgmc.
        lo_operation = NEW zcl__bgpf_operation( IV_DATA  ).

*    cl_abap_tx=>save( ) .
        TRY.
            lo_process_factory = cl_bgmc_process_factory=>get_default( ).

            lo_process = lo_process_factory->create( ).

            lo_process->set_name( 'Test process 1'
                     )->set_operation( lo_operation ).



            lo_process->save_for_execution( ).

            COMMIT WORK.

          CATCH cx_bgmc INTO lx_bgmc.
        data(lv)    =    lx_bgmc->get_longtext( ) .

            ROLLBACK WORK.

        ENDTRY.
    ENDMETHOD.
ENDCLASS.
