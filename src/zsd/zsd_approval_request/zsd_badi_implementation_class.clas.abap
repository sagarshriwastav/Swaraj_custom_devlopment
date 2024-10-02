CLASS zsd_badi_implementation_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_badi_interface .
    INTERFACES if_sd_apm_set_approval_reason .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZSD_BADI_IMPLEMENTATION_CLASS IMPLEMENTATION.


  METHOD if_sd_apm_set_approval_reason~set_approval_reason.


    DATA: lt_order TYPE TABLE OF tds_bd_sd_apm_item,
          ls_order LIKE LINE OF lt_order.

        lt_order[] = salesdocumentitem[].

 READ TABLE lt_order INTO DATA(WA_SALESDOCUMENT) INDEX 1.
***********************************PLANT 1200 APPROVAL***************************************************************************
    IF WA_SALESDOCUMENT-plant = '1200' .
*      CREATE SALES ORDER Approvel

          if  salesdocument-sddocumentcategory = 'C' AND  salesdocument-salesdocumenttype = 'TA'  .
          IF salesdocument-salesdocument = '' .

*       IF  SY-uname = 'CB9980000021' .
*           salesdocapprovalreason = 'Z003'.
*       ELSE.
           salesdocapprovalreason = 'Z004'.
*       ENDIF.

           return.
         ENDIF.
        endif.

*      CHANGE SALES ORDER Approvel

***************************slodtoparty cheack *************
if  salesdocument-sddocumentcategory = 'C' AND  salesdocument-salesdocumenttype = 'TA' .

LOOP AT SALESDOCUMENTPARTNER INTO DATA(WA_SALESDOCUMENTPARTNER).
  IF WA_SALESDOCUMENTPARTNER-partnerfunction = 'WE' OR  WA_SALESDOCUMENTPARTNER-partnerfunction = 'RE' OR
  WA_SALESDOCUMENTPARTNER-partnerfunction = 'AG' OR WA_SALESDOCUMENTPARTNER-partnerfunction = 'RG' .
  SELECT SINGLE Customer FROM I_SalesDocumentPartner WITH PRIVILEGED ACCESS WHERE SalesDocument =  @salesdocument-salesdocument
                                                  AND PartnerFunction =   @WA_SALESDOCUMENTPARTNER-partnerfunction
                                                  AND PartnerFunction <> 'ZA'
                                                  INTO @DATA(WA_PARTNER) .
          if WA_PARTNER is not initial and "Check for non-initial
          WA_PARTNER ne  WA_SALESDOCUMENTPARTNER-customer. "Check for value change

*          IF  SY-uname = 'CB9980000021' .
*           salesdocapprovalreason = 'Z003'.
*       ELSE.
           salesdocapprovalreason = 'Z004'.
*       ENDIF.
          return.
        endif.
 ENDIF .
ENDLOOP.

 data soldtoparty type I_SalesDocument-soldtoparty.

       "Sales Orders
        select single soldtoparty from I_SalesDocument WITH PRIVILEGED ACCESS where SalesDocument = @salesdocument-salesdocument into @soldtoparty .
        if soldtoparty is not initial and "Check for non-initial
            soldtoparty ne  salesdocument-soldtoparty. "Check for value change
*          IF  SY-uname = 'CB9980000021' .
*           salesdocapprovalreason = 'Z003'.
*       ELSE.
           salesdocapprovalreason = 'Z004'.
*       ENDIF.
           return.
        endif.
endif.


if  salesdocument-sddocumentcategory = 'C' AND  salesdocument-salesdocumenttype = 'TA' .

  LOOP AT lt_order INTO DATA(WA_DATA).
************************NETAMOUNT******************
  "Sales Orders
        select single b~NETAMOUNT from I_SalesDocument WITH PRIVILEGED ACCESS as a
        Left Outer Join i_salesdocumentitem WITH PRIVILEGED ACCESS as b on ( b~salesdocument = a~SalesDocument )
        where a~SalesDocument = @salesdocument-salesdocument
        AND b~salesdocumentitem = @WA_DATA-salesdocumentitem
        into @DATA(NETAMOUNT)  .
        if NETAMOUNT is not initial . "Check for non-initial
        "    NETAMOUNT ne  WA_DATA-netamount. "Check for value change

       IF ( NETAMOUNT <= ( WA_DATA-netamount + 1 ) AND NETAMOUNT >= ( WA_DATA-netamount - 1 ) ) .
       ELSE.
       salesdocapprovalreason = 'Z004'.
       ENDIF.
       return.
       EXIT.
       endif.

