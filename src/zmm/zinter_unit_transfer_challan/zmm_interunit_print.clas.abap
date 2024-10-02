CLASS zmm_interunit_print DEFINITION
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
    CONSTANTS lc_template_name TYPE string VALUE 'Unit_transfer_challan/Unit_transfer_challan'.

ENDCLASS.



CLASS ZMM_INTERUNIT_PRINT IMPLEMENTATION.


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

select SINGLE * from  zmm_gr_print WITH PRIVILEGED ACCESS  where MaterialDocument = @matdoc  into @data(it) .

SELECT * from  I_MaterialDocumentItem_2 WITH PRIVILEGED ACCESS as a
left outer join I_ProductDescription WITH PRIVILEGED ACCESS as b on   ( b~Product  = a~Material and b~Language = 'E' )
where a~MaterialDocument = @matdoc   into table @data(item1)  .

sort item1  by a-materialdocumentitem .
DELETE ADJACENT DUPLICATES FROM ITEM1 COMPARING A-MaterialDocument A-MaterialDocumentItem  .

select single * from zsd_plant_address WITH PRIVILEGED ACCESS where PLANT = @it-Plant INTO @DATA(PLANTADD).


""""""""""""""""""""""""""""""""""""""""""""""""""""Plant Wise Address, GST & PAN"""""""""""""""""""""""""""""""""""
if PLANTADD-Plant  = '1100'.
DATA(gst1)  = '23AAHCS2781A1ZP'.
Data(pan1)  = 'AAHCS2781A'.
DATA(Register1) = 'SWARAJ SUITING LIMITED'.
Data(Register2) = 'Spinning Division-I, B-24 To B-41 Jhanjharwada Industrial Area' .
DATA(Register3) = ' Jhanjharwada, Neemuch - 458441, Madhya Pradesh, India'.
DATA(cin1) = 'L18101RJ2003PLC018359'.
Data(Plantname) = 'Spinning Division-I'.
elseif PLANTADD-Plant  = '1200'.
 gst1  = '23AAHCS2781A1ZP'.
 pan1  = 'AAHCS2781A'.
 Register1 = 'SWARAJ SUITING LIMITED'.
 Register2 = 'Denim Division-I, B-24 To B-41 Jhanjharwada Industrial Area' .
 Register3 = 'Jhanjharwada, Neemuch - 458441, Madhya Pradesh, India'.
 cin1 = 'L18101RJ2003PLC018359'.
 Plantname = 'Denim Division-I'.
elseif PLANTADD-Plant  = '1300'.
 gst1  = '08AAHCS2781A1ZH'.
 pan1  = 'AAHCS2781A'.
 Register1 = 'SWARAJ SUITING LIMITED'.
 Register2 = 'Weaving Division-I, F-483 To F-487 RIICO Growth Centre' .
 Register3 = 'Hamirgarh, Bhilwara-311025, Rajasthan, India'.
 cin1 = 'L18101RJ2003PLC018359'.
 Plantname = 'Weaving Division-I'.
elseif PLANTADD-Plant  = '1310'.
 gst1  = '23AAHCS2781A1ZP'.
 pan1  = 'AAHCS2781A'.
 Register1 = 'SWARAJ SUITING LIMITED'.
 Register2 = 'Weaving Division-II, B-24 To B-41 Jhanjharwada Industrial Area' .
 Register3 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
 cin1 = 'L18101RJ2003PLC018359'.
 Plantname ='Weaving Division-II'.
elseif PLANTADD-Plant  = '1400'.
 gst1  = '23AAHCS2781A1ZP'.
 pan1  = 'AAHCS2781A'.
 Register1 = 'SWARAJ SUITING LIMITED'.
 Register2 = 'Process House-I, B-24 To B-41 Jhanjharwada Industrial Area' .
 Register3 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
 cin1 = 'L18101RJ2003PLC018359'.
 Plantname = 'Process House-I'.
elseif PLANTADD-Plant  = '2100'.
 gst1  = '08AABCM5293P1ZT'.
 pan1  = 'AABCM5293P'.
 Register1 = 'MODWAY SUITING PVT. LIMITED'.
 Register2 = 'Weaving Division-I, 20th Km Stone, Chittorgarh Road' .
 Register3 = 'Takhatpura, Bhilwara-311025, Rajasthan, India'.
 cin1 = 'U18108RJ1986PTC003788'.
 Plantname = 'Weaving Division-I'.
