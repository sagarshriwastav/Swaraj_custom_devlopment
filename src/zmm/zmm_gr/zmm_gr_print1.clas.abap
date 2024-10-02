CLASS zmm_gr_print1 DEFINITION
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
    CONSTANTS lc_template_name TYPE string VALUE 'ZMM_GR_PRINT/ZMM_GR_PRINT'.


ENDCLASS.



CLASS ZMM_GR_PRINT1 IMPLEMENTATION.


   METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).

  ENDMETHOD .


  METHOD if_oo_adt_classrun~main.

DATA(TEST)  = READ_POSTS( matdoc = '5000000249'  year = ' ' )  .
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
*left outer join I_BatchDistinct as g on ( a~Batch = a~Batch and g~Material = a~Material )
*left outer join ydata_gr_print as h on ( h~ClfnObjectInternalID = g~ClfnObjectInternalID )
  where a~MaterialDocument = @matdoc   into table @data(item1)  .


sort item1  by a-materialdocumentitem .
DELETE ADJACENT DUPLICATES FROM ITEM1 COMPARING A-MaterialDocument A-MaterialDocumentItem .

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
 Register1 = 'SWARAJ SUITING LIMITED'.
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
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

 READ TABLE ITEM1 INTO DATA(WITEM)  INDEX 1 .

   select single PersonFullName from I_BusinessUserBasic where UserID = @witem-_head-CreatedByUser into @data(person).


  IF SY-SYSID = 'XMV'.
    SELECT SINGLE * FROM I_BatchDistinct as a LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as c on ( c~ClassType = '023' and c~ClfnObjectTable = 'MCH1'
           and c~ClfnObjectInternalID = a~ClfnObjectInternalID and c~CharcInternalID = '0000000819' )
           left outer join ZI_ClfnCharcValueDesc_cds as h on ( h~mil = c~CharcValue and h~CharcInternalID = '0000000819' and h~Language = 'E' )
           WHERE ( a~Batch = @witem-a-Batch and a~Material = @witem-a-Material )   into @DATA(millname).
  ELSEIF SY-SYSID = 'XWL'.
    SELECT SINGLE * FROM I_BatchDistinct as a LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as c on ( c~ClassType = '023' and c~ClfnObjectTable = 'MCH1'
           and c~ClfnObjectInternalID = a~ClfnObjectInternalID and c~CharcInternalID = '0000000806' )
           left outer join ZI_ClfnCharcValueDesc_cds as h on ( h~mil = c~CharcValue and h~CharcInternalID = '0000000806' and h~Language = 'E' )
           WHERE ( a~Batch = @witem-a-Batch and a~Material = @witem-a-Material )   into @millname.
  ELSEIF SY-SYSID = 'Z6L'.
      SELECT SINGLE * FROM I_BatchDistinct as a LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as c on ( c~ClassType = '023' and c~ClfnObjectTable = 'MCH1'
           and c~ClfnObjectInternalID = a~ClfnObjectInternalID and c~CharcInternalID = '0000000807' )
           left outer join ZI_ClfnCharcValueDesc_cds as h on ( h~mil = c~CharcValue and h~CharcInternalID = '0000000807' and h~Language = 'E' )
           WHERE ( a~Batch = @witem-a-Batch and a~Material = @witem-a-Material )   into @millname.
 ENDIF.


DATA GV4 TYPE STRING .
DATA GV1 TYPE STRING .
DATA GV2 TYPE STRING .
DATA GV3 TYPE STRING .


  GV3 = witem-e-LrDate+0(4)  .
  GV2 = witem-e-LrDate+5(2)  .
  GV1 = witem-e-LrDate+8(2)  .

  CONCATENATE GV1 '/' GV2 '/' GV3 INTO GV4 .
*  CONCATENATE GV3 GV2 GV1 INTO GV4 .

 if witem-e-LrNo IS INITIAL.
 gv4 = ''.
 endif.
 if WITEM-_head-ReferenceDocument is initial.
 it-DocumentDate = ''.
 endif.


 DATA lc_template_name1 TYPE string .
 DATA: LEN TYPE C.
 LEN = witem-a-Material+0(6)..
 DATA(YARN) = LEN+0(1).

 IF YARN NE 'Y'.
 lc_template_name1 = 'ZMM_GR_PRINT/ZMM_GR_PRINT'.
 DATA(lv_xml) =
      |<form1>| &&
        |<plantname>{ Register1 }</plantname>| &&
      |<address1>{ Register2 }</address1>| &&
      |<address2>{ Register3 }</address2>| &&
