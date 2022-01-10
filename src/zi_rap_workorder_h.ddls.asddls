@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Work Order BO View'

define root view entity zi_rap_workorder_h
  as select from zglb_work_ordr_h
{
  key gwo_uuid                as gwo_uuid,
      work_order              as WorkOrder,
      sales_order             as SalesOrder,
      delivery_doc            as DeliveryDoc,
      handeling_unit_internal as HandelingUnit,
      created_by              as CreatedBy,
      created_on              as CreatedOn

}