elseif PLANTADD-Plant  = '2200'.
 gst1  = '23AABCM5293P1Z1'.
 pan1  = 'AABCM5293P'.
 Register1 = 'MODWAY SUITING PVT. LIMITED'.
 Register2 = 'Weaving Division-II, B-24 To B-41 Jhanjharwada Industrial Area' .
 Register3 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
 cin1 = 'U18108RJ1986PTC003788'.
 Plantname = 'Weaving Division-II'.
ENDIF.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
READ TABLE ITEM1 INTO DATA(WITEM)  INDEX 1 .

 IF SY-SYSID = 'XMV'.
    SELECT SINGLE * FROM I_BatchDistinct as a
         LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as c on ( c~ClassType = '023' and c~ClfnObjectTable = 'MCH1'
         and c~ClfnObjectInternalID = a~ClfnObjectInternalID and c~CharcInternalID = '0000000819' )
         LEFT OUTER JOIN ZI_ClfnCharcValueDesc_cds as h on ( h~mil = c~CharcValue and h~CharcInternalID = '0000000819' and h~Language = 'E' )
         WHERE ( a~Batch = @witem-a-Batch and a~Material = @witem-a-Material )   into @DATA(millname).
 ELSEIF SY-SYSID = 'XWL'.
    SELECT SINGLE * FROM I_BatchDistinct as a
         LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as c on ( c~ClassType = '023' and c~ClfnObjectTable = 'MCH1'
         and c~ClfnObjectInternalID = a~ClfnObjectInternalID and c~CharcInternalID = '0000000806' )
         LEFT OUTER JOIN ZI_ClfnCharcValueDesc_cds as h on ( h~mil = c~CharcValue and h~CharcInternalID = '0000000806' and h~Language = 'E' )
         WHERE ( a~Batch = @witem-a-Batch and a~Material = @witem-a-Material )   into @millname.
 ELSEIF SY-SYSID = 'Z6L'.
    SELECT SINGLE * FROM I_BatchDistinct as a
         LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as c on ( c~ClassType = '023' and c~ClfnObjectTable = 'MCH1'
         and c~ClfnObjectInternalID = a~ClfnObjectInternalID and c~CharcInternalID = '0000000807' )
         LEFT OUTER JOIN ZI_ClfnCharcValueDesc_cds as h on ( h~mil = c~CharcValue and h~CharcInternalID = '0000000807' and h~Language = 'E' )
         WHERE ( a~Batch = @witem-a-Batch and a~Material = @witem-a-Material )   into @millname.
 ENDIF.

   select single PersonFullName from I_BusinessUserBasic where UserID = @it-CreatedByUser into @data(person).
   SELECT SINGLE * FROM I_CostCenterText WHERE CostCenter  =  @witem-a-costcenter AND Language = 'E' INTO @DATA(text)  .

loop at item1 into witem.
if WITEM-a-DebitCreditCode = 'H'.
data(location) = WITEM-a-StorageLocation.
ENDIF..
if WITEM-a-DebitCreditCode = 'S'.
data(location1)  = WITEM-a-StorageLocation.
endif.
SELECT SINGLE StorageLocationName from I_StorageLocation where  StorageLocation =  @location  INTO @DATA(storagename).
SELECT SINGLE StorageLocationName from I_StorageLocation where  StorageLocation =  @location1  INTO @DATA(storagename1).
endloop.

SELECT SINGLE goodsmovementtypename FROM i_goodsmovementtypet WHERE goodsmovementtype = @witem-a-goodsmovementtype AND language = 'E' INTO @DATA(goodsmove).


DATA lc_template_name1 TYPE string .

 DATA: LEN TYPE C.
 LEN = witem-a-Material+0(6)..
 DATA(YARN) = LEN+0(1).

 IF YARN NE 'Y'.
 lc_template_name1 = 'Unit_Challan_Store_New/Unit_Challan_Store_New'.

