*&---------------------------------------------------------------------*
*& Report zma_05_calculations_in_sql
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zma_05_calculations_in_sql.

TYPES: BEGIN OF ty_conn_revenues,
         carrid          TYPE s_carr_id,
         connid          TYPE s_conn_id,
         fldate          TYPE s_date,
         maximum_revenue TYPE s_price,
         currency        TYPE s_currcode,
       END OF ty_conn_revenues.

DATA gt_conn_revenues TYPE STANDARD TABLE OF ty_conn_revenues WITH NON-UNIQUE KEY carrid connid.

PARAMETERS p_carrid TYPE s_carr_id.

START-OF-SELECTION.

  SELECT carrid, connid, fldate, CAST( price AS CURR ) * CAST( seatsmax AS CURR ) AS maximum_revenue, currency
  FROM sflight INTO CORRESPONDING FIELDS OF TABLE @gt_conn_revenues
  WHERE carrid = @p_carrid.

  CHECK sy-subrc = 0.

  cl_demo_output=>new(
  )->begin_section( 'Maximum Revenues per Connection'
  )->write_data( gt_conn_revenues
  )->display( ).
