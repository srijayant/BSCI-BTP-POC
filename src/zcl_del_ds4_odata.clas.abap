CLASS zcl_del_ds4_odata DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_rap_query_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS is_key_filter
      IMPORTING it_filter_cond          TYPE if_rap_query_filter=>tt_name_range_pairs
      RETURNING VALUE(rv_is_key_filter) TYPE abap_bool.

    METHODS get_orderby_clause
      IMPORTING it_sort_elements         TYPE if_rap_query_request=>tt_sort_elements
      RETURNING VALUE(rv_orderby_string) TYPE string.
ENDCLASS.



CLASS ZCL_DEL_DS4_ODATA IMPLEMENTATION.


  METHOD if_rap_query_provider~select.
    DATA: ls_entity_key     TYPE zzodata_zc_rap_deliv942e56eb5e,
          lt_business_data  TYPE TABLE OF zzodata_zc_rap_deliv942e56eb5e,
          ls_business_data  TYPE zzodata_zc_rap_deliv942e56eb5e,
          lo_http_client    TYPE REF TO if_web_http_client,
          lo_client_proxy   TYPE REF TO /iwbep/if_cp_client_proxy,
          lo_request        TYPE REF TO /iwbep/if_cp_request_read_list,
          lo_response       TYPE REF TO /iwbep/if_cp_response_read_lst,
          lt_del            TYPE TABLE OF zce_del_ds4,
          ls_del            TYPE zce_del_ds4,
          lv_details_read   TYPE abap_bool, "variables generic for implementation of custom entity
          lv_orderby_string TYPE string,
          lv_select_string  TYPE string.


    TRY.
        TRY.
            IF io_request->is_data_requested( ).
************************************************************************************get data from ds4
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

                  DATA(lv_top)     = io_request->get_paging( )->get_page_size( ).
                  DATA(lv_skip)    = io_request->get_paging( )->get_offset( ).

                  DATA : lv_top_t  TYPE int4,
                         lv_skip_t TYPE int4.
                  lv_top_t = lv_top.
                  lv_skip_t = lv_skip.

                  CLEAR : lv_top_t, lv_skip_t.
                  IF lv_top GE 0 .
                    lv_top_t =  lv_top.
                    lv_skip_t = lv_skip.
                    lo_request->set_top( lv_top_t )->set_skip( lv_skip_t ).
                  ENDIF.

                  " Execute the request and retrieve the business data
                  lo_response = lo_request->execute( ).
                  lo_response->get_business_data( IMPORTING et_business_data = lt_business_data ).

                CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
                  " Handle remote Exception
                  " It contains details about the problems of your http(s) connection
                  lx_remote->get_text( ).
                CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
                  " Handle Exception
                  lx_gateway->get_text( ).
                CATCH cx_http_dest_provider_error INTO DATA(lo_sde).
                  lo_sde->get_text( ).
                CATCH cx_ai_system_fault INTO DATA(lo_sf).
                  lo_sf->get_text( ).
                CATCH cx_web_http_client_error  INTO DATA(lo_cxweb).
                  lo_cxweb->get_text( ).
              ENDTRY.


************************************************************************************custom entity implementation
              TRY.
                  "get and add filter
                  DATA(lt_filter_cond) = io_request->get_filter( )->get_as_ranges( ). "  get_filter_conditions( ).
                CATCH cx_rap_query_filter_no_range INTO DATA(lx_no_sel_option).
              ENDTRY.

              DATA(lt_fields)  = io_request->get_requested_elements( ).
              DATA(lt_sort)    = io_request->get_sort_elements( ).

              "check if filter condition is for a single read
              lv_details_read = is_key_filter( lt_filter_cond ).


              "get existing WO
              SELECT *
              FROM zglb_work_ordr_h
              FOR ALL ENTRIES IN @lt_business_data
              WHERE delivery_doc = @lt_business_data-Vbeln
              INTO TABLE @DATA(lt_glb_wo).

              IF lv_details_read = abap_false.
                LOOP AT lt_business_data INTO ls_business_data.
                  ls_del = CORRESPONDING #( ls_business_data ).
                  ls_del-Delivery = ls_business_data-Vbeln.
                  DATA(ls_glb_wo) = VALUE #( lt_glb_wo[ delivery_doc = ls_business_data-Vbeln ] DEFAULT space ).
                  ls_del-WorkOrder = ls_glb_wo-work_order.
                  APPEND ls_del TO lt_del.
                  CLEAR ls_del.
                ENDLOOP.
              ELSE.
                READ TABLE lt_filter_cond WITH KEY name = 'DELIVERY' INTO DATA(ls_productid_filter_key).
                IF sy-subrc = 0 AND lines( ls_productid_filter_key-range ) = 1.
                  READ TABLE ls_productid_filter_key-range INTO DATA(ls_id_option) INDEX 1.
                  IF sy-subrc = 0 AND ls_id_option-sign = 'I' AND ls_id_option-option = 'EQ' AND ls_id_option-low IS NOT INITIAL.
                    DATA(lv_vbeln_key) = ls_id_option-low.
                  ENDIF.
                  ls_business_data = VALUE #( lt_business_data[ Vbeln = lv_vbeln_key ] DEFAULT space ).
                  ls_del = CORRESPONDING #( ls_business_data ).
                  ls_del-Delivery = ls_business_data-Vbeln.
                  ls_glb_wo = VALUE #( lt_glb_wo[ delivery_doc = ls_business_data-Vbeln ] DEFAULT space ).
                  ls_del-WorkOrder = ls_glb_wo-work_order.
                  ls_del-gwo_uuid = ls_glb_wo-gwo_uuid.
                  ls_del-created_by = ls_glb_wo-created_by.
                  ls_del-created_on = ls_glb_wo-created_on.
                  APPEND ls_del TO lt_del.
                  CLEAR ls_del.
                ENDIF.
              ENDIF.

              "Set total no. of records
              io_response->set_total_number_of_records( lines( lt_del ) ).
              io_response->set_data( lt_del ).
            ELSE.
              "Data Was not requested
              CLEAR lt_del.
              io_response->set_total_number_of_records( lines( lt_del ) ).
              io_response->set_data( lt_del ).
            ENDIF.
          CATCH cx_rap_query_filter_no_range INTO lx_no_sel_option.
            DATA(lv_msg) = lx_no_sel_option->get_text( ).
        ENDTRY.
      CATCH cx_root INTO DATA(lo_cx).
        DATA(lv_msg_cx) = lo_cx->get_text( ).
    ENDTRY.
  ENDMETHOD.


  METHOD is_key_filter.
    "check if the request is a single read
    READ TABLE it_filter_cond WITH KEY name = 'DELIVERY' INTO DATA(ls_productid_filter_key).
    IF sy-subrc = 0 AND lines( ls_productid_filter_key-range ) = 1.
      READ TABLE ls_productid_filter_key-range INTO DATA(ls_id_option) INDEX 1.
      IF sy-subrc = 0 AND ls_id_option-sign = 'I' AND ls_id_option-option = 'EQ' AND ls_id_option-low IS NOT INITIAL.
        "read details for single record in list
        rv_is_key_filter = abap_true.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD get_orderby_clause.

  ENDMETHOD.
ENDCLASS.
