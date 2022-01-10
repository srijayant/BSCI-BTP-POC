@EndUserText.label: 'Custom Entity : DEL From DS4 via RFC'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_DEL_DS4_ODATA'

@UI.selectionVariant: [
{ qualifier: 'DeliveryDoc',
  text: 'Delivery Document' }
]

@UI: {
  headerInfo: {
  typeName: 'Delivery Document',
  typeNamePlural: 'Delivery Documents for Localization'
  }
}
define root custom entity ZCE_DEL_DS4
{
      @UI.facet  : [
           {
             id  : 'Delivery',
             purpose   : #STANDARD,
             type: #IDENTIFICATION_REFERENCE,
             label     : 'Delivery : Globe L10n Work Order',
             position  : 10 }
         ]

      @UI        : {
      lineItem   : [{position: 10, importance: #HIGH, label: 'Delivery'}],
      identification: [{position: 10, label: 'Delivery'}],
      selectionField: [{position: 10}]
      }
  key Delivery   : abap.char( 10 );

      @UI        : {
          lineItem      : [{position: 20, importance: #HIGH, label: 'Created by'}],
          selectionField: [{position: 20}]
          }
      Ernam      : abap.char( 12 );

      @UI        : {
      lineItem   : [{position: 30, importance: #HIGH, label: 'Created on'}]
      }
      Erdat      : rap_cp_odata_v2_edm_datetime;

      @UI        : {
      lineItem   : [{position: 40, importance: #HIGH, label: 'Shipping Point'}]
      }
      Vstel      : abap.char( 4 );

      Vkorg      : abap.char( 4 );

      @UI        : {
      lineItem   : [{position: 50, importance: #HIGH, label: 'Delivery Type'}]
      }
      Lfart      : abap.char( 4 );

      @UI        : {
      lineItem   : [{position: 60, importance: #HIGH, label: 'Ship-to party'}]
      }
      Kunnr      : abap.char( 10 );

      Kunag      : abap.char( 10 );

      @UI        : {
      lineItem   : [{position: 70, importance: #HIGH, label: 'Net weight'}]
      }
      @Semantics.quantity.unitOfMeasure: 'Gewei'
      Ntgew      : abap.dec( 15, 2 );

      Gewei      : abap.unit( 3 );
      @UI        : {
      lineItem   : [{position: 80, importance: #HIGH, label: 'Work Order' } ],
      identification: [{position: 10, label: 'Work Order'}],
      selectionField: [{position: 10}]
      }

      WorkOrder  : abap.char( 10 );

      @UI        : {
      lineItem   : [{ type: #FOR_ACTION,  dataAction: 'createGlobeWorkOrderDEL' , label: 'Create Globe Work Order' , position: 90 } ]
      }
      action     : abap.char( 10 );

      @UI.identification: [{position: 30, label: 'GUID'}]
      gwo_uuid   : sysuuid_x16;
      @UI.identification: [{position: 40, label: 'Work Order Created By'}]
      created_by : usnam;
      @UI.identification: [{position: 50, label: 'Work Order Created On'}]
      created_on : datn;


}
