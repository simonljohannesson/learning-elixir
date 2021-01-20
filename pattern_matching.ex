
# pattern matching
x = 1
IO.puts (1 = x)

# try catch is unusual in elixir
try do
  IO.puts (2 = x)
rescue
  MatchError -> IO.puts(MatchError)
end

# assign by destructuring
{a, b, c} = {"a", 5, "haj"}

IO.inspect([a, b, c])

# matching specific values
{:ok, result} = {:ok, "result string"}
IO.puts(result)

# list matching
[h | t] = ["a", "b", 5]
IO.inspect(h)
IO.inspect(t)

# matching against existing varuable
try do
  val = 55
  ^val = 56
rescue
  MatchError -> IO.puts(MatchError)
end
