CLASS zmm_purchase_contract_print DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  INTERFACES if_oo_adt_classrun .


        CLASS-DATA : access_token TYPE string .
        CLASS-DATA : xml_file TYPE string .
*        CLASS-DATA : template TYPE string .

    TYPES :BEGIN OF struct,
        xdp_template TYPE string,
        xml_data     TYPE string,
        form_type    TYPE string,
        form_locale  TYPE string,
        tagged_pdf   TYPE string,
        embed_font   TYPE string,
      END OF struct."


       CLASS-METHODS :

      create_client
        IMPORTING url           TYPE string
        RETURNING VALUE(result) TYPE REF TO if_web_http_client
        RAISING   cx_static_check ,

      read_posts
        importing
                 plant TYPE string
                 contract type string
**                  VALUE(ValidityEndDate)         TYPE string
**                  VALUE(ValidityStartDate)      TYPE string

           RETURNING VALUE(result12) TYPE string
           RAISING   cx_static_check .



  PROTECTED SECTION.
  PRIVATE SECTION.


        CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
        CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
        CONSTANTS  lv2_url    TYPE string VALUE 'https://btp-yvzjjpaz.authentication.eu10.hana.ondemand.com/oauth/token'  .
        CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
        CONSTANTS lc_template_name TYPE string VALUE 'ZMM_PURCHASE_CONTRACT/ ZMM_PURCHASE_CONTRACT'.



ENDCLASS.



CLASS ZMM_PURCHASE_CONTRACT_PRINT IMPLEMENTATION.


      METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).


      ENDMETHOD.


       METHOD if_oo_adt_classrun~main.

       ENDMETHOD.


      method read_posts .

      DATA lv_xml TYPE string.
      DATA XSML TYPE STRING.
      DATA n TYPE n VALUE 0 .

*    DATA date2 TYPE string.
*    DATA gv1 TYPE string .
*    DATA gv2 TYPE string .
*    DATA gv3 TYPE string .
*
*    gv3 = ValidityStartDate+6(4)  .
*    gv2 = ValidityStartDate+3(2)  .
*    gv1 = ValidityStartDate+0(2)  .
*
*    CONCATENATE gv3 gv2 gv1   INTO date2.
*
*    DATA date3 TYPE string.
*    DATA gv4 TYPE string .
*    DATA gv5 TYPE string .
*    DATA gv6 TYPE string .
*
*    gv6 = ValidityEndDate+6(4)  .
*    gv5 = ValidityEndDate+3(2)  .
*    gv4 = ValidityEndDate+0(2)  .
*
*    CONCATENATE gv6 gv5 gv4  INTO date3.






      SELECT  * FROM I_PurchaseContractItemAPI01 AS a
**                      LEFT JOIN I_Supplier as b ON ( b~Supplier = c~Supplier )
                      LEFT JOIN I_PurchaseContractAPI01 as c ON ( c~PurchaseContract = a~PurchaseContract  )
                     LEFT JOIN I_Product as d ON ( d~Product = a~Material )
                     LEFT JOIN I_Supplier as b ON ( b~Supplier = c~Supplier )
                      LEFT JOIN I_ProductDescription as e ON ( e~Product = a~Material AND e~Language = 'E' )
                      LEFT JOIN I_ProductPlantBasic as f ON ( f~Product = a~Material )
                      WHERE c~PurchaseContract = @contract  INTO table  @data(it) .




     SORT it  ASCENDING BY  c-PurchaseContract.
    DELETE ADJACENT DUPLICATES FROM it COMPARING d-Product  .
*    DELETE it WHERE A- NE matdoc .
    READ TABLE it INTO DATA(WA) INDEX 1.


      SELECT SINGLE * from zsd_plant_address WITH PRIVILEGED ACCESS where PLANT = @wa-a-Plant INTO @DATA(PLANTADD).
       SELECT SINGLE * FROM I_Supplier    WHERE Supplier = @wa-c-Supplier INTO @data(supp).
       SELECT SINGLE * FROM I_PurchaseContractAPI01 WHERE PurchaseContract = @wa-c-PurchaseContract INTO @data(pur).
       SELECT SINGLE * FROM I_PurchaseContractItemAPI01 WHERE PurchaseContract = @wa-c-PurchaseContract INTO @data(puritem).
       SELECT SINGLE * FROM I_PaymentTermsText WHERE PaymentTerms = @wa-c-PaymentTerms INTO @data(pterms).
       SELECT SINGLE * FROM zsupplier_details WHERE Supplier = @wa-c-Supplier INTO @data(email).
       SELECT SINGLE * FROM I_RegionText WHERE Region = @wa-b-Region AND Country = 'IN' INTO @data(region).

