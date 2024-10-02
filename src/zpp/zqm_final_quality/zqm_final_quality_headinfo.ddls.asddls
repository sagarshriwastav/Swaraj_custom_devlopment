@AbapCatalog.sqlViewName: 'YHEADINFO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Finish Quality Inspection Header Info'
define view ZQM_FINAL_QUALITY_HEADINFO as select from zpp_sortmaster as a  
                           left outer join zpc_headermaster as b on ( b.zpqlycode = a.material )
{ 
    key a.material,
    key a.plant,
    key a.pdcode,
        a.dyeingsort,
        a.dyeingshade,
        a.processroute,
        a.stdwidthinch as finwd,
        a.stdwidthinchtolerance,
        a.weight,
        a.warpshrinkageperc,
        a.weftshrinkageperc,
        b.zpweavetype,
        a.stretch
}   
