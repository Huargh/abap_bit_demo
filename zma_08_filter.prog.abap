*&---------------------------------------------------------------------*
*& Report ZMA_08_FILTER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zma_08_filter.
"Demo on how the Filter function works.

DATA lt_sflight TYPE SORTED TABLE OF sflight WITH UNIQUE KEY carrid connid fldate.
DATA ld_connid TYPE s_conn_id VALUE IS INITIAL.
PARAMETERS p_carrid TYPE s_carr_id.

INITIALIZATION.

  IF lt_sflight IS INITIAL.
    SELECT * FROM sflight INTO TABLE lt_sflight.
  ENDIF.


START-OF-SELECTION.

  DATA(lt_upcoming_flights) = FILTER #( lt_sflight WHERE carrid = p_carrid
*                                                     AND connid <> CONV #( '0000' ) "Workaround, see below
                                                     AND connid <> ld_connid  "Workaround, see below
                                                     AND fldate >= sy-datum ).

  cl_demo_output=>new(
  )->begin_section( |Your next flight options for carrier { p_carrid } are:|
  )->write_data( lt_upcoming_flights
  )->display( ).

  "Caveat: This only works with sorted & hashed internal tables & full primary key specification:
  "1. --> uncomment this, does not work:
*  SELECT * FROM sflight INTO TABLE @DATA(lt_sflight_standard).
*  DATA(lt_upcoming_standard) = FILTER #( lt_sflight_standard WHERE carrid = p_carrid
*                                                 AND connid <> CONV #( '0000' )
*                                                 AND fldate >= sy-datum ).

  "2. Try to comment connid in filter-function --> does not work
