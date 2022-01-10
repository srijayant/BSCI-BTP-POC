CLASS lhc_glbso DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PUBLIC SECTION.
    TYPES: BEGIN OF ts_message.
             INCLUDE TYPE symsg.
    " TYPES:   elements TYPE name.
    TYPES: END OF ts_message.

    TYPES:tt_messages TYPE STANDARD TABLE OF ts_message.

  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR glbso RESULT result.

*    METHODS create FOR MODIFY
*      IMPORTING entities FOR CREATE glbso.
*
*    METHODS update FOR MODIFY
*      IMPORTING entities FOR UPDATE glbso.
*
*    METHODS delete FOR MODIFY
*      IMPORTING keys FOR DELETE glbso.

    METHODS read FOR READ
      IMPORTING keys FOR READ glbso RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK glbso.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR glbso RESULT result.

    METHODS createGlobeWorkOrderSO FOR MODIFY
      IMPORTING keys FOR ACTION glbso~createGlobeWorkOrderSO RESULT result.
    CLASS-DATA  ls_wo TYPE zglb_work_ordr_h.

ENDCLASS.

CLASS lhc_glbso IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

*  METHOD create.
*
*  ENDMETHOD.
*
*  METHOD update.
*  ENDMETHOD.
*
*  METHOD delete.
*  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD createGlobeWorkOrderSO.
    DATA lt_reported TYPE TABLE FOR REPORTED zce_so_ds4 .
    DATA ls_reported LIKE LINE OF lt_reported .

    DATA:ls_message TYPE ts_message,
         ls_measure TYPE REF TO data.



    DATA(lt_key) = keys.
    READ TABLE keys INTO DATA(ls_key) INDEX 1.
    IF sy-subrc = 0 AND NOT ls_key-Vbeln IS INITIAL.
      SELECT SINGLE
  FROM  zglb_work_ordr_h
  FIELDS MAX( work_order ) AS WorkOrderNum
  INTO @DATA(max_WorkOrderNum).

      ls_wo-client = sy-mandt.
      ls_wo-sales_order = ls_key-Vbeln.
      ls_wo-created_by = sy-uname.
      ls_wo-created_on = sy-datum.
      ls_wo-work_order = max_WorkOrderNum + 000000001.

      TRY.
          DATA(lv_uuid) =   cl_system_uuid=>create_uuid_x16_static( ).
          ls_wo-gwo_uuid = lv_uuid.
        CATCH cx_uuid_error INTO DATA(lo_x).
          DATA(msg) = lo_x->get_text( ).
      ENDTRY.

      INSERT INTO  zglb_work_ordr_h VALUES @ls_wo.
      IF sy-subrc = 0.
        ls_reported-%msg = new_message(
                                           id       = 'S'
                                           number   =  '001'
                                           severity = if_abap_behv_message=>severity-success
                                           v1       = 'Work Order'
                                           v2       = ls_wo-work_order
                                           v3       = 'Created Sucessfully'
                                           v4       = ls_message-msgv4 ).

*        ASSIGN COMPONENT ls_message-elements OF STRUCTURE ls_reported-%element TO FIELD-SYMBOL(<element>).
*        IF <element> IS ASSIGNED.
*          <element> = if_abap_behv=>mk-on.
*        ENDIF.

        INSERT ls_reported INTO TABLE reported-glbso.

      ENDIF.
    ENDIF.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZCE_SO_DS4 DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZCE_SO_DS4 IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.