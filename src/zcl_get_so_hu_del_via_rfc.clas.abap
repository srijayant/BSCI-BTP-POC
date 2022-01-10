CLASS zcl_get_so_hu_del_via_rfc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA lt_so TYPE TABLE OF zvbak.
    INTERFACES if_oo_adt_classrun.
*    INTERFACES if_rap_query_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_GET_SO_HU_DEL_VIA_RFC IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    TRY.
        DATA(lo_destination) = cl_rfc_destination_provider=>create_by_cloud_destination(
                                i_name                  = 'RefAppsBackend_DS4_100'
                               ).

        DATA(lv_destination) = lo_destination->get_destination_name( ).

        DATA lv_result TYPE c LENGTH 200.

        CALL FUNCTION 'ZPOC_RFCFM_GET_SO_HU_DEL'
          DESTINATION lv_destination
          EXPORTING
            get_so = abap_true
          TABLES
            et_so  = lt_so.

        out->write( lt_so ).
      CATCH cx_root INTO DATA(lx_root).
        out->write( lx_root->get_text( ) ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
