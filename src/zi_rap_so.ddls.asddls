@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order BO View'

define root view entity ZI_RAP_SO
  as select from zglb_work_ordr_h as _wo
  association [0..*] to ZCE_SO_DS4 as _SO on _wo.sales_order = _SO.Vbeln
{
  key gwo_uuid    as gwo_uuid,
      work_order  as WorkOrder,
      sales_order as SalesOrder,
      _SO

}
