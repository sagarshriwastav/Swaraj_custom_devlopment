CLASS ymm_interunit_print DEFINITION
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
                   matdoc type string
                   year  type  string

        RETURNING VALUE(result12) TYPE string
        RAISING   cx_static_check .

  PROTECTED SECTION.
  PRIVATE SECTION.


    CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
    CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
    CONSTANTS  lv2_url    TYPE string VALUE 'https://btp-yvzjjpaz.authentication.eu10.hana.ondemand.com/oauth/token' .
    CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
    CONSTANTS lc_template_name TYPE string VALUE 'Transfer_Chalan/Transfer_Chalan'.


ENDCLASS.



CLASS YMM_INTERUNIT_PRINT IMPLEMENTATION.


   METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).

  ENDMETHOD .


  METHOD if_oo_adt_classrun~main.

*DATA(TEST)  = READ_POSTS( matdoc = '5000000249'  year = ' ' )  .
*number_of_rolls2 = '16' order = '123432'  ) .

  ENDMETHOD.


  method read_posts .

*  DATA : lv_xml TYPE STRING .

select SINGLE * from  zmm_gr_print   where MaterialDocument = @matdoc  into @data(it) .

select Single * from  I_PurchaseOrderItemAPI01 where PurchaseOrder = @it-PurchaseOrder and PurchaseOrderItem = @it-PurchaseOrderItem
                      and Plant = @it-Plant into @DATA(ITEM).


SELECT * from  I_MaterialDocumentItem_2 as a
left outer join I_ProductDescription as b on   ( a~Material = b~Product and b~Language = 'E' )
INNER JOIN      i_product as c on a~Material = c~Product
INNER JOIN   I_MaterialDocumentHeader_2 AS _HEAD ON ( A~MaterialDocument = _HEAD~MaterialDocument )
left OUTER join I_PurchaseOrderItemAPI01 as d on ( a~PurchaseOrder = d~PurchaseOrder and  a~PurchaseOrderItem = d~PurchaseOrderItem and a~Material = d~Material )
left outer join Ygate_headercds as e on ( e~Invoice = _head~ReferenceDocument )
left outer join ygate_itemcds as f on ( f~Zinvoice = e~Invoice and f~Ebeln = a~PurchaseOrder and f~Ebelp = a~PurchaseOrderItem )
  where a~MaterialDocument = @matdoc   into table @data(item1)  .
sort item1  by a-materialdocumentitem .

SELECT SINGLE * from I_Supplier where Supplier = @it-Supplier into @data(tab_sup).

select single ProductOldID, ProductManufacturerNumber from i_product where  Product = @it-Material into @data(prod).

select SINGLE PurchaseOrderDate  from I_PurchaseOrderAPI01 where PurchaseOrder = @it-PurchaseOrder into @data(CreateDt).

Select SINGLE * from I_ProductDescription where Product = @item-Material into @data(matrialdec).

*select single * from I_busi where AddressID = @tab_sup-AddressID into @data(Addsupp).
*.
select single * from zsd_plant_address WITH PRIVILEGED ACCESS where PLANT = @it-Plant INTO @DATA(PLANTADD).
SELECT SINGLE * FROM I_InventoryTransactionTypeT AS A INNER JOIN I_MaterialDocumentHeader_2 AS B ON A~InventoryTransactionType = B~InventoryTransactionType
WHERE B~MaterialDocument = @matdoc
 AND A~Language = 'E'   INTO @DATA(GRNTEXT)  .


""""""""""""""""""""""""""""""""""""""""""""""""""""Plant Wise Address, GST & PAN"""""""""""""""""""""""""""""""""""
if PLANTADD-Plant  = '1100'.
DATA(gst1)  = '23AAHCS2781A1ZP'.
Data(pan1)  = 'AAHCS2781A'.
DATA(Register1) = 'Swaraj Suiting Limited'.
Data(Register2) = 'Spinning Division-I, B-24 To B-41 Jhanjharwada Industrial Area' .
DATA(Register3) = ' Jhanjharwada, Neemuch - 458441, Madhya Pradesh, India'.
DATA(cin1) = 'L18101RJ2003PLC018359'.
elseif PLANTADD-Plant  = '1200'.
 gst1  = '23AAHCS2781A1ZP'.
 pan1  = 'AAHCS2781A'.
 Register1 = 'Swaraj Suiting Limited'.
 Register2 = 'Denim Division-I, B-24 To B-41 Jhanjharwada Industrial Area' .
 Register3 = 'Jhanjharwada, Neemuch - 458441, Madhya Pradesh, India'.
 cin1 = 'L18101RJ2003PLC018359'.
