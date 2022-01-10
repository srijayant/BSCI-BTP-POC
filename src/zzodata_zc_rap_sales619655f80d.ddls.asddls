/********** GENERATED on 06/06/2021 at 17:57:49 by CB9980000002**************/
 @OData.entitySet.name: 'ZC_RAP_SALESDOC' 
 @OData.entityType.name: 'ZC_RAP_SALESDOCType' 
 define root abstract entity ZZODATA_ZC_RAP_SALES619655F80D { 
 key Vbeln : abap.char( 10 ) ; 
 @Odata.property.valueControl: 'Erdat_vc' 
 Erdat : RAP_CP_ODATA_V2_EDM_DATETIME ; 
 Erdat_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Erzet_vc' 
 Erzet : RAP_CP_ODATA_V2_EDM_TIME ; 
 Erzet_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Ernam_vc' 
 Ernam : abap.char( 12 ) ; 
 Ernam_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Auart_vc' 
 Auart : abap.char( 4 ) ; 
 Auart_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Netwr_vc' 
 @Semantics.amount.currencyCode: 'Waerk' 
 Netwr : abap.curr( 16, 3 ) ; 
 Netwr_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Waerk_vc' 
 @Semantics.currencyCode: true 
 Waerk : abap.cuky ; 
 Waerk_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Vkorg_vc' 
 Vkorg : abap.char( 4 ) ; 
 Vkorg_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Vtweg_vc' 
 Vtweg : abap.char( 2 ) ; 
 Vtweg_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'Spart_vc' 
 Spart : abap.char( 2 ) ; 
 Spart_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'CheckBox_vc' 
 CheckBox : abap.char( 1 ) ; 
 CheckBox_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 
 } 
