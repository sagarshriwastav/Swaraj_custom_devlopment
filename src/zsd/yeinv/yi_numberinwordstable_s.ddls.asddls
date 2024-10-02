@EndUserText.label: 'NUMBER IN WORDS TABLE Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity YI_NumberInWordsTable_S
  as select from I_Language
    left outer join YNUM_WORDS on 0 = 0
  composition [0..*] of YI_NumberInWordsTable as _NumberInWordsTable
{
  key 1 as SingletonID,
  _NumberInWordsTable,
  max( YNUM_WORDS.LOCAL_LAST_CHANGED_AT ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