*      |<address3>Mirum est</address3>| &&
      |<CINNO>{ cin1 }</CINNO>| &&
      |<GSTIN>{ gst1 }</GSTIN>| &&
      |<PAN>{ pan1 }</PAN> | &&
       |<Row4/>| &&
   |<Row4/>| &&
   |<Row4/>| &&
   |<Subform1>| &&
      |<Table4>| &&
         |<Row1/>| &&
      |</Table4>| &&
   |</Subform1>| &&
   |<Subform2>| &&
      |<SIGN></SIGN>| &&
      |<preparedby>{ person }</preparedby>| &&
   |</Subform2>| &&
     |<Page>| &&
      |<HaderData>| &&
      |<LeftSide>| &&
      |<GRNNO.>{ it-MaterialDocument }</GRNNO.>| &&
      |<VendorCode>{ it-Supplier }</VendorCode>| &&
      |<VendorName>{ tab_sup-SupplierName  }</VendorName>| &&
      |<VendorAddress>{ witem-e-Gateno }</VendorAddress>| &&
      |<VehicleNo>{ witem-e-VehicalNo }</VehicleNo>| &&
      |<LRDate>{ gv4 }</LRDate>| &&
      |<LRNo>{ witem-e-LrNo }</LRNo>| &&
      |<GRNType>{ witem-e-TrOper }</GRNType>| &&
      |</LeftSide>| &&
      |<RightSide>| &&
      |<Date>{ CreateDt }</Date>| &&
      |<PoNo>{ it-PurchaseOrder }</PoNo>| &&
      |<PoName>{ CreateDt }</PoName>| &&
      |<BillNo>{ WITEM-_head-ReferenceDocument  }</BillNo>| &&
      |<BillDate>{ it-DocumentDate }</BillDate>| &&
      |<CostCentre>{ it-CostCenter }</CostCentre>| &&
      |<TransporterName></TransporterName>| &&
      |</RightSide>| &&
      |<Text>| &&
      |<HRemark>{ it-MaterialDocumentHeaderText }</HRemark>| &&
      |</Text>| &&
      |</HaderData>| &&
      |<Table>| &&
      |<Table1>| &&
      |<HeaderRow/>|.

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
         |<Row1>| &&
*               |<SIGN>{ FOR }</SIGN>| &&
*               |<Cell1>{ it-Batch }</Cell1>| &&
               |<Matrial>{ iv-a-Material }</Matrial>| &&
               |<MatrialDescription>{ iv-b-ProductDescription }</MatrialDescription>| &&
               |<ItemText> { iv-a-MaterialDocumentItemText } </ItemText>| &&
               |<GRNQty>{ iv-d-OrderQuantity }</GRNQty>| &&
              |<BillQty>Si manu vacuas</BillQty>| &&
               |<UOM>{ unit }</UOM>| &&
               |<Batch>{ iv-a-Batch }</Batch>| &&
               |<OldMatrial>{ iv-c-ProductOldID }</OldMatrial>| &&
               |<PoQty>{ iv-a-QuantityInBaseUnit }</PoQty>| &&
               |<Plant> { iv-a-Plant } </Plant>| &&
               |<Storage> { iv-a-StorageLocation  } </Storage>| &&
               |<PartName> { iv-c-ProductManufacturerNumber }</PartName>| &&
            |</Row1>|
.
CONCATENATE xsml lv_xml2 into  xsml .
*clear  : lv_xml2,iv,unit.
endloop .



*
data(lv_xml3) =
       |</Table1>| &&
       |</Table>| &&
       |</Page>| &&
       |</form1>|.

 CONCATENATE lv_xml xsml lv_xml3 into lv_xml .


 ELSEIF YARN = 'Y'.
 lc_template_name1 = 'MM_GR_YARN/MM_GR_YARN'.
  lv_xml =
      |<form1>| &&
        |<plantname>{ Register1 }</plantname>| &&
      |<address1>{ Register2 }</address1>| &&
      |<address2>{ Register3 }</address2>| &&
