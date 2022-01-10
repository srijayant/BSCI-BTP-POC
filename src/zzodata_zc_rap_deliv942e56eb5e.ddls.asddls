/********** GENERATED on 06/06/2021 at 17:57:49 by CB9980000002**************/
 @OData.entitySet.name: 'ZC_RAP_DELIVERY' 
 @OData.entityType.name: 'ZC_RAP_DELIVERYType' 
 define root abstract entity ZZODATA_ZC_RAP_DELIV942E56EB5E { 
 key Vbeln : abap.char( 10 ) ; 
 @Odata.property.valueControl: 'Ernam_vc' 
 Ernam : abap.char( 12 ) ; 
 Ernam_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Erdat_vc' 
 Erdat : RAP_CP_ODATA_V2_EDM_DATETIME ; 
 Erdat_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Vstel_vc' 
 Vstel : abap.char( 4 ) ; 
 Vstel_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Vkorg_vc' 
 Vkorg : abap.char( 4 ) ; 
 Vkorg_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Lfart_vc' 
 Lfart : abap.char( 4 ) ; 
 Lfart_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Kunnr_vc' 
 Kunnr : abap.char( 10 ) ; 
 Kunnr_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Kunag_vc' 
 Kunag : abap.char( 10 ) ; 
 Kunag_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Ntgew_vc' 
 @Semantics.quantity.unitOfMeasure: 'Gewei' 
 Ntgew : abap.dec( 15, 3 ) ; 
 Ntgew_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Gewei_vc' 
 @Semantics.unitOfMeasure: true 
 Gewei : abap.unit( 3 ) ; 
 Gewei_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 
 } 
