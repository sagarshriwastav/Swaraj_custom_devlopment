CLASS zmm_pr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

     CLASS-DATA : access_token TYPE string .
    CLASS-DATA : xml_file TYPE string .
    TYPES :
      BEGIN OF struct,
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
                   martdoc type string
                   year  type  string

        RETURNING VALUE(result12) TYPE string
        RAISING   cx_static_check .

  PROTECTED SECTION.
  PRIVATE SECTION.


    CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
    CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
    CONSTANTS  lv2_url    TYPE string VALUE 'https://btp-yvzjjpaz.authentication.eu10.hana.ondemand.com/oauth/token'  .
    CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
    CONSTANTS lc_template_name TYPE string VALUE 'PurchaseRequisition/PurchaseRequisition'.



ENDCLASS.



CLASS ZMM_PR IMPLEMENTATION.


   METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).

  ENDMETHOD .


  METHOD if_oo_adt_classrun~main.

  DATA(TEST)  = READ_POSTS( martdoc =  '1100000004'  year = '' ) .

  ENDMETHOD.


  method read_posts .

*  DATA : lv_xml TYPE STRING .

        select SINGLE * from I_PurchaseRequisitionAPI01 WHERE PurchaseRequisition  = @martdoc into @data(it).
        select single * from I_PurchaseRequisitionItemAPI01 where IsDeleted <> 'X' AND PurchaseRequisition = @martdoc into @data(main).

select single ProductOldID, ProductManufacturerNumber from i_product where  Product = @main-Material into @data(prod).
*select   MatlWrhsStkQtyInMatlBaseUnit   from I_MaterialStock_2 where Material = @main-material and Plant = '1101'   into table @data(I_Mat1).

SELECT SINGLE * from I_Supplier where Supplier = @main-Supplier into @data(tab_sup).

select * from  I_PurchaseRequisitionItemAPI01 as a
    LEFT OUTER join i_product    as b on ( a~Material = b~Product )
    LEFT OUTER  join I_ProductDescription as c on ( a~Material = c~Product and c~Language = 'E'  )

     where a~IsDeleted <> 'X' AND PurchaseRequisition = @martdoc into table @data(_pritem)  .


select single * from zsd_plant_address WITH PRIVILEGED ACCESS where PLANT = @main-Plant INTO @DATA(PLANTADD).

SELECT SINGLE * from I_MaterialDocumentHeader_2 WHERE MaterialDocument = @martdoc  into @data(item1)  .


select single PersonFullName from I_BusinessUserBasic where UserID = @main-CreatedByUser into @data(person).


