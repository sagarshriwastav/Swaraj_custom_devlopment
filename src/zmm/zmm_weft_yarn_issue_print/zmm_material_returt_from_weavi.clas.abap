CLASS zmm_material_returt_from_weavi DEFINITION

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
                   vehicleno  type  string

        RETURNING VALUE(result12) TYPE string
        RAISING   cx_static_check .

  PROTECTED SECTION.
  PRIVATE SECTION.

    CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
    CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
    CONSTANTS  lv2_url    TYPE string VALUE 'https://btp-yvzjjpaz.authentication.eu10.hana.ondemand.com/oauth/token' .
    CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
    CONSTANTS lc_template_name TYPE string VALUE 'MATERIAL_RETURN_WEAVING_MM/ MATERIAL_RETURN_WEAVING_MM'.
ENDCLASS.



CLASS ZMM_MATERIAL_RETURT_FROM_WEAVI IMPLEMENTATION.


   METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).
   ENDMETHOD .


   METHOD if_oo_adt_classrun~main.
*DATA(TEST)  = READ_POSTS( matdoc = '5000000249'  year = ' ' )  .
*number_of_rolls2 = '16' order = '123432'  ) .
   ENDMETHOD.


  METHOD read_posts .

    SELECT * from  I_MaterialDocumentItem_2 as a
     left outer join  I_MaterialDocumentHeader_2 as b on ( a~MaterialDocument = b~MaterialDocument )
     left outer join I_ProductDescription as c on   ( a~Material = c~Product and c~Language = 'E' )
     WHERE a~MaterialDocument = @matdoc AND a~InventorySpecialStockType = 'E'
     and A~goodsmovementtype = '542' into table @data(item1)  .


    SORT item1  ASCENDING BY  a-materialdocumentitem.
    DELETE ADJACENT DUPLICATES FROM ITEM1 COMPARING a-MaterialDocument a-MaterialDocumentItem  .
    DELETE item1 WHERE A-MaterialDocument NE matdoc .
    READ TABLE ITEM1 INTO DATA(WA) INDEX 1.

    SELECT SINGLE * from I_Supplier where Supplier = @WA-a-Supplier into @data(tab_sup).
    SELECT SINGLE regionname from I_RegionText where Region = @tab_sup-Region AND Language = 'E' AND country = 'IN'  into @DATA(state).
    SELECT SINGLE ProductOldID, ProductManufacturerNumber from i_product where  Product = @wa-a-Material into @data(prod).
    SELECT SINGLE PurchaseOrderDate  from I_PurchaseOrderAPI01 where PurchaseOrder = @wa-a-PurchaseOrder into @data(CreateDt).
    Select SINGLE * from I_ProductDescription where Product = @wa-a-Material into @data(matrialdec).
    SELECT SINGLE * from zsd_plant_address WITH PRIVILEGED ACCESS where PLANT = @wa-a-Plant INTO @DATA(PLANTADD).
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
     ELSE.
        SELECT SINGLE * FROM I_BatchDistinct as a
             LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as c on ( c~ClassType = '023' and c~ClfnObjectTable = 'MCH1'
             and c~ClfnObjectInternalID = a~ClfnObjectInternalID and c~CharcInternalID = '0000000806' )
             LEFT OUTER JOIN ZI_ClfnCharcValueDesc_cds as h on ( h~mil = c~CharcValue and h~CharcInternalID = '0000000806' and h~Language = 'E' )
             WHERE ( a~Batch = @witem-a-Batch and a~Material = @witem-a-Material )   into @millname.
     ENDIF.

       SELECT SINGLE PersonFullName from I_BusinessUserBasic where UserID = @witem-b-CreatedByUser into @data(person).
       SELECT SINGLE * FROM I_CostCenterText WHERE CostCenter  =  @witem-a-costcenter AND Language = 'E' INTO @DATA(text)  .

       SELECT SINGLE GoodsMovementReasonCode from I_GoodsMovementCube WHERE MaterialDocument = @witem-a-MaterialDocument
              AND MaterialDocumentItem = @witem-a-MaterialDocumentItem INTO @DATA(GMRC).

**              IF GMRC = '0000'.
**               DATA(HEADER) = 'Material Issue For Job Weaving'.
**              ELSEIF GMRC = '0001'.
**                    HEADER = 'Material Issue For Loan' .
**                ELSE GMRC = '0001'.
                 DATA(HEADER) = 'Materil Return From Job Weaving' .
