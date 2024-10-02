CLASS zsd_domestic_packinglist_frc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  INTERFACES if_oo_adt_classrun .

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


    CLASS-DATA : access_token TYPE string .
    CLASS-DATA : xml_file TYPE string .
    CLASS-DATA : template TYPE string .
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
        IMPORTING VALUE(variable) TYPE string
                  VALUE(variable1) TYPE string
*                  VALUE(year) TYPE string


        RETURNING VALUE(result12) TYPE string
        RAISING   cx_static_check .




  PROTECTED SECTION.
  PRIVATE SECTION.

     CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
    CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
    CONSTANTS  lv2_url    TYPE string VALUE 'https://btp-yvzjjpaz.authentication.eu10.hana.ondemand.com/oauth/token' .
    CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
    CONSTANTS lc_template_name TYPE string VALUE 'ZSD_DOMESTIC_PACKING_LIST/ZSD_DOMESTIC_PACKING_LIST'.

ENDCLASS.



CLASS ZSD_DOMESTIC_PACKINGLIST_FRC IMPLEMENTATION.


  METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).

  ENDMETHOD .


  METHOD if_oo_adt_classrun~main.



    DATA(xml)  = read_posts( variable = '0080000330' variable1 = '0080000330'  )   .


  ENDMETHOD.


   METHOD read_posts .


    DATA:LV  TYPE  C LENGTH 100   .
     DATA VAR1 TYPE ZCHAR10.
     DATA VAR2 TYPE ZCHAR10.
        VAR1 = variable.
        VAR1 =   |{ VAR1  ALPHA = IN }| .
        VAR2 = variable1.
        VAR2 =   |{ VAR2  ALPHA = IN }| .

IF VAR1 IS NOT INITIAL AND VAR2 IS INITIAL .

VAR2 = VAR1 .

ENDIF.


*         select * from I_DeliveryDocument
*         where DeliveryDocument BETWEEN  @VAR1 AND @VAR2 INTO TABLE @DATA(IT_FORM) .

*        DELETE ADJACENT DUPLICATES FROM  IT_FORM COMPARING  DeliveryDocument .
         data   lv_xml type string.

*  lv_xml  =
*         |<Form>| .

*  LOOP AT IT_FORM INTO DATA(WA_FORM) .




         select A~*,
                B~*,
                @LV   AS LV,
                C~*
         from I_DeliveryDocumentItem as a
         LEFT OUTER JOIN I_DeliveryDocument as b ON ( b~DeliveryDocument = A~DeliveryDocument )
         LEFT OUTER JOIN zpp_frc_tab AS C ON  ( RecBatch = A~Batch )
         where
            a~DeliveryDocument = @VAR1 INTO TABLE @DATA(it) .

        DELETE it where a-Batch = ''.
         READ TABLE It INTO DATA(WA) INDEX 1.


 SELECT SINGLE b~taxnumber3,
 b~customer,
 b~TelephoneNumber1,
 c~organizationname1,
 c~organizationname2,
 c~organizationname3,
 c~housenumber,
 c~streetname,
 c~streetprefixname1,
 c~streetprefixname2,
 c~streetsuffixname1,
 c~streetsuffixname2,
 c~districtname,
 c~cityname,
 c~postalcode,
 c~addresssearchterm1,
 d~regionname
 FROM i_salesdocumentpartner AS a
 LEFT JOIN i_customer AS b ON ( b~customer = a~customer )
 LEFT JOIN ZI_DeliveryDocumentAddress2 WITH PRIVILEGED ACCESS AS c ON ( c~addressid = a~addressid )
 LEFT JOIN i_regiontext AS d ON ( d~region = b~region AND d~language = 'E' AND d~country = 'IN ')
