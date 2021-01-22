defmodule Math do
  def derivative({:const, _}, _), do: {:const, 0}
  def derivative({:var, v}, v), do: {:const, 1}
  def derivative({:var, y}, _), do: {:const, 0}
  def derivative({:mul, e1, e2}, v) do
    {:add, {:mul, derivative(e1, v), e2}, {:mul, e1, derivative(e2, v)} }
  end
  def derivative({:add, e1, e2}, v) do
    {:add, derivative(e1, v), derivative(e2, v)}
  end
end


# 2 x^2  +  3x + 5



# val = "2 * x^2"
# a ={
#       :mul,
#       {:const, 2},
#       {
#         :mul,
#         {:var, :x},
#         {:var, :x}
#       }
#     }

b = {
  :mul,
  {:var, :x},
  {:var, :x}
}

IO.inspect(b)
r = Math.derivative(b, :x)
IO.inspect(r)
