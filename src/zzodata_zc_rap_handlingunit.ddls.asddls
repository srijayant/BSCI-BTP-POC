/********** GENERATED on 06/06/2021 at 10:00:54 by CB9980000002**************/
 @OData.entitySet.name: 'ZC_RAP_HANDLINGUNIT' 
 @OData.entityType.name: 'ZC_RAP_HANDLINGUNITType' 
 define root abstract entity ZZODATA_ZC_RAP_HANDLINGUNIT { 
 key Venum : abap.char( 10 ) ; 
 @Odata.property.valueControl: 'Exidv_vc' 
 Exidv : abap.char( 20 ) ; 
 Exidv_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Exida_vc' 
 Exida : abap.char( 1 ) ; 
 Exida_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Vstel_vc' 
 Vstel : abap.char( 4 ) ; 
 Vstel_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Brgew_vc' 
 @Semantics.quantity.unitOfMeasure: 'Gewei' 
 Brgew : abap.dec( 15, 3 ) ; 
 Brgew_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Ntgew_vc' 
 @Semantics.quantity.unitOfMeasure: 'Gewei' 
 Ntgew : abap.dec( 15, 3 ) ; 
 Ntgew_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Gewei_vc' 
 @Semantics.unitOfMeasure: true 
 Gewei : abap.unit( 3 ) ; 
 Gewei_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Werks_vc' 
 Werks : abap.char( 4 ) ; 
 Werks_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Vkorg_vc' 
 Vkorg : abap.char( 4 ) ; 
 Vkorg_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Vtweg_vc' 
 Vtweg : abap.char( 2 ) ; 
 Vtweg_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 ETAG__ETAG : abap.string( 0 ) ; 
 
 } 
