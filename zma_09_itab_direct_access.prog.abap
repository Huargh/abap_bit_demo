*&---------------------------------------------------------------------*
*& Report zma_09_itab_direct_access
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zma_09_itab_direct_access.

"Examples based on Horst Kellers blog: https://blogs.sap.com/2013/05/29/abap-news-for-release-740-table-expressions/

DATA ls_scarr TYPE scarr.
DATA ld_index TYPE i.

SELECT * FROM scarr INTO TABLE @DATA(lt_scarr)
    WHERE currcode = 'EUR'.

" Read by Index:
ld_index = 2.
READ TABLE lt_scarr INTO ls_scarr INDEX ld_index.
CLEAR ls_scarr.
" Is equivalent to
ls_scarr = lt_scarr[ ld_index ].
CLEAR ls_scarr.

*"Important Difference for a missed entry: Index > number of entries:
*ld_index = 100.
*READ TABLE lt_scarr INTO ls_scarr INDEX ld_index. "This sets sy-subrc = 4
*CLEAR ls_scarr.
*
*ls_scarr = lt_scarr[ ld_index ]. "This raises exception type CX_SY_ITAB_LINE_NOT_FOUND (DYNAMIC_CHECK, no compile-time warning), dumps if not caught

**********************************************************************

"Read by Key:
READ TABLE lt_scarr INTO ls_scarr WITH KEY carrid = 'LH'.
"Is equivalent to
TRY.
    ls_scarr = lt_scarr[ carrid = 'LH' ].
  CATCH cx_sy_itab_line_not_found.
ENDTRY.


**********************************************************************
" Itab Existence check:
" Instead of
READ TABLE lt_scarr INTO ls_scarr WITH KEY carrid = 'LH'.
IF sy-subrc = 0.
  "Do something with that line
ENDIF.
"you can use
IF line_exists( lt_scarr[ carrid = 'LH' ] ).
  "Do something with that line
  IF 1 = 2.
  ENDIF.
ENDIF.

**********************************************************************
" Itab line access with Default Value in case there is no entry with specified key/index.
"Here we find an entry, default value does not take effect
DATA(ld_carrname) = VALUE #( lt_scarr[ 1 ]-carrname DEFAULT 'n/a' ).

"Here we don't find an entry. Default value is set
DATA(lt_scarr_empty) = lt_scarr.
CLEAR lt_scarr_empty.
DATA(ld_carrname2) = VALUE #( lt_scarr_empty[ 1 ]-carrname DEFAULT 'n/a' ).


**********************************************************************
"Also with the VALUE constructor, an access to a nonexistent itab line without a specified default value raises an exception
*DATA(ld_carrname3) = VALUE #( lt_scarr_empty[ 1 ]-carrname ). "Uncomment this line to get a dump
"With default value optional, it does not
DATA(ld_carrname4) = VALUE #( lt_scarr_empty[ 1 ]-carrname OPTIONAL ).
IF ld_carrname4 IS NOT INITIAL.
ELSE.
  IF 1 = 2.
  ENDIF.
ENDIF.
