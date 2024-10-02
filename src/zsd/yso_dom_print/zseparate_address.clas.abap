CLASS zseparate_address DEFINITION
  PUBLIC
  FINAL

 CREATE PUBLIC .



 PUBLIC SECTION.

 CLASS-DATA :BEGIN OF wa_add,

 var1(80) TYPE c,

 var2(80) TYPE c,

 var3(80) TYPE c,

 var4(80) TYPE c,

 var5(80) TYPE c,

 var6(80) TYPE c,

 var7(80) TYPE c,

 var8(80) TYPE c,

 var9(80) TYPE c,

 var10(80) TYPE c,

 var11(80) TYPE c,

 var12(80) TYPE c,

 var13(80) TYPE c,

 var14(80) TYPE c,

 var15(80) TYPE c,

 END OF wa_add.



 CLASS-METHODS:separate

 CHANGING var LIKE wa_add

 RETURNING VALUE(return) TYPE string.



 PROTECTED SECTION.

 PRIVATE SECTION.

ENDCLASS.



CLASS ZSEPARATE_ADDRESS IMPLEMENTATION.


 METHOD separate .



 DATA:index TYPE i.

 DO 15 TIMES.

 index = index + 1.

 DATA(field) = |VAR{ index }|.

 ASSIGN COMPONENT field OF STRUCTURE var TO FIELD-SYMBOL(<fs>).

 IF <fs> IS ASSIGNED AND <fs> IS NOT INITIAL.

 IF return IS INITIAL.

 return = <fs>.

 ELSE.

 CONCATENATE return <fs> INTO return SEPARATED BY space.

 ENDIF.

 CONDENSE return.

 ENDIF.

 ENDDO.

 CLEAR var.

 ENDMETHOD.
ENDCLASS.
