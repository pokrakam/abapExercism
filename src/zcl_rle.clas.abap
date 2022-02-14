class zcl_rle definition
  public
  final
  create public .

  public section.

    methods encode importing input         type string
                   returning value(result) type string.

    methods decode importing input         type string
                   returning value(result) type string.

endclass.



class zcl_rle implementation.


  method encode.

    data: character  type string,
          duplicates type string.

    data(remaining_string) = input.

    "The loop will "eat" a character and it's adjacent duplicates on each pass and add the result to the output
    while remaining_string is not initial.

      find regex '([\w\s])(\1*)(.*)'
           in remaining_string
           submatches character
                      duplicates
                      remaining_string
           ##SUBRC_OK.

      "The regex expression consists of the following search groups which, if matched, are placed into the
      "variables listed under submatches:

      "Example search string: aaabbbcc
      "
      "  regex     | result | assigned to      | Description
      "  ----------+--------+------------------+-------------------------------------------------------------
      "  ([\w\s])  | a      | character        | Match a word character (A-z,numbers,underscore) or space
      "  (\1*)     | aa     | duplicates       | Next, match zero or more occurrences of the result of group 1 again
      "  (.*)      | bbbcc  | remaining_string | match the rest of the string

      if duplicates is not initial.
        result = |{ result }{ strlen( duplicates ) + 1 }{ character }|.
      else.
        result = |{ result }{ character }|.
      endif.

    endwhile.

  endmethod.


  method decode.

    data: character   type string,
          repetitions type string.

    data(remaining_string) = input.

    while remaining_string is not initial.

      "Similar to encode, regex consists of groups: (zero or more numeric digits)(alpha or space character)(rest of string)
      find regex '(\d*)([\w\s])(.*)' in remaining_string submatches repetitions character remaining_string  ##SUBRC_OK.

      if repetitions is not initial.
        result = |{ result }{ repeat( val = character occ = repetitions ) }|.
      else.
        result = |{ result }{ character }|.
      endif.

    endwhile.

  endmethod.


endclass.