""""""""""""""""""""""""""""""""""""""""""""""""""""Plant Wise Address, GST & PAN"""""""""""""""""""""""""""""""""""
if PLANTADD-Plant  = '1100'.
DATA(gst1)  = '23AAHCS2781A1ZP'.
Data(pan1)  = 'AAHCS2781A'.
DATA(Register1) = 'SWARAJ SUITING LIMITED'.
Data(Register2) = 'Spinning Division-I, B-24 To B-41 Jhanjharwada Industrial Area' .
DATA(Register3) = ' Jhanjharwada, Neemuch - 458441, Madhya Pradesh, India'.
DATA(cin1) = 'L18101RJ2003PLC018359'.
elseif PLANTADD-Plant  = '1200'.
 gst1  = '23AAHCS2781A1ZP'.
 pan1  = 'AAHCS2781A'.
 Register1 = 'SWARAJ SUITING LIMITED'.
 Register2 = 'Denim Division-I, B-24 To B-41 Jhanjharwada Industrial Area' .
 Register3 = 'Jhanjharwada, Neemuch - 458441, Madhya Pradesh, India'.
 cin1 = 'L18101RJ2003PLC018359'.
elseif PLANTADD-Plant  = '1300'.
 gst1  = '08AAHCS2781A1ZH'.
 pan1  = 'AAHCS2781A'.
 Register1 = 'SWARAJ SUITING LIMITED'.
 Register2 = 'Weaving Division-I, F-483 To F-487 RIICO Growth Centre' .
 Register3 = 'Hamirgarh, Bhilwara-311025, Rajasthan, India'.
 cin1 = 'L18101RJ2003PLC018359'.
elseif PLANTADD-Plant  = '1310'.
 gst1  = '23AAHCS2781A1ZP'.
 pan1  = 'AAHCS2781A'.
 Register1 = 'SWARAJ SUITING LIMITED'.
 Register2 = 'Weaving Division-II, B-24 To B-41 Jhanjharwada Industrial Area' .
 Register3 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
 cin1 = 'L18101RJ2003PLC018359'.
elseif PLANTADD-Plant  = '1400'.
 gst1  = '23AAHCS2781A1ZP'.
 pan1  = 'AAHCS2781A'.
 Register1 = 'Swaraj Suiting Limited'.
 Register2 = 'Process House-I, B-24 To B-41 Jhanjharwada Industrial Area' .
 Register3 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
 cin1 = 'L18101RJ2003PLC018359'.
elseif PLANTADD-Plant  = '2100'.
 gst1  = '08AABCM5293P1ZT'.
 pan1  = 'AABCM5293P'.
 Register1 = 'MODWAY SUITING PVT. LIMITED'.
 Register2 = 'Weaving Division-I, 20th Km Stone, Chittorgarh Road' .
 Register3 = 'Takhatpura, Bhilwara-311025, Rajasthan, India'.
 cin1 = 'U18108RJ1986PTC003788'.
elseif PLANTADD-Plant  = '2200'.
 gst1  = '23AABCM5293P1Z1'.
 pan1  = 'AABCM5293P'.
 Register1 = 'MODWAY SUITING PVT. LIMITED'.
 Register2 = 'Weaving Division-II, B-24 To B-41 Jhanjharwada Industrial Area' .
 Register3 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
 cin1 = 'U18108RJ1986PTC003788'.
