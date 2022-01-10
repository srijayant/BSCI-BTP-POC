CLASS lhc_glbworkorder DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS setWorkOrderNumber FOR DETERMINE ON SAVE
      IMPORTING keys FOR glbworkorder~setWorkOrderNumber.

ENDCLASS.

CLASS lhc_glbworkorder IMPLEMENTATION.

  METHOD setWorkOrderNumber.

    READ ENTITIES OF zi_rap_workorder_h IN LOCAL MODE
        ENTITY glbworkorder
          FIELDS ( WorkOrder ) WITH CORRESPONDING #( keys )
        RESULT DATA(workorders).


    SELECT SINGLE
    FROM  zglb_work_ordr_h
    FIELDS MAX( work_order ) AS WorkOrderNum
    INTO @DATA(max_WorkOrderNum).

    " Set default Work Order Number
    MODIFY ENTITIES OF zi_rap_workorder_h IN LOCAL MODE
    ENTITY glbworkorder
      UPDATE
        FIELDS ( WorkOrder CreatedBy CreatedOn )
        WITH VALUE #( FOR WorkOrder IN workorders
                      ( %tky         = WorkOrder-%tky
                        CreatedBy = sy-uname
                        CreatedOn = sy-datum
                        WorkOrder = max_WorkOrderNum + 000000001 ) )
    REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).

  ENDMETHOD.

ENDCLASS.