* DATA(lv_xml) =
 DATA(lv_xml) =
   |<form1>| &&
   |<Subform1>| &&
      |<head>| &&
         |<CIN>{ cin1  }</CIN>| &&
         |<GST>{ gst1  }</GST>| &&
         |<PAN>{ pan1 }</PAN>| &&
      |</head>| &&
      |<adress3></adress3>| &&
      |<address2>{ Register3  }</address2>| &&
      |<address1>{ Register2 }</address1>| &&
      |<Platname>{ Register1 }</Platname>| &&
   |</Subform1>| &&
   |<Subform2>| &&
      |<Left>| &&
         |<reservation>{ WITEM-a-Reservation }</reservation>| &&
         |<plant>{ WITEM-a-Plant }-{ Plantname }</plant>| &&
         |<plantname></plantname>| &&
         |<dispatchfrom>{ location }</dispatchfrom>| &&
         |<storagename>{ storagename }</storagename>| &&
         |<ReceivingLocation>{ location1 }</ReceivingLocation>| &&
         |<storagename1>{ storagename1 }</storagename1>| &&
      |</Left>| &&
      |<right>| &&
         |<DocNo>{ WITEM-a-MaterialDocument }</DocNo>| &&
         |<DateDate>{ WITEM-a-DocumentDate  }</DateDate>| &&
         |<Printedon>{ WITEM-a-Reservation }</Printedon>| &&   "reservation number
         |<MovementType>{ WITEM-a-GoodsMovementType }-{ goodsmove  }</MovementType>| &&
         |<costcenter>{ WITEM-a-CostCenter  }</costcenter>| &&
          |<TextField1>{ text-CostCenterDescription }</TextField1>| &&
           |<Order_No>{ witem-a-OrderID }</Order_No>| &&
      |</right>| &&
      |</Subform2>|.

*data xsml type string .
data xlml1 type string .
 loop at item1 into data(iv) .

    if iv-a-DebitCreditCode = 'S' or iv-a-GoodsMovementType = '201' or iv-a-GoodsMovementType = '261' .
     data(BATCH_NO)  = iv-a-BATCH.


if iv-a-MaterialBaseUnit = 'ST' .

 data(unit) = 'PC' .

ELSE  .

unit = iv-a-MaterialBaseUnit .

ENDIF .

 data tot type string.
data tot1 type string.
data tot2 type string.

 tot = iv-a-QuantityInBaseUnit.
* tot1 = iv-d-OrderQuantity.

*  DATA(lv_xml1) =
   lv_xml = lv_xml &&
     |<table>| &&
      |<matrial>{ iv-a-Material }</matrial>| &&
      |<matrialdec>{ iv-b-ProductDescription }</matrialdec>| &&
      |<OldMatrial></OldMatrial>| &&
      |<Partno></Partno>| &&
      |<ITEMTEXT></ITEMTEXT>| &&
      |<Qty>{ iv-a-QuantityInBaseUnit  }</Qty>| &&
      |<UOM>{ unit }</UOM>| &&
      |<Date>{ BATCH_NO  }</Date>| &&   """""""" batch
      |<TOTALAMOUNT>{ iv-a-SalesOrder } / { iv-a-SalesOrderItem }</TOTALAMOUNT>| &&     """""""sales order
      |<itemtext></itemtext>| &&
   |</table>|.

endif.
endloop .


*data(lv_xml4) =
 lv_xml = lv_xml &&
      |<footer>| &&
      |<partysign>{ person }</partysign>| &&
      |<authsign></authsign>| &&
      |</footer>| &&
      |</form1>|.

* CONCATENATE lv_xml  lv_xml1 lv_xml4 into lv_xml .
*REPLACE ALL OCCURRENCES OF '&' IN lv_xml WITH 'and'.

 ELSEIF YARN = 'Y'.
 lc_template_name1 = 'Unit_Transfer_Challan_Y/Unit_Transfer_Challan_Y'.