*      |<address3>Mirum est</address3>| &&
      |<CINNO>{ cin1 }</CINNO>| &&
      |<GSTIN>{ gst1 }</GSTIN>| &&
      |<PAN>{ pan1 }</PAN> | &&
       |<Row4/>| &&
   |<Row4/>| &&
   |<Row4/>| &&
   |<Subform1>| &&
      |<Table4>| &&
         |<Row1/>| &&
      |</Table4>| &&
   |</Subform1>| &&
   |<Subform2>| &&
      |<SIGN></SIGN>| &&
      |<preparedby>{ person }</preparedby>| &&
   |</Subform2>| &&
     |<Page>| &&
      |<HaderData>| &&
      |<LeftSide>| &&
      |<GRNNO.>{ it-MaterialDocument }</GRNNO.>| &&
      |<VendorCode>{ it-Supplier }</VendorCode>| &&
      |<VendorName>{ tab_sup-SupplierName  }</VendorName>| &&
      |<VendorAddress>{ witem-e-Gateno }</VendorAddress>| &&
      |<VehicleNo>{ witem-e-VehicalNo }</VehicleNo>| &&
      |<LRDate>{ gv4 }</LRDate>| &&
      |<LRNo>{ witem-e-LrNo }</LRNo>| &&
      |<GRNType>{ witem-e-TrOper }</GRNType>| &&
      |</LeftSide>| &&
      |<RightSide>| &&
      |<Date>{ CreateDt }</Date>| &&
      |<PoNo>{ it-PurchaseOrder }</PoNo>| &&
      |<PoName>{ CreateDt }</PoName>| &&
      |<BillNo>{ WITEM-_head-ReferenceDocument  }</BillNo>| &&
      |<BillDate>{ it-DocumentDate }</BillDate>| &&
     |<Plant>{ witem-a-Plant }</Plant>| &&
     |<StorLoc>{ witem-a-StorageLocation }</StorLoc>| &&
     |<MillNo>{ millName-h-CharcValueDescription }</MillNo>| &&
      |<CostCentre>{ it-CostCenter }</CostCentre>| &&
      |<TransporterName></TransporterName>| &&
      |</RightSide>| &&
      |<Text>| &&
      |<HRemark>{ it-MaterialDocumentHeaderText }</HRemark>| &&
      |</Text>| &&
      |</HaderData>| &&
      |<Table>| &&
      |<Table1>| &&
      |<HeaderRow/>|.

 loop at item1 into iv .

 IF SY-SYSID = 'XMV'.
    SELECT SINGLE a~ClfnObjectInternalID , c~CharcValue  FROM I_BatchDistinct as a
           LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as c on ( c~ClassType = '023' and c~ClfnObjectTable = 'MCH1'
           and c~ClfnObjectInternalID = a~ClfnObjectInternalID and c~CharcInternalID = '0000000818' )
           WHERE ( a~Batch = @iv-a-Batch and a~Material = @iv-a-Material ) into @DATA(lotno).

    SELECT SINGLE c~CharcFromDecimalValue FROM I_BatchDistinct as a
           LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as c on ( c~ClassType = '023' and c~ClfnObjectTable = 'MCH1'
           and c~ClfnObjectInternalID = a~ClfnObjectInternalID and c~CharcInternalID = '0000000814' )
           WHERE ( a~Batch = @witem-a-Batch and a~Material = @witem-a-Material )   into @DATA(bags).

   SELECT SINGLE c~CharcFromDecimalValue FROM I_BatchDistinct as a
           LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as c on ( c~ClassType = '023' and c~ClfnObjectTable = 'MCH1'
           and c~ClfnObjectInternalID = a~ClfnObjectInternalID and c~CharcInternalID = '0000000815' )
           WHERE ( a~Batch = @witem-a-Batch and a~Material = @witem-a-Material )   into @DATA(cones).


 ELSEIF SY-SYSID = 'XWL'.
    SELECT SINGLE a~ClfnObjectInternalID , c~CharcValue  FROM I_BatchDistinct as a
           LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as c on ( c~ClassType = '023' and c~ClfnObjectTable = 'MCH1'
           and c~ClfnObjectInternalID = a~ClfnObjectInternalID and c~CharcInternalID = '0000000807' )
           WHERE ( a~Batch = @iv-a-Batch and a~Material = @iv-a-Material ) into @lotno.

    SELECT SINGLE c~CharcFromDecimalValue FROM I_BatchDistinct as a
           LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as c on ( c~ClassType = '023' and c~ClfnObjectTable = 'MCH1'
           and c~ClfnObjectInternalID = a~ClfnObjectInternalID and c~CharcInternalID = '0000000808' )
           WHERE ( a~Batch = @witem-a-Batch and a~Material = @witem-a-Material )   into @bags.

   SELECT SINGLE c~CharcFromDecimalValue FROM I_BatchDistinct as a
           LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as c on ( c~ClassType = '023' and c~ClfnObjectTable = 'MCH1'
           and c~ClfnObjectInternalID = a~ClfnObjectInternalID and c~CharcInternalID = '0000000809' )
           WHERE ( a~Batch = @witem-a-Batch and a~Material = @witem-a-Material )   into @cones.

  ELSEIF SY-SYSID = 'Z6L'.

    SELECT SINGLE a~ClfnObjectInternalID , c~CharcValue  FROM I_BatchDistinct as a
           LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as c on ( c~ClassType = '023' and c~ClfnObjectTable = 'MCH1'
           and c~ClfnObjectInternalID = a~ClfnObjectInternalID and c~CharcInternalID = '0000000806' )
           WHERE ( a~Batch = @iv-a-Batch and a~Material = @iv-a-Material ) into @lotno.

    SELECT SINGLE c~CharcFromDecimalValue FROM I_BatchDistinct as a
           LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as c on ( c~ClassType = '023' and c~ClfnObjectTable = 'MCH1'
           and c~ClfnObjectInternalID = a~ClfnObjectInternalID and c~CharcInternalID = '0000000808' )
           WHERE ( a~Batch = @witem-a-Batch and a~Material = @witem-a-Material )   into @bags.

   SELECT SINGLE c~CharcFromDecimalValue FROM I_BatchDistinct as a
           LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as c on ( c~ClassType = '023' and c~ClfnObjectTable = 'MCH1'
           and c~ClfnObjectInternalID = a~ClfnObjectInternalID and c~CharcInternalID = '0000000809' )
           WHERE ( a~Batch = @witem-a-Batch and a~Material = @witem-a-Material )   into @cones.

 ENDIF.


 if iv-a-MaterialBaseUnit = 'ST' .
  unit = 'PC' .
 ELSE  .
  unit = iv-a-MaterialBaseUnit .
 ENDIF .

 tot = iv-a-QuantityInBaseUnit.
 tot1 = iv-d-OrderQuantity.
  lv_xml2 =
         |<Row1>| &&
