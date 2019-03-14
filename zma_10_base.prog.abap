*&---------------------------------------------------------------------*
*& Report zma_10_base
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zma_10_base.

"Based on https://blogs.sap.com/2014/09/29/abap-news-for-740-sp08-start-value-for-constructor-expressions/

DATA:
  BEGIN OF struct1,
    alice(10) TYPE c VALUE 'alice',
    bob(10)   TYPE c VALUE 'bob',
  END OF struct1.

DATA:
  BEGIN OF struct2,
    bob(10)   TYPE c VALUE 'bob',
    carol(10) TYPE c VALUE 'carol',
  END OF struct2.

**Let's compare
*MOVE-CORRESPONDING struct1 TO struct2.


*"With this:
*struct2 = CORRESPONDING #( struct1 ).

*cl_demo_output=>new( )->begin_section( )->write_data( struct2 )->display( ).


*"Same goes for tables:
*DATA itab TYPE TABLE OF i.
*itab = VALUE #( ( 1 ) ( 2 ) ( 3 ) ).
*itab = VALUE #( ( 4 ) ( 5 ) ( 6 ) ).
*cl_demo_output=>new( )->begin_section( )->write_data( itab )->display( ).


*"This is where we'd use BASE
*struct2 = CORRESPONDING #( BASE ( struct2 ) struct1 ).
*cl_demo_output=>new( )->begin_section( )->write_data( struct2 )->display( ).


*"or for our table example:
*DATA itab TYPE TABLE OF i.
*itab = VALUE #( ( 1 ) ( 2 ) ( 3 ) ).
*itab = VALUE #( BASE itab  ( 4 ) ( 5 ) ( 6 ) ). "Notice that you mustn't use parantheses around the BASE argument here!
*cl_demo_output=>new( )->begin_section( )->write_data( itab )->display( ).


*"You can also use this to construct structures:
*DATA: BEGIN OF all_names,
*        alice(10) TYPE c,
*        bob(10)   TYPE c,
*        carol(10) TYPE c,
*      END OF all_names.
*all_names = VALUE #( BASE struct1 carol = 'carol' ).
*cl_demo_output=>new( )->begin_section( )->write_data( all_names )->display( ).
