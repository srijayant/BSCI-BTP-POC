@EndUserText.label: 'Projection root entity for zi_rap_so'
@AccessControl.authorizationCheck: #CHECK
define root view entity ZC_RAP_SO as projection on ZI_RAP_SO {
    key gwo_uuid,
    WorkOrder,
    SalesOrder,
    /* Associations */
    _SO
}
