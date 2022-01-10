@EndUserText.label: 'Work order BO projection view entity'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.allowExtensions: true

@ObjectModel: {
  semanticKey: [ 'WorkOrder' ]
} 

define root view entity zc_rap_workorder_h
  as projection on zi_rap_workorder_h
{
  key gwo_uuid,
      @Search.defaultSearchElement: true
      @ObjectModel.text.element: ['WorkOrder']
      WorkOrder,
      SalesOrder,
      DeliveryDoc,
      HandelingUnit,
      CreatedBy,
      CreatedOn
}
