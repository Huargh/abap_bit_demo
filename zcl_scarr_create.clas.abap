class ZCL_SCARR_CREATE definition
  public
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !IP_STRING type STRING
      !IP_SEPARATOR type CHAR1 .
  methods CREATE_SCARR_RECORD .
protected section.
private section.

  data _MS_SCARR type SCARR .

  methods _FORMATTING_AND_CONVERSION .
  methods _INPUT_VALIDATION .
  methods _IS_CURRENCY_VALID
    returning
      value(RV_IS_VALID) type XFELD .
  methods _SCARR_ALREADY_EXISTS
    returning
      value(RV_ALREADY_EXISTS) type XFELD .
ENDCLASS.



CLASS ZCL_SCARR_CREATE IMPLEMENTATION.


  METHOD constructor.

    CHECK ip_string IS NOT INITIAL.

    SPLIT ip_string AT ip_separator INTO _ms_scarr-mandt _ms_scarr-carrid _ms_scarr-carrname _ms_scarr-currcode _ms_scarr-url.

    _formatting_and_conversion( ).
    _input_validation( ).

  ENDMETHOD.


  METHOD create_scarr_record.

    "--> MODIFY scarr FROM _ms_scarr.
    "--> Commit Work

  ENDMETHOD.


  method _FORMATTING_AND_CONVERSION.

    "This is just a stub

  endmethod.


  METHOD _input_validation.

    IF _scarr_already_exists( ).
      RAISE EXCEPTION TYPE zcx_bc_user_cancelled.
    ENDIF.

    IF _is_currency_valid( ) = abap_false.
*      raise exception type zcx_generic_validation_error.
    ENDIF.

  ENDMETHOD.


  METHOD _is_currency_valid.

    SELECT SINGLE waers FROM tcurc INTO _ms_scarr-currcode
      WHERE waers = _ms_scarr-currcode.

    CHECK sy-subrc = 0.

    rv_is_valid = abap_true.

  ENDMETHOD.


  METHOD _scarr_already_exists.

    SELECT SINGLE carrid FROM scarr INTO _ms_scarr-carrid
      WHERE carrid = _ms_scarr-carrid.

    CHECK sy-subrc <> 0.

    rv_already_exists = abap_true.

  ENDMETHOD.
ENDCLASS.
