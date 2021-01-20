defmodule Fact do
  def rec(n) do
    case n do
      0 -> 0
      1 -> 1
      _ -> n * rec(n-1)
    end
  end
@doc """
Factorial implemented with tail recursion.
Really the 'go' function is tail recursive.
"""
  def tail(n) do go(n-1, n) end
  def go(n, acc) do
    case n do
      1 -> acc
      _ -> go(n-1, n*acc)
    end
  end
end



# var = 120000
# {tr, vr} = :timer.tc(fn -> Fact.rec(var) end)
# {tt, vt} = :timer.tc(fn -> Fact.tail(var) end)
# IO.inspect(tr)
# IO.inspect(tt)
# IO.inspect(vr == vt)


defmodule Fibonacci do
  def naive(n) do
    case n do
      0 -> 0
      1 -> 1
      _ -> naive(n-1) + naive(n-2)
    end
  end

  def tail(n) do
    go(n, 0, 1)
  end
  def go(n, current, next) do
    case n do
      0 -> current
      1 -> next
      _ -> go(n-1, next, next+current)
    end
  end
end



var = 35
{tr, vr} = :timer.tc(fn -> Fibonacci.naive(var) end)
{tt, vt} = :timer.tc(fn -> Fibonacci.tail(var) end)
IO.inspect(tr, label: "Naive micro sec")
IO.inspect(tt, label: "Tail micro sec ")
IO.inspect(vr == vt, label: "equals")
