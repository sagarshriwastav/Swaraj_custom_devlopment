@EndUserText.label: 'yadd_vendor'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity yadd_vendor as  select from
 I_Customer as a left outer join I_Address_2 as bik on  bik.AddressID = a.AddressID    { key a.Customer,
                                                                                 a.CustomerName,
                                                                                 a.CustomerFullName,
                                                                                 a.CreatedByUser,
                                                                                 a.CreationDate,
                                                                                 a.AddressID,
                                                                                 a.CustomerClassification,
                                                                                 a.VATRegistration,
                                                                                 a.CustomerAccountGroup,
                                                                                 a.AuthorizationGroup,
                                                                                 a.DeliveryIsBlocked,
                                                                                 a.PostingIsBlocked,
                                                                                 a.BillingIsBlockedForCustomer,
                                                                                 a.OrderIsBlockedForCustomer,
                                                                                 a.InternationalLocationNumber1,
                                                                                 a.IsOneTimeAccount,
                                                                                 a.TaxJurisdiction,
                                                                                 a.Industry,
                                                                                 a.TaxNumberType,
                                                                                 a.TaxNumber1,
                                                                                 a.TaxNumber2,
                                                                                 a.TaxNumber3,
                                                                                 a.TaxNumber4,
                                                                                 a.TaxNumber5,
                                                                                 a.TaxNumber6,
                                                                                 a.CustomerCorporateGroup,
                                                                                 a.Supplier,
                                                                                 a.NielsenRegion,
                                                                                 a.IndustryCode1,
                                                                                 a.IndustryCode2,
                                                                                 a.IndustryCode3,
                                                                                 a.IndustryCode4,
                                                                                 a.IndustryCode5,
                                                                                 a.Country,
                                                                                 a.OrganizationBPName1,
                                                                                 a.OrganizationBPName2,
                                                                                 a.CityName,
                                                                                 a.PostalCode,
                                                                                 a.StreetName,
                                                                                 a.SortField,
                                                                                 a.FaxNumber,
                                                                                 a.BR_SUFRAMACode,
                                                                                 a.Region,
                                                                                 a.TelephoneNumber1,
                                                                                 a.TelephoneNumber2,
                                                                                 a.AlternativePayerAccount,
                                                                                 a.DataMediumExchangeIndicator,
                                                                                 a.VATLiability,
                                                                                 a.IsBusinessPurposeCompleted,
                                                                                 a.ResponsibleType,
                                                                                 a.FiscalAddress,
                                                                                 a.NFPartnerIsNaturalPerson,
                                                                                 a.DeletionIndicator,
                                                                                 a.Language,
                                                                                 a.TradingPartner,
                                                                                 a.DeliveryDateTypeRule,
                                                                                 a.ExpressTrainStationName,
                                                                                 a.TrainStationName,
                                                                                 a.InternationalLocationNumber2,
                                                                                 a.InternationalLocationNumber3,
                                                                                 a.CityCode,
                                                                                 a.County,
                                                                                 a.CustomerHasUnloadingPoint,
                                                                                 a.CustomerWorkingTimeCalendar,
                                                                                 a.IsCompetitor,
                                                                                 a.TaxInvoiceRepresentativeName,
                                                                                 a.BusinessType,
                                                                                 a.IndustryType,
                                                                                 a.TW_CollvBillingIsSupported,
                                                                                 a.AlternativePayeeIsAllowed,
                                                                                 a.FreeDefinedAttribute01,
                                                                                 a.FreeDefinedAttribute02,
                                                                                 a.FreeDefinedAttribute03,
                                                                                 a.FreeDefinedAttribute04,
                                                                                 a.FreeDefinedAttribute05,
                                                                                 a.FreeDefinedAttribute06,
                                                                                 a.FreeDefinedAttribute07,
                                                                                 a.FreeDefinedAttribute08,
                                                                                 a.FreeDefinedAttribute09,
                                                                                 a.FreeDefinedAttribute10,
                                                                                 a.PaymentReason,
                                                                                 /* Associations */
                                                                                 a._AddressDefaultRepresentation,
                                                                                 a._ContactPerson,
                                                                                 a._CorrespondingSupplier,
                                                                                 a._CreatedByUser,
                                                                                 a._CustomerAccountGroupText,
                                                                                 a._CustomerAddr,
                                                                                 a._CustomerAddrSalesAreaTax,
                                                                                 a._CustomerClassification,
                                                                                 a._CustomerClassificationText,
                                                                                 a._CustomerCompany,
                                                                                 a._CustomerHierarchyNode,
                                                                                 a._CustomerSalesArea,
                                                                                 a._CustomerSalesAreaTax,
                                                                                 a._CustomerToBusinessPartner,
                                                                                 a._GlobalCompany,
                                                                                 a._StandardAddress
    
}
