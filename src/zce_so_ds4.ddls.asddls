@EndUserText.label: 'Custom Entity : SO From DS4 via RFC'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_SO_DS4_ODATA'

@UI.selectionVariant: [
{ qualifier: 'SalesDoc',
  text: 'Sales Document' }
]


@UI: {
  headerInfo: {
  typeName: 'Sales Order',
  typeNamePlural: 'Sales Orders for Localization'
  }
}

@ObjectModel: {
  semanticKey: [ 'WorkOrder' ]
}


define root custom entity ZCE_SO_DS4
{

      @UI.facet  : [
           {
             id  : 'SoWorkOrders',
             purpose   : #STANDARD,
             type: #IDENTIFICATION_REFERENCE,
             label     : 'Sales Order : Globe L10n Work Order',
             position  : 10
           }
         ]

      @UI        : {
      lineItem   : [{position: 10, importance: #HIGH, label: 'Sales Order'}],
      identification: [{position: 10, label: 'Sales Order'}],
      selectionField: [{position: 10}]
      }
  key Vbeln      : zvbeln_va;

      @UI        : {
          lineItem      : [{position: 20, importance: #HIGH, label: 'Created on'}]
          }
      Erdat      : rap_cp_odata_v2_edm_datetime;

      @UI        : {
      lineItem   : [{position: 30, importance: #HIGH, label: 'Time'}]
      }
      Erzet      : rap_cp_odata_v2_edm_time;

      @UI        : {
      lineItem   : [{position: 40, importance: #HIGH, label: 'Created by'}]
      }
      Ernam      : abap.char( 12 );

      @UI        : {
      lineItem   : [{position: 50, importance: #HIGH, label: 'Sales Document Type'}]
      }
      Auart      : abap.char( 4 );

      @UI        : {
      lineItem   : [{position: 60, importance: #HIGH, label: 'Net Value'}]
      }
      @Semantics.amount.currencyCode: 'Waerk'
      Netwr      : abap.curr( 16, 2 );

      @UI        : {
      lineItem   : [{position: 70, importance: #HIGH, label: 'Sales Organization'}]
      }
      Vkorg      : abap.char( 4 );

      @UI        : {
      lineItem   : [{position: 80, importance: #HIGH, label: 'Distribution Channel'}]
      }
      Vtweg      : abap.char( 2 );

      Spart      : abap.char( 2 );

      @Consumption.semanticObject: 'WorkOrder'
      @UI        : { lineItem  : [{position: 90, importance: #HIGH, label: 'Work Order' } ],
                    identification: [{position: 10, label: 'Work Order'}],
                    selectionField: [{position: 20} ]}
      WorkOrder  : zwork_order;

      @UI        : {lineItem  : [{ type: #FOR_ACTION,  dataAction: 'createGlobeWorkOrderSO' , label: 'Create Globe Work Order' , position: 90 } ]}
      action     : abap.char( 10 );

      Waerk      : abap.cuky;

      @UI        : {selectionField: [{position: 30}]}
      Venum      : zvenum;

      @UI        : {selectionField: [{position: 40}]}
      Delivery   : zvbeln_vl;

      @UI.identification: [{position: 30, label: 'GUID'}]
      gwo_uuid   : sysuuid_x16;
      @UI.identification: [{position: 40, label: 'Work Order Created By'}]
      created_by : usnam;
      @UI.identification: [{position: 50, label: 'Work Order Created On'}]
      created_on : datn;
}
