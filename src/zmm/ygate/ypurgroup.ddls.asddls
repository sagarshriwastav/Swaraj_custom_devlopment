//@AbapCatalog.sqlViewName: 'YPURGROUP'
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view  entity YPURGROUP as select from  I_PurchasingGroup { key PurchasingGroup,
                                                                       PurchasingGroupName,
                                                                  PurchasingGroupPhoneNumber,
                                                                  FaxNumber,
                                                                  PhoneNumber,
                                                                  PhoneNumberExtension,
                                                                  EmailAddress
    
}
