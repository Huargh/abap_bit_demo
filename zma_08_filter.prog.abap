*&---------------------------------------------------------------------*
*& Report ZMA_08_FILTER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zma_08_filter.
"Demo on how the Filter function works.

DATA lt_sflight TYPE SORTED TABLE OF sflight WITH UNIQUE KEY carrid connid fldate
                                             WITH NON-UNIQUE SORTED KEY carrier_plane COMPONENTS carrid planetype
                                             WITH NON-UNIQUE SORTED KEY carrid_fldate COMPONENTS carrid fldate.
DATA ld_connid TYPE s_conn_id VALUE IS INITIAL.
PARAMETERS p_carrid TYPE s_carr_id.

INITIALIZATION.

  IF lt_sflight IS INITIAL.
    SELECT * FROM sflight INTO TABLE lt_sflight.
  ENDIF.


START-OF-SELECTION.

  DATA(lt_upcoming_flights) = FILTER #( lt_sflight WHERE carrid = p_carrid
                                                     AND connid <> ld_connid  "Workaround, see below
*                                                     AND connid <> CONV #( '0000' ) "Or even w/o local variable
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

  "3. 1st Alternative: Use a secondary key. For example you're only flying with A380s on principle
  CONSTANTS con_plane_a380 TYPE s_planetye VALUE 'A380-800'.
  DATA(lt_with_secondary) = FILTER #( lt_sflight USING KEY carrier_plane
                                                 WHERE carrid = p_carrid
                                                   AND planetype = con_plane_a380 ).
  DATA(lt_heinz) = FILTER #( lt_sflight USING KEY carrid_fldate
                                                 WHERE carrid = p_carrid
                                                   AND fldate <= sy-datum ).
  "4. 2nd Alternative: Use FOR .. IN .. WHERE
  DATA(lt_forinwhere) = VALUE ty_flights( FOR line IN lt_sflight WHERE ( carrid EQ p_carrid AND fldate <= sy-datum ) ( line ) ).


  IF 1 = 2.

  ENDIF.
