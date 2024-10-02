@EndUserText.label: 'Copy ZPACKD SCREEN TABLE'
define abstract entity ZD_CopyZpackdGRAD
{
  @EndUserText.label: 'New Werks'
  Werks : abap.char( 4 );
  @EndUserText.label: 'New Prctr'
  Prctr : abap.char( 10 );
  @EndUserText.label: 'New Grade'
  Grade : abap.char( 3 );
  
}