*               |<SIGN>{ FOR }</SIGN>| &&
*               |<Cell1>{ it-Batch }</Cell1>| &&
               |<Matrial>{ iv-a-Material }</Matrial>| &&
               |<MatrialDescription>{ iv-b-ProductDescription }</MatrialDescription>| &&
               |<ItemText> { iv-a-MaterialDocumentItemText } </ItemText>| &&
               |<GRNQty>{ iv-d-OrderQuantity }</GRNQty>| &&
               |<BillQty>Si manu vacuas</BillQty>| &&
               |<UOM>{ unit }</UOM>| &&
              |<LotNo>{ lotno-CharcValue }</LotNo>| &&
              |<Bags>{ bags }</Bags>| &&
              |<Cones>{ cones }</Cones>| &&
               |<Batch>{ iv-a-Batch }</Batch>| &&
               |<OldMatrial>{ iv-c-ProductOldID }</OldMatrial>| &&
               |<PoQty>{ iv-a-QuantityInBaseUnit }</PoQty>| &&
               |<Plant> { iv-a-Plant } </Plant>| &&
               |<Storage> { iv-a-StorageLocation  } </Storage>| &&
               |<PartName> { iv-c-ProductManufacturerNumber }</PartName>| &&
            |</Row1>|
.
CONCATENATE xsml lv_xml2 into  xsml .
*clear  : lv_xml2,iv,unit.
endloop .



*
  lv_xml3 =
       |</Table1>| &&
       |</Table>| &&
       |</Page>| &&
       |</form1>|.

CONCATENATE lv_xml xsml lv_xml3 into lv_xml .

ENDIF.



   CALL METHOD ycl_test_adobe=>getpdf(
       EXPORTING
         xmldata  = LV_XML
         template = lc_template_name1
       RECEIVING
         result   = result12 ).

  ENDMETHOD.
ENDCLASS.
