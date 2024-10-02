@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Weave Grading Table'
define view entity ZWEAVE_GRADETAB as select from zweav_grad_tab
{
    key werks as Werks,
    key prctr as Prctr,
    key grade as Grade,
    zdesc as Zdesc,
    zsnro as Zsnro

}