* left join I_Region as D on ( D~Region = a~ )
 WHERE salesdocument = @wa-A-ReferenceSDDocument AND partnerfunction = 'WE' INTO @DATA(shiptoparty).

 wa_add-var1 = shiptoparty-organizationname1.
 wa_add-var2 = shiptoparty-organizationname2.
 wa_add-var3 = shiptoparty-organizationname3.

 DATA(shipaddname) = zseparate_address=>separate( CHANGING var = wa_add ).

 wa_add-var1 = shiptoparty-housenumber.
 wa_add-var2 = shiptoparty-streetname.
 wa_add-var3 = shiptoparty-streetprefixname1.
 wa_add-var4 = shiptoparty-streetprefixname2.
 wa_add-var5 = shiptoparty-streetsuffixname1.
 wa_add-var6 = shiptoparty-streetsuffixname2.

 DATA(shipaddhono) = zseparate_address=>separate( CHANGING var = wa_add ).

 wa_add-var1 = shiptoparty-cityname.
* wa_add-var2 = shiptoparty-districtname.
 wa_add-var3 = shiptoparty-postalcode.

 DATA(shipaddcity) = zseparate_address=>separate( CHANGING var = wa_add ).

  wa_add-var1 = shiptoparty-cityname.

 DATA(shipaddcity1) = zseparate_address=>separate( CHANGING var = wa_add ).

  SELECT SINGLE b~taxnumber3,
 b~customer,
 b~TelephoneNumber1,
 c~organizationname1,
 c~organizationname2,
 c~organizationname3,
 c~housenumber,
 c~streetname,
 c~streetprefixname1,
 c~streetprefixname2,
 c~streetsuffixname1,
 c~streetsuffixname2,
 c~districtname,
 c~cityname,
 c~postalcode,
 c~addresssearchterm1,
 d~regionname
 FROM i_salesdocumentpartner AS a
 LEFT JOIN i_customer AS b ON ( b~customer = a~customer )
 LEFT JOIN i_address_2 WITH PRIVILEGED ACCESS AS c ON ( c~addressid = b~addressid )
 LEFT JOIN i_regiontext AS d ON ( d~region = b~region AND d~language = 'E' AND d~country = 'IN ')
* left join I_Region as D on ( D~Region = a~ )
 WHERE salesdocument = @wa-A-ReferenceSDDocument AND partnerfunction = 'RE' INTO @DATA(BilLtoparty).

 wa_add-var1 = BilLtoparty-organizationname1.
 wa_add-var2 = BilLtoparty-organizationname2.
 wa_add-var3 = BilLtoparty-organizationname3.

 DATA(Billaddname) = zseparate_address=>separate( CHANGING var = wa_add ).

 wa_add-var1 = BilLtoparty-housenumber.
 wa_add-var2 = BilLtoparty-streetname.
 wa_add-var3 = BilLtoparty-streetprefixname1.
 wa_add-var4 = BilLtoparty-streetprefixname2.
 wa_add-var5 = BilLtoparty-streetsuffixname1.
 wa_add-var6 = BilLtoparty-streetsuffixname2.

 DATA(Billaddhono) = zseparate_address=>separate( CHANGING var = wa_add ).

 wa_add-var1 = BilLtoparty-cityname.
* wa_add-var2 = shiptoparty-districtname.
 wa_add-var3 = BilLtoparty-postalcode.

 DATA(Billaddcity) = zseparate_address=>separate( CHANGING var = wa_add ).

  SELECT SINGLE FULLNAME
 FROM i_salesdocumentpartner
 WHERE salesdocument = @wa-A-ReferenceSDDocument AND partnerfunction = 'ZT' INTO @DATA(transporter).

         select single * from I_SalesDocumentItem where SalesDocument = @wa-a-ReferenceSDDocument
                                                       and plant = @wa-a-Plant into @data(sales).



     lv_xml =
            |<Form>| &&
