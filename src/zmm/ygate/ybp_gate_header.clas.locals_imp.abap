CLASS lhc_ygate_header DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
 METHODS
derive  FOR DETERMINE ON MODIFY
IMPORTING keys FOR ygate_itemcds~Sono .

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR ygate_header RESULT result.

ENDCLASS.

CLASS lhc_ygate_header IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD derive .





 READ ENTITIES OF ygate_header  IN LOCAL MODE
    ENTITY ygate_itemcds FIELDS ( InQty Banfn Deldat GateQty GateItem  )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_project).

  READ ENTITIES OF ygate_header  IN LOCAL MODE
    ENTITY ygate_header FIELDS ( RefGate  )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_project1).

read table lt_project1 into  data(hb) index 1 .
IF SY-SUBRC = 0 .
IF hb-EntryType = 'RGP' AND  hb-RefGate IS NOT INITIAL .
DATA  LITEM TYPE ygatEITEM1.
loop at lt_project ASSIGNING FIELD-SYMBOL(<fs>) .
select single * from ygatEITEM1 where Gateno = @hb-RefGate and gate_item = @<fs>-GateItem
into @LITEM .
IF LITEM-open_qty IS INITIAL .
LITEM-open_qty = LITEM-out_qty - <fs>-GateQty .
ELSE .
LITEM-open_qty = LITEM-open_qty  - <fs>-GateQty .

ENDIF .

UPDATE ygateitem1 FROM @LITEM .


endloop .
ENDIF .
ENDIF .
*READ ENTITIES OF YGATE_HEADER IN LOCAL MODE
*ENTITY ygate_itemcds FROM keys

*MODIFY ENTITIES OF YGATE_HEADER IN LOCAL MODE
*entity ygate_itemcds
*UPDATE FIELDS ( Sono Soitm ZbagQty  )
*with VALUE #(
*FOR lw_proj in  lt_project INDEX INTO i (
*    %key = lw_proj-%key
*   Sono = '2201'  ) )

*  REPORTED DATA(lt_reported).



  ENDMETHOD.






ENDCLASS.