elseif PLANTADD-Plant  = '1300'.
 gst1  = '08AAHCS2781A1ZH'.
 pan1  = 'AAHCS2781A'.
 Register1 = 'Swaraj Suiting Limited'.
 Register2 = 'Weaving Division-I, F-483 To F-487 RIICO Growth Centre' .
 Register3 = 'Hamirgarh, Bhilwara-311025, Rajasthan, India'.
 cin1 = 'L18101RJ2003PLC018359'.
elseif PLANTADD-Plant  = '1310'.
 gst1  = '23AAHCS2781A1ZP'.
 pan1  = 'AAHCS2781A'.
 Register1 = 'Swaraj Suiting Limited'.
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
 Register1 = 'Modway Suiting Pvt. Limited'.
 Register2 = 'Weaving Division-I, 20th Km Stone, Chittorgarh Road' .
 Register3 = 'Takhatpura, Bhilwara-311025, Rajasthan, India'.
 cin1 = 'U18108RJ1986PTC003788'.
elseif PLANTADD-Plant  = '2200'.
 gst1  = '23AABCM5293P1Z1'.
 pan1  = 'AABCM5293P'.
 Register1 = 'Modway Suiting Pvt. Limited'.
 Register2 = 'Weaving Division-II, B-24 To B-41 Jhanjharwada Industrial Area' .
 Register3 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
 cin1 = 'U18108RJ1986PTC003788'.
ENDIF.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""




READ TABLE ITEM1 INTO DATA(WITEM)  INDEX 1 .


select single invoice from ygate_headercds where Invoice = @witem-_head-ReferenceDocument  into @data(inv).
select single * from ygate_itemcds where Ebeln = @witem-a-PurchaseOrder and Ebelp = @witem-a-PurchaseOrderItem
and Zinvoice = @inv into @data(gr).

select single PersonFullName from I_BusinessUserBasic where UserID = @witem-_head-CreatedByUser into @data(person).


 DATA(lv_xml) =
   |<form1>| &&
   |<Subform1>| &&
      |<head>| &&
         |<CIN>{ cin1 }</CIN>| &&
         |<GST>{ gst1 }</GST>| &&
         |<PAN>{ pan1 }</PAN>| &&
      |</head>| &&
      |<PlantSF>| &&
         |<Platname>{ Register1  }</Platname>| &&
         |<address1>{ Register2  }</address1>| &&
         |<address2>{ Register3 }</address2>| &&
         |<adress3></adress3>| &&
      |</PlantSF>| &&
   |</Subform1>| &&
   |<HaderData>| &&
      |<Reservation>Ad retia sedebam</Reservation>| &&
      |<dispatchfrom>Vale</dispatchfrom>| &&
      |<ReceivingLocation>Ego ille</ReceivingLocation>| &&
      |<DocumentNo>Si manu vacuas</DocumentNo>| &&
      |<Date>20040606T101010</Date>| &&
      |<Printedon>Apros tres et quidem</Printedon>| &&
*      |<Movementtype>{ WITEM-a-GoodsMovementType }</Movementtype>| &&
   |</HaderData>|.

data xsml type string .
 loop at item1 into data(iv) .

if iv-a-MaterialBaseUnit = 'ST' .

 data(unit) = 'PC' .

ELSE  .

unit = iv-a-MaterialBaseUnit .

ENDIF .

 data tot type string.
data tot1 type string.
data tot2 type string.

 tot = iv-a-QuantityInBaseUnit.
 tot1 = iv-d-OrderQuantity.
  DATA(lv_xml2) =

 |<Table>| &&
      |<Matrial>{ iv-a-Material }</Matrial>| &&
      |<matrialdec>{ iv-b-ProductDescription }</matrialdec>| &&
      |<OldMatrial>meditabar aliquid enotabamque, ut, si manus</OldMatrial>| &&
      |<Partno>Iam undique silvae et solitudo ipsumque illud </Partno>| &&
      |<description>Licebit auctore</description>| &&
      |<salesorder>Proinde</salesorder>| &&
      |<Quantity>Am undique</Quantity>| &&
      |<uom>{ unit }</uom>| &&
      |<batch>{ iv-a-Batch  }</batch>| &&
      |<Su.Batch>Ad retia sedebam</Su.Batch>| &&
      |<noofbags>Vale</noofbags>| &&
  |</Table>|.

.
CONCATENATE xsml lv_xml2 into  xsml .
*clear  : lv_xml2,iv,unit.
endloop .



*
data(lv_xml3) =
      |<Subform2>| &&
      |<AuthoritySignature>Si manu vacuas</AuthoritySignature>| &&
      |<PartySIgnature>Apros tres et quidem</PartySIgnature>| &&
      |</Subform2>| &&
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