lv_xml =
  |<form1>| &&
   |<Subform1>| &&
      |<head>| &&
         |<CIN>{ cin1  }</CIN>| &&
         |<GST>{ gst1  }</GST>| &&
         |<PAN>{ pan1 }</PAN>| &&
      |</head>| &&
      |<adress3></adress3>| &&
      |<address2>{ Register3  }</address2>| &&
      |<address1>{ Register2 }</address1>| &&
      |<Platname>{ Register1 }</Platname>| &&
   |</Subform1>| &&
   |<Subform2>| &&
      |<Left>| &&
         |<reservation>{ WITEM-a-Reservation }</reservation>| &&
         |<plant>{ WITEM-a-Plant }-{ Plantname }</plant>| &&
         |<plantname></plantname>| &&
         |<dispatchfrom>{ location }</dispatchfrom>| &&
         |<storagename>{ storagename }</storagename>| &&
         |<ReceivingLocation>{ location1 }</ReceivingLocation>| &&
         |<storagename1>{ storagename1 }</storagename1>| &&
      |</Left>| &&
      |<right>| &&
         |<DocNo>{ WITEM-a-MaterialDocument }</DocNo>| &&
         |<DateDate>{ WITEM-a-DocumentDate  }</DateDate>| &&
         |<Printedon>{ WITEM-a-Reservation }</Printedon>| &&   "reservation number
         |<MovementType>{ WITEM-a-GoodsMovementType }-{ goodsmove  }</MovementType>| &&
         |<costcenter>{ WITEM-a-CostCenter  }</costcenter>| &&
          |<TextField1>{ text-CostCenterDescription }</TextField1>| &&
      |</right>| &&
      |</Subform2>|.

data xsml type string.
  loop at item1 into iv .

IF SY-SYSID = 'XMV'.
    SELECT SINGLE a~ClfnObjectInternalID , c~CharcValue  FROM I_BatchDistinct as a
            LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as c on ( c~ClassType = '023' and c~ClfnObjectTable = 'MCH1'
            and c~ClfnObjectInternalID = a~ClfnObjectInternalID and c~CharcInternalID = '0000000818' )
            WHERE ( a~Batch = @iv-a-Batch and a~Material = @iv-a-Material )  into @DATA(lotno).


    SELECT SINGLE c~CharcFromDecimalValue , a~batch , a~material  FROM I_BatchDistinct as a
           LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as c on ( c~ClassType = '023' and c~ClfnObjectTable = 'MCH1'
           and c~ClfnObjectInternalID = a~ClfnObjectInternalID and c~CharcInternalID = '0000000814' )
           WHERE ( a~Batch = @iv-a-Batch and a~Material = @iv-a-Material )   into @DATA(bags).

  if iv-a-DebitCreditCode = 'H'.
   SELECT SINGLE QuantityInBaseUnit from I_MaterialDocumentItem_2 where batch = @iv-a-Batch and material = @bags-material
           and goodsmovementtype = '101'   into @data(totqty)  .
         data(BagsNo) = bags-CharcFromDecimalValue * iv-a-QuantityInBaseUnit / totqty.


   SELECT SINGLE c~CharcFromDecimalValue FROM I_BatchDistinct as a
          LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as c on ( c~ClassType = '023' and c~ClfnObjectTable = 'MCH1'
          and c~ClfnObjectInternalID = a~ClfnObjectInternalID and c~CharcInternalID = '0000000815' )
          WHERE ( a~Batch = @iv-a-Batch and a~Material = @iv-a-Material )   into @DATA(cones).
        data(ConeNo) = cones * iv-a-QuantityInBaseUnit / totqty.
   endif.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 ELSEIF SY-SYSID = 'XWL'.
    SELECT SINGLE a~ClfnObjectInternalID , c~CharcValue  FROM I_BatchDistinct as a
            LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as c on ( c~ClassType = '023' and c~ClfnObjectTable = 'MCH1'
            and c~ClfnObjectInternalID = a~ClfnObjectInternalID and c~CharcInternalID = '0000000807' )
            WHERE ( a~Batch = @iv-a-Batch and a~Material = @iv-a-Material )  into @lotno.


    SELECT SINGLE c~CharcFromDecimalValue , a~batch , a~material  FROM I_BatchDistinct as a
           LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as c on ( c~ClassType = '023' and c~ClfnObjectTable = 'MCH1'
           and c~ClfnObjectInternalID = a~ClfnObjectInternalID and c~CharcInternalID = '0000000808' )
           WHERE ( a~Batch = @iv-a-Batch and a~Material = @iv-a-Material )   into @bags.

  if iv-a-DebitCreditCode = 'H'.
   SELECT SINGLE QuantityInBaseUnit from I_MaterialDocumentItem_2 where batch = @bags-Batch and material = @bags-material
           and goodsmovementtype = '101'  into @totqty  .
         BagsNo = bags-CharcFromDecimalValue * iv-a-QuantityInBaseUnit / totqty.

   SELECT SINGLE c~CharcFromDecimalValue FROM I_BatchDistinct as a
          LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as c on ( c~ClassType = '023' and c~ClfnObjectTable = 'MCH1'
          and c~ClfnObjectInternalID = a~ClfnObjectInternalID and c~CharcInternalID = '0000000809' )
          WHERE ( a~Batch = @iv-a-Batch and a~Material = @iv-a-Material )   into @cones.
        ConeNo = cones * iv-a-QuantityInBaseUnit / totqty.
   endif.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  ELSEIF SY-SYSID = 'Z6L'.
      SELECT SINGLE a~ClfnObjectInternalID , c~CharcValue  FROM I_BatchDistinct as a
            LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as c on ( c~ClassType = '023' and c~ClfnObjectTable = 'MCH1'
            and c~ClfnObjectInternalID = a~ClfnObjectInternalID and c~CharcInternalID = '0000000806' )
            WHERE ( a~Batch = @iv-a-Batch and a~Material = @iv-a-Material )  into @lotno.


     SELECT SINGLE c~CharcFromDecimalValue , a~batch , a~material  FROM I_BatchDistinct as a
           LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as c on ( c~ClassType = '023' and c~ClfnObjectTable = 'MCH1'
           and c~ClfnObjectInternalID = a~ClfnObjectInternalID and c~CharcInternalID = '0000000808' )
           WHERE ( a~Batch = @iv-a-Batch and a~Material = @iv-a-Material )   into @bags.

  if iv-a-DebitCreditCode = 'H'.
     SELECT SINGLE QuantityInBaseUnit from I_MaterialDocumentItem_2 where batch = @bags-Batch and material = @bags-material
           and goodsmovementtype = '101'  into @totqty  .
         BagsNo = bags-CharcFromDecimalValue * iv-a-QuantityInBaseUnit / totqty.

   SELECT SINGLE c~CharcFromDecimalValue FROM I_BatchDistinct as a
          LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as c on ( c~ClassType = '023' and c~ClfnObjectTable = 'MCH1'
          and c~ClfnObjectInternalID = a~ClfnObjectInternalID and c~CharcInternalID = '0000000809' )
          WHERE ( a~Batch = @iv-a-Batch and a~Material = @iv-a-Material )   into @cones.
        ConeNo = cones * iv-a-QuantityInBaseUnit / totqty.
   endif.
 ENDIF.

   if iv-a-DebitCreditCode = 'S'.
     BATCH_NO  = iv-a-BATCH.
     data(so)        = iv-a-SalesOrder.
     data(so_no)     = iv-a-SalesOrderItem.
