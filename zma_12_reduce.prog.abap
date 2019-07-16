*&---------------------------------------------------------------------*
*& Report zma_12_reduce
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zma_12_reduce.

DATA lt_sflight TYPE SORTED TABLE OF sflight WITH UNIQUE KEY carrid connid fldate
                                             WITH NON-UNIQUE SORTED KEY carrier_plane COMPONENTS carrid planetype
                                             WITH NON-UNIQUE SORTED KEY carrid_fldate COMPONENTS carrid fldate.

PARAMETERS p_carrid TYPE s_carr_id.

INITIALIZATION.

  IF lt_sflight IS INITIAL.
    SELECT * FROM sflight INTO TABLE lt_sflight.
  ENDIF.

START-OF-SELECTION.

**********************************************************************
* Simple Version
  DATA(ld_total_payments_simple) = REDUCE s_sum( INIT val TYPE s_sum
                                          FOR wa IN lt_sflight
                                          NEXT val = val + wa-paymentsum ).

  cl_demo_output=>new(
  )->begin_section( |Overall revenue|
  )->write_data( |The overall revenue (w/o currency conversion) is { ld_total_payments_simple }|
  )->display( ).
**********************************************************************

**********************************************************************
** More advanced version, combined with FILTER (WHERE-clause)
*  DATA(ld_total_payments) = REDUCE s_sum( INIT val TYPE s_sum
*                                          FOR wa IN FILTER #( lt_sflight WHERE carrid = p_carrid
*                                                                           AND connid <> CONV #( '0000' )
*                                                                           AND fldate >= ( sy-datum - 365 ) )
*                                          NEXT val = val + wa-paymentsum ).

*  cl_demo_output=>new(
*  )->begin_section( |Revenue report for { p_carrid }|
*  )->write_data( |Within the last year, { p_carrid } had a total revenue of { ld_total_payments }|
*  )->display( ).
