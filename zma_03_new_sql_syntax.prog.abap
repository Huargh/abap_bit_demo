*&---------------------------------------------------------------------*
*& Report zma_02_new_sql_syntax
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zma_03_new_sql_syntax.


PARAMETERS: p_carrid TYPE s_carr_id.

START-OF-SELECTION.


* Old Syntax:
  DATA gv_carrname TYPE s_carrname.
  DATA gv_url TYPE s_carrurl.
  SELECT SINGLE carrname url FROM scarr INTO (gv_carrname, gv_url)
  WHERE carrid = p_carrid.
  IF sy-subrc = 0.
    cl_demo_output=>new( )->begin_section(
        'Important Notification' )->write_text(
        |The Homepage of { gv_carrname } is { gv_url }|
          )->display( ).

  ENDIF.


***********************************************************************
** New Syntax: Separate selection field list with ",". Host variables (i.e. ABAP fields in the program unknown to the DB
**             must be escaped with @
***********************************************************************
*  SELECT SINGLE carrname, url FROM scarr INTO ( @DATA(gd_carrname), @DATA(gd_url) )
*      WHERE carrid = @p_carrid.
*  IF sy-subrc = 0.
*    cl_demo_output=>new( )->begin_section(
*          'Important Notification' )->write_text(
*          |The Homepage of { gd_carrname } is { gd_url }|
*            )->display( ).
*  ENDIF.
