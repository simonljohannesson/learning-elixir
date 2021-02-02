# determine unicode code point
IO.puts(?A)

IO.puts(Integer.to_string(?A, 16))

IO.puts("\u0041" == "A")

IO.puts("\u0041")

IO.puts("hełło" <> <<0>>)
IO.inspect("hełło" <> <<0>>)  # concatenating a null byte to view inner binary representation
IO.inspect("hełło")