*select single sddocument, salesdocumentitem from I_PurReqnAcctAssgmtAPI01 where PurchaseRequisition = @MAIN-PurchaseRequisition
*              and PurchaseRequisitionItem = @main-PurchaseRequisitionItem into @data(SO).


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""Plant Wise Address, GST & PAN"""""""""""""""""""""""""""""""""""
if PLANTADD-Plant  = '1100'.
DATA(gst1)  = '23AAHCS2781A1ZP'.
Data(pan1)  = 'AAHCS2781A'.
DATA(Register1) = 'SWARAJ SUITING LIMITED'.
Data(Register2) = 'Spinning Division-I, B-24 To B-41 Jhanjharwada Industrial Area' .
DATA(Register3) = 'Jhanjharwada, Neemuch - 458441,Madhya Pradesh, India'.
DATA(cin1) = 'L18101RJ2003PLC018359'.
elseif PLANTADD-Plant  = '1200'.
 gst1  = '23AAHCS2781A1ZP'.
 pan1  = 'AAHCS2781A'.
 Register1 = 'SWARAJ SUITING LIMITED'.
 Register2 = 'Denim Division-I, B-24 To B-41 Jhanjharwada Industrial Area' .
 Register3 = 'Jhanjharwada, Neemuch - 458441,Madhya Pradesh, India'.
 cin1 = 'L18101RJ2003PLC018359'.
elseif PLANTADD-Plant  = '1300'.
 gst1  = '08AAHCS2781A1ZH'.
 pan1  = 'AAHCS2781A'.
 Register1 = 'SWARAJ SUITING LIMITED'.
 Register2 = 'Weaving Division-I, F-483 To F-487 RIICO Growth Centre' .
 Register3 = 'Hamirgarh, Bhilwara-311025,Rajasthan, India'.
 cin1 = 'L18101RJ2003PLC018359'.
elseif PLANTADD-Plant  = '1310'.
 gst1  = '23AAHCS2781A1ZP'.
 pan1  = 'AAHCS2781A'.
 Register1 = 'SWARAJ SUITING LIMITED'.
 Register2 = 'Weaving Division-II, B-24 To B-41 Jhanjharwada Industrial Area' .
 Register3 = 'Jhanjharwada, Neemuch-458441,Madhya Pradesh, India'.
 cin1 = 'L18101RJ2003PLC018359'.
elseif PLANTADD-Plant  = '1400'.
 gst1  = '23AAHCS2781A1ZP'.
 pan1  = 'AAHCS2781A'.
 Register1 = 'SWARAJ SUITING LIMITED'.
 Register2 = 'Process House-I, B-24 To B-41 Jhanjharwada Industrial Area' .
 Register3 = 'Jhanjharwada, Neemuch-458441,Madhya Pradesh, India'.
 cin1 = 'L18101RJ2003PLC018359'.
elseif PLANTADD-Plant  = '2100'.
 gst1  = '08AABCM5293P1ZT'.
 pan1  = 'AABCM5293P'.
 Register1 = 'MODWAY SUITING PVT. LIMITED'.
 Register2 = 'Weaving Division-I, 20th Km Stone, Chittorgarh Road, Takhatpura' .
 Register3 = 'Bhilwara, Bhilwara-311025,Rajasthan, India'.
 cin1 = 'U18108RJ1986PTC003788'.
elseif PLANTADD-Plant  = '2200'.
 gst1  = '23AABCM5293P1Z1'.
 pan1  = 'AABCM5293P'.
 Register1 = 'MODWAY SUITING PVT. LIMITED'.
 Register2 = 'Weaving Division-II, B-24 To B-41 Jhanjharwada Industrial Area' .
 Register3 = ' Jhanjharwada, Neemuch-458441,Madhya Pradesh, India'.
 cin1 = 'U18108RJ1986PTC003788'.
ENDIF.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*IF PLANTADD-Plant ='1000'.
*DATA(cin1) = 'U14219RJ1983PLC002818'.
*elseif PLANTADD-Plant  = '4100'.
*cin1 = 'U63011MH2014PTC281181'.
*elseif PLANTADD-Plant = '1100'.
*cin1 = 'U14219RJ1983PLC002818'.
*elseif PLANTADD-Plant = '4110'.
*cin1 = 'U14219RJ1983PLC002818'.
*elseif PLANTADD-Plant = '1110'.
*cin1 = 'U14219RJ1983PLC002818'.
*elseif PLANTADD-Plant = '4120'.
*cin1 = 'U14219RJ1983PLC002818'.
*elseif PLANTADD-Plant = '1120'.
*endif.


 DATA(lv_xml) =
            |<form1>| &&
            |<Page>| &&
            |<address1>{ Register2 }</address1>| &&
            |<address2>{ Register3 }</address2>| &&
*            |<adress3>{ Register3 }</adress3>| &&
            |<Platname>{ Register1 }</Platname>| &&
            |<CINNO>{ cin1 }</CINNO>| &&
            |<GSTIN>{ gst1 }</GSTIN>| &&
            |<PAN>{ pan1 }</PAN>| &&
            |<RequisitionNo>{ main-PurchaseRequisition  }</RequisitionNo>| &&
            |<RequisitionByCode>{ main-RequirementTracking }</RequisitionByCode>| &&
            |<RequisitionBy>{ main-RequisitionerName }</RequisitionBy>| &&
            |<RequisitionByType>{ main-PurchaseRequisitionType }</RequisitionByType>| &&
            |<Date>{ main-CreationDate }</Date>| &&
            |<VendorCode>{ main-Supplier }</VendorCode>| &&
            |<VendorName>{ tab_sup-SupplierFullName }</VendorName>| &&
*            |<JobOrder>{  }</JobOrder>| &&
            |<TextField2>{ it-PurReqnDescription }</TextField2>| .


data xsml type string .


 loop at _pritem into data(iv).
  select  sum( MatlWrhsStkQtyInMatlBaseUnit )  from I_MaterialStock_2 where Material = @iv-a-material  into @data(I_Mat).

  select single MovingAveragePrice from I_ProductValuationBasic where product = @iv-a-Material  and ValuationArea = '1101' into @data(MovingAveragePrice) .

  select single sddocument, salesdocumentitem from I_PurReqnAcctAssgmtAPI01 where PurchaseRequisition = @iv-a-PurchaseRequisition
              and PurchaseRequisitionItem = @iv-a-PurchaseRequisitionItem into @data(SO).
** SELECT SINGLE PurchasingDocumentTypeName FROM i_PurchasingDocumentTypeText WHERE PurchasingDocumentType = @iv-a-PurchaseRequisition AND
**                      Language = 'E' AND PurchasingDocumentCategory = 'B' INTO @data(Remark).

 if iv-a-BaseUnit = 'ST' .

 data(unit) = 'PC' .

ELSE  .

unit = iv-a-BaseUnit .

ENDIF .

data tot type string.
tot = iv-a-RequestedQuantity * iv-a-PurchaseRequisitionPrice.
 SHIFT SO-SDDocument  LEFT DELETING LEADING '0'.
 SHIFT SO-SalesDocumentItem  LEFT DELETING LEADING '0'.

 IF iv-a-Material IS INITIAL .
 iv-a-Material =  iv-a-PurchaseRequisitionItemText .
 ENDIF.

  DATA(lv_xml2) =
         |<table>| &&
         |<matrial>{ iv-a-Material }</matrial>| &&
         |<matrialdec>{ iv-c-ProductDescription }</matrialdec>| &&
         |<OldMatrial>{ iv-b-ProductManufacturerNumber }</OldMatrial>| &&
         |<Partno>{ iv-b-ProductOldID }</Partno>| &&
*         |<ITEMTEXT>1234</ITEMTEXT>| &&
         |<Qty>{ iv-a-RequestedQuantity }</Qty>| &&
         |<UOM>{ unit }</UOM>| &&
         |<Date>{ iv-a-DeliveryDate  }</Date>| &&
         |<MatrialCurStock>{ i_mat }</MatrialCurStock>| &&
         |<avgrate>{ iv-a-PurchaseRequisitionPrice }</avgrate>| &&
         |<TOTALAMOUNT>{ tot }</TOTALAMOUNT>| &&
         |<SO_Item>{ SO-SDDocument } / { SO-SalesDocumentItem }</SO_Item>| &&
         |<Remark>{ IV-a-YY1_LineItemText_PRI }</Remark>| &&
*         |<LastPurcseRate></LastPurcseRate>| &&
*         |<itemtext></itemtext>| &&
         |</table>|

.
CONCATENATE xsml lv_xml2 into  xsml .
clear  : lv_xml2,I_Mat,MovingAveragePrice,UNIT, SO,iv.
 endloop .


data(lv_xml3) =
   |</Page>| &&
*   |<remark>Apros tres et quidem</remark>| &&
    |<prepareby>{ person }</prepareby>| &&
    |<Sign></Sign>| &&
   |</form1>|.

CONCATENATE lv_xml xsml lv_xml3 into lv_xml .

  CALL METHOD ycl_test_adobe=>getpdf(
       EXPORTING
         xmldata  = LV_XML
         template = lc_template_name
       RECEIVING
         result   = result12 ).


  ENDMETHOD.
ENDCLASS.