******************************ORDERQUANTITY*************************
"Sales Orders
        select single b~ORDERQUANTITY from I_SalesDocument WITH PRIVILEGED ACCESS as a
        Left Outer Join i_salesdocumentitem WITH PRIVILEGED ACCESS as b on ( b~salesdocument = a~SalesDocument )
        where A~SalesDocument = @salesdocument-salesdocument
        AND b~salesdocumentitem = @WA_DATA-salesdocumentitem
        into @DATA(ORDERQUANTITY)  .
        if ORDERQUANTITY is not initial and "Check for non-initial
            ORDERQUANTITY ne  WA_DATA-requestedquantity. "Check for value change
*          IF  SY-uname = 'CB9980000021' .
*           salesdocapprovalreason = 'Z003'.
*       ELSE.
           salesdocapprovalreason = 'Z004'.
*       ENDIF.
           return.
        EXIT.
        endif.

**************************MATERIAL ******************************
   "Sales Orders
        select single b~MATERIAL from I_SalesDocument WITH PRIVILEGED ACCESS as a
        Left Outer Join i_salesdocumentitem WITH PRIVILEGED ACCESS as b on ( b~salesdocument = a~SalesDocument )
        where A~SalesDocument = @salesdocument-salesdocument
        AND b~salesdocumentitem = @WA_DATA-salesdocumentitem
        into @DATA(MATERIAL)  .
        if MATERIAL is not initial and "Check for non-initial
            MATERIAL ne  WA_DATA-MATERIAL. "Check for value change
*          IF  SY-uname = 'CB9980000021' .
*           salesdocapprovalreason = 'Z003'.
*       ELSE.
           salesdocapprovalreason = 'Z004'.
*       ENDIF.
           return.
        EXIT.
        endif.

*************************PLANT ***************
    "Sales Orders
        select single b~Plant from I_SalesDocument WITH PRIVILEGED ACCESS as a
        Left Outer Join i_salesdocumentitem WITH PRIVILEGED ACCESS as b on ( b~salesdocument = a~SalesDocument )
        where A~SalesDocument = @salesdocument-salesdocument
        AND b~salesdocumentitem = @WA_DATA-salesdocumentitem
        into @DATA(Plant)  .
        if Plant is not initial and "Check for non-initial
            Plant ne  WA_DATA-PLANT. "Check for value change
*        IF  SY-uname = 'CB9980000021' .
*           salesdocapprovalreason = 'Z003'.
*       ELSE.
           salesdocapprovalreason = 'Z004'.
*       ENDIF.
           return.
        EXIT.
        endif.
  ENDLOOP.
endif.

***********************************PLANT 1200 APPROVAL END ***************************************************************************

***********************************PLANT 1300 2100 APPROVAL END ***************************************************************************

ELSEIF WA_SALESDOCUMENT-plant = '1300' OR WA_SALESDOCUMENT-plant = '2100' .

*      CREATE SALES ORDER Approvel
IF salesdocument-organizationdivision <> '15' AND  WA_SALESDOCUMENT-plant <> '1300'.


          if  salesdocument-sddocumentcategory = 'C' AND  salesdocument-salesdocumenttype = 'TA'  .
          IF salesdocument-salesdocument = '' .

       IF  SY-uname = 'CB9980000046' .
           salesdocapprovalreason = 'Z001'.
       ELSE.
           salesdocapprovalreason = 'Z002'.
       ENDIF.

           return.
         ENDIF.
        endif.
*      CHANGE SALES ORDER Approvel

***************************slodtoparty cheack *************
if  salesdocument-sddocumentcategory = 'C' AND  salesdocument-salesdocumenttype = 'TA' .

LOOP AT SALESDOCUMENTPARTNER INTO WA_SALESDOCUMENTPARTNER.
  IF WA_SALESDOCUMENTPARTNER-partnerfunction = 'WE' OR  WA_SALESDOCUMENTPARTNER-partnerfunction = 'RE' OR
  WA_SALESDOCUMENTPARTNER-partnerfunction = 'AG' OR WA_SALESDOCUMENTPARTNER-partnerfunction = 'RG' .
  SELECT SINGLE Customer FROM I_SalesDocumentPartner WITH PRIVILEGED ACCESS WHERE SalesDocument =  @salesdocument-salesdocument
                                                  AND PartnerFunction =   @WA_SALESDOCUMENTPARTNER-partnerfunction
                                                  AND PartnerFunction <> 'ZA'
                                                  INTO @WA_PARTNER .
          if WA_PARTNER is not initial and "Check for non-initial
          WA_PARTNER ne  WA_SALESDOCUMENTPARTNER-customer. "Check for value change
           IF  SY-uname = 'CB9980000046' .
           salesdocapprovalreason = 'Z005'.
           ELSE .
           salesdocapprovalreason = 'Z006'.
           ENDIF.
          return.
        endif.
 ENDIF .
