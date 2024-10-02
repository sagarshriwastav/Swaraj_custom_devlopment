@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Loom Type F4'
define root view entity ZLOOM_TYPE_CDS as select from zloom_type

{
    key serialno as Serialno,
        loomtype as Loomtype
}
