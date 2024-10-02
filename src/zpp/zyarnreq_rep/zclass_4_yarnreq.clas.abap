CLASS zclass_4_yarnreq DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
   CLASS-METHODS : Yarn_req_data
   RETURNING VALUE(status)  TYPE string .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCLASS_4_YARNREQ IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

data(status) = yarn_req_data(  )  .
  ENDMETHOD.


  METHOD yarn_req_data.

types : begin of ty1 ,
        plant type werks_d ,
        vbeln type string ,
        so_item type n LENGTH 6 ,
        Components type string ,
        desc       type string ,
        req_qty    type p LENGTH 12 DECIMALS 2 ,
        Uom        type C LENGTH 3 ,
       sort_string  type string ,
        end of ty1 .


select
SalesOrder ,
SalesOrderItem ,
product ,
Plant ,
OrderQuantity ,
OrderQuantityUnit

 from
 I_SALESORDERITEM where SalesOrder =  '0070000004' into table @data(it_sales)       .

loop at it_sales into DATA(wa_sales)   .












endloop .








  ENDMETHOD.
ENDCLASS.
