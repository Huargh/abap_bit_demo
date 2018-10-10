*&---------------------------------------------------------------------*
*& Report zma_01_templating
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zma_01_templating.

DATA gd_string TYPE string.
DATA gd_connid TYPE s_conn_id.

PARAMETERS: pv_carri TYPE s_carr_id.


gd_string = 'I can concatenate strings' && ' like this'.
gd_string = gd_string && | and embed variables like this: { pv_carri }|.



SELECT SINGLE connid FROM spfli INTO gd_connid
    WHERE carrid = pv_carri.

CHECK sy-subrc = 0.

cl_demo_output=>new( )->begin_section( 'Result'
                     )->write_text( |You selected a flight from Carrier { pv_carri }|
                     )->write_text( |Your Flight Connection Number in internal format is { gd_connid ALPHA = IN }| "Adds leading zeros
                     )->write_text( |Your Flight Connection Number in external format is { gd_connid ALPHA = OUT }|
                     )->write_text( |and here's my string: { gd_string }|
                     )->display( ).
