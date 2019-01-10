*&---------------------------------------------------------------------*
*& Report zma_06_values
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zma_07_values.

DATA lt_scarr TYPE STANDARD TABLE OF scarr WITH NON-UNIQUE KEY carrid.

*SELECT * FROM scarr INTO TABLE @DATA(lt_scarr)
*    WHERE currcode = 'EUR'.
*AB     Air Berlin           EUR      http://www.airberlin.de
*AF     Air France           EUR      http://www.airfrance.fr
*AZ     Alitalia             EUR      http://www.alitalia.it
*LH     Lufthansa            EUR      http://www.lufthansa.com
*NG     Lauda Air            EUR      http://www.laudaair.com

* Typing with generic data type #:
lt_scarr = VALUE #( ( carrid = 'AB' carrname = 'Air Berlin' currcode = 'EUR' url = 'http://www.airberlin.de')
                ( carrid = 'AF' carrname = 'Air France' currcode = 'EUR' url = 'http://www.airfrance.fr')  ).
INSERT VALUE #( carrid = 'MA' carrname = 'Aigner Airlines' currcode = 'EUR' url = 'www.aignerair.org' ) INTO TABLE lt_scarr.


**********************************************************************
* Using a specific data type allows for type inference
DATA(lt_scarr_ti) = VALUE ty_scarr( ( carrid = 'AB' carrname = 'Air Berlin' currcode = 'EUR' url = 'http://www.airberlin.de')
                                    ( carrid = 'AF' carrname = 'Air France' currcode = 'EUR' url = 'http://www.airfrance.fr')  ).
INSERT VALUE #( carrid = 'MA' carrname = 'Aigner Airlines' currcode = 'EUR' url = 'www.aignerair.org' ) INTO TABLE lt_scarr_ti.


IF 1 = 2. "Conclusion:
  "The first example would not work with a DATA(lt_scarr) inline declaration: Since we used the generic constructor #, no type can be derived.
  "In the second example, we use a typed constructor. This allows for lt_scarr_ti to infer the type from ty_scarr.
ENDIF.