ENDIF.
 DATA ContractType TYPE string .

    IF pur-PurchaseContractType = 'MK' .
    ContractType = 'Quantity Contract' .
    ELSEIF
    pur-PurchaseContractType = 'WK'.
    ContractType = 'Value Contact'.
    ENDIF.

    DATA date2 TYPE string.
    DATA gv1 TYPE string .
    DATA gv2 TYPE string .
    DATA gv3 TYPE string .

    gv3 = pur-ValidityStartDate+0(4)  .
    gv2 = pur-ValidityStartDate+4(2)  .
    gv1 = pur-ValidityStartDate+6(2)  .

    CONCATENATE gv1 '-' gv2 '-' gv3   INTO date2.

    DATA date3 TYPE string.
    DATA gv4 TYPE string .
    DATA gv5 TYPE string .
    DATA gv6 TYPE string .

    gv6 = pur-ValidityEndDate+0(4)  .
    gv5 = pur-ValidityEndDate+4(2)  .
    gv4 = pur-ValidityEndDate+6(2)  .

    CONCATENATE gv4 '-' gv5 '-' gv6  INTO date3.

      DATA lc_template_name1 TYPE string .

      lc_template_name1 = 'ZMM_PURCHASE_CONTRACT/ZMM_PURCHASE_CONTRACT'.

   lv_xml =
         |<form1>| &&
         |<pagesub>| &&
         |<plantsub>| &&
         |<logosub/>| &&
         |<addsubform>| &&
         |<plantname>{ register1 }</plantname>| &&
         |<ADD1>{ register2 }</ADD1>| &&
         |<ADD2>{ register3 }</ADD2>| &&
         |<ADD3></ADD3>| &&
         |</addsubform>| &&
         |<imagesub/>| &&
         |<gstsub>| &&
         |<GSTIN>{ gst1 }</GSTIN>| &&
         |<CIN>{ cin1 }</CIN>| &&
         |<PAN>{ pan1 }</PAN>| &&
         |</gstsub>| &&
         |<purchasesubform/>| &&
         |</plantsub>| &&
         |<VendorAdd>| &&
         |<to>{ pur-Supplier }</to>| &&
         |<vendor>{ supp-SupplierName }</vendor>| &&
         |<vendor>{ supp-BPAddrStreetName } { supp-BPAddrCityName } { supp-PostalCode }</vendor>| &&
         |<mobileno>{ supp-PhoneNumber1 }</mobileno>| &&
         |<vendorGSTIN>{ supp-TaxNumber3 }</vendorGSTIN>| &&
         |<state>{ region-RegionName }</state>| &&
         |<Email>{ email-EmailAddress }</Email>| &&
         |</VendorAdd>| &&
         |<Subform1>| &&
         |<StartDate>{ date2 }</StartDate>| &&
         |<EndDate>{ date3 }</EndDate>| &&
         |</Subform1>| &&
         |<Contractsub>| &&
         |<ContractNo.>{ pur-PurchaseContract }</ContractNo.>| &&
         |<ContractType>{ ContractType }</ContractType>| &&
         |<Date>{ date2 }</Date>| &&
         |<SupplierRefererence>{ pur-CorrespncExternalReference }</SupplierRefererence>| &&
         |<ContactPerson></ContactPerson>| &&
         |<Mobile></Mobile>| &&
         |<E-mail></E-mail>| &&
         |</Contractsub>| &&
            |<Table2>| &&
            |<HeaderRow/>| .


       LOOP AT it INTO DATA(iv) .
          DATA Total TYPE P DECIMALS 2  .
           n = n + 1 .
           Total = iv-a-TargetQuantity * iv-a-ContractNetPriceAmount .


*            SELECT SINGLE * FROM  I_PurchaseContractItemAPI01 AS A
*                      LEFT JOIN  I_Product AS B ON ( B~Product = A~Material )
*                      LEFT JOIN I_ProductDescription as C ON ( C~Product = B~Product AND C~Language = 'E' )
*                      LEFT JOIN I_ProductPlantBasic as D ON ( D~Product = A~Material )
*                      WHERE  A~PurchaseContract = @IV-a-PurchaseContract INTO  @DATA(DES).

       lv_xml  =  lv_xml &&

            |<Row1>| &&
            |<SNo>{ n }</SNo>| &&
            |<material>{ iv-d-Product }</material>| &&
            |<materialdes>{ iv-e-ProductDescription }</materialdes>| &&
*            |<MaterialDescription>{ iv-e-ProductDescription }</MaterialDescription>| &&
            |<HSNSAC>{ iv-f-ConsumptionTaxCtrlCode }</HSNSAC>| &&
            |<UOM>{ iv-a-OrderPriceUnit }</UOM>| &&
            |<PLANTCODE>{ iv-a-Plant }</PLANTCODE>| &&
            |<QUANTITY>{ iv-a-TargetQuantity }</QUANTITY>| &&
            |<RATE>{ iv-a-ContractNetPriceAmount }</RATE>| &&
            |<Total>{ total }</Total>| &&
            |<DISCOUNT></DISCOUNT>| &&
            |<CGST></CGST>| &&
            |<SGST></SGST>| &&
            |<IGST></IGST>| &&
            |</Row1>| .


    clear: iv  .
    data tot_2 TYPE p DECIMALS 2.
          tot_2 = tot_2 + total .
       ENDLOOP.


     lv_xml =  lv_xml &&
             |</Table2>| &&
      |<TOTGST>{ tot_2 }</TOTGST>| &&
      |<AMOUNTINWORD></AMOUNTINWORD>| &&
      |<INCOTERMS></INCOTERMS>| &&
      |<FREIGHT></FREIGHT>| &&
      |<PAYMENTTERMS>{ pterms-PaymentTermsDescription }</PAYMENTTERMS>| &&
      |<TextField1>{ pur-CorrespncExternalReference }</TextField1>| &&


*          |<prepaidby>{ pur-CreatedByUser }</prepaidby>| &&
*          |<SIGN></SIGN>| &&
*          |</pagesub>| &&
*          |</form1>| .
       |</pagesub>| &&
       |<Subform2/>| &&
       |<Subform3>| &&
       |<PREPAIDBY>{ pur-CreatedByUser }</PREPAIDBY>| &&
       |<SIGN></SIGN>| &&
       |</Subform3>| &&
       |</form1>| .





   CALL METHOD ycl_test_adobe=>getpdf(
       EXPORTING
         xmldata  = LV_XML
         template = lc_template_name1
       RECEIVING
         result   = result12 ).

   ENDMETHOD.
ENDCLASS.
