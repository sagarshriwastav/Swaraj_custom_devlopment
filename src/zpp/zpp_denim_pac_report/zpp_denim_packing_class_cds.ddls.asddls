@EndUserText.label: 'product demo data read via rfc from on prem'
@ObjectModel: {
    query: {
        implementedBy: 'ABAP:ZDENIM_PACKING_CLASS'
    }
}
//@EndUserText.label: 'product demo data read via rfc from on prem'
//@ObjectModel.query.implementedBy: 'ABAP:ZDENIM_PACKING_CLASS'

define  abstract entity ZPP_DENIM_PACKING_CLASS_CDS
{

 key  plant         : abap.char( 4 );
      TypeCode      : abap.char( 2 );
      @UI           : {
      lineItem      : [{position: 20, importance: #HIGH}],
      identification: [{position: 20}],
      selectionField: [{position: 20}]
      }
      rec_batch      : abap.char( 10 );
      @UI           : {
      lineItem      : [{position: 30, importance: #HIGH}],
      identification: [{position: 30}]
      }
      batch          : abap.char( 10 );
      @UI           : {
      lineItem      : [{position: 40, importance: #HIGH}],
      identification: [{position: 40}]
      }
      ftype         :abap.sstring( 100 ) ;
      
}
