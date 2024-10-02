@EndUserText.label: 'NUMBER IN WORDS TABLE'
@AccessControl.authorizationCheck: #CHECK
define view entity YI_NumberInWordsTable
  as select from YNUM_WORDS
  association to parent YI_NumberInWordsTable_S as _NumberInWordsTabAll on $projection.SingletonID = _NumberInWordsTabAll.SingletonID
{
  key VALUE as Value,
  WORDS as Words,
  CREATED_BY as CreatedBy,
  CREATED_AT as CreatedAt,
  LAST_CHANGED_BY as LastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LAST_CHANGED_AT as LastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  LOCAL_LAST_CHANGED_AT as LocalLastChangedAt,
  1 as SingletonID,
  _NumberInWordsTabAll
  
}
