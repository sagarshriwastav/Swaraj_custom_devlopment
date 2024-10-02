@AbapCatalog.sqlViewName: 'ZADDER'
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'ADDRESS'


@EndUserText.label: 'CUSTOM1'
@Search.searchable: false
@Metadata.allowExtensions: true
@AbapCatalog.dataMaintenance: #DISPLAY_ONLY
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.representativeKey: 'CUSTOMER'
define view ZSD_DOM_ADDRESS 
as select from I_Customer as A 
association [0..1] to I_Address_2 as ADD on 
A.AddressID = ADD.AddressID { 

key A.Customer,
    A.CustomerName,
    A.CustomerFullName,
    A.CreatedByUser,
    A.CreationDate,
    A.AddressID,
    A.CustomerClassification,
    A.VATRegistration,
    A.CustomerAccountGroup,
    A.AuthorizationGroup,
    A.DeliveryIsBlocked,
    A.PostingIsBlocked,
    A.BillingIsBlockedForCustomer,
    A.OrderIsBlockedForCustomer,
    A.InternationalLocationNumber1,
    A.IsOneTimeAccount,
    A.TaxJurisdiction,
    A.Industry,
    A.TaxNumberType,
    A.TaxNumber1,
    A.TaxNumber2,
    A.TaxNumber3,
    A.TaxNumber4,
    A.TaxNumber5,
    A.TaxNumber6,
    A.CustomerCorporateGroup,
    A.Supplier,
    A.NielsenRegion,
    A.IndustryCode1,
    A.IndustryCode2,
    A.IndustryCode3,
    A.IndustryCode4,
    A.IndustryCode5,
    A.Country,
    A.OrganizationBPName1,
    A.OrganizationBPName2,
    A.CityName,
    A.PostalCode,
    A.StreetName,
    A.SortField,
    A.FaxNumber,
    A.BR_SUFRAMACode,
    A.Region,
    A.TelephoneNumber1,
    A.TelephoneNumber2,
    A.AlternativePayerAccount,
    A.DataMediumExchangeIndicator,
    A.VATLiability,
    A.IsBusinessPurposeCompleted,
    A.ResponsibleType,
    A.FiscalAddress,
    A.NFPartnerIsNaturalPerson,
    A.DeletionIndicator,
    A.Language,
    A.TradingPartner,
    A.CityCode,
    A.County,
    A.CustomerHasUnloadingPoint,
    A.CustomerWorkingTimeCalendar,
    A.IsCompetitor,
    A.TaxInvoiceRepresentativeName,
    A.BusinessType,
    A.IndustryType,
    A._StandardAddress,

 ADD.AddressID as ADDID,
 ADD.AddressPersonID,
 ADD.AddressRepresentationCode,
 ADD.AddressObjectType,
 ADD.CorrespondenceLanguage,
 ADD.PrfrdCommMediumType,
 ADD.AddresseeFullName,
 ADD.PersonGivenName,
 ADD.PersonFamilyName,
 ADD.OrganizationName1,
 ADD.OrganizationName2,
 ADD.OrganizationName3,
 ADD.OrganizationName4,
 ADD.AddressSearchTerm1,
 ADD.AddressSearchTerm2,
 ADD.CityNumber,
 ADD.CityName as CITY,
 ADD.DistrictName,
 ADD.VillageName,
 ADD.PostalCode as POST,
 ADD.CompanyPostalCode,
 ADD.Street ,
 ADD.StreetName as STREETE,
 ADD.StreetAddrNonDeliverableReason,
 ADD.StreetPrefixName1,
 ADD.StreetPrefixName2,
 ADD.StreetSuffixName1,
 ADD.StreetSuffixName2,
 ADD.HouseNumber,
 ADD.HouseNumberSupplementText,
 ADD.Building,
 ADD.Floor,
 ADD.RoomNumber,
 ADD.Country as COUNRT,
 ADD.Region as REGCODE,
 ADD.FormOfAddress,
 ADD.TaxJurisdiction as TZXJ,
 ADD.TransportZone,
 ADD.POBox,
 ADD.POBoxAddrNonDeliverableReason,
 ADD.POBoxIsWithoutNumber,
 ADD.POBoxPostalCode,
 ADD.POBoxLobbyName,
 ADD.POBoxDeviatingCityName,
 ADD.POBoxDeviatingRegion,
 ADD.POBoxDeviatingCountry,
 ADD.CareOfName,
 ADD.DeliveryServiceTypeCode,
 ADD.DeliveryServiceNumber,
 ADD.AddressTimeZone,
 ADD.SecondaryRegion,
 ADD.SecondaryRegionName,
 ADD.TertiaryRegion,
 ADD.TertiaryRegionName,
 ADD.RegionalStructureCheckStatus,
 ADD.AddressGroup,
 ADD._AddressGroup,
 ADD._AddressObjectType,
 ADD._AddressPersonName,
 ADD._AddressRepresentationCode,
 ADD._CorrespondenceLanguage,
 ADD._Country,
 ADD._CurrentDfltEmailAddress,
 ADD._CurrentDfltFaxNumber,
 ADD._CurrentDfltLandlinePhoneNmbr,
 ADD._CurrentDfltMobilePhoneNumber,
 ADD._DeliveryServiceTypeCode,
 ADD._EmailAddress,
 ADD._FaxNumber,
 ADD._FormOfAddress,
 ADD._MainWebsiteURL,
 ADD._OrganizationAddress,
 ADD._PersonAddress,
 ADD._PhoneNumber,
 ADD._POBoxAddrNonDeliverableReason,
 ADD._POBoxDeviatingCountry,
 ADD._POBoxDeviatingRegion,
 ADD._PostalCity,
 ADD._PrfrdCommMediumType,
 ADD._Region,
 ADD._RegionalStructureCheckStatus,
 ADD._SecondaryRegion,
 ADD._Street,
 ADD._StreetAddrNonDeliverableRsn,
 ADD._TertiaryRegion,
 ADD._TimeZone,
 ADD._TransportationZone,
 ADD._UniformResourceIdentifier
//as select from data_source_name
//association [1] to target_data_source_name as _association_name
//    on $projection.element_name = _association_name.target_element_name {
    
//    _association_name // Make association public
}
