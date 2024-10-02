CLASS zsd_delivery_number_range DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_badi_interface .
    INTERFACES if_le_shp_modify_head .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZSD_DELIVERY_NUMBER_RANGE IMPLEMENTATION.


  METHOD if_le_shp_modify_head~modify_fields.

  delivery_document_out = delivery_document_in .
 read table DELIVERY_DOCUMENT_ITEMS assigning field-symbol(<fs_field_properties>) index 1 .
if sy-subrc eq 0 .
 delivery_document_out-yy1_distribution_dlh         = <fs_field_properties>-distributionchannel  .
  delivery_document_out-yy1_plant1_dlh         = <fs_field_properties>-plant  .
*    field_properties_out = field_properties_in.
*    loop at field_properties_out assigning field-symbol(<fs_field_properties>).
*      if <fs_field_properties>-field_name = 'YY1_FIELD_1'.
*        <fs_field_properties>-read_only = 'X'.
*      endif.
*    endloop.

endif .
  ENDMETHOD.
ENDCLASS.