**                    ENDIF.

   LOOP AT item1 INTO witem.
    IF WITEM-a-DebitCreditCode = 'H'.
    DATA(location) = WITEM-a-StorageLocation.
    ENDIF..
    IF WITEM-a-DebitCreditCode = 'S'.
    DATA(location1)  = WITEM-a-StorageLocation.
    ENDIF.
    ENDLOOP.


   DATA lc_template_name1 TYPE string .

     lc_template_name1 =  'MATERIAL_RETURN_WEAVING_MM/MATERIAL_RETURN_WEAVING_M'.
     DATA(lv_xml) =
   |<form1>| &&
   |<Subform1>| &&
      |<Subform1>| &&
         |<head>| &&
            |<CIN>{ cin1 }</CIN>| &&
            |<GST>{ gst1 }</GST>| &&
            |<PAN>{ pan1 }</PAN>| &&
         |</head>| &&
          |<adress3>Mirum est</adress3>| &&
         |<Platname>{ register1 }</Platname>| &&
         |<adress3></adress3>| &&
         |<address2>{ Register3 }</address2>| &&
         |<address1>{ Register2 }</address1>| &&
      |</Subform1>| &&
      |<Subform5/>| &&
  |</Subform1>| &&
   |<Subform2>| &&
      |<Left>| &&
         |<PARTYTO>{ tab_sup-SupplierName }</PARTYTO>| &&
         |<PARTYTOADDR1>{ tab_sup-CityName }({ tab_sup-PostalCode })</PARTYTOADDR1>| &&
         |<Head></Head>| &&
         |<PARTYTOMADDR2>{ state }</PARTYTOMADDR2>| &&
         |<PARTYTOADDR3></PARTYTOADDR3>| &&
         |<PARTYTOfromLeft>| &&
            |<PARTYFrom>{ Register1 }</PARTYFrom>| &&
            |<PARTYFROMADDR1>{ Register2 }</PARTYFROMADDR1>| &&
            |<PARTFROMMADDR2>{ Register3 }</PARTFROMMADDR2>| &&
            |<PARTYFROMADDR3></PARTYFROMADDR3>| &&
         |</PARTYTOfromLeft>| &&
      |</Left>| &&
      |<right>| &&
         |<Sno></Sno>| &&
         |<DateDate>{ witem-b-DocumentDate }</DateDate>| &&
         |<Printedon>Ad retia sedebam</Printedon>| &&
         |<DOCUMENTNO>{ witem-b-MaterialDocument }</DOCUMENTNO>| &&
         |<TRKNO.>{ vehicleno }</TRKNO.>| &&
      |</right>| &&
   |</Subform2>|  .

     data xlml1 type string .
     loop at item1 into data(iv) .

         IF SY-SYSID = 'XMV'.
        SELECT SINGLE a~ClfnObjectInternalID , c~CharcValue  FROM I_BatchDistinct as a
                LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as c on ( c~ClassType = '023' and c~ClfnObjectTable = 'MCH1'
                and c~ClfnObjectInternalID = a~ClfnObjectInternalID and c~CharcInternalID = '0000000818' )
                WHERE ( a~Batch = @iv-a-Batch and a~Material = @iv-a-Material )  into @DATA(lotno).

        SELECT SINGLE c~CharcFromDecimalValue , a~batch , a~material  FROM I_BatchDistinct as a
               LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as c on ( c~ClassType = '023' and c~ClfnObjectTable = 'MCH1'
               and c~ClfnObjectInternalID = a~ClfnObjectInternalID and c~CharcInternalID = '0000000814' )
               WHERE ( a~Batch = @iv-a-Batch and a~Material = @iv-a-Material )   into @DATA(bags).

       SELECT SINGLE QuantityInBaseUnit from I_MaterialDocumentItem_2 where batch = @iv-a-Batch and material = @bags-material
               and goodsmovementtype = '101' or goodsmovementtype = '561'  into @data(totqty)  .
             data(BagsNo) = bags-CharcFromDecimalValue * iv-a-QuantityInBaseUnit / totqty.

       SELECT SINGLE c~CharcFromDecimalValue FROM I_BatchDistinct as a
              LEFT OUTER JOIN I_ClfnObjectCharcValForKeyDate as c on ( c~ClassType = '023' and c~ClfnObjectTable = 'MCH1'
              and c~ClfnObjectInternalID = a~ClfnObjectInternalID and c~CharcInternalID = '0000000815' )
              WHERE ( a~Batch = @iv-a-Batch and a~Material = @iv-a-Material )   into @DATA(cones).
            data(ConeNo) = cones * iv-a-QuantityInBaseUnit / totqty.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
     ELSE.
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
       ENDIF.
       ENDIF.

       SELECT SINGLE ConsumptionTaxCtrlCode FROM I_ProductPlantIntlTrd WHERE  Product = @iv-a-Material AND Plant = @PLANTADD-Plant INTO @DATA(HSN).

     data tot type string.
     data tot1 type string.
     data tot2 type string.

     tot = iv-a-QuantityInBaseUnit.
*     tot1 = iv-c-OrderQuantity.

*      SHIFT iv-a-Batch LEFT DELETING LEADING '0'.
      SHIFT iv-a-SalesOrder LEFT DELETING LEADING '0' .
      SHIFT iv-a-SalesOrderItem LEFT DELETING LEADING '0'.


    lv_xml = lv_xml &&
    |<table>| &&
      |<matrial>{ iv-a-Material }</matrial>| &&
      |<matrialdec>{ iv-c-ProductDescription }</matrialdec>| &&
      |<HSNSAC>{ HSN }</HSNSAC>| &&
      |<BATCH>{ iv-a-Batch }</BATCH>| &&
      |<MLLNAME>{ millName-h-CharcValueDescription }</MLLNAME>| &&
      |<LOTNO>{ lotno-CharcValue }</LOTNO>| &&
      |<REFSOSOITEM>{ iv-a-SalesOrder }/{ iv-a-SalesOrderItem }</REFSOSOITEM>| &&
      |<NOOFBAGS>{ bagsno }</NOOFBAGS>| &&
      |<NWTWT>{ iv-a-QuantityInBaseUnit }</NWTWT>| &&
   |</table>| .

    endloop .


           lv_xml = lv_xml &&
           |<HEADER>{ HEADER }</HEADER>| &&
            |<PrepareBy>{ person }</PrepareBy>| &&
           |</form1>| .



     CALL METHOD ycl_test_adobe=>getpdf(
       EXPORTING
         xmldata  = LV_XML
         template = lc_template_name1
       RECEIVING
         result   = result12 ).
      ENDMETHOD.
ENDCLASS.