*    endif.

if iv-a-MaterialBaseUnit = 'ST' .

 unit = 'PC' .

ELSE  .

unit = iv-a-MaterialBaseUnit .

ENDIF .

 tot = iv-a-QuantityInBaseUnit.
* tot1 = iv-d-OrderQuantity.

* lv_xml1 =
 lv_xml = lv_xml &&
     |<table>| &&
      |<matrial>{ iv-a-Material }</matrial>| &&
      |<matrialdec>{ iv-b-ProductDescription }</matrialdec>| &&
      |<OldMatrial></OldMatrial>| &&
      |<Partno></Partno>| &&
      |<ITEMTEXT></ITEMTEXT>| &&
      |<Qty>{ iv-a-QuantityInBaseUnit  }</Qty>| &&
      |<UOM>{ unit }</UOM>| &&
      |<Date>{ BATCH_NO }</Date>| &&   """""""" batch
      |<bags>{ bagsno }</bags>| &&
      |<cones>{ ConeNo }</cones>| &&
      |<TOTALAMOUNT>{ so } / { so_no }</TOTALAMOUNT>| &&     """""""sales order
      |<itemtext></itemtext>| &&
   |</table>|.

endif.

endloop .


* lv_xml4 =
 lv_xml = lv_xml &&
      |<footer>| &&
      |<partysign>{ person }</partysign>| &&
      |<authsign></authsign>| &&
      |</footer>| &&
      |</form1>|.



* CONCATENATE lv_xml  lv_xml1 lv_xml4 into lv_xml .

 ENDIF.


    CALL METHOD ycl_test_adobe=>getpdf(
       EXPORTING
         xmldata  = LV_XML
         template = lc_template_name1
       RECEIVING
         result   = result12 ).

  ENDMETHOD.
ENDCLASS.
