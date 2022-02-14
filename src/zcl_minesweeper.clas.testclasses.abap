class ltc_test definition final for testing
  duration short
  risk level harmless.

  private section.

    data cut type ref to zcl_minesweeper.

    methods setup.
    methods assert_that importing input  type string_table
                                  output type string_table.

    methods no_rows                       for testing raising cx_static_check.
    methods no_columns                    for testing raising cx_static_check.
    methods no_mines                      for testing raising cx_static_check.
    methods only_mines                    for testing raising cx_static_check.
    methods mine_surrounded_by_spaces     for testing raising cx_static_check.
    methods space_surrounded_by_mines     for testing raising cx_static_check.
    methods horizontal_line               for testing raising cx_static_check.
    methods horizontal_line_mines_at_ends for testing raising cx_static_check.
    methods vertical_line                 for testing raising cx_static_check.
    methods vertical_line_mines_at_ends   for testing raising cx_static_check.
    methods cross                         for testing raising cx_static_check.
    methods large_minefield               for testing raising cx_static_check.

endclass.


class ltc_test implementation.

  method setup.
    cut = new #( ).
  endmethod.


  method no_rows.
    assert_that(
      input  = value #( )
      output = value #( ) ).
  endmethod.


  method no_columns.
    assert_that(
      input  = value #( ( ) )
      output = value #( ( ) ) ).
  endmethod.


  method no_mines.
    assert_that(
      input  = value #(
        ( `   ` )
        ( `   ` )
        ( `   ` ) )
      output = value #(
        ( `   ` )
        ( `   ` )
        ( `   ` ) ) ).
  endmethod.


  method only_mines.
    assert_that(
      input  = value #(
        ( `***` )
        ( `***` )
        ( `***` ) )
      output = value #(
        ( `***` )
        ( `***` )
        ( `***` ) ) ).
  endmethod.


  method mine_surrounded_by_spaces.
    assert_that(
      input  = value #(
        ( `   ` )
        ( ` * ` )
        ( `   ` ) )
      output = value #(
        ( `111` )
        ( `1*1` )
        ( `111` ) ) ).
  endmethod.


  method space_surrounded_by_mines.
    assert_that(
      input  = value #(
        ( `***` )
        ( `* *` )
        ( `***` ) )
      output = value #(
        ( `***` )
        ( `*8*` )
        ( `***` ) ) ).
  endmethod.


  method horizontal_line.
    assert_that(
      input  = value #( ( ` * * ` ) )
      output = value #( ( `1*2*1` ) ) ).
  endmethod.


  method horizontal_line_mines_at_ends.
    assert_that(
      input  = value #( ( `*   *` ) )
      output = value #( ( `*1 1*` ) ) ).
  endmethod.


  method vertical_line.
    assert_that(
      input  = value #(
        ( ` ` )
        ( `*` )
        ( ` ` )
        ( `*` )
        ( ` ` ) )
      output = value #(
        ( `1` )
        ( `*` )
        ( `2` )
        ( `*` )
        ( `1` ) ) ).
  endmethod.


  method vertical_line_mines_at_ends.
    assert_that(
      input  = value #(
        ( `*` )
        ( ` ` )
        ( ` ` )
        ( ` ` )
        ( `*` ) )
      output = value #(
        ( `*` )
        ( `1` )
        ( ` ` )
        ( `1` )
        ( `*` ) ) ).
  endmethod.


  method cross.
    assert_that(
      input  = value #(
        ( `  *  ` )
        ( `  *  ` )
        ( `*****` )
        ( `  *  ` )
        ( `  *  ` ) )
      output = value #(
        ( ` 2*2 ` )
        ( `25*52` )
        ( `*****` )
        ( `25*52` )
        ( ` 2*2 ` ) ) ).
  endmethod.


  method large_minefield.
    assert_that(
      input  = value #(
        ( ` *  * ` )
        ( `  *   ` )
        ( `    * ` )
        ( `   * *` )
        ( ` *  * ` )
        ( `      ` ) )
      output = value #(
        ( `1*22*1` )
        ( `12*322` )
        ( ` 123*2` )
        ( `112*4*` )
        ( `1*22*2` )
        ( `111111` ) ) ).
  endmethod.


  method assert_that.
    data(act) = cut->sweep( input ).
    cl_abap_unit_assert=>assert_equals( act = act
                                        exp = output ).
  endmethod.

endclass.