*            |<bdyMain>| &&
            |<Subform1>| &&
               |<Subform4>| &&
                  |<BilltoParty>| &&
                     |<AddressLineBill1>{ Billaddname }</AddressLineBill1>| &&
                     |<AddressLineBill2>{ Billaddhono }</AddressLineBill2>| &&
                     |<AddressLineBill3>{ Billaddcity }</AddressLineBill3>| &&
                     |<AddressLineBill4>{ BilLtoparty-DistrictName }</AddressLineBill4>| &&
                     |<AddressLineBill5></AddressLineBill5>| &&
                     |<AddressLineBill6>{ BilLtoparty-RegionName }</AddressLineBill6>| &&
                  |</BilltoParty>| &&
                  |<ShipToParty>| &&
                     |<AddressLine1ship>{ shipaddname }</AddressLine1ship>| &&
                     |<AddressLine2ship>{ shipaddhono }</AddressLine2ship>| &&
                     |<AddressLine3ship>{ shipaddcity }</AddressLine3ship>| &&
                     |<AddressLine5ship>{ shiptoparty-districtname }</AddressLine5ship>| &&
                     |<AddressLine6ship></AddressLine6ship>| &&
                     |<AddressLine7ship>{ shiptoparty-regionname }</AddressLine7ship>| &&
                     |<AddressLine8ship></AddressLine8ship>| &&
                  |</ShipToParty>| &&
               |</Subform4>| &&
               |<TextSub>| &&
                  |<Subform7>| &&
                     |<terms>{ wa-b-IncotermsClassification }</terms>| &&
                     |<destination>{ shipaddcity }</destination>| &&
                     |<sddocument>{ wa-a-ReferenceSDDocument }</sddocument>| &&
                     |<TransporterName>{ transporter }</TransporterName>| &&
                  |</Subform7>| &&
               |</TextSub>| &&
            |</Subform1>| &&
             |<HIDDD>| &&
             |<DeliveryDocument>{ wa-a-DeliveryDocument }</DeliveryDocument>| &&
             |<Plant1>{ WA-a-Plant }</Plant1>| &&
             |<GoodsMovementDate>{ wa-b-ActualGoodsMovementDate }</GoodsMovementDate>| &&
             |</HIDDD>| &&
             |<Table2>| &&
             |<HeaderRow/>| .

   DATA MATDES TYPE STRING .
   DATA MENGE1 TYPE menge_d .
   DATA NETWT TYPE menge_d .
   DATA GWT TYPE menge_d .
   DATA CNT(3) TYPE C.
   DATA PC(3) TYPE C.

 DATA(it1) = it[].
DATA(it_FIN) = it[].
FREE:it_FIN[].
 LOOP AT IT1 ASSIGNING FIELD-SYMBOL(<fs>).
  IF <fs>-A-MaterialByCustomer IS NOT INITIAL .
      <fs>-A-MaterialByCustomer = <fs>-A-MaterialByCustomer .
     ELSE.
     <fs>-A-MaterialByCustomer =    <fs>-a-DeliveryDocumentItemText.
     ENDIF.

        <FS>-LV = | { <fs>-A-MaterialByCustomer } | .
        CONDENSE <FS>-LV NO-GAPS.
 ENDLOOP.
 DATA(it2) = it1[].
