@AbapCatalog.sqlViewName: 'ZDELADD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For SD Document'
define view ZI_DeliveryDocumentAddress2 as select from I_Address_2 
{
  
  key AddressID,
  key AddressPersonID,
  key AddressRepresentationCode,
  AddressObjectType,
  CorrespondenceLanguage,
  PrfrdCommMediumType,
  AddresseeFullName,
  PersonGivenName,
  PersonFamilyName,
  OrganizationName1,
  OrganizationName2,
  OrganizationName3,
  OrganizationName4,
  AddressSearchTerm1,
  AddressSearchTerm2,
  CityNumber,
  CityName,
  DistrictName,
  VillageName,
  PostalCode,
  CompanyPostalCode,
  Street,
  StreetName,
  StreetAddrNonDeliverableReason,
  StreetPrefixName1,
  StreetPrefixName2,
  StreetSuffixName1,
  StreetSuffixName2,
  HouseNumber,
  HouseNumberSupplementText,
  Building,
  Floor,
  RoomNumber,
  Country,
  Region,
  FormOfAddress,
  TaxJurisdiction,
  TransportZone,
  POBox,
  POBoxAddrNonDeliverableReason,
  POBoxIsWithoutNumber,
  POBoxPostalCode,
  POBoxLobbyName,
  POBoxDeviatingCityName,
  POBoxDeviatingCityCode,
  POBoxDeviatingRegion,
  POBoxDeviatingCountry,
  CareOfName,
  DeliveryServiceTypeCode,
  DeliveryServiceNumber,
  AddressTimeZone,
  SecondaryRegion,
  SecondaryRegionName,
  TertiaryRegion,
  TertiaryRegionName,
  RegionalStructureCheckStatus,
  AddressGroup,
  AddressCreatedByUser,
  AddressCreatedOnDateTime,
  AddressChangedByUser,
  AddressChangedOnDateTime,
  /* Associations */
  _AddressGroup,
  _AddressObjectType,
  _AddressPersonName,
  _AddressRepresentationCode,
  _CorrespondenceLanguage,
  _Country,
  _CurrentDfltEmailAddress,
  _CurrentDfltFaxNumber,
  _CurrentDfltLandlinePhoneNmbr,
  _CurrentDfltMobilePhoneNumber,
  _DeliveryServiceTypeCode,
  _EmailAddress,
  _FaxNumber,
  _FormOfAddress,
  _MainWebsiteURL,
  _OrganizationAddress,
  _PersonAddress,
  _PhoneNumber,
  _POBoxAddrNonDeliverableReason,
  _POBoxDeviatingCityCode,
  _POBoxDeviatingCountry,
  _POBoxDeviatingRegion,
  _PostalCity,
  _PrfrdCommMediumType,
  _Region,
  _RegionalStructureCheckStatus,
  _SecondaryRegion,
  _Street,
  _StreetAddrNonDeliverableRsn,
  _TertiaryRegion,
  _TimeZone,
  _TransportationZone,
  _UniformResourceIdentifier
  
}