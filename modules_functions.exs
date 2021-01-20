defmodule MyModule do
  def first_name() do
    "my name"
  end

  def age(num) do
    sum(num, 7)
  end
  defp sum(a, b) do ## private function
    a + b
  end
end


IO.puts(MyModule.first_name())
IO.puts(MyModule.age(21))

# anonymous functions must be invoced with a .
a = fn a, b -> a + b end
IO.puts(a.(5, 4))

func = &MyModule.age/1  # function stored in variable
IO.puts(func.(60))
IO.inspect(func)

func2 = &MyModule.age(&1) # other syntax
IO.inspect(func2)


# default arguments
defmodule Test do
  def new_fun(a \\ "monkey", b \\ " world") do # note, no whitespace between name and parenthesis
    a <> b
  end
end

IO.puts(Test.new_fun())

# functions with guards and clauses
defmodule Guarded do
  def first(0) do
    IO.puts("Input was 0.")
  end
  def first(input) when input > 10 and is_integer(input) do
    IO.puts("Input larger than 10")
  end

end

Guarded.first(11)
