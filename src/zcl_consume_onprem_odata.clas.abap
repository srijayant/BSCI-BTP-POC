CLASS zcl_consume_onprem_odata DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_CONSUME_ONPREM_ODATA IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA: ls_entity_key    TYPE zzodata_zc_rap_delivery,
          lt_business_data TYPE TABLE OF zzodata_zc_rap_delivery,
          ls_business_data TYPE zzodata_zc_rap_delivery,
          lo_http_client   TYPE REF TO if_web_http_client,
          lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request       TYPE REF TO /iwbep/if_cp_request_read_list,
          lo_response      TYPE REF TO /iwbep/if_cp_response_read_lst.


    TRY.

        DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination(
        i_name = 'RefAppsBackend_DS4_100'
        i_authn_mode = if_a4c_cp_service=>service_specific
        ).

        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).


        lo_client_proxy = cl_web_odata_client_factory=>create_v2_remote_proxy(
          EXPORTING
            iv_service_definition_name = 'ZODATA_SCM1'
            io_http_client             = lo_http_client
            iv_relative_service_root   = '/sap/opu/odata/sap/ZUI_RAP_MANAGEWORKORDER_V2/' ).


        " Navigate to the resource and create a request for the read operation
        lo_request = lo_client_proxy->create_resource_for_entity_set('ZC_RAP_DELIVERY' )->create_request_for_read( ).
        "lo_request->set_top( 1 )->set_skip( 0 ).
        " Execute the request and retrieve the business data
        lo_response = lo_request->execute( ).
        lo_response->get_business_data( IMPORTING et_business_data = lt_business_data ).

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        " Handle remote Exception
        " It contains details about the problems of your http(s) connection
        out->write( lx_remote->get_text( ) ).
      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        " Handle Exception
        out->write( lx_gateway->get_text( ) ).
      CATCH cx_http_dest_provider_error INTO DATA(lo_sde).
        out->write( lo_sde->get_text( ) ).
      CATCH cx_ai_system_fault INTO DATA(lo_sf).
        out->write( lo_sf->get_text( ) ).
      CATCH cx_web_http_client_error  INTO DATA(lo_cxweb).
        out->write( lo_cxweb->get_text( ) ).

    ENDTRY.
  ENDMETHOD.
ENDCLASS.
