@EndUserText.label: 'projction  view for YCONSIGNEDATA'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity YCONSIGNEDATA_proj  provider contract transactional_query
  as projection on  YCONSIGNEDATA_PR1 {
    key Docno,
    key Doctype ,
    Billtobuyrname,
    Billtostreet1,
    Billtostreet2,
    Billtostreet3,
    Billtocity,
    Billtocountry,
    Constoname,
    Constostreet1,
    Constostreet2,
    Constostreet3,
    Constocity,
    Constocountry,
    Notifyname,
    Notifystreet1,
    Notifystreet2,
    Notifystreet3,
    Notifycity,
    Notifycountry,
    Conslctoname,
    Conslctostreet1,
    Conslctostreet2,
    Conslctostreet3,
    Conslctocity,
    Conslctocountry,
    Notify2name,
    Notify2street1,
    Notify2street2,
    Notify2street3,
    Notify2city,
    Notify2country,
    Notify3name,
    Notify3street1,
    Notify3street2,
    Notify3street3,
    Notify3city,
    Notify3country,
    Taxid,
    Secondbuyer,
    Secondbuyername,
    Secondstreet1,
    Secondstreet2,
    Secondstreet3,
    Secondcity,
    Secondcountry
}
