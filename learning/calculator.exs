defmodule Calc do
  @moduledoc """
  A rudimentary calculator.
  """
  def eval({:int, n}, bindings) do
    n
  end
  def eval({:add, a, b}, bindings) do
    eval(a, bindings) + eval(b, bindings)
  end
  def eval({:multiply, a, b}, bindings) do
    eval(a, bindings) * eval(b, bindings)
  end
  def eval({:subtract, a, b}, bindings) do
    eval(a, bindings) - eval(b, bindings)
  end
  def eval({:var, name}, bindings) do lookup(name, bindings) end
  def lookup(var, [{:bind, var, value} | _]) do value end
  def lookup(var, [_ | rest]) do lookup(var, rest) end
end

# r = Calc.eval({:add, {:int, 4}, {:int, 9}})
# IO.inspect(r)
# r = Calc.eval({:multiply, {:int, 4}, {:int, 9}})
# IO.inspect(r)
# r = Calc.eval({:subtract, {:int, 4}, {:int, 9}})
# IO.inspect(r)

bindings = [{:bind, :x, 9}, {:bind, :y, 12}, {:bind, :z, 3}]
val = Calc.eval({:var, :z}, bindings)
IO.inspect(val)

a = Calc.eval({:var, :x}, [{:bind, :x, 5}])
IO.inspect(a)
a= Calc.eval({:add, {:var, :x}, {:var, :y}}, [{:bind, :x, 5}, {:bind, :y, 2}])
IO.inspect(a)
