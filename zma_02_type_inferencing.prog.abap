*&---------------------------------------------------------------------*
*& Report zma_01_type_inferencing
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zma_02_type_inferencing.

DATA gv_land1 TYPE land1.
DATA gt_t005 TYPE SORTED TABLE OF t005 WITH UNIQUE KEY land1.


SELECT-OPTIONS so_land1 FOR gv_land1.

START-OF-SELECTION.

  SELECT * FROM t005 INTO TABLE gt_t005
  WHERE land1 IN so_land1.


* Type for gs_t005 is inferred by the type of table gt_t005
  LOOP AT gt_t005 INTO DATA(gs_t005) WHERE xegld = abap_true.

    cl_demo_output=>new( )->begin_section(
    'Important Notification' )->write_text(
    |Country { gs_t005-land1 } is part of the EU|
      )->display( ).

  ENDLOOP.



**********************************************************************
* Same goes for Field Symbols:
  LOOP AT gt_t005 ASSIGNING FIELD-SYMBOL(<g_t005>).
    DATA(ld_irgendwas) = gv_land1.
    cl_demo_output=>new( )->begin_section(
    'Important Notification' )->write_text(
    |Country { <g_t005>-land1 } is part of the EU|
      )->display( ).

  ENDLOOP.

*--> Careful: Scope of the variable is not limited to the LOOP
  IF gs_t005 IS NOT INITIAL.
    cl_demo_output=>new( )->begin_section(
    |Hi! This is gs_t005 speaking.| )->write_text(
    |I have still some data here:|
      )->write_data( gs_t005
      )->display( ).
  ENDIF.