ENDLOOP.



       "Sales Orders
        select single soldtoparty from I_SalesDocument WITH PRIVILEGED ACCESS where SalesDocument = @salesdocument-salesdocument into @soldtoparty .
        if soldtoparty is not initial and "Check for non-initial
            soldtoparty ne  salesdocument-soldtoparty. "Check for value change
           IF  SY-uname = 'CB9980000046' .
           salesdocapprovalreason = 'Z005'.
           ELSE .
           salesdocapprovalreason = 'Z006'.
           ENDIF.
           return.
        endif.
endif.


if  salesdocument-sddocumentcategory = 'C' AND  salesdocument-salesdocumenttype = 'TA' .

  LOOP AT lt_order INTO WA_DATA.
************************NETAMOUNT******************
  "Sales Orders
        select single b~NETAMOUNT from I_SalesDocument WITH PRIVILEGED ACCESS as a
        Left Outer Join i_salesdocumentitem WITH PRIVILEGED ACCESS as b on ( b~salesdocument = a~SalesDocument )
        where a~SalesDocument = @salesdocument-salesdocument
        AND b~salesdocumentitem = @WA_DATA-salesdocumentitem
        into @NETAMOUNT  .
        if NETAMOUNT is not initial . "Check for non-initial
         "   NETAMOUNT ne  WA_DATA-netamount. "Check for value change
       IF ( NETAMOUNT <= ( WA_DATA-netamount + 1 ) AND NETAMOUNT >= ( WA_DATA-netamount - 1 ) ) .
       ELSE.

       IF  SY-uname = 'CB9980000046' .
           salesdocapprovalreason = 'Z005'.
       ELSE .
           salesdocapprovalreason = 'Z006'.
      ENDIF.
      return.
      EXIT.
      ENDIF.
      endif.

******************************ORDERQUANTITY*************************
"Sales Orders
        select single b~ORDERQUANTITY from I_SalesDocument WITH PRIVILEGED ACCESS as a
        Left Outer Join i_salesdocumentitem WITH PRIVILEGED ACCESS as b on ( b~salesdocument = a~SalesDocument )
        where A~SalesDocument = @salesdocument-salesdocument
        AND b~salesdocumentitem = @WA_DATA-salesdocumentitem
        into @ORDERQUANTITY  .
        if ORDERQUANTITY is not initial and "Check for non-initial
            ORDERQUANTITY ne  WA_DATA-requestedquantity. "Check for value change
           IF  SY-uname = 'CB9980000046' .
           salesdocapprovalreason = 'Z005'.
           ELSE .
           salesdocapprovalreason = 'Z006'.
           ENDIF.
           return.
        EXIT.
        endif.

**************************MATERIAL ******************************
   "Sales Orders
        select single b~MATERIAL from I_SalesDocument WITH PRIVILEGED ACCESS as a
        Left Outer Join i_salesdocumentitem WITH PRIVILEGED ACCESS as b on ( b~salesdocument = a~SalesDocument )
        where A~SalesDocument = @salesdocument-salesdocument
        AND b~salesdocumentitem = @WA_DATA-salesdocumentitem
        into @MATERIAL  .
        if MATERIAL is not initial and "Check for non-initial
            MATERIAL ne  WA_DATA-MATERIAL. "Check for value change
            IF  SY-uname = 'CB9980000046' .
           salesdocapprovalreason = 'Z005'.
           ELSE .
           salesdocapprovalreason = 'Z006'.
           ENDIF.
           return.
        EXIT.
        endif.

*************************PLANT ***************
    "Sales Orders
        select single b~Plant from I_SalesDocument WITH PRIVILEGED ACCESS as a
        Left Outer Join i_salesdocumentitem WITH PRIVILEGED ACCESS as b on ( b~salesdocument = a~SalesDocument )
        where A~SalesDocument = @salesdocument-salesdocument
        AND b~salesdocumentitem = @WA_DATA-salesdocumentitem
        into @Plant  .
        if Plant is not initial and "Check for non-initial
            Plant ne  WA_DATA-PLANT. "Check for value change
           IF  SY-uname = 'CB9980000046' .
           salesdocapprovalreason = 'Z005'.
           ELSE .
           salesdocapprovalreason = 'Z006'.
           ENDIF.
           return.
        EXIT.
        endif.
  ENDLOOP.
ENDIF.

  ELSEIF  salesdocument-organizationdivision = '15' AND  WA_SALESDOCUMENT-plant = '1300'.


    if  salesdocument-sddocumentcategory = 'C' AND  salesdocument-salesdocumenttype = 'TA'  .
          IF salesdocument-salesdocument = '' .
           salesdocapprovalreason = 'Z003'.

           return.
         ENDIF.
        endif.
*      CHANGE SALES ORDER Approvel

