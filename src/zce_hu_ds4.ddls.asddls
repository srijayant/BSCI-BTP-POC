@EndUserText.label: 'Custom Entity : HU From DS4 via RFC'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_HU_DS4_ODATA'

@UI.selectionVariant: [
{
qualifier: 'HandlingUnit',
  text: 'Handling Unit' }
]


@UI: {
  headerInfo: {
  typeName: 'Handlint Unit',
  typeNamePlural: 'Handlint Units for Localization'
  }
}
define root custom entity ZCE_HU_DS4
{
      @UI.facet  : [
           {
             id  : 'HandellingUnit',
             purpose   : #STANDARD,
             type: #IDENTIFICATION_REFERENCE,
             label     : 'HU : Globe L10N Work Order',
             position  : 10 }
         ]

      @UI        : {
      lineItem   : [{position: 10, importance: #HIGH, label: 'Int. HU number'}],
      identification: [{position: 10, label: 'Internal HU number'}],
      selectionField: [{position: 10}]
      }
  key Venum      : abap.char( 10 );

      @UI        : {
          lineItem      : [{position: 20, importance: #HIGH, label: 'Ext. Handling Unit'}],
          identification: [{position: 20, label: 'External Handling Unit'}],
          selectionField: [{position: 20}]
          }
      Exidv      : abap.char( 20 );

      @UI        : {
      lineItem   : [{position: 30, importance: #HIGH, label: 'HU Identfier Type'}]
      }
      Exida      : abap.char( 1 );

      @UI        : {
      lineItem   : [{position: 40, importance: #HIGH, label: 'Shipping Point'}]
      }

      Vstel      : abap.char( 4 );

      @UI        : {
      lineItem   : [{position: 50, importance: #HIGH, label: 'Total Weight'}]
      }
      @Semantics.quantity.unitOfMeasure: 'Gewei'
      Brgew      : abap.dec( 15, 2 );

      @UI        : {
      lineItem   : [{position: 60, importance: #HIGH, label: 'Loading Weight'}]
      }
      @Semantics.quantity.unitOfMeasure: 'Gewei'
      Ntgew      : abap.dec( 15, 2 );

      Gewei      : abap.unit( 3 );
      @UI        : {
      lineItem   : [{position: 70, importance: #HIGH, label: 'Plant'}],
      identification: [{position: 70}]
      }
      Werks      : abap.char( 4 );

      Vkorg      : abap.char( 4 );

      Vtweg      : abap.char( 2 );
      @UI        : {
      lineItem   : [{position: 80, importance: #HIGH, label: 'Work Order' } ],
      identification: [{position: 10, label: 'Work Order' } ],
      selectionField: [{position: 10}]
      }

      WorkOrder  : abap.char( 10 );

      @UI        : {
      lineItem   : [{ type: #FOR_ACTION,  dataAction: 'createGlobeWorkOrderHU' , label: 'Create Globe Work Order' , position: 90 } ]
      }
      action     : abap.char( 10 );

      @UI.identification: [{position: 30, label: 'GUID'}]
      gwo_uuid   : sysuuid_x16;
      @UI.identification: [{position: 40, label: 'Work Order Created By'}]
      created_by : usnam;
      @UI.identification: [{position: 50, label: 'Work Order Created On'}]
      created_on : datn;


}