sORT IT2 ASCENDING BY A-MaterialByCustomer .
SORT IT1 ASCENDING BY A-MaterialByCustomer.
DELETE ADJACENT DUPLICATES FROM IT1 COMPARING A-MaterialByCustomer.
  DATA:VA TYPE C LENGTH 100.

  LOOP AT it1 ASSIGNING FIELD-SYMBOL(<ft>).
  LOOP AT iT2 INTO DATA(wt) WHERE LV = <ft>-lv.

  IF wt-C-gcgrosswt = 0 .
  wt-C-gcgrosswt = wt-C-baleqty.
  ENDIF.

  MENGE1 = MENGE1 + WT-a-OriginalDeliveryQuantity.
  NETWT = NETWT +  WT-c-totalwt.
  GWT =   GWT +  WT-c-gcgrosswt.

  CNT = CNT + 1.
  APPEND WT TO it_FIN.
  ENDLOOP.
  CLEAR:wt.


  wt-a-MaterialByCustomer = 'SUBTOTAL'.
  wt-a-OriginalDeliveryQuantity = MENGE1.
  wt-c-totalwt = NETWT.
  wt-c-gcgrosswt  = GWT.
  APPEND WT TO it_FIN.


  CLEAR:MENGE1,NETWT,GWT, PC,CNT.
  ENDLOOP.
  FREE IT[].
  IT[] = IT_FIN[].

  DATA MTRTOT TYPE menge_d .
  DATA NTWTTOT TYPE menge_d .
  DATA GWTTOT TYPE menge_d .
  DATA PCSTOT(3) TYPE  C.
  DATA SNO TYPE  C LENGTH 3.
  DATA SNO1 TYPE C LENGTH 3.

 LOOP AT It into data(wa_ga) .

  IF wa_ga-C-gcgrosswt = 0  .
  wa_ga-C-gcgrosswt = wa_ga-C-baleqty.
  ENDIF.

     IF wa_ga-a-MaterialByCustomer NE 'SUBTOTAL'   .
     SNO = SNO + 1.

     ENDIF.
     IF wa_ga-a-MaterialByCustomer = 'SUBTOTAL'.
     SNO1 = ''.
     MTRTOT =  MTRTOT + wa_ga-a-OriginalDeliveryQuantity .
     NTWTTOT  = NTWTTOT + wa_ga-C-totalwt .
     GWTTOT = GWTTOT  + wa_ga-C-gcgrosswt.
     ELSEIF  wa_ga-a-MaterialByCustomer NE 'SUBTOTAL'.
     SNO1 = SNO .

     SELECT SINGLE dyeingshade FROM zpp_sortmaster  WHERE material = @wa_ga-A-Material INTO @DATA(SHadeno).

     ENDIF.

     IF WA_GA-A-MaterialByCustomer IS NOT INITIAL .
       MATDES = WA_GA-A-MaterialByCustomer .
     ELSE.
     MATDES =    wa_ga-a-DeliveryDocumentItemText.
     ENDIF.




              lv_xml = lv_xml &&

            |<RowData>| &&
               |<SNO>{ SNO1 }</SNO>| &&
               |<description>{ MATDES }</description>| &&
               |<batch>{ wa_ga-a-Batch }</batch>| &&
               |<width></width>| &&
               |<mtr>{ wa_ga-a-OriginalDeliveryQuantity }</mtr>| &&
               |<netwt>{ wa_ga-C-totalwt }</netwt>| &&
               |<grosswt>{ wa_ga-C-gcgrosswt }</grosswt>| &&
               |<pcs></pcs>| &&
               |<Grade></Grade>| &&
               |<shade>{ SHadeno }</shade>| &&
               |<reamrk></reamrk>| &&
            |</RowData>| .
    CLEAR: SHadeno,wa_ga,MATDES .
   ENDLOOP.

            lv_xml = lv_xml &&
            |<RowData1>| &&
            |<MTRTOT>{ MTRTOT }</MTRTOT>| &&
            |<NTWTTOT>{ NTWTTOT }</NTWTTOT>| &&
            |<GWTTOT>{ GWTTOT }</GWTTOT>| &&
            |<PCSTOT>{ PCSTOT }</PCSTOT>| &&
            |</RowData1>| &&
            |</Table2>| &&
*            |</bdyMain>| &&
            |</Form>| .



    REPLACE ALL OCCURRENCES OF '&' IN lv_xml WITH 'and'.

  CALL METHOD ycl_test_adobe=>getpdf(
       EXPORTING
         xmldata  = LV_XML
         template = lc_template_name
       RECEIVING
         result   = result12 ).

  ENDMETHOD.
ENDCLASS.
