
x = 55
case {1, 3, 5} do
  {1, 3, 4} ->
    IO.puts("nope")
  {1, ^x, 5} ->
    IO.puts("not this either")
  {1, 3, 5} ->
    IO.puts("Thats a bingo!")
end

case {"3", "d"} do
  {"no"} -> IO.puts("nope")
  _ -> IO.puts("matches anything")
end


if true do
  IO.puts(true)
end

if false do
  IO.puts(true)
else
  IO.puts("was false")
end

unless false do
  IO.puts ("monkey")
end


if(true, [do: IO.puts("WOW!"), else: IO.puts("ALSO WOW!")])
if(false, [do: IO.puts("WOW!"), else: IO.puts("ALSO WOW!")])
