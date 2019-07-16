*&---------------------------------------------------------------------*
*& Report zma_11_for_expressions
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zma_11_for_expressions.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Additional sources: https://blogs.sap.com/2014/09/30/abap-news-for-740-sp08-iteration-expressions/
"                     https://www.tricktresor.de/blog/abap-740-features-unter-der-lupe/
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Use-Case 1: Get unique values of a column of an internal table, similar to SELECT DISTINCT.
"            For example get all planetypes used in gt_sflight
"            (item categories/materials in use from an XVBAP[]-table)

DATA gt_sflight TYPE SORTED TABLE OF sflight WITH UNIQUE KEY carrid connid fldate.
DATA gt_planetype TYPE STANDARD TABLE OF s_planetye.

SELECT * FROM sflight INTO TABLE gt_sflight.

gt_planetype = VALUE #( FOR GROUPS planetype OF <line> IN gt_sflight
                        GROUP BY <line>-planetype WITHOUT MEMBERS ( planetype ) ).

cl_demo_output=>display( gt_planetype ).

**********************************************************************
* Aus ABAP Doku:
**********************************************************************
*SELECT * FROM spfli INTO TABLE @DATA(spfli).
*
*TYPES group_keys TYPE STANDARD TABLE OF spfli-carrid WITH EMPTY KEY.
*
*cl_demo_output=>display(
*  VALUE group_keys(
*    FOR GROUPS gruppenname OF wa IN spfli
*    GROUP BY wa-carrid
*    ASCENDING
*    WITHOUT MEMBERS
*    ( gruppenname ) ) ).
