*&---------------------------------------------------------------------*
*& Report zma_13_corresponding_construct
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zma_13_corresponding_construct.

**********************************************************************
* Types for our example. Note, that TY_CHANGE_DATA is included in both the SO and the PP structure
TYPES: BEGIN OF ty_change_data,
         ernam  TYPE ernam,
         erdat  TYPE erdat,
         erzeit TYPE eu_gzeit,
         aenam  TYPE aenam,
         aedat  TYPE aedat,
         aezeit TYPE eu_vzeit,
       END OF ty_change_data.

TYPES: BEGIN OF ty_so_data,
         vbeln TYPE vbeln,
         posnr TYPE posnr,
         auart TYPE auart,
         pstyp TYPE pstyp,
         matnr TYPE matnr.
    INCLUDE TYPE ty_change_data.
TYPES   END OF ty_so_data.


TYPES: BEGIN OF ty_pp_data,
         aufnr TYPE aufnr,
         auart TYPE auart,
         autyp TYPE auftyp,
         kdauf TYPE kdauf,
         kdpos TYPE kdpos,
         werks TYPE werks_d.
    INCLUDE TYPE ty_change_data.
TYPES   END OF ty_pp_data.

**********************************************************************
CLASS lcl_logger DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS show_change_data IMPORTING is_change_data TYPE ty_change_data.
ENDCLASS.

CLASS lcl_logger IMPLEMENTATION.

  METHOD show_change_data.

    cl_demo_output=>new(
  )->begin_section( 'Create and Change Information'
  )->write_text( 'Here are the create and change information for this document'
  )->write_data( is_change_data
  )->end_section(
  )->display( ).

  ENDMETHOD.

ENDCLASS.

**********************************************************************
START-OF-SELECTION.

  DATA(gs_salesorder) = VALUE ty_so_data( vbeln = '1234567890'
                                          posnr = '000010'
                                          auart = 'TA'
                                          pstyp = 'TAN'
                                          matnr = 'T-050-A3'
                                          ernam = 'SPONGEBOB'
                                          erdat = '20190101'
                                          erzeit = sy-uzeit - 5000
                                          aenam = sy-uname
                                          aedat = sy-datum
                                          aezeit = sy-uzeit ).

  DATA(gs_prodorder) = VALUE ty_pp_data( aufnr = '0000000001'
                                         auart = 'PP01'
                                         autyp = '10'
                                         kdauf = '1234567890'
                                         kdpos = '000010'
                                         werks = '1000'
                                         ernam = 'GERRY'
                                         erdat = '20190122'
                                         erzeit = sy-uzeit - 1000
                                         aenam = sy-uname
                                         aedat = sy-datum
                                         aezeit = sy-uzeit  ).


  lcl_logger=>show_change_data( CORRESPONDING ty_change_data( gs_salesorder ) ).

  lcl_logger=>show_change_data( CORRESPONDING ty_change_data( gs_prodorder ) ).
