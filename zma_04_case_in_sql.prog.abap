*&---------------------------------------------------------------------*
*& Report zma_04_case_in_sql
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zma_04_case_in_sql.

TYPES: BEGIN OF ty_laender,
         land1        TYPE land1,
         landx        TYPE landx,
         beschreibung TYPE string,
       END OF ty_laender.

DATA gt_laender TYPE SORTED TABLE OF ty_laender WITH UNIQUE KEY land1.

DATA gv_land1 TYPE land1.

SELECT-OPTIONS so_land1 FOR gv_land1.

START-OF-SELECTION.

  SELECT t005~land1, t005t~landx,
      CASE
          WHEN t005~xegld = 'X' THEN 'ist Mitglied der EU'
          ELSE 'ist nicht Mitglied der EU'
      END
        AS beschreibung
      INTO CORRESPONDING FIELDS OF TABLE @gt_laender
      FROM t005 INNER JOIN t005t
       ON t005~land1 = t005t~land1
      WHERE t005~land1 IN @so_land1
        AND t005t~spras = @sy-langu.

  CHECK gt_laender IS NOT INITIAL.

  cl_demo_output=>new(
    )->begin_section( 'Bahnbrechende Erkenntnis'
    )->write_text( |Unsere Analyse ergab:|
    )->write_data( gt_laender
    )->display( ).
