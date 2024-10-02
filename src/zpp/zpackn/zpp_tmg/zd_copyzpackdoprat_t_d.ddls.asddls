@EndUserText.label: 'Copy ZPACKD SCREEN TABLE'
define abstract entity ZD_CopyZpackdOPRAT_T_D
{
  @EndUserText.label: 'New Bukrs'
  Bukrs : abap.char( 4 );
  @EndUserText.label: 'New Plant'
  Plant : abap.char( 4 );
  @EndUserText.label: 'Emp Num'
  Empcode : abap.char(10) ;
}