***************************slodtoparty cheack *************
if  salesdocument-sddocumentcategory = 'C' AND  salesdocument-salesdocumenttype = 'TA' .

LOOP AT SALESDOCUMENTPARTNER INTO WA_SALESDOCUMENTPARTNER.
  IF WA_SALESDOCUMENTPARTNER-partnerfunction = 'WE' OR  WA_SALESDOCUMENTPARTNER-partnerfunction = 'RE' OR
  WA_SALESDOCUMENTPARTNER-partnerfunction = 'AG' OR WA_SALESDOCUMENTPARTNER-partnerfunction = 'RG' .
  SELECT SINGLE Customer FROM I_SalesDocumentPartner WITH PRIVILEGED ACCESS WHERE SalesDocument =  @salesdocument-salesdocument
                                                  AND PartnerFunction =   @WA_SALESDOCUMENTPARTNER-partnerfunction
                                                  AND PartnerFunction <> 'ZA'
                                                  INTO @WA_PARTNER .
          if WA_PARTNER is not initial and "Check for non-initial
          WA_PARTNER ne  WA_SALESDOCUMENTPARTNER-customer. "Check for value change
           salesdocapprovalreason = 'Z003'.

          return.
        endif.
 ENDIF .
ENDLOOP.



       "Sales Orders
        select single soldtoparty from I_SalesDocument WITH PRIVILEGED ACCESS where SalesDocument = @salesdocument-salesdocument into @soldtoparty .
        if soldtoparty is not initial and "Check for non-initial
            soldtoparty ne  salesdocument-soldtoparty. "Check for value change
           salesdocapprovalreason = 'Z003'.

           return.
        endif.
endif.


if  salesdocument-sddocumentcategory = 'C' AND  salesdocument-salesdocumenttype = 'TA' .

  LOOP AT lt_order INTO WA_DATA.
************************NETAMOUNT******************
  "Sales Orders
        select single b~NETAMOUNT from I_SalesDocument WITH PRIVILEGED ACCESS as a
        Left Outer Join i_salesdocumentitem WITH PRIVILEGED ACCESS as b on ( b~salesdocument = a~SalesDocument )
        where a~SalesDocument = @salesdocument-salesdocument
        AND b~salesdocumentitem = @WA_DATA-salesdocumentitem
        into @NETAMOUNT  .
        if NETAMOUNT is not initial and "Check for non-initial
            NETAMOUNT ne  WA_DATA-netamount. "Check for value change

           salesdocapprovalreason = 'Z003'.

           return.
        EXIT.
        endif.

******************************ORDERQUANTITY*************************
"Sales Orders
        select single b~ORDERQUANTITY from I_SalesDocument WITH PRIVILEGED ACCESS as a
        Left Outer Join i_salesdocumentitem WITH PRIVILEGED ACCESS as b on ( b~salesdocument = a~SalesDocument )
        where A~SalesDocument = @salesdocument-salesdocument
        AND b~salesdocumentitem = @WA_DATA-salesdocumentitem
        into @ORDERQUANTITY  .
        if ORDERQUANTITY is not initial and "Check for non-initial
            ORDERQUANTITY ne  WA_DATA-requestedquantity. "Check for value change
           salesdocapprovalreason = 'Z003'.
           return.
        EXIT.
        endif.

**************************MATERIAL ******************************
   "Sales Orders
        select single b~MATERIAL from I_SalesDocument WITH PRIVILEGED ACCESS as a
        Left Outer Join i_salesdocumentitem WITH PRIVILEGED ACCESS as b on ( b~salesdocument = a~SalesDocument )
        where A~SalesDocument = @salesdocument-salesdocument
        AND b~salesdocumentitem = @WA_DATA-salesdocumentitem
        into @MATERIAL  .
        if MATERIAL is not initial and "Check for non-initial
            MATERIAL ne  WA_DATA-MATERIAL. "Check for value change

           salesdocapprovalreason = 'Z003'.

           return.
        EXIT.
        endif.

*************************PLANT ***************
    "Sales Orders
        select single b~Plant from I_SalesDocument WITH PRIVILEGED ACCESS as a
        Left Outer Join i_salesdocumentitem WITH PRIVILEGED ACCESS as b on ( b~salesdocument = a~SalesDocument )
        where A~SalesDocument = @salesdocument-salesdocument
        AND b~salesdocumentitem = @WA_DATA-salesdocumentitem
        into @Plant  .
        if Plant is not initial and "Check for non-initial
            Plant ne  WA_DATA-PLANT. "Check for value chang
            salesdocapprovalreason = 'Z003'.

           return.
        EXIT.
        endif.
  ENDLOOP.

ENDIF.
endif.
ENDIF.
**********************************************end *********************
  ENDMETHOD.
ENDCLASS.
