IO.inspect(Enum.map(1..6, &(&1 * 1)))
IO.inspect(100..105)


Enum.map(1..10, &(&1+0)) |> IO.inspect(label: "before") |> Enum.map(&(&1*&1)) |> IO.inspect(label: "after")


defmodule Test do
  def myf(a, b) do
    a + a + b + b
  end
end

x = Test.myf(6, 3)
IO.puts(x)
