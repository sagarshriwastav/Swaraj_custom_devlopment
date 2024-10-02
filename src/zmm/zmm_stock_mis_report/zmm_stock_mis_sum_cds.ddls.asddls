@AbapCatalog.sqlViewName: 'YMISSUM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMM_STOCK_MIS_SUM_CDS'
define view ZMM_STOCK_MIS_SUM_CDS
with parameters
     p_fromdate : abap.dats,
    p_todate   : abap.dats
 as select from ZMM_STOCK_MIS_RECEIPT_QTY( p_fromdate:$parameters.p_fromdate , p_todate:$parameters.p_todate) as a
 left outer join ZMM_OPENING_SUM( p_fromdate:$parameters.p_fromdate ) as opening on ( opening.ProductType = a.ProductType
                                                                                              and opening.Plant = a.Plant )
 left outer join ZMM_STOCK_MIS_REP_FIN_CDS( p_fromdate:$parameters.p_todate ) as closing  on ( closing.ProductType = a.ProductType 
                                                                                              and closing.Plant = a.Plant )
{
    key opening.ProductType ,
    key opening.Plant,
        opening.MaterialBaseUnit,
     //    a.MaterialBaseUnit1,
    //     cast( 'M' as abap.unit( 3 ) ) as  MaterialBaseUnit,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        opening.Openingqty as Openingqty,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        closing.Closingqty as Closingqty,
    
    
    
 
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    sum(Receiptqty) as Receiptqty,
     @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    sum(Issueqty) as Issueqty,
    CompanyCodeCurrency,
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    sum(a.RECEIPTVALUE) as RECEIPTVALUE,
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    sum(a.issuevalue) as issuevalue
   
   
}where opening.ProductType = 'ZFFO' or opening.ProductType = 'ZYRP' or opening.ProductType = 'ZSDC'
     or opening.ProductType = 'ZGFO' or opening.ProductType = 'ZPDM' or opening.ProductType = 'ZFFP' or opening.ProductType = 'ZYGT'
      or opening.ProductType = 'ZSSP' or opening.ProductType = 'ZSPS' or opening.ProductType = 'ZSCB' or opening.ProductType = 'ZUSW'

  group by opening.ProductType,
           opening.Plant,
           opening.MaterialBaseUnit,
           CompanyCodeCurrency,
           opening.Openingqty,
           closing.Closingqty,
           Receiptqty,
           Issueqty
