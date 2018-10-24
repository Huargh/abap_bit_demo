*&---------------------------------------------------------------------*
*& Report ZMA_06_NEW_CONSTRUCTOR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zma_06_new_constructor.

DATA gd_input TYPE string VALUE '491#SU#Aeroflot Russian Airlines#RUB#https://www.aeroflot.ru'.
DATA rs_response TYPE string.

***********************************************************************
* Instantiation the old way
DATA gr_carrier TYPE REF TO zcl_scarr_create.

CREATE OBJECT gr_carrier
  EXPORTING
    ip_string    = gd_input
    ip_separator = '#'.


*********************************************************************
** Instantiation with the NEW Constructor
*TRY.
*    DATA(gr_carrier) = NEW zcl_scarr_create( ip_string = gd_input
*                                             ip_separator = '#' ).
*
*    gr_carrier->create_scarr_record( ).
*  CATCH zcx_bc_user_cancelled INTO DATA(go_exc).
*    "Send message back:
*    rs_response = go_exc->get_text( ).
*ENDTRY.
