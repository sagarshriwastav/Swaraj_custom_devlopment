CLASS zmail_testing_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  CLASS-METHODS
      read_data
*        IMPORTING variable        TYPE string
        RETURNING VALUE(result12) TYPE string
        RAISING   cx_static_check .
  CLASS-DATA: lx_bcs_mail TYPE REF TO cx_bcs_mail.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZMAIL_TESTING_CLASS IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  TRY.
  DATA(return_data) = read_data( ) .
  ENDTRY.
  ENDMETHOD.


  METHOD read_data.


      DATA lv TYPE string .
 lv = |Dear sir,<P>Please find below mentioned maintenance order detail </P><P>| &&
 |<table BORDER = "1"><tr><th>Gate Entry</th><th>'5654'</th></tr><tr><th>VEHICLE NO.</th><th>'4354'</th></tr>| &&
* |<tr><th>Maint. item desc</th><th>{ wa-MaintenanceItemDescription }</th></tr><tr><th>Maintenance Plant</th><th>{ wa-MaintenancePlanningPlant }</th></tr>| &&
* |<tr><th>Task task Group/Count</th><th>{ wa-tasklistgroup }  /  { wa-tasklistgroupcounter }</th></tr><tr><th>Plan date</th><th>{ Plandate }</th></tr>|  &&
 |<tr><th>Maintenance Strategy</th><th>'TESTING'</th></tr></table>|.


      DATA(config_instance) = cl_bcs_mail_system_config=>create_instance( ).
      DATA recipient_domains TYPE cl_bcs_mail_system_config=>tyt_recipient_domains.
      DATA sender_domains TYPE cl_bcs_mail_system_config=>tyt_sender_domains.
      recipient_domains = VALUE #( ( 'novelveritas.com' ) ).
      sender_domains = VALUE #( ( 'Swarajsuiting.com' ) ).
      "Add allowed domains

      TRY.
      config_instance->set_address_check_active( abap_true ).
      config_instance->add_allowed_recipient_domains( recipient_domains ).
      config_instance->add_allowed_sender_domains( sender_domains ).
      config_instance->modify_default_sender_address( iv_default_address = 'noreply@Swarajsuiting.com'
      iv_default_name = 'Default Sender' ).
      CATCH cx_bcs_mail_config INTO DATA(write_error).
      "handle exception
      ENDTRY.

      TRY.
      DATA(lo_mail) = cl_bcs_mail_message=>create_instance( ).
      lo_mail->set_sender( 'noreply@Swarajsuiting.com' ).             "'smpl.it@thesagar.in' ).   noreply@thesagar.in
      lo_mail->add_recipient( 'gajendra.s@novelveritas.com' ).

*      lo_mail->add_recipient( 'rakeshvyas@thesagar.in' ).
*      lo_mail->add_recipient( 'sachinraghuwanshi@thesagar.in' ).

      lo_mail->set_subject( 'Maintenance Order' ).
      lo_mail->set_main( cl_bcs_mail_textpart=>create_instance(
      iv_content      = lv
      iv_content_type = 'text/html'
      ) ).

*     lo_mail->add_attachment( cl_bcs_mail_textpart=>create_instance(
*       iv_content      = 'This is a text attachment'
*       iv_content_type = 'text/plain'
*       iv_filename     = 'Text_Attachment.txt'
*     ) ).
        lo_mail->send( IMPORTING et_status = DATA(lt_status) ).
        CATCH cx_bcs_mail INTO lx_bcs_mail.
      ENDTRY.


  ENDMETHOD.
ENDCLASS.
