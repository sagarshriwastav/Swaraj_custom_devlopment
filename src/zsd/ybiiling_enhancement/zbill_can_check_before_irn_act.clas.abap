CLASS zbill_can_check_before_irn_act DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_badi_interface .
    INTERFACES if_sd_bil_flex_cancellation .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZBILL_CAN_CHECK_BEFORE_IRN_ACT IMPLEMENTATION.


  METHOD if_sd_bil_flex_cancellation~set_cancellation_data.


    SELECT SINGLE a~BillingDocument,b~irn_status FROM I_OperationalAcctgDocItem WITH PRIVILEGED ACCESS as a
    LEFT OUTER JOIN y1ig_invrefnum WITH PRIVILEGED ACCESS as b ON ( b~docno = a~BillingDocument AND b~bukrs = a~CompanyCode
    AND b~doc_year = a~FiscalYear ) WHERE AccountingDocument = @bil_doc-journalentry
    AND CompanyCode = @bil_doc-companycode AND FiscalYear = @bil_doc-fiscalyear AND ( a~FinancialAccountType = 'K' OR a~FinancialAccountType = 'D' )
     INTO @DATA(irn_status).

  IF irn_status-irn_status = 'ACT' .
      bil_doc_canc_is_rejected  = abap_true.
      rejection_reason_text = 'Irn Is Not Cancel Against This Billing document.'.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
